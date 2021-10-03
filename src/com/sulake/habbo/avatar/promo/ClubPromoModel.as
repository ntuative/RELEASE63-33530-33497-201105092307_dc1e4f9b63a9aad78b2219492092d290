package com.sulake.habbo.avatar.promo
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.common.ISideContentModel;
   
   public class ClubPromoModel implements ISideContentModel
   {
       
      
      private var _controller:HabboAvatarEditor;
      
      private var _view:ClubPromoView;
      
      public const const_2208:String = "try_club";
      
      public const const_2207:String = "buy_club";
      
      public function ClubPromoModel(param1:HabboAvatarEditor)
      {
         super();
         this._controller = param1;
      }
      
      public function dispose() : void
      {
         if(this._view)
         {
            this._view.dispose();
            this._view = null;
         }
      }
      
      public function reset() : void
      {
      }
      
      private function init() : void
      {
         if(!this._view)
         {
            this._view = new ClubPromoView(this);
         }
      }
      
      public function tryClubClothes() : void
      {
         this._view.showBuyView();
         if(this.controller)
         {
            this.controller.useClubClothing();
         }
      }
      
      public function get controller() : HabboAvatarEditor
      {
         return this._controller;
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         this.init();
         if(this._view)
         {
            return this._view.getWindowContainer();
         }
         return null;
      }
   }
}
