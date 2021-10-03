package com.sulake.habbo.catalog.recycler
{
   public class FurniSlotItem
   {
       
      
      private var _id:int = 0;
      
      private var _category:int = 0;
      
      private var var_2166:int = 0;
      
      private var var_2830:String = null;
      
      public function FurniSlotItem(param1:int, param2:int, param3:int = 0, param4:String = null)
      {
         super();
         this._id = param1;
         this._category = param2;
         this.var_2166 = param3;
         this.var_2830 = param4;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get category() : int
      {
         return this._category;
      }
      
      public function get typeId() : int
      {
         return this.var_2166;
      }
      
      public function get xxxExtra() : String
      {
         return this.var_2830;
      }
      
      public function set id(param1:int) : void
      {
         this._id = param1;
      }
   }
}
