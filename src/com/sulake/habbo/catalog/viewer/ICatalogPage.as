package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.window.IWindowContainer;
   import flash.events.Event;
   
   public interface ICatalogPage
   {
       
      
      function dispose() : void;
      
      function init() : void;
      
      function closed() : void;
      
      function dispatchWidgetEvent(param1:Event) : Boolean;
      
      function get window() : IWindowContainer;
      
      function get viewer() : ICatalogViewer;
      
      function get pageId() : int;
      
      function get offers() : Array;
      
      function get localization() : IPageLocalization;
      
      function get layoutCode() : String;
      
      function get hasLinks() : Boolean;
      
      function get links() : Array;
      
      function selectOffer(param1:int) : void;
      
      function replaceOffers(param1:Array, param2:Boolean = false) : void;
   }
}
