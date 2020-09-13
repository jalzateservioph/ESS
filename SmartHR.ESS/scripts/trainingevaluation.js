// Modified by: Joshua Alzate
// Modified on: 04/12/2019
// Description:
//     Changed all references to hidden fields from the hidden fields themselves to local hidden field accessors

function updateProgressBarOnCheckedChanged(s, e) {

    var progBar = document.getElementById("hfProgBar");
    var externalTally1 = document.getElementById("hfExternalTally1");
    var externalTally2 = document.getElementById("hfExternalTally2");
    var externalTally3 = document.getElementById("hfExternalTally3");
    var externalTally4 = document.getElementById("hfExternalTally4");

    if (s.uniqueID.indexOf("memo") > 0) {

        var addProgress = 0;
        var existingTally = parseInt($("#pnlExternal_001_lblTally1_001").text()) + parseInt($("#pnlExternal_001_lblTally2_001").text()) + parseInt($("#pnlExternal_001_lblTally3_001").text()) + parseInt($("#pnlExternal_001_lblTally4_001").text());

        for (var ctr = 1; ctr <= 7; ctr++) {

            if ($("#pnlExternal_001_memoExt" + ctr + "_001_I").val().length > 0) {
                addProgress += 1;
            }
        }

        progBar.value = addProgress + existingTally;

        progIndicator_001.SetPosition((progBar.value / 27) * 100.0);

        return;
    }

    if (!s.GetValue()) {
        progBar.value = parseInt(progBar.value) - 1;

        switch (s.uniqueID[s.uniqueID.length - 5]) {

            case "1":
                externalTally1.value = parseInt(externalTally1.value) - 1;
                $("#pnlExternal_001_lblTally1_001").text(externalTally1.value);
                break;
            case "2":
                externalTally2.value = parseInt(externalTally2.value) - 1;
                $("#pnlExternal_001_lblTally2_001").text(externalTally2.value);
                break;
            case "3":
                externalTally3.value = parseInt(externalTally3.value) - 1;
                $("#pnlExternal_001_lblTally3_001").text(externalTally3.value);
                break;
            case "4":
                externalTally4.value = parseInt(externalTally4.value) - 1;
                $("#pnlExternal_001_lblTally4_001").text(externalTally4.value);
                break;
        }

        progIndicator_001.SetPosition((progBar.value / 27) * 100.0);

        return;
    }

    progBar.value = progBar.value ? parseInt(progBar.value) + 1 : 1;

    switch (s.uniqueID[s.uniqueID.length - 5]) {

        case "1":
            externalTally1.value = externalTally1.value ? parseInt(externalTally1.value) + 1 : 1;
            $("#pnlExternal_001_lblTally1_001").text(externalTally1.value);
            break;
        case "2":
            externalTally2.value = externalTally2.value ? parseInt(externalTally2.value) + 1 : 1;
            $("#pnlExternal_001_lblTally2_001").text(externalTally2.value);
            break;
        case "3":
            externalTally3.value = externalTally3.value ? parseInt(externalTally3.value) + 1 : 1;
            $("#pnlExternal_001_lblTally3_001").text(externalTally3.value);
            break;
        case "4":
            externalTally4.value = externalTally4.value ? parseInt(externalTally4.value) + 1 : 1;
            $("#pnlExternal_001_lblTally4_001").text(externalTally4.value);
            break;
    }


    progIndicator_001.SetPosition((progBar.value / 27) * 100.0);
}

function updateProgressBarOnSelectedIndexChanged(s, e) {

    var arr = []
    arr.push($("[id*='rbtContentDelivery_002_VI']")[0].value >= 0 ? 1 : 0)
    arr.push($("[id*='rbtContentMastery_002_VI']")[0].value >= 0 ? 1 : 0)
    arr.push($("[id*='rbtClassInteraction_002_VI']")[0].value >= 0 ? 1 : 0)
    arr.push($("[id*='rbtTimeManagement_002_VI']")[0].value >= 0 ? 1 : 0)
    arr.push($("[id*='rbtProfessionalism_002_VI']")[0].value >= 0 ? 1 : 0)
    arr.push($("[id*='rbtActivitiesWorkshop_002_VI']")[0].value >= 0 ? 1 : 0)
    arr.push($("[id*='rbtPaceTiming_002_VI']")[0].value >= 0 ? 1 : 0)
    arr.push($("[id*='rbtContentFlow_002_VI']")[0].value >= 0 ? 1 : 0)
    arr.push($("[id*='rbtContent_002_VI']")[0].value >= 0 ? 1 : 0)
    arr.push($("[id*='rbtRelevance_002_VI']")[0].value >= 0 ? 1 : 0)
    arr.push($("[id*='rbtTraining_002_VI']")[0].value >= 0 ? 1 : 0)
    arr.push($("[id*='rbtMaterials_002_VI']")[0].value >= 0 ? 1 : 0)
    arr.push($("[id*='rbtEquipment_002_VI']")[0].value >= 0 ? 1 : 0)
    arr.push($("[id*='rbtVenue_002_VI']")[0].value >= 0 ? 1 : 0)
    arr.push($("[id*='rbtFood_002_VI']")[0].value >= 0 ? 1 : 0)
    arr.push($("[id*='rbtAdminSupport_002_VI']")[0].value >= 0 ? 1 : 0)
    arr.push($("[id*='rbtOverall_002_VI']")[0].value >= 0 ? 1 : 0)

    var total = arr.reduce(getSum, 0)

    if ($("[id*='memoCommentsSuggestion_002_I']").val().length > 0) {
        total += 1;
    }

    progIndicator_002.SetPosition((total / 18) * 100.0);
}

function getSum(total, num) {
    return total + num;
}