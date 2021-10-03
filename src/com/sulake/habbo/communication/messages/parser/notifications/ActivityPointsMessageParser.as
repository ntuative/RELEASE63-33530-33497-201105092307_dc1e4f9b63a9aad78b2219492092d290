package com.sulake.habbo.communication.messages.parser.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import flash.utils.Dictionary;
   
   public class ActivityPointsMessageParser implements IMessageParser
   {
       
      
      private var var_2040:Dictionary;
      
      public function ActivityPointsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this.var_2040 = new Dictionary();
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readInteger();
            _loc5_ = param1.readInteger();
            this.var_2040[_loc4_] = _loc5_;
            _loc3_++;
         }
         return true;
      }
      
      public function get points() : Dictionary
      {
         return this.var_2040;
      }
   }
}
