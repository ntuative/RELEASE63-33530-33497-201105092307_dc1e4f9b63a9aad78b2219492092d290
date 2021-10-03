package com.sulake.habbo.room.utils
{
   import com.sulake.core.utils.Map;
   
   public class RoomInstanceData
   {
       
      
      private var _roomId:int = 0;
      
      private var _roomCategory:int = 0;
      
      private var var_821:TileHeightMap = null;
      
      private var var_1270:LegacyWallGeometry = null;
      
      private var var_1269:RoomCamera = null;
      
      private var var_823:SelectedRoomObjectData = null;
      
      private var var_822:SelectedRoomObjectData = null;
      
      private var _worldType:String = null;
      
      private var var_559:Map;
      
      private var var_558:Map;
      
      public function RoomInstanceData(param1:int, param2:int)
      {
         this.var_559 = new Map();
         this.var_558 = new Map();
         super();
         this._roomId = param1;
         this._roomCategory = param2;
         this.var_1270 = new LegacyWallGeometry();
         this.var_1269 = new RoomCamera();
      }
      
      public function get roomId() : int
      {
         return this._roomId;
      }
      
      public function get roomCategory() : int
      {
         return this._roomCategory;
      }
      
      public function get tileHeightMap() : TileHeightMap
      {
         return this.var_821;
      }
      
      public function set tileHeightMap(param1:TileHeightMap) : void
      {
         if(this.var_821 != null)
         {
            this.var_821.dispose();
         }
         this.var_821 = param1;
      }
      
      public function get legacyGeometry() : LegacyWallGeometry
      {
         return this.var_1270;
      }
      
      public function get roomCamera() : RoomCamera
      {
         return this.var_1269;
      }
      
      public function get worldType() : String
      {
         return this._worldType;
      }
      
      public function set worldType(param1:String) : void
      {
         this._worldType = param1;
      }
      
      public function get selectedObject() : SelectedRoomObjectData
      {
         return this.var_823;
      }
      
      public function set selectedObject(param1:SelectedRoomObjectData) : void
      {
         if(this.var_823 != null)
         {
            this.var_823.dispose();
         }
         this.var_823 = param1;
      }
      
      public function get placedObject() : SelectedRoomObjectData
      {
         return this.var_822;
      }
      
      public function set placedObject(param1:SelectedRoomObjectData) : void
      {
         if(this.var_822 != null)
         {
            this.var_822.dispose();
         }
         this.var_822 = param1;
      }
      
      public function dispose() : void
      {
         if(this.var_821 != null)
         {
            this.var_821.dispose();
            this.var_821 = null;
         }
         if(this.var_1270 != null)
         {
            this.var_1270.dispose();
            this.var_1270 = null;
         }
         if(this.var_1269 != null)
         {
            this.var_1269.dispose();
            this.var_1269 = null;
         }
         if(this.var_823 != null)
         {
            this.var_823.dispose();
            this.var_823 = null;
         }
         if(this.var_822 != null)
         {
            this.var_822.dispose();
            this.var_822 = null;
         }
         if(this.var_559 != null)
         {
            this.var_559.dispose();
            this.var_559 = null;
         }
         if(this.var_558 != null)
         {
            this.var_558.dispose();
            this.var_558 = null;
         }
      }
      
      public function addFurnitureData(param1:FurnitureData) : void
      {
         if(param1 != null)
         {
            this.var_559.remove(param1.id);
            this.var_559.add(param1.id,param1);
         }
      }
      
      public function getFurnitureData() : FurnitureData
      {
         if(this.var_559.length > 0)
         {
            return this.getFurnitureDataWithId(this.var_559.getKey(0));
         }
         return null;
      }
      
      public function getFurnitureDataWithId(param1:int) : FurnitureData
      {
         return this.var_559.remove(param1);
      }
      
      public function addWallItemData(param1:FurnitureData) : void
      {
         if(param1 != null)
         {
            this.var_558.remove(param1.id);
            this.var_558.add(param1.id,param1);
         }
      }
      
      public function getWallItemData() : FurnitureData
      {
         if(this.var_558.length > 0)
         {
            return this.getWallItemDataWithId(this.var_558.getKey(0));
         }
         return null;
      }
      
      public function getWallItemDataWithId(param1:int) : FurnitureData
      {
         return this.var_558.remove(param1);
      }
   }
}
