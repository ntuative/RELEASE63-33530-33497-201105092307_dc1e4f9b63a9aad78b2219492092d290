package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.habbo.room.object.visualization.data.DirectionalOffsetData;
   import com.sulake.room.object.IRoomObjectModel;
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   
   public class FurnitureRoomBackgroundVisualization extends FurnitureRoomBrandingVisualization
   {
       
      
      private var var_746:Dictionary;
      
      public function FurnitureRoomBackgroundVisualization()
      {
         super();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.var_746 = null;
      }
      
      override protected function getAdClickUrl(param1:IRoomObjectModel) : String
      {
         return null;
      }
      
      override protected function imageReady(param1:BitmapData, param2:String) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         super.imageReady(param1,param2);
         if(param1 != null)
         {
            this.var_746 = new Dictionary();
            _loc3_ = 64;
            _loc4_ = param1.width;
            _loc5_ = param1.height;
            this.addDirectionalOffsets(_loc3_,_loc5_,_loc4_);
            _loc3_ = 32;
            _loc4_ /= 2;
            _loc5_ /= 2;
            this.addDirectionalOffsets(_loc3_,_loc5_,_loc4_);
         }
      }
      
      private function addDirectionalOffsets(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:int = getSize(param1);
         var _loc5_:DirectionalOffsetData = new DirectionalOffsetData();
         _loc5_.setOffset(1,0,-param2);
         _loc5_.setOffset(3,0,0);
         _loc5_.setOffset(5,-param3,0);
         _loc5_.setOffset(7,-param3,-param2);
         _loc5_.setOffset(4,-param3 / 2,-param2 / 2);
         this.var_746[_loc4_] = _loc5_;
      }
      
      override protected function getSpriteXOffset(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         if(this.var_746 != null)
         {
            _loc4_ = getSize(param1);
            _loc5_ = this.var_746[_loc4_];
            if(_loc5_ != null)
            {
               return _loc5_.getOffsetX(param2,0);
            }
         }
         return super.getSpriteXOffset(param1,param2,param3);
      }
      
      override protected function getSpriteYOffset(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         if(this.var_746 != null)
         {
            _loc4_ = getSize(param1);
            _loc5_ = this.var_746[_loc4_];
            if(_loc5_ != null)
            {
               return _loc5_.getOffsetY(param2,0);
            }
         }
         return super.getSpriteYOffset(param1,param2,param3);
      }
   }
}
