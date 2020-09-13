function ExecDeleteCallback(s, e) {
    hPanel.Set('Deleted', true);
    hPanel.Set('SelectedIndex', e.visibleIndex)
    if(!hPanel.Contains('Confirm'))
        hPanel.Set('Confirm', false);
    if (!hPanel.Get('Confirm')) {
        hPanel.Set('dgClientGridID', s.name);
        e.processOnServer = false;
        pcDelete.Show();
    }
    else {
        s.DeleteRow(e.visibleIndex);
    }
}
function clearpanel() {
    hPanel.Clear();
}

function postUrl(response, clear) {

    reset();

    if (clear) {

        clearpanel();

    }

    if(response.constructor.toString().indexOf('Array') == -1) {

        if (response.indexOf('\ ') != -1) {

            response = response.split('\ ');

        }

    }

    if (response[0].toLowerCase().indexOf('http://') != 0) {

        lpPage.Show();

    }

    if (response[0].toLowerCase().indexOf('.aspx') == -1) {

        response[0] = response[0] + '.aspx';
    }

    if (response[1].toLowerCase().indexOf('.aspx') == -1) {

        response[1] = response[1] + '.aspx';

    }

    var pane = spIndex.GetPaneByName('title_right');

    pane.SetContentUrl(response[1]);

    pane.RefreshContentUrl();

    pane = spIndex.GetPaneByName('content_main');

    pane.SetContentUrl(response[0]);

    pane.RefreshContentUrl();

}

function reset() {
    if (lpPage.GetVisible()) {
        lpPage.Hide();
    }
    tmrTimeout.SetEnabled(false);
    tmrTimeout.SetEnabled(true);
}
function ShowPopup(text) {
    var response = text.split(' ');
    switch(response[0]) {
        case 'success': {
                pcPopup.SetHeaderText('SUCCESS');
                pcPopup.SetHeaderImageUrl('images/info.png');
                lblMessage_Popup.SetText(text.substring(response[0].length));
            };
            break;
        case 'information': {
                pcPopup.SetHeaderText('INFORMATION');
                pcPopup.SetHeaderImageUrl('images/info.png');
                lblMessage_Popup.SetText(text.substring(response[0].length));
            };
            break;
        case 'error': {
                pcPopup.SetHeaderText('ERROR');
                pcPopup.SetHeaderImageUrl('images/error.png');
                lblMessage_Popup.SetText(text.substring(response[0].length));
            };
            break;
    };
    pcPopup.Show();
}