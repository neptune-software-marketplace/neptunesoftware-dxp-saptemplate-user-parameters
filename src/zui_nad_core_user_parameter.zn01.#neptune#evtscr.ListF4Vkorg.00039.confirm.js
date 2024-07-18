var selectedItem = oEvent.getParameter("selectedItem");
var context = selectedItem.getBindingContext();

currentRow.PARVA = context.getProperty("VKORG");
modeltabParam.refresh();
