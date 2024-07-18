var context = oEvent.oSource.getBindingContext();
var value = context.getProperty("PARID");
currentRow = context.getObject();

switch (value) {

    case "WRK":
        if (!modelListF4Werks.oData.length) {
            getOnlineListF4Werks();
        } else {
            ListF4Werks.open();
        }
        break;

    case "EKO":
        if (!modelListF4Ekorg.oData.length) {
            getOnlineListF4Ekorg();
        } else {
            ListF4Ekorg.open();
        }
        break;

    case "EKG":
        if (!modelListF4Ekgrp.oData.length) {
            getOnlineListF4Ekgrp();
        } else {
            ListF4Ekgrp.open();
        }
        break;

    case "VKO":
        if (!modelListF4Vkorg.oData.length) {
            getOnlineListF4Vkorg();
        } else {
            ListF4Vkorg.open();
        }
        break;

    case "SPA":
        if (!modelListF4Spart.oData.length) {
            getOnlineListF4Spart();
        } else {
            ListF4Spart.open();
        }
        break;

    case "VTW":
        getOnlineListF4Vtweg();
        break;

    default:
        break;

}
