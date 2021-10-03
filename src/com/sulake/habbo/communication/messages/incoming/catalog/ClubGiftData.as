package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class ClubGiftData
   {
       
      
      private var _offerId:int;
      
      private var var_2375:Boolean;
      
      private var var_2377:Boolean;
      
      private var var_2376:int;
      
      public function ClubGiftData(param1:IMessageDataWrapper)
      {
         super();
         this._offerId = param1.readInteger();
         this.var_2375 = param1.readBoolean();
         this.var_2376 = param1.readInteger();
         this.var_2377 = param1.readBoolean();
      }
      
      public function get offerId() : int
      {
         return this._offerId;
      }
      
      public function get isVip() : Boolean
      {
         return this.var_2375;
      }
      
      public function get isSelectable() : Boolean
      {
         return this.var_2377;
      }
      
      public function get daysRequired() : int
      {
         return this.var_2376;
      }
   }
}
