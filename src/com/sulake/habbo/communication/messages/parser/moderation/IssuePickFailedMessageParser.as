package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class IssuePickFailedMessageParser implements IMessageParser
   {
       
      
      private var _issues:Array;
      
      private var var_2660:Boolean;
      
      private var include:int;
      
      public function IssuePickFailedMessageParser()
      {
         super();
      }
      
      public function get issues() : Array
      {
         return this._issues;
      }
      
      public function get retryEnabled() : Boolean
      {
         return this.var_2660;
      }
      
      public function get retryCount() : int
      {
         return this.include;
      }
      
      public function flush() : Boolean
      {
         this._issues = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:* = null;
         this._issues = new Array();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readInteger();
            _loc5_ = param1.readInteger();
            _loc6_ = param1.readString();
            _loc7_ = new IssueMessageData(_loc4_,0,0,0,0,0,0,null,0,null,_loc5_,_loc6_,null,0,null,0,null,0,null,null,0,0);
            this._issues.push(_loc7_);
            _loc3_++;
         }
         this.var_2660 = param1.readBoolean();
         this.include = param1.readInteger();
         return true;
      }
   }
}
