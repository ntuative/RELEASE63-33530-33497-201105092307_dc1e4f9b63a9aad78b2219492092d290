package com.sulake.habbo.roomevents.userdefinedroomevents
{
   import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
   import flash.display.BlendMode;
   import flash.display.Shader;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.ShaderFilter;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class RoomObjectHightLighter
   {
       
      
      private var var_80:HabboUserDefinedRoomEvents;
      
      private var var_1799:Array;
      
      public function RoomObjectHightLighter(param1:HabboUserDefinedRoomEvents)
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         super();
         this.var_80 = param1;
         _loc2_ = RoomObjectHightLighter_GrayscaleFilter;
         _loc3_ = new Shader(new _loc2_() as ByteArray);
         _loc4_ = new ShaderFilter(_loc3_);
         this.var_1799 = [_loc4_];
      }
      
      public function hide(param1:int) : void
      {
         this.inactivateFurni(this.getFurni(param1));
      }
      
      public function hideAll(param1:Dictionary) : void
      {
         var _loc2_:* = null;
         for(_loc2_ in param1)
         {
            Logger.log("Show furni as unselected: " + _loc2_);
            this.inactivateFurni(this.getFurni(parseInt(_loc2_)));
         }
      }
      
      public function show(param1:int) : void
      {
         this.activateFurni(this.getFurni(param1));
      }
      
      public function showAll(param1:Dictionary) : void
      {
         var _loc2_:* = null;
         for(_loc2_ in param1)
         {
            Logger.log("Show furni as selected: " + _loc2_);
            this.activateFurni(this.getFurni(parseInt(_loc2_)));
         }
      }
      
      private function getFurni(param1:int) : IRoomObject
      {
         return this.var_80.roomEngine.getRoomObject(this.var_80.roomId,this.var_80.roomCategory,param1,RoomObjectCategoryEnum.const_27);
      }
      
      private function activateFurni(param1:IRoomObject) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         if(param1)
         {
            _loc2_ = param1.getVisualization() as IRoomObjectSpriteVisualization;
            Logger.log("Furni visualization: " + _loc2_);
            _loc3_ = 0;
            while(_loc3_ < _loc2_.spriteCount)
            {
               _loc4_ = _loc2_.getSprite(_loc3_);
               if(_loc4_.blendMode != BlendMode.ADD)
               {
                  _loc4_.filters = this.var_1799;
               }
               _loc3_++;
            }
         }
      }
      
      private function inactivateFurni(param1:IRoomObject) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         if(param1)
         {
            _loc2_ = param1.getVisualization() as IRoomObjectSpriteVisualization;
            Logger.log("Furni visualization: " + _loc2_);
            _loc3_ = 0;
            while(_loc3_ < _loc2_.spriteCount)
            {
               _loc4_ = _loc2_.getSprite(_loc3_);
               _loc4_.filters = [];
               _loc3_++;
            }
         }
      }
   }
}
