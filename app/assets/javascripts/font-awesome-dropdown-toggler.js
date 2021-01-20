$(document).ready(function(){
  $("#sidebar ul.nav").on("shown.bs.collapse", function(event){
    $(this).siblings(".sidebar-item-header").html("<i class='fa fa-chevron-up pull-right'></i> Accounts")
  })
  $("#sidebar ul.nav").on("hidden.bs.collapse", function(event){
    $(this).siblings(".sidebar-item-header").html("<i class='fa fa-chevron-down pull-right'></i> Accounts")
  })
})
