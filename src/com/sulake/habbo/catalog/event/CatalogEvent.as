package com.sulake.habbo.catalog.event
{
   import flash.events.Event;
   
   public class CatalogEvent extends Event
   {
      
      public static const CATALOG_INITIALIZED:String = "CATALOG_INITIALIZED";
      
      public static const CATALOG_NOT_READY:String = "CATALOG_NOT_READY";
       
      
      public function CatalogEvent(param1:String)
      {
         super(param1,false,false);
      }
   }
}
