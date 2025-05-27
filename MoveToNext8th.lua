SCRIPT_TITLE = "Move selected note 8th note later"

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
      { SCRIPT_TITLE, "8分後に選択ノートを移動する" }
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

  for i = 1, #selectedNotes do
    local note = selectedNotes[i]
    local currentOnset = note:getOnset()
    local timeAxis = SV:getProject():getTimeAxis()
    local tempoMark = timeAxis:getTempoMarkAt(currentOnset)

    local bpm = tonumber(tempoMark.bpm)
    local currentBar = ((60 / bpm) * 4) / 8
    local currentBarBlick = timeAxis:getBlickFromSeconds(currentBar)
    local diffBlick = currentOnset + currentBarBlick

    selectedNotes[i]:setOnset(diffBlick)
  end

  SV:finish()
end
