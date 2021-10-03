package com.sulake.habbo.communication.messages.outgoing.marketplace
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class BuyMarketplaceTokensMessageComposer implements IMessageComposer
   {
       
      
      public function BuyMarketplaceTokensMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return new Array();
      }
      
      public function dispose() : void
      {
      }
   }
}
