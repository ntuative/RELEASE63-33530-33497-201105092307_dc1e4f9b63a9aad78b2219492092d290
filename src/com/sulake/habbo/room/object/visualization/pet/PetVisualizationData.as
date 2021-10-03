package com.sulake.habbo.room.object.visualization.pet
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.habbo.avatar.IAvatarImage;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.avatar.IPetImageListener;
   import com.sulake.habbo.avatar.enum.AvatarScaleType;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   
   public class PetVisualizationData implements IRoomObjectVisualizationData
   {
       
      
      private var _avatarRenderer:IAvatarRenderManager = null;
      
      public function PetVisualizationData()
      {
         super();
      }
      
      public function get avatarRenderer() : IAvatarRenderManager
      {
         return this._avatarRenderer;
      }
      
      public function set avatarRenderer(param1:IAvatarRenderManager) : void
      {
         this._avatarRenderer = param1;
      }
      
      public function initialize(param1:XML) : Boolean
      {
         return true;
      }
      
      public function dispose() : void
      {
         this._avatarRenderer = null;
      }
      
      public function getAvatar(param1:String, param2:Number, param3:IPetImageListener) : IAvatarImage
      {
         var _loc4_:* = null;
         if(this._avatarRenderer != null)
         {
            _loc4_ = null;
            if(param2 > 48)
            {
               _loc4_ = this._avatarRenderer.createPetImageFromFigure(param1,AvatarScaleType.const_56,param3);
            }
            else
            {
               _loc4_ = this._avatarRenderer.createPetImageFromFigure(param1,AvatarScaleType.const_91,param3);
            }
            return _loc4_;
         }
         return null;
      }
      
      public function getLayerCount(param1:String) : Number
      {
         return 0;
      }
      
      public function getAvatarRendererAsset(param1:String) : IAsset
      {
         if(this._avatarRenderer == null)
         {
            return null;
         }
         return this._avatarRenderer.assets.getAssetByName(param1);
      }
   }
}
