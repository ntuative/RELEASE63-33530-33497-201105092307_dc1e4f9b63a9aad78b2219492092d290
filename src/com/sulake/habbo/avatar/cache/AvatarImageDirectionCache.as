package com.sulake.habbo.avatar.cache
{
   import com.sulake.habbo.avatar.AvatarImageBodyPartContainer;
   import com.sulake.habbo.avatar.AvatarImagePartContainer;
   import flash.utils.Dictionary;
   
   public class AvatarImageDirectionCache
   {
       
      
      private var var_1749:Array;
      
      private var _images:Dictionary;
      
      public function AvatarImageDirectionCache(param1:Array)
      {
         super();
         this._images = new Dictionary();
         this.var_1749 = param1;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in this._images)
         {
            if(_loc1_)
            {
               _loc1_.dispose();
            }
         }
         this._images = null;
      }
      
      public function getPartList() : Array
      {
         return this.var_1749;
      }
      
      public function getImageContainer(param1:int) : AvatarImageBodyPartContainer
      {
         var _loc2_:String = this.getCacheKey(param1);
         return this._images[_loc2_];
      }
      
      public function updateImageContainer(param1:AvatarImageBodyPartContainer, param2:int) : void
      {
         var _loc4_:* = null;
         var _loc3_:String = this.getCacheKey(param2);
         if(this._images[_loc3_])
         {
            _loc4_ = this._images[_loc3_] as AvatarImageBodyPartContainer;
            if(_loc4_)
            {
               _loc4_.dispose();
            }
         }
         this._images[_loc3_] = param1;
      }
      
      private function getCacheKey(param1:int) : String
      {
         var _loc3_:* = null;
         var _loc2_:* = "";
         for each(_loc3_ in this.var_1749)
         {
            _loc2_ = _loc2_ + _loc3_.partId + ":" + _loc3_.getFrameIndex(param1) + "/";
         }
         return _loc2_;
      }
      
      private function debugInfo(param1:String) : void
      {
      }
   }
}
