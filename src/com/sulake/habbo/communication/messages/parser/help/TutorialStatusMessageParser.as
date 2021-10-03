package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class TutorialStatusMessageParser implements IMessageParser
   {
       
      
      private var var_1155:Boolean;
      
      private var var_1154:Boolean;
      
      private var var_1417:Boolean;
      
      public function TutorialStatusMessageParser()
      {
         super();
      }
      
      public function get hasChangedLooks() : Boolean
      {
         return this.var_1155;
      }
      
      public function get hasChangedName() : Boolean
      {
         return this.var_1154;
      }
      
      public function get hasCalledGuideBot() : Boolean
      {
         return this.var_1417;
      }
      
      public function flush() : Boolean
      {
         this.var_1155 = false;
         this.var_1154 = false;
         this.var_1417 = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_1155 = param1.readBoolean();
         this.var_1154 = param1.readBoolean();
         this.var_1417 = param1.readBoolean();
         return true;
      }
   }
}
