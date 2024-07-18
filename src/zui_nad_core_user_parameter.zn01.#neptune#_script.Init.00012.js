// Globals
var currentRow;

// Update Data
sap.ui.getCore().attachInit(function() {
    setTimeout(function() {
        getOnlineGetData();
    }, 200);
});
