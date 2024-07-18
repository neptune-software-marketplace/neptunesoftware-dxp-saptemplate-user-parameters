var binding = oEvent.getParameter("itemsBinding");
var value = oEvent.getParameter("value");
var filter = new sap.ui.model.Filter("PARVA", "Contains", value);
binding.filter([filter]);
