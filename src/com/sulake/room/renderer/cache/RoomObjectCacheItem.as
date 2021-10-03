package com.sulake.room.renderer.cache
{
   public class RoomObjectCacheItem
   {
       
      
      private var var_462:RoomObjectLocationCacheItem = null;
      
      private var var_200:RoomObjectSortableSpriteCacheItem = null;
      
      public function RoomObjectCacheItem(param1:String)
      {
         super();
         this.var_462 = new RoomObjectLocationCacheItem(param1);
         this.var_200 = new RoomObjectSortableSpriteCacheItem();
      }
      
      public function get location() : RoomObjectLocationCacheItem
      {
         return this.var_462;
      }
      
      public function get sprites() : RoomObjectSortableSpriteCacheItem
      {
         return this.var_200;
      }
      
      public function dispose() : void
      {
         if(this.var_462 != null)
         {
            this.var_462.dispose();
            this.var_462 = null;
         }
         if(this.var_200 != null)
         {
            this.var_200.dispose();
            this.var_200 = null;
         }
      }
   }
}
