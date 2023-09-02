var SCRIPT_TITLE = "Move selected note 8th note earlier";

function getClientInfo() {
  return {
    "name": SV.T(SCRIPT_TITLE),
    "author": "lag129",
    "versionNumber": 1,
    "minEditorVersion": 0
  }
}

function getTranslations(langCode) {
  if(langCode == "ja-jp") {
    return [
      [SCRIPT_TITLE, "選択ノートを8分音符にクオンタイズする"]
    ];
  }
  return [];
}

function main() {
    var selection = SV.getMainEditor().getSelection();
    var selectedNotes = selection.getSelectedNotes();

    if(selectedNotes.length == 0){
        SV.finish();
    }

    for(var i=0; i<selectedNotes.length; i++){
		
		var timeAxis = SV.getProject().getTimeAxis();
		var tempoMark = timeAxis.getTempoMarkAt(currentOnset);

		var currentOnset = selectedNotes[i].getOnset();
		var bpm = tempoMark.bpm;
		var currentBar = ((60/bpm)*4)/8
		var currentBarBlick = timeAxis.getBlickFromSeconds(currentBar)

		selectedNotes[i].setDuration(currentBarBlick);
    }

  	SV.finish();
}
