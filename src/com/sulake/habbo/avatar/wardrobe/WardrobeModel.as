package com.sulake.habbo.avatar.wardrobe
{
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.common.ISideContentModel;
   import com.sulake.habbo.communication.messages.incoming.avatar.OutfitData;
   import com.sulake.habbo.session.HabboClubLevelEnum;
   
   public class WardrobeModel implements ISideContentModel
   {
       
      
      private var _controller:HabboAvatarEditor;
      
      private var _view:WardrobeView;
      
      private var var_482:Map;
      
      private var var_192:Boolean = false;
      
      public function WardrobeModel(param1:HabboAvatarEditor)
      {
         super();
         this._controller = param1;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         this._controller = null;
         for each(_loc1_ in this.var_482)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         this.var_482 = null;
         if(this._view)
         {
            this._view.dispose();
            this._view = null;
         }
         this.var_192 = false;
      }
      
      public function reset() : void
      {
         this.var_192 = false;
      }
      
      private function init() : void
      {
         var _loc2_:* = null;
         if(this._controller.handler != null)
         {
            this._controller.handler.getWardrobe();
         }
         if(this.var_482)
         {
            for each(_loc2_ in this.var_482)
            {
               _loc2_.dispose();
               _loc2_ = null;
            }
         }
         this.var_482 = new Map();
         var _loc1_:int = 1;
         while(_loc1_ <= 10)
         {
            this.var_482.add(_loc1_,new WardrobeSlot(this._controller,_loc1_,this.isSlotEnabled(_loc1_)));
            _loc1_++;
         }
         if(this._view)
         {
            this._view.dispose();
         }
         this._view = new WardrobeView(this);
         this.var_192 = true;
         this.updateView();
      }
      
      public function get controller() : HabboAvatarEditor
      {
         return this._controller;
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         if(!this.var_192)
         {
            this.init();
         }
         return this._view.getWindowContainer();
      }
      
      public function updateView() : void
      {
         this._view.update();
      }
      
      public function updateSlots(param1:int, param2:Array) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(!this.var_192)
         {
            return;
         }
         if(!param2)
         {
            ErrorReportStorage.addDebugData("WardrobeModel","updateSlots: outfits is null!");
         }
         if(!this.var_482)
         {
            ErrorReportStorage.addDebugData("WardrobeModel","updateSlots: _slots is null!");
         }
         for each(_loc4_ in param2)
         {
            _loc3_ = this.var_482.getValue(_loc4_.slotId) as WardrobeSlot;
            if(_loc3_)
            {
               _loc3_.update(_loc4_.figureString,_loc4_.gender,this.isSlotEnabled(_loc3_.id));
            }
         }
      }
      
      private function isSlotEnabled(param1:int) : Boolean
      {
         if(param1 <= 5)
         {
            return this._controller.sessionData.hasUserRight("fuse_use_wardrobe",HabboClubLevelEnum.const_45);
         }
         return this._controller.sessionData.hasUserRight("fuse_larger_wardrobe",HabboClubLevelEnum.const_47);
      }
      
      public function get slots() : Array
      {
         return this.var_482.getValues();
      }
   }
}
