$(function () {
    $("#tabTraining_pnlTraining_003, " +
      "#tabTraining_pnlTraining_004, " +
      "#tabTraining_pnlTraining_005, " +
      "#tabTraining_pnlTraining_006").each(function () {

          var id = $(this).attr("id");
          var $tbl = $(this).find("> tbody > tr > td > table");

          var $hdr = $tbl.find("> tbody > tr:eq(1)");

          $hdr.css("cursor", "pointer");
          $hdr.data("isexpanded", true);

          $hdr.click(function () {
              var $this = $(this);

              if ($this.data("isexpanded") == true) {
                  $tbl.find("> tbody > tr:eq(2)").hide();
                  $tbl.find("> tbody > tr:eq(3)").hide();

                  $this.data("isexpanded", false);
              } else {
                  $tbl.find("> tbody > tr:eq(2)").show();
                  $tbl.find("> tbody > tr:eq(3)").show();

                  if (id.indexOf("_003") >= 0) {
                      dgView_006.Refresh();
                  } else if (id.indexOf("_004") >= 0) {
                      dgView_007.Refresh();
                  } else if (id.indexOf("_005") >= 0) {
                      dgView_008.Refresh();
                  } else if (id.indexOf("_006") >= 0) {
                      dgView_009.Refresh();
                  }

                  $this.data("isexpanded", true);
              }
          });

          if ((id.indexOf("_004") >= 0 ||
              id.indexOf("_005") >= 0 ||
              id.indexOf("_006") >= 0)) {
              $hdr.click();
          }
      });
    //jlacno will merge this and the top later.
    $("#expandAll, #collapseAll").click(function (e) {
        e.preventDefault();

        var id = $(this).attr("id");

        var $tbl003 = $("#tabTraining_pnlTraining_003 > tbody > tr > td > table > tbody > tr:eq(1)");
        var $tbl004 = $("#tabTraining_pnlTraining_004 > tbody > tr > td > table > tbody > tr:eq(1)");
        var $tbl005 = $("#tabTraining_pnlTraining_005 > tbody > tr > td > table > tbody > tr:eq(1)");
        var $tbl006 = $("#tabTraining_pnlTraining_006 > tbody > tr > td > table > tbody > tr:eq(1)");

        if (id == "expandAll") {
            $tbl003.data("isexpanded", false);
            $tbl004.data("isexpanded", false);
            $tbl005.data("isexpanded", false);
            $tbl006.data("isexpanded", false);
        } else if (id == "collapseAll") {
            $tbl003.data("isexpanded", true);
            $tbl004.data("isexpanded", true);
            $tbl005.data("isexpanded", true);
            $tbl006.data("isexpanded", true);
        }

        $tbl003.click();
        $tbl004.click();
        $tbl005.click();
        $tbl006.click();
    });

    
    $("#tabTraining_pnlAgreement_001, " +
      "#tabTraining_pnlAgreement_002, " +
      "#tabTraining_pnlAgreement_003, " +
      "#tabTraining_pnlAgreement_004").each(function () {
          var id = $(this).attr("id");
          var $tbl = $(this).find("> tbody > tr > td > table");

          var $hdr = $tbl.find("> tbody > tr:eq(1)");

          $hdr.css("cursor", "pointer");
          $hdr.data("isexpanded", true);

          $hdr.click(function () {
              var $this = $(this);

              if ($this.data("isexpanded") == true) {
                  $tbl.find("> tbody > tr:eq(2)").hide();
                  $tbl.find("> tbody > tr:eq(3)").hide();

                  $this.data("isexpanded", false);
              } else {
                  $tbl.find("> tbody > tr:eq(2)").show();
                  $tbl.find("> tbody > tr:eq(3)").show();

                  $this.data("isexpanded", true);
              }
          });

          if (id.indexOf("_002") >= 0 ||
              id.indexOf("_003") >= 0 ||
              id.indexOf("_004") >= 0) {
              $hdr.click();
          }

          //if (isPostBack && (id.indexOf("_002") >= 0 ||
          //    id.indexOf("_003") >= 0 ||
          //    id.indexOf("_004") >= 0)) {
          //    $hdr.click();
          //    if (id.indexOf("_004") >= 0) {
          //        isPostBack = false;
          //    }
          //}
      });

    $("#expandAgreement, #collapseAgreement").click(function (e) {
        e.preventDefault();

        var id = $(this).attr("id");

        var $tbl001 = $("#tabTraining_pnlAgreement_001 > tbody > tr > td > table > tbody > tr:eq(1)");
        var $tbl002 = $("#tabTraining_pnlAgreement_002 > tbody > tr > td > table > tbody > tr:eq(1)");
        var $tbl003 = $("#tabTraining_pnlAgreement_003 > tbody > tr > td > table > tbody > tr:eq(1)");
        var $tbl004 = $("#tabTraining_pnlAgreement_004 > tbody > tr > td > table > tbody > tr:eq(1)");

        if (id == "expandAgreement") {
            $tbl001.data("isexpanded", false);
            $tbl002.data("isexpanded", false);
            $tbl003.data("isexpanded", false);
            $tbl004.data("isexpanded", false);
        } else if (id == "collapseAgreement") {
            $tbl001.data("isexpanded", true);
            $tbl002.data("isexpanded", true);
            $tbl003.data("isexpanded", true);
            $tbl004.data("isexpanded", true);
        }

        $tbl001.click();
        $tbl002.click();
        $tbl003.click();
        $tbl004.click();
    });
});

var addFormSpecificYesOrNo = function () {
    $("#tabTraining_pnlAgreement_004_btnMainSubmit_014").click();
};

function dgView_008_009_cbCourse_SelectedIndexChanged(s, e, id) {
    var value = s.GetValue();

    if (value != undefined) {
        if (id == "dgView_008") {
            dgView_008.PerformCallback('<ID=CourseName><Value=' + value.toString() + '>');
        } else if (id == "dgView_009") {
            dgView_009.PerformCallback('<ID=CourseName><Value=' + value.toString() + '>');
        }        
    }
}