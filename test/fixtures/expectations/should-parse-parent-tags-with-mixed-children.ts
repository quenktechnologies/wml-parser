
import * as ___wml from '../../src';




export class Main extends ___wml.AppView<void> {

    constructor(___context: void) {

        super(___context);

        this.template = (___view:___wml.AppView<void>) =>
          ___wml.node('panel', {html : {  } ,wml : {  } }, [___wml.text(` This is my offsprings.`),___wml.node('a', {html : {  } ,wml : {  } }, [___wml.text(`Link`)], ___view) ,___wml.text(`Hey now! `),___wml.widget(Input, {html : {  } ,wml : {  } }, [], ___view)], ___view) ;

       }

     }

