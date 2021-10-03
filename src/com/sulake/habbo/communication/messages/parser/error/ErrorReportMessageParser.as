package com.sulake.habbo.communication.messages.parser.error
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class ErrorReportMessageParser implements IMessageParser
   {
       
      
      private var var_1662:int;
      
      private var var_1814:int;
      
      private var var_1813:String;
      
      public function ErrorReportMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_1814 = param1.readInteger();
         this.var_1662 = param1.readInteger();
         this.var_1813 = param1.readString();
         return true;
      }
      
      public function flush() : Boolean
      {
         this.var_1662 = 0;
         this.var_1814 = 0;
         this.var_1813 = null;
         return true;
      }
      
      public function get errorCode() : int
      {
         return this.var_1662;
      }
      
      public function get messageId() : int
      {
         return this.var_1814;
      }
      
      public function get timestamp() : String
      {
         return this.var_1813;
      }
   }
}
