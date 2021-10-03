package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.room.engine.SlideObjectMessageData;
   import com.sulake.room.utils.Vector3d;
   
   public class SlideObjectBundleMessageParser implements IMessageParser
   {
       
      
      private var _roomId:int = 0;
      
      private var _roomCategory:int = 0;
      
      private var _id:int;
      
      private var var_2978:Number;
      
      private var var_2979:String;
      
      private var var_1563:Array;
      
      private var var_1562:SlideObjectMessageData = null;
      
      public function SlideObjectBundleMessageParser()
      {
         super();
      }
      
      public function get roomId() : int
      {
         return this._roomId;
      }
      
      public function get roomCategory() : int
      {
         return this._roomCategory;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get avatar() : SlideObjectMessageData
      {
         return this.var_1562;
      }
      
      public function get objectList() : Array
      {
         return this.var_1563;
      }
      
      public function flush() : Boolean
      {
         this._roomId = 0;
         this._roomCategory = 0;
         this._id = -1;
         this.var_1562 = null;
         this.var_1563 = new Array();
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc7_:int = 0;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:Number = param1.readInteger();
         var _loc3_:Number = param1.readInteger();
         var _loc4_:Number = param1.readInteger();
         var _loc5_:Number = param1.readInteger();
         var _loc6_:int = param1.readInteger();
         this.var_1563 = new Array();
         var _loc13_:int = 0;
         while(_loc13_ < _loc6_)
         {
            _loc7_ = param1.readInteger();
            _loc11_ = Number(param1.readString());
            _loc12_ = Number(param1.readString());
            _loc9_ = new Vector3d(_loc2_,_loc3_,_loc11_);
            _loc10_ = new Vector3d(_loc4_,_loc5_,_loc12_);
            _loc8_ = new SlideObjectMessageData(_loc7_,_loc9_,_loc10_);
            this.var_1563.push(_loc8_);
            _loc13_++;
         }
         this._id = param1.readInteger();
         var _loc14_:int = param1.readInteger();
         switch(_loc14_)
         {
            case 0:
               break;
            case 1:
               _loc7_ = param1.readInteger();
               _loc11_ = Number(param1.readString());
               _loc12_ = Number(param1.readString());
               _loc9_ = new Vector3d(_loc2_,_loc3_,_loc11_);
               _loc10_ = new Vector3d(_loc4_,_loc5_,_loc12_);
               this.var_1562 = new SlideObjectMessageData(_loc7_,_loc9_,_loc10_,SlideObjectMessageData.const_1273);
               break;
            case 2:
               _loc7_ = param1.readInteger();
               _loc11_ = Number(param1.readString());
               _loc12_ = Number(param1.readString());
               _loc9_ = new Vector3d(_loc2_,_loc3_,_loc11_);
               _loc10_ = new Vector3d(_loc4_,_loc5_,_loc12_);
               this.var_1562 = new SlideObjectMessageData(_loc7_,_loc9_,_loc10_,SlideObjectMessageData.const_1107);
               break;
            default:
               Logger.log("** Incompatible character movetype!");
         }
         return true;
      }
   }
}
