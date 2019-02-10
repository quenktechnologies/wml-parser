
import * as ___wml from '../../src';




export class Main extends ___wml.AppView<void> {

    constructor(___context: void) {

        super(___context);

        this.template = (___view:___wml.AppView<void>) =>
          ___wml.node('root', {html : {  } ,wml : {  } }, [___wml.map(list, function _map(item ) { return ___wml.node('stem', {html : {  } ,wml : {  } }, [___wml.text(`A Stem`)], ___view)  }, function otherwise() { return document.createDocumentFragment(); }) ], ___view) ;

       }

     }

