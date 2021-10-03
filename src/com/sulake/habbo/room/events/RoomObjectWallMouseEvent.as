package com.sulake.habbo.room.events
{
   import com.sulake.room.events.RoomObjectMouseEvent;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   public class RoomObjectWallMouseEvent extends RoomObjectMouseEvent
   {
       
      
      private var _x:Number;
      
      private var var_152:Number;
      
      private var _direction:Number;
      
      private var var_1782:Vector3d = null;
      
      private var var_1783:Vector3d = null;
      
      private var var_1781:Vector3d = null;
      
      public function RoomObjectWallMouseEvent(param1:String, param2:String, param3:int, param4:String, param5:IVector3d, param6:IVector3d, param7:IVector3d, param8:Number, param9:Number, param10:Number, param11:Boolean = false, param12:Boolean = false, param13:Boolean = false, param14:Boolean = false, param15:Boolean = false, param16:Boolean = false)
      {
         super(param1,param2,param3,param4,param11,param12,param13,param14,param15,param16);
         this.var_1782 = new Vector3d();
         this.var_1782.assign(param5);
         this.var_1783 = new Vector3d();
         this.var_1783.assign(param6);
         this.var_1781 = new Vector3d();
         this.var_1781.assign(param7);
         this._x = param8;
         this.var_152 = param9;
         this._direction = param10;
      }
      
      public function get wallLocation() : IVector3d
      {
         return this.var_1782;
      }
      
      public function get wallWidth() : IVector3d
      {
         return this.var_1783;
      }
      
      public function get wallHeight() : IVector3d
      {
         return this.var_1781;
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function get y() : Number
      {
         return this.var_152;
      }
      
      public function get direction() : Number
      {
         return this._direction;
      }
   }
}
