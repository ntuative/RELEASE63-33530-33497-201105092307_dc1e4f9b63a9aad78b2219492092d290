package com.sulake.habbo.catalog.viewer.widgets.events
{
   import com.sulake.core.utils.Map;
   import flash.events.Event;
   
   public class RentableBotDefinitionWidgetEvent extends Event
   {
       
      
      private var var_1900:Map;
      
      public function RentableBotDefinitionWidgetEvent(param1:Map, param2:Boolean = false, param3:Boolean = false)
      {
         super(WidgetEvent.CWE_RENTABLE_BOT_DEFINITIONS,param2,param3);
         this.var_1900 = param1;
      }
      
      public function get botFigureData() : Map
      {
         return this.var_1900;
      }
   }
}
