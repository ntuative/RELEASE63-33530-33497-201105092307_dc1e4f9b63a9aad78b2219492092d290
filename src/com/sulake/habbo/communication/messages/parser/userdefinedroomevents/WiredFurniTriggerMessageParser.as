package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.TriggerDefinition;
   
   public class WiredFurniTriggerMessageParser implements IMessageParser
   {
       
      
      private var var_1856:TriggerDefinition;
      
      public function WiredFurniTriggerMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this.var_1856 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_1856 = new TriggerDefinition(param1);
         return true;
      }
      
      public function get def() : TriggerDefinition
      {
         return this.var_1856;
      }
   }
}
