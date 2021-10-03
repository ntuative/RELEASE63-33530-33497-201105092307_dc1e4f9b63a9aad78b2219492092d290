package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IDisposable;
   
   public class OffenceCategoryData implements INamed, IDisposable
   {
       
      
      private var _name:String;
      
      private var var_1340:Array;
      
      private var _disposed:Boolean;
      
      public function OffenceCategoryData(param1:IMessageDataWrapper)
      {
         this.var_1340 = new Array();
         super();
         this._name = param1.readString();
         Logger.log("READ CAT: " + this._name);
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.var_1340.push(new OffenceData(param1));
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         if(this._disposed)
         {
            return;
         }
         this._disposed = true;
         this.var_1340 = null;
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get offences() : Array
      {
         return this.var_1340;
      }
   }
}
