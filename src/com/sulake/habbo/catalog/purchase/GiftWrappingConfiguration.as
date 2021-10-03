package com.sulake.habbo.catalog.purchase
{
   import com.sulake.habbo.communication.messages.incoming.catalog.GiftWrappingConfigurationEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.GiftWrappingConfigurationParser;
   
   public class GiftWrappingConfiguration
   {
       
      
      private var var_1592:Boolean = false;
      
      private var var_1645:int;
      
      private var var_2025:Array;
      
      private var var_829:Array;
      
      private var var_828:Array;
      
      public function GiftWrappingConfiguration(param1:GiftWrappingConfigurationEvent)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         var _loc2_:GiftWrappingConfigurationParser = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         this.var_1592 = _loc2_.isWrappingEnabled;
         this.var_1645 = _loc2_.wrappingPrice;
         this.var_2025 = _loc2_.stuffTypes;
         this.var_829 = _loc2_.boxTypes;
         this.var_828 = _loc2_.ribbonTypes;
      }
      
      public function get isEnabled() : Boolean
      {
         return this.var_1592;
      }
      
      public function get price() : int
      {
         return this.var_1645;
      }
      
      public function get stuffTypes() : Array
      {
         return this.var_2025;
      }
      
      public function get boxTypes() : Array
      {
         return this.var_829;
      }
      
      public function get ribbonTypes() : Array
      {
         return this.var_828;
      }
   }
}
