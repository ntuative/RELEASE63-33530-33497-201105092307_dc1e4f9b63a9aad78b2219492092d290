package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class GiftWrappingConfigurationParser implements IMessageParser
   {
       
      
      private var var_2877:Boolean;
      
      private var var_2876:int;
      
      private var var_2025:Array;
      
      private var var_829:Array;
      
      private var var_828:Array;
      
      public function GiftWrappingConfigurationParser()
      {
         super();
      }
      
      public function get isWrappingEnabled() : Boolean
      {
         return this.var_2877;
      }
      
      public function get wrappingPrice() : int
      {
         return this.var_2876;
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
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         this.var_2025 = [];
         this.var_829 = [];
         this.var_828 = [];
         this.var_2877 = param1.readBoolean();
         this.var_2876 = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.var_2025.push(param1.readInteger());
            _loc2_++;
         }
         _loc3_ = param1.readInteger();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.var_829.push(param1.readInteger());
            _loc2_++;
         }
         _loc3_ = param1.readInteger();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.var_828.push(param1.readInteger());
            _loc2_++;
         }
         return true;
      }
   }
}
