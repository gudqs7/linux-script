const Koa = require('koa');

// 注意require('koa-router')返回的是函数:
const router = require('koa-router')();

const app = new Koa();


router.post('/hook/nginx-update', async (ctx, next) => {
    console.log('\n\n----------------------');
    console.log('nginx-update at: ' + new Date().toLocaleString());
    var exec = require('child_process').exec;
    var cmdStr = 'sh ${scriptDir}/nginx-update.sh';
    const {stdout, stderr} = await exec(cmdStr);
    console.log('----------------------');
    ctx.response.status = 200;
    ctx.response.body = stdout;
});

router.post('/hook/api-update', async (ctx, next) => {
    console.log('\n\n--------------------');
    console.log('api-update at:' + new Date().toLocaleString());
    var exec = require('child_process').exec;
    var cmdStr = 'sh ${scriptDir}/update.sh';
    const {stdout, stderr} = await exec(cmdStr);
    console.log('--------------------');
    ctx.response.status = 200;
    ctx.response.body = stdout;
});


// add router middleware:
app.use(router.routes());

app.listen(3000);
console.log('app started at port 3000...');