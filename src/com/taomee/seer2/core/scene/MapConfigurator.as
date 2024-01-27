package com.taomee.seer2.core.scene {
import com.taomee.seer2.core.entity.AnimateElement;
import com.taomee.seer2.core.entity.AnimateElementManager;
import com.taomee.seer2.core.entity.IExtendedEntity;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.definition.AnimationDefinition;
import com.taomee.seer2.core.entity.definition.NpcDefinition;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.utils.Util;

import org.taomee.utils.DomainUtil;

public class MapConfigurator {

    public static const EXTENDED_ENTITY_BASE:String = "com.taomee.seer2.app.entity.";

    public static const DREAM_ENTITY_BASE:String = "com.taomee.seer2.app.dream.";


    private var _mapModel:MapModel;

    private var _configXml:XML;

    public function MapConfigurator(param1:MapModel) {
        super();
        this._mapModel = param1;
        this._configXml = this._mapModel.configXml;
    }

    public function config():void {
        this.parseEntities();
    }

    private function parseEntities():void {
        var _loc2_:XML = null;
        var _loc3_:String = null;
        var _loc1_:XMLList = this._configXml.elements("entities").elements("*");
        for each(_loc2_ in _loc1_) {
            _loc3_ = String(_loc2_.name().toString());
            switch (_loc3_) {
                case "animation":
                    this.parseAnimation(_loc2_);
                    break;
                case "npc":
                    this.parseNpc(_loc2_);
                    break;
                default:
                    this.parseExtendEntity(_loc3_, _loc2_);
                    break;
            }
        }
    }

    private function parseAnimation(param1:XML):void {
        var _loc2_:AnimationDefinition = new AnimationDefinition(param1);
        AnimateElementManager.createElement(this._mapModel.libManager, _loc2_);
    }

    private function parseNpc(param1:XML):void {
        var _loc2_:NpcDefinition = new NpcDefinition(param1);
        MobileManager.createNpc(_loc2_);
    }

    private function parseExtendEntity(param1:String, param2:XML):void {
        var _loc4_:AnimateElement = null;
        var _loc5_:Number = NaN;
        var _loc6_:Number = NaN;
        var _loc7_:AnimateElement = null;
        var _loc3_:Class = DomainUtil.getCurrentDomainClass(EXTENDED_ENTITY_BASE + Util.capitalizeFirstLetter(param1));
        if (_loc3_) {
            (_loc4_ = new _loc3_() as AnimateElement).id = uint(param2.attribute("id").toString());
            if (_loc4_ is IExtendedEntity) {
                (_loc4_ as IExtendedEntity).setData(param2);
            }
            AnimateElementManager.addElement(_loc4_);
            if (MapLoader.isDream) {
                if (Util.capitalizeFirstLetter(param1) == "Teleport" || Util.capitalizeFirstLetter(param1) == "teleport") {
                    _loc4_.visible = false;
                    if (_loc4_.id == 1) {
                        _loc5_ = _loc4_.x;
                        _loc6_ = _loc4_.y;
                        _loc3_ = DomainUtil.getCurrentDomainClass(DREAM_ENTITY_BASE + Util.capitalizeFirstLetter("DreamSystemTeleport"));
                        ((_loc7_ = new _loc3_() as AnimateElement) as IExtendedEntity).setData(<teleport name="离开梦境"
                                                                                                         pos="1,1"
                                                                                                         targetMapId="70"/>);
                        _loc7_.x = _loc5_;
                        _loc7_.y = _loc6_;
                        AnimateElementManager.addElement(_loc7_);
                    }
                }
            }
        }
    }

    public function dispose():void {
        this._mapModel = null;
        this._configXml = null;
    }
}
}
