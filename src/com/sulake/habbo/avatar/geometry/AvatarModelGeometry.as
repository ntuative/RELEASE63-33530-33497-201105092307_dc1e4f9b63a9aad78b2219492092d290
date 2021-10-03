package com.sulake.habbo.avatar.geometry
{
   import com.sulake.habbo.avatar.structure.AvatarCanvas;
   import flash.utils.Dictionary;
   
   public class AvatarModelGeometry
   {
       
      
      private var var_1833:AvatarSet;
      
      private var var_768:Dictionary;
      
      private var var_1834:Dictionary;
      
      private var var_1182:Matrix4x4;
      
      private var var_956:Vector3D;
      
      private var var_162:Dictionary;
      
      public function AvatarModelGeometry(param1:XML)
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = null;
         this.var_956 = new Vector3D(0,0,10);
         super();
         this.var_1182 = new Matrix4x4();
         this.var_768 = new Dictionary();
         this.var_1834 = new Dictionary();
         this.var_1833 = new AvatarSet(param1.avatarset[0]);
         this.var_162 = new Dictionary();
         var _loc2_:XML = param1.camera[0];
         if(_loc2_ != null)
         {
            _loc11_ = parseFloat(_loc2_.x.text());
            _loc12_ = parseFloat(_loc2_.y.text());
            _loc13_ = parseFloat(_loc2_.z.text());
            this.var_956.x = _loc11_;
            this.var_956.y = _loc12_;
            this.var_956.z = _loc13_;
         }
         for each(_loc3_ in param1.canvas)
         {
            _loc14_ = String(_loc3_.@scale);
            _loc15_ = new Dictionary();
            for each(_loc4_ in _loc3_.geometry)
            {
               _loc5_ = new AvatarCanvas(_loc4_);
               _loc15_[String(_loc4_.@id)] = _loc5_;
            }
            this.var_162[_loc14_] = _loc15_;
         }
         for each(_loc6_ in param1.type)
         {
            _loc7_ = new Dictionary();
            _loc8_ = new Dictionary();
            for each(_loc9_ in _loc6_.bodypart)
            {
               _loc10_ = new GeometryBodyPart(_loc9_);
               _loc7_[String(_loc9_.@id)] = _loc10_;
               for each(_loc16_ in _loc10_.getPartIds())
               {
                  _loc8_[_loc16_] = _loc10_;
               }
            }
            this.var_768[String(_loc6_.@id)] = _loc7_;
            this.var_1834[String(_loc6_.@id)] = _loc8_;
         }
      }
      
      public function removeDynamicItems() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         for each(_loc1_ in this.var_768)
         {
            for each(_loc2_ in _loc1_)
            {
               _loc2_.removeDynamicParts();
            }
         }
      }
      
      public function getBodyPartIdsInAvatarSet(param1:String) : Array
      {
         var _loc2_:* = [];
         var _loc3_:AvatarSet = this.var_1833.findAvatarSet(param1);
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.getBodyParts();
         }
         return _loc2_;
      }
      
      public function isMainAvatarSet(param1:String) : Boolean
      {
         var _loc2_:AvatarSet = this.var_1833.findAvatarSet(param1);
         if(_loc2_ != null)
         {
            return _loc2_.isMain;
         }
         return false;
      }
      
      public function getCanvas(param1:String, param2:String) : AvatarCanvas
      {
         var _loc4_:* = null;
         var _loc3_:Dictionary = this.var_162[param1];
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_[param2] as AvatarCanvas;
         }
         return _loc4_;
      }
      
      private function typeExists(param1:String) : Boolean
      {
         return this.var_768[param1] != null;
      }
      
      private function hasBodyPart(param1:String, param2:String) : Boolean
      {
         var _loc3_:* = null;
         if(this.typeExists(param1))
         {
            _loc3_ = this.var_768[param1] as Dictionary;
            return _loc3_[param2] != null;
         }
         return false;
      }
      
      private function getBodyPartIDs(param1:String) : Array
      {
         var _loc4_:* = null;
         var _loc2_:Dictionary = this.getBodyPartsOfType(param1);
         var _loc3_:Array = new Array();
         for(_loc4_ in this.var_768)
         {
            _loc3_.push(_loc4_);
         }
         return _loc3_;
      }
      
      private function getBodyPartsOfType(param1:String) : Dictionary
      {
         if(this.typeExists(param1))
         {
            return this.var_768[param1] as Dictionary;
         }
         return new Dictionary();
      }
      
      public function getBodyPart(param1:String, param2:String) : GeometryBodyPart
      {
         var _loc3_:Dictionary = this.getBodyPartsOfType(param1);
         return _loc3_[param2];
      }
      
      public function getBodyPartOfItem(param1:String, param2:String) : GeometryBodyPart
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc3_:Dictionary = this.var_1834[param1];
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_[param2];
            if(_loc4_ != null)
            {
               return _loc4_;
            }
            _loc5_ = this.getBodyPartsOfType(param1);
            for each(_loc4_ in _loc5_)
            {
               if(_loc4_.hasPart(param2))
               {
                  return _loc4_;
               }
            }
         }
         return null;
      }
      
      private function getBodyPartsInAvatarSet(param1:Dictionary, param2:String) : Array
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = [];
         var _loc4_:Array = this.getBodyPartIdsInAvatarSet(param2);
         for each(_loc6_ in _loc4_)
         {
            _loc5_ = param1[_loc6_];
            if(_loc5_ != null)
            {
               _loc3_.push(_loc5_);
            }
         }
         return _loc3_;
      }
      
      public function getBodyPartsAtAngle(param1:String, param2:uint, param3:String) : Array
      {
         var _loc7_:* = null;
         var _loc9_:Number = NaN;
         var _loc10_:* = null;
         if(param3 == null)
         {
            Logger.log("[AvatarModelGeometry] ERROR: Geometry ID not found for action: ");
            return [];
         }
         var _loc4_:Dictionary = this.getBodyPartsOfType(param3);
         var _loc5_:Array = this.getBodyPartsInAvatarSet(_loc4_,param1);
         var _loc6_:Array = new Array();
         var _loc8_:Array = new Array();
         this.var_1182 = Matrix4x4.getYRotationMatrix(param2);
         for each(_loc7_ in _loc5_)
         {
            _loc7_.applyTransform(this.var_1182);
            _loc9_ = _loc7_.getDistance(this.var_956);
            _loc6_.push([_loc9_,_loc7_]);
         }
         _loc6_.sort(this.orderByDistance);
         for each(_loc10_ in _loc6_)
         {
            _loc7_ = _loc10_[1] as GeometryBodyPart;
            _loc8_.push(_loc7_.id);
         }
         return _loc8_;
      }
      
      public function getParts(param1:String, param2:String, param3:uint, param4:Array) : Array
      {
         var _loc5_:* = null;
         if(this.hasBodyPart(param1,param2))
         {
            _loc5_ = this.getBodyPartsOfType(param1)[param2] as GeometryBodyPart;
            this.var_1182 = Matrix4x4.getYRotationMatrix(param3);
            return _loc5_.getParts(this.var_1182,this.var_956,param4);
         }
         return [];
      }
      
      private function orderByDistance(param1:Array, param2:Array) : Number
      {
         var _loc3_:Number = param1[0] as Number;
         var _loc4_:Number = param2[0] as Number;
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         return 0;
      }
   }
}
