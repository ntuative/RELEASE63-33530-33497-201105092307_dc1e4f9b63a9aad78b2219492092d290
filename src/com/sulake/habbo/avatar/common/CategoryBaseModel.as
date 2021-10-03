package com.sulake.habbo.avatar.common
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   
   public class CategoryBaseModel implements IAvatarEditorCategoryModel
   {
       
      
      protected var var_100:Map;
      
      protected var _controller:HabboAvatarEditor;
      
      protected var var_192:Boolean = false;
      
      protected var _view:IAvatarEditorCategoryView;
      
      private var var_1076:Boolean;
      
      public function CategoryBaseModel(param1:HabboAvatarEditor)
      {
         super();
         this._controller = param1;
      }
      
      public function dispose() : void
      {
         if(this._view != null)
         {
            this._view.dispose();
         }
         this._view = null;
         this.var_100 = null;
         this._controller = null;
         this.var_1076 = true;
      }
      
      public function get disposed() : Boolean
      {
         return this.var_1076;
      }
      
      protected function init() : void
      {
         if(!this.var_100)
         {
            this.var_100 = new Map();
         }
      }
      
      public function reset() : void
      {
         var _loc1_:* = null;
         this.var_192 = false;
         for each(_loc1_ in this.var_100)
         {
            if(_loc1_)
            {
               _loc1_.dispose();
            }
         }
         this.var_100 = new Map();
         if(this._view)
         {
            this._view.reset();
         }
      }
      
      protected function initCategory(param1:String) : void
      {
         var _loc3_:* = null;
         var _loc2_:CategoryData = this.var_100[param1];
         if(_loc2_ == null)
         {
            _loc3_ = this._controller.generateDataContent(this,param1);
            if(_loc3_)
            {
               this.var_100[param1] = _loc3_;
               this.updateSelectionsFromFigure(param1);
            }
         }
      }
      
      public function switchCategory(param1:String) : void
      {
         if(!this.var_192)
         {
            this.init();
         }
         if(this._view)
         {
            this._view.switchCategory(param1);
         }
      }
      
      protected function updateSelectionsFromFigure(param1:String) : void
      {
         if(!this.var_100 || !this._controller || !this._controller.figureData)
         {
            return;
         }
         var _loc2_:CategoryData = this.var_100[param1];
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:int = this._controller.figureData.getPartSetId(param1);
         var _loc4_:Array = this._controller.figureData.getColourIds(param1);
         if(!_loc4_)
         {
            _loc4_ = new Array();
         }
         _loc2_.selectPartId(_loc3_);
         _loc2_.selectColorIds(_loc4_);
         if(this._view)
         {
            this._view.showPalettes(param1,_loc4_.length);
         }
      }
      
      public function hasClubItemsOverLevel(param1:int) : Boolean
      {
         var _loc3_:* = null;
         var _loc4_:Boolean = false;
         if(!this.var_100)
         {
            return false;
         }
         var _loc2_:Boolean = false;
         for each(_loc3_ in this.var_100)
         {
            if(_loc3_)
            {
               _loc4_ = _loc3_.hasClubSelectionsOverLevel(param1);
               if(_loc4_)
               {
                  _loc2_ = true;
               }
            }
         }
         return _loc2_;
      }
      
      public function stripClubItemsOverLevel(param1:int) : Boolean
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:Boolean = false;
         var _loc8_:* = null;
         if(!this.var_100)
         {
            return false;
         }
         var _loc2_:Array = this.var_100.getKeys();
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = _loc2_[_loc4_];
            _loc6_ = this.var_100[_loc5_];
            _loc7_ = false;
            if(_loc6_.stripClubItemsOverLevel(param1))
            {
               _loc7_ = true;
            }
            if(_loc6_.stripClubColorsOverLevel(param1))
            {
               _loc7_ = true;
            }
            if(_loc7_)
            {
               _loc8_ = _loc6_.getCurrentPart();
               if(_loc8_ && this._controller && this._controller.figureData && _loc6_)
               {
                  this._controller.figureData.savePartData(_loc5_,_loc8_.id,_loc6_.getSelectedColorIds(),true);
               }
               _loc3_ = true;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function selectPart(param1:String, param2:int) : void
      {
         var _loc3_:CategoryData = this.var_100[param1];
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.selectPartIndex(param2);
         var _loc4_:AvatarEditorGridPartItem = _loc3_.getCurrentPart();
         if(!_loc4_)
         {
            return;
         }
         if(this._view)
         {
            this._view.showPalettes(param1,_loc4_.colorLayerCount);
         }
         if(this._controller && this._controller.figureData)
         {
            this._controller.figureData.savePartData(param1,_loc4_.id,_loc3_.getSelectedColorIds(),true);
         }
      }
      
      public function selectColor(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:CategoryData = this.var_100[param1];
         if(_loc4_ == null)
         {
            return;
         }
         _loc4_.selectColorIndex(param2,param3);
         if(this._controller && this._controller.figureData)
         {
            this._controller.figureData.savePartSetColourId(param1,_loc4_.getSelectedColorIds(),true);
         }
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
         if(!this._view)
         {
            return null;
         }
         return this._view.getWindowContainer();
      }
      
      public function getCategoryData(param1:String) : CategoryData
      {
         if(!this.var_192)
         {
            this.init();
         }
         if(!this.var_100)
         {
            return null;
         }
         return this.var_100[param1];
      }
   }
}
