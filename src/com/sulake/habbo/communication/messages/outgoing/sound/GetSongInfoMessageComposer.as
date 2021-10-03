package com.sulake.habbo.communication.messages.outgoing.sound
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IDisposable;
   
   public class GetSongInfoMessageComposer implements IMessageComposer, IDisposable
   {
       
      
      private var var_31:Array;
      
      public function GetSongInfoMessageComposer(param1:Array)
      {
         var _loc2_:int = 0;
         this.var_31 = new Array();
         super();
         this.var_31.push(param1.length);
         for each(_loc2_ in param1)
         {
            this.var_31.push(_loc2_);
         }
      }
      
      public function getMessageArray() : Array
      {
         return this.var_31;
      }
      
      public function dispose() : void
      {
         this.var_31 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}
