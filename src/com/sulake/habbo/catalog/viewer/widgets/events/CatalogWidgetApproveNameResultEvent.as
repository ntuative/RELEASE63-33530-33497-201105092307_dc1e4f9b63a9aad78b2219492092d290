package com.sulake.habbo.catalog.viewer.widgets.events
{
   import flash.events.Event;
   
   public class CatalogWidgetApproveNameResultEvent extends Event
   {
       
      
      private var _result:int;
      
      private var var_1737:String;
      
      public function CatalogWidgetApproveNameResultEvent(param1:int, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(WidgetEvent.const_797,param3,param4);
         this._result = param1;
         this.var_1737 = param2;
      }
      
      public function get result() : int
      {
         return this._result;
      }
      
      public function get nameValidationInfo() : String
      {
         return this.var_1737;
      }
   }
}
