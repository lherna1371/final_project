function setup(){catBoard=new catList(".dish_categories"),catBoard.initialize()}var searchBar=function(t){this.el=$(t),this.search=""};searchBar.prototype.setSearch=function(t){if(this.search!=t){this.search=t;var i=$("#url").text(),e=t.replace("      ","").replace("    ","").replace(/(\r\n|\n|\r)/gm,""),a={url:i,search:e};$.ajax({url:"/"+i+"/dishes",data:a,method:"GET"}).done(function(t){console.log("in"),$(".dish_layout").html(""),$(".dish_layout").append(t)})}};var catList=function(t){this.el=$(t),this.categories=[]};catList.prototype.initialize=function(){var t=this;this.searchBar=new searchBar("#search_field"),$.each(this.el.find("li"),function(){var i=new Category($(this).find("button"),t);t.addCat(i)})},catList.prototype.addCat=function(t){this.categories.push(t)};var Category=function(t,i){this.el=$(t),this.list=i,this.buttonDown=!1,this.initialize()};Category.prototype.initialize=function(){var t=this;this.el.on("click",function(i){i.stopPropagation(),$(t.list.categories).each(function(){this.buttonDown=!1,$(this.el).removeClass("button_down")}),t.list.searchBar.setSearch(t.el.text()),t.buttonDown=!0,$(this).addClass("button_down")})},$(document).on("ready",setup),$(document).on("page:load",setup);