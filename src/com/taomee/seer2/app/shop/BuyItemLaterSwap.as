package com.taomee.seer2.app.shop {
import com.adobe.crypto.MD5;
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.config.MatchingConfig;
import com.taomee.seer2.app.config.ShopPanelConfig;
import com.taomee.seer2.app.config.info.ShopItemInfo;
import com.taomee.seer2.app.net.parser.Parser_1224;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.shopManager.ShopManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.LittleEndianByteArray;
import com.taomee.seer2.core.utils.URLUtil;

public class BuyItemLaterSwap {

    private static var _itemId:uint;

    private static var _completeFun:Function;

    private static var _itemType:String;


    public function BuyItemLaterSwap() {
        super();
    }

    public static function start(param1:uint, param2:Function, param3:String = "hideShop"):void {
        _itemId = param1;
        _completeFun = param2;
        _itemType = param3;
        getMeeCoin();
    }

    private static function getMeeCoin():void {
        var _info:ShopItemInfo = null;
        var list:Vector.<ShopItemInfo> = ShopPanelConfig.getInfoList(_itemType);
        var newId:uint = MatchingConfig.getOldId(_itemId);
        var i:int = 0;
        while (i < list.length) {
            if (list[i].referenceId == newId) {
                _info = list[i];
                break;
            }
            i++;
        }
        if (!_info) {
            AlertManager.showAlert("购买的物品" + newId + "不存在");
            return;
        }
        ShopManager.checkReally(_info.price, function (param1:Boolean):void {
            var b:Boolean = param1;
            AlertManager.showConfirm("您确定花费" + _info.price + "购买" + _info.name + "?", function ():void {
                if (b) {
                    ActiveCountManager.requestActiveCount(202148, function (param1:uint, param2:uint):void {
                        var type:uint = param1;
                        var count:uint = param2;
                        if (count != 0) {
                            AlertManager.showConfirm("请先关闭支付密码的输入", function ():void {
                                ModuleManager.showModule(URLUtil.getAppModule("ChpherPanel"), "正在打开...");
                            });
                        } else {
                            nextBuyItem();
                        }
                    });
                    return;
                }
                AlertManager.showAlert("星钻余额不足，请充值之后再试!");
            });
        });
    }

    private static function nextBuyItem():void {
        var _loc5_:String = null;
        var _loc6_:int = 0;
        var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
        var _loc2_:String = String(MD5.hash("0"));
        var _loc3_:int = _loc2_.length;
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            _loc5_ = _loc2_.substr(_loc4_, 2);
            _loc6_ = parseInt(_loc5_, 16);
            _loc1_.writeByte(_loc6_);
            _loc4_ += 2;
        }
        ShopManager.buyShopItem(_itemId, 1, _loc1_, nextSwap);
    }

    private static function nextSwap(param1:Parser_1224):void {
        _completeFun();
        _completeFun = null;
    }
}
}
