SCRIPT_TITLE = "Set selected notes to 8th note length"

function getClientInfo()
  return {
    name = SV:T(SCRIPT_TITLE),
    author = "lag129",
    versionNumber = 1,
    minEditorVersion = 68354
  }
end

function getTranslations(langCode)
  if langCode == "ja-jp" then
    return {
      { SCRIPT_TITLE, "選択したノートを8分音符にクオンタイズ" }
    }
  end
  return {}
end

function main()
  local selection = SV:getMainEditor():getSelection()
  local selectedNotes = selection:getSelectedNotes()

  if #selectedNotes == 0 then
    SV:finish()
    return
  end

  local timeAxis = SV:getProject():getTimeAxis()
  for i = 1, #selectedNotes do
    local note = selectedNotes[i]
    local currentOnset = note:getOnset()
    local tempoMark = timeAxis:getTempoMarkAt(currentOnset)

    local bpm = tonumber(tempoMark.bpm)
    local currentBar = ((60 / bpm) * 4) / 8
    local currentBarBlick = timeAxis:getBlickFromSeconds(currentBar)

    selectedNotes[i]:setDuration(currentBarBlick)
  end

  SV:finish()
end
