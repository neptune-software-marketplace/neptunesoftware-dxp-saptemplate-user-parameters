var selectedItem = oEvent.getParameter("selectedItem");
var context = selectedItem.getBindingContext();

currentRow.PARVA = context.getProperty("WERKS");
modeltabParam.refresh();
