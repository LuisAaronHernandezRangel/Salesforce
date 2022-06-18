import { LightningElement,track } from 'lwc';

export default class ModalDemoInLWC extends LightningElement {
    @track isShowModal = false;
    @track showDetail = false;

    @track codigoProducto="";

    showModalBox() {  
        this.isShowModal = true;
        this.showDetail = false;
    }

    hideDetail(){
        this.showDetail = true;
    }

    showDetail(){
        this.showDetail = !this.showDetail;
    }

    hideModalBox() {  
        this.isShowModal = false;
    }

    cpChange(event){
        this.codigoProducto= event.target.value
    }

    pqChange(event){
        this.productQuantity= event.target.value
    }
}