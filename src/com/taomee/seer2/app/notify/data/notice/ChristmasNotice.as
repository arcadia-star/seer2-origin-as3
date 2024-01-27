package com.taomee.seer2.app.notify.data.notice {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.popup.AlertManager;

public class ChristmasNotice extends Notice {


    private var _friendName:String;

    private var _itemID:uint;

    public function ChristmasNotice(param1:String, param2:uint) {
        super(NoticeType.VIP, ActorManager.actorInfo.id);
        this._friendName = param1;
        this._itemID = param2;
    }

    override public function process():void {
        ItemManager.requestEquipList(function ():void {
            if (ItemManager.getItemByReferenceId(_itemID) != null) {
                return;
            }
            ItemManager.requestItemList(function ():void {
                if (ItemManager.getItemQuantityByReferenceId(_itemID) >= 1) {
                    return;
                }
                ItemManager.addItem(_itemID, 1, 0);
            });
        });
        AlertManager.showAlert(this._friendName + "给你许愿成功啦！快看看背包多了什么呢？");
    }
}
}
