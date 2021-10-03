package com.sulake.habbo.communication.messages.incoming.avatar
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class OutfitData
   {
       
      
      private var var_2067:int;
      
      private var var_2369:String;
      
      private var var_1060:String;
      
      public function OutfitData(param1:IMessageDataWrapper)
      {
         super();
         this.var_2067 = param1.readInteger();
         this.var_2369 = param1.readString();
         this.var_1060 = param1.readString();
      }
      
      public function get slotId() : int
      {
         return this.var_2067;
      }
      
      public function get figureString() : String
      {
         return this.var_2369;
      }
      
      public function get gender() : String
      {
         return this.var_1060;
      }
   }
}
