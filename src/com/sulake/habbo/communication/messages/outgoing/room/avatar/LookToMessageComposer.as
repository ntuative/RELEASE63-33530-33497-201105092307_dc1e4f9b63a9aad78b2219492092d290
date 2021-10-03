package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class LookToMessageComposer implements IMessageComposer
   {
       
      
      private var var_2215:int;
      
      private var var_2214:int;
      
      public function LookToMessageComposer(param1:int, param2:int)
      {
         super();
         this.var_2215 = param1;
         this.var_2214 = param2;
      }
      
      public function getMessageArray() : Array
      {
         return [this.var_2215,this.var_2214];
      }
      
      public function dispose() : void
      {
      }
   }
}
