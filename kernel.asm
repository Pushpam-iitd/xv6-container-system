
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 b0 10 00       	mov    $0x10b000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc d0 d5 10 80       	mov    $0x8010d5d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 c0 2e 10 80       	mov    $0x80102ec0,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb f4 dd 10 80       	mov    $0x8010ddf4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 c0 84 10 80       	push   $0x801084c0
80100051:	68 c0 dd 10 80       	push   $0x8010ddc0
80100056:	e8 65 47 00 00       	call   801047c0 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 0c 25 11 80 bc 	movl   $0x801124bc,0x8011250c
80100062:	24 11 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 10 25 11 80 bc 	movl   $0x801124bc,0x80112510
8010006c:	24 11 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba bc 24 11 80       	mov    $0x801124bc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 bc 24 11 80 	movl   $0x801124bc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 c7 84 10 80       	push   $0x801084c7
80100097:	50                   	push   %eax
80100098:	e8 f3 45 00 00       	call   80104690 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 25 11 80       	mov    0x80112510,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 10 25 11 80    	mov    %ebx,0x80112510
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d bc 24 11 80       	cmp    $0x801124bc,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 c0 dd 10 80       	push   $0x8010ddc0
801000e4:	e8 17 48 00 00       	call   80104900 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 25 11 80    	mov    0x80112510,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc 24 11 80    	cmp    $0x801124bc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc 24 11 80    	cmp    $0x801124bc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c 25 11 80    	mov    0x8011250c,%ebx
80100126:	81 fb bc 24 11 80    	cmp    $0x801124bc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc 24 11 80    	cmp    $0x801124bc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 c0 dd 10 80       	push   $0x8010ddc0
80100162:	e8 59 48 00 00       	call   801049c0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 5e 45 00 00       	call   801046d0 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 bd 1f 00 00       	call   80102140 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 ce 84 10 80       	push   $0x801084ce
80100198:	e8 f3 01 00 00       	call   80100390 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 bd 45 00 00       	call   80104770 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
  iderw(b);
801001c4:	e9 77 1f 00 00       	jmp    80102140 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 df 84 10 80       	push   $0x801084df
801001d1:	e8 ba 01 00 00       	call   80100390 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 7c 45 00 00       	call   80104770 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 2c 45 00 00       	call   80104730 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 dd 10 80 	movl   $0x8010ddc0,(%esp)
8010020b:	e8 f0 46 00 00       	call   80104900 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 10 25 11 80       	mov    0x80112510,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 bc 24 11 80 	movl   $0x801124bc,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 10 25 11 80       	mov    0x80112510,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 10 25 11 80    	mov    %ebx,0x80112510
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 c0 dd 10 80 	movl   $0x8010ddc0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 5f 47 00 00       	jmp    801049c0 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 e6 84 10 80       	push   $0x801084e6
80100269:	e8 22 01 00 00       	call   80100390 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 eb 14 00 00       	call   80101770 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010028c:	e8 6f 46 00 00       	call   80104900 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 e0 05 13 80    	mov    0x801305e0,%edx
801002a7:	39 15 e4 05 13 80    	cmp    %edx,0x801305e4
801002ad:	74 2c                	je     801002db <consoleread+0x6b>
801002af:	eb 5f                	jmp    80100310 <consoleread+0xa0>
801002b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b8:	83 ec 08             	sub    $0x8,%esp
801002bb:	68 20 c5 10 80       	push   $0x8010c520
801002c0:	68 e0 05 13 80       	push   $0x801305e0
801002c5:	e8 96 3b 00 00       	call   80103e60 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 e0 05 13 80    	mov    0x801305e0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 e4 05 13 80    	cmp    0x801305e4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 20 35 00 00       	call   80103800 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 c5 10 80       	push   $0x8010c520
801002ef:	e8 cc 46 00 00       	call   801049c0 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 94 13 00 00       	call   80101690 <ilock>
        return -1;
801002fc:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100302:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100307:	5b                   	pop    %ebx
80100308:	5e                   	pop    %esi
80100309:	5f                   	pop    %edi
8010030a:	5d                   	pop    %ebp
8010030b:	c3                   	ret    
8010030c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100310:	8d 42 01             	lea    0x1(%edx),%eax
80100313:	a3 e0 05 13 80       	mov    %eax,0x801305e0
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 60 05 13 80 	movsbl -0x7fecfaa0(%eax),%eax
    if(c == C('D')){  // EOF
80100324:	83 f8 04             	cmp    $0x4,%eax
80100327:	74 3f                	je     80100368 <consoleread+0xf8>
    *dst++ = c;
80100329:	83 c6 01             	add    $0x1,%esi
    --n;
8010032c:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
8010032f:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
80100332:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100335:	74 43                	je     8010037a <consoleread+0x10a>
  while(n > 0){
80100337:	85 db                	test   %ebx,%ebx
80100339:	0f 85 62 ff ff ff    	jne    801002a1 <consoleread+0x31>
8010033f:	8b 45 10             	mov    0x10(%ebp),%eax
  release(&cons.lock);
80100342:	83 ec 0c             	sub    $0xc,%esp
80100345:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100348:	68 20 c5 10 80       	push   $0x8010c520
8010034d:	e8 6e 46 00 00       	call   801049c0 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 36 13 00 00       	call   80101690 <ilock>
  return target - n;
8010035a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010035d:	83 c4 10             	add    $0x10,%esp
}
80100360:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100363:	5b                   	pop    %ebx
80100364:	5e                   	pop    %esi
80100365:	5f                   	pop    %edi
80100366:	5d                   	pop    %ebp
80100367:	c3                   	ret    
80100368:	8b 45 10             	mov    0x10(%ebp),%eax
8010036b:	29 d8                	sub    %ebx,%eax
      if(n < target){
8010036d:	3b 5d 10             	cmp    0x10(%ebp),%ebx
80100370:	73 d0                	jae    80100342 <consoleread+0xd2>
        input.r--;
80100372:	89 15 e0 05 13 80    	mov    %edx,0x801305e0
80100378:	eb c8                	jmp    80100342 <consoleread+0xd2>
8010037a:	8b 45 10             	mov    0x10(%ebp),%eax
8010037d:	29 d8                	sub    %ebx,%eax
8010037f:	eb c1                	jmp    80100342 <consoleread+0xd2>
80100381:	eb 0d                	jmp    80100390 <panic>
80100383:	90                   	nop
80100384:	90                   	nop
80100385:	90                   	nop
80100386:	90                   	nop
80100387:	90                   	nop
80100388:	90                   	nop
80100389:	90                   	nop
8010038a:	90                   	nop
8010038b:	90                   	nop
8010038c:	90                   	nop
8010038d:	90                   	nop
8010038e:	90                   	nop
8010038f:	90                   	nop

80100390 <panic>:
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100398:	fa                   	cli    
  cons.locking = 0;
80100399:	c7 05 54 c5 10 80 00 	movl   $0x0,0x8010c554
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 a2 23 00 00       	call   80102750 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 ed 84 10 80       	push   $0x801084ed
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 6c 8d 10 80 	movl   $0x80108d6c,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 03 44 00 00       	call   801047e0 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 01 85 10 80       	push   $0x80108501
801003ed:	e8 6e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 58 c5 10 80 01 	movl   $0x1,0x8010c558
80100400:	00 00 00 
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc>:
  if(panicked){
80100410:	8b 0d 58 c5 10 80    	mov    0x8010c558,%ecx
80100416:	85 c9                	test   %ecx,%ecx
80100418:	74 06                	je     80100420 <consputc+0x10>
8010041a:	fa                   	cli    
8010041b:	eb fe                	jmp    8010041b <consputc+0xb>
8010041d:	8d 76 00             	lea    0x0(%esi),%esi
{
80100420:	55                   	push   %ebp
80100421:	89 e5                	mov    %esp,%ebp
80100423:	57                   	push   %edi
80100424:	56                   	push   %esi
80100425:	53                   	push   %ebx
80100426:	89 c6                	mov    %eax,%esi
80100428:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
8010042b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100430:	0f 84 b1 00 00 00    	je     801004e7 <consputc+0xd7>
    uartputc(c);
80100436:	83 ec 0c             	sub    $0xc,%esp
80100439:	50                   	push   %eax
8010043a:	e8 81 6c 00 00       	call   801070c0 <uartputc>
8010043f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100442:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100447:	b8 0e 00 00 00       	mov    $0xe,%eax
8010044c:	89 da                	mov    %ebx,%edx
8010044e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100454:	89 ca                	mov    %ecx,%edx
80100456:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100457:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010045a:	89 da                	mov    %ebx,%edx
8010045c:	c1 e0 08             	shl    $0x8,%eax
8010045f:	89 c7                	mov    %eax,%edi
80100461:	b8 0f 00 00 00       	mov    $0xf,%eax
80100466:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100467:	89 ca                	mov    %ecx,%edx
80100469:	ec                   	in     (%dx),%al
8010046a:	0f b6 d8             	movzbl %al,%ebx
  pos |= inb(CRTPORT+1);
8010046d:	09 fb                	or     %edi,%ebx
  if(c == '\n')
8010046f:	83 fe 0a             	cmp    $0xa,%esi
80100472:	0f 84 f3 00 00 00    	je     8010056b <consputc+0x15b>
  else if(c == BACKSPACE){
80100478:	81 fe 00 01 00 00    	cmp    $0x100,%esi
8010047e:	0f 84 d7 00 00 00    	je     8010055b <consputc+0x14b>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100484:	89 f0                	mov    %esi,%eax
80100486:	0f b6 c0             	movzbl %al,%eax
80100489:	80 cc 07             	or     $0x7,%ah
8010048c:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
80100493:	80 
80100494:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
80100497:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010049d:	0f 8f ab 00 00 00    	jg     8010054e <consputc+0x13e>
  if((pos/80) >= 24){  // Scroll up.
801004a3:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004a9:	7f 66                	jg     80100511 <consputc+0x101>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004ab:	be d4 03 00 00       	mov    $0x3d4,%esi
801004b0:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b5:	89 f2                	mov    %esi,%edx
801004b7:	ee                   	out    %al,(%dx)
801004b8:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
801004bd:	89 d8                	mov    %ebx,%eax
801004bf:	c1 f8 08             	sar    $0x8,%eax
801004c2:	89 ca                	mov    %ecx,%edx
801004c4:	ee                   	out    %al,(%dx)
801004c5:	b8 0f 00 00 00       	mov    $0xf,%eax
801004ca:	89 f2                	mov    %esi,%edx
801004cc:	ee                   	out    %al,(%dx)
801004cd:	89 d8                	mov    %ebx,%eax
801004cf:	89 ca                	mov    %ecx,%edx
801004d1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004d2:	b8 20 07 00 00       	mov    $0x720,%eax
801004d7:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004de:	80 
}
801004df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004e2:	5b                   	pop    %ebx
801004e3:	5e                   	pop    %esi
801004e4:	5f                   	pop    %edi
801004e5:	5d                   	pop    %ebp
801004e6:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e7:	83 ec 0c             	sub    $0xc,%esp
801004ea:	6a 08                	push   $0x8
801004ec:	e8 cf 6b 00 00       	call   801070c0 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 c3 6b 00 00       	call   801070c0 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 b7 6b 00 00       	call   801070c0 <uartputc>
80100509:	83 c4 10             	add    $0x10,%esp
8010050c:	e9 31 ff ff ff       	jmp    80100442 <consputc+0x32>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100511:	52                   	push   %edx
80100512:	68 60 0e 00 00       	push   $0xe60
    pos -= 80;
80100517:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010051a:	68 a0 80 0b 80       	push   $0x800b80a0
8010051f:	68 00 80 0b 80       	push   $0x800b8000
80100524:	e8 97 45 00 00       	call   80104ac0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100529:	b8 80 07 00 00       	mov    $0x780,%eax
8010052e:	83 c4 0c             	add    $0xc,%esp
80100531:	29 d8                	sub    %ebx,%eax
80100533:	01 c0                	add    %eax,%eax
80100535:	50                   	push   %eax
80100536:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
80100539:	6a 00                	push   $0x0
8010053b:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100540:	50                   	push   %eax
80100541:	e8 ca 44 00 00       	call   80104a10 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 05 85 10 80       	push   $0x80108505
80100556:	e8 35 fe ff ff       	call   80100390 <panic>
    if(pos > 0) --pos;
8010055b:	85 db                	test   %ebx,%ebx
8010055d:	0f 84 48 ff ff ff    	je     801004ab <consputc+0x9b>
80100563:	83 eb 01             	sub    $0x1,%ebx
80100566:	e9 2c ff ff ff       	jmp    80100497 <consputc+0x87>
    pos += 80 - pos%80;
8010056b:	89 d8                	mov    %ebx,%eax
8010056d:	b9 50 00 00 00       	mov    $0x50,%ecx
80100572:	99                   	cltd   
80100573:	f7 f9                	idiv   %ecx
80100575:	29 d1                	sub    %edx,%ecx
80100577:	01 cb                	add    %ecx,%ebx
80100579:	e9 19 ff ff ff       	jmp    80100497 <consputc+0x87>
8010057e:	66 90                	xchg   %ax,%ax

80100580 <printint>:
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d3                	mov    %edx,%ebx
80100588:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100590:	74 04                	je     80100596 <printint+0x16>
80100592:	85 c0                	test   %eax,%eax
80100594:	78 5a                	js     801005f0 <printint+0x70>
    x = xx;
80100596:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010059d:	31 c9                	xor    %ecx,%ecx
8010059f:	8d 75 d7             	lea    -0x29(%ebp),%esi
801005a2:	eb 06                	jmp    801005aa <printint+0x2a>
801005a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
801005a8:	89 f9                	mov    %edi,%ecx
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 79 01             	lea    0x1(%ecx),%edi
801005af:	f7 f3                	div    %ebx
801005b1:	0f b6 92 30 85 10 80 	movzbl -0x7fef7ad0(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005ba:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>
  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
801005cb:	8d 79 02             	lea    0x2(%ecx),%edi
801005ce:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
801005d8:	0f be 03             	movsbl (%ebx),%eax
801005db:	83 eb 01             	sub    $0x1,%ebx
801005de:	e8 2d fe ff ff       	call   80100410 <consputc>
  while(--i >= 0)
801005e3:	39 f3                	cmp    %esi,%ebx
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
801005ef:	90                   	nop
    x = -xx;
801005f0:	f7 d8                	neg    %eax
801005f2:	eb a9                	jmp    8010059d <printint+0x1d>
801005f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100600 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
80100609:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060c:	ff 75 08             	pushl  0x8(%ebp)
8010060f:	e8 5c 11 00 00       	call   80101770 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010061b:	e8 e0 42 00 00       	call   80104900 <acquire>
  for(i = 0; i < n; i++)
80100620:	83 c4 10             	add    $0x10,%esp
80100623:	85 f6                	test   %esi,%esi
80100625:	7e 18                	jle    8010063f <consolewrite+0x3f>
80100627:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010062a:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 d5 fd ff ff       	call   80100410 <consputc>
  for(i = 0; i < n; i++)
8010063b:	39 fb                	cmp    %edi,%ebx
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 c5 10 80       	push   $0x8010c520
80100647:	e8 74 43 00 00       	call   801049c0 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 3b 10 00 00       	call   80101690 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100669:	a1 54 c5 10 80       	mov    0x8010c554,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100670:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100673:	0f 85 6f 01 00 00    	jne    801007e8 <cprintf+0x188>
  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c7                	mov    %eax,%edi
80100680:	0f 84 77 01 00 00    	je     801007fd <cprintf+0x19d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100689:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010068c:	31 db                	xor    %ebx,%ebx
  argp = (uint*)(void*)(&fmt + 1);
8010068e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100691:	85 c0                	test   %eax,%eax
80100693:	75 56                	jne    801006eb <cprintf+0x8b>
80100695:	eb 79                	jmp    80100710 <cprintf+0xb0>
80100697:	89 f6                	mov    %esi,%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
801006a0:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
801006a3:	85 d2                	test   %edx,%edx
801006a5:	74 69                	je     80100710 <cprintf+0xb0>
801006a7:	83 c3 02             	add    $0x2,%ebx
    switch(c){
801006aa:	83 fa 70             	cmp    $0x70,%edx
801006ad:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
801006b0:	0f 84 84 00 00 00    	je     8010073a <cprintf+0xda>
801006b6:	7f 78                	jg     80100730 <cprintf+0xd0>
801006b8:	83 fa 25             	cmp    $0x25,%edx
801006bb:	0f 84 ff 00 00 00    	je     801007c0 <cprintf+0x160>
801006c1:	83 fa 64             	cmp    $0x64,%edx
801006c4:	0f 85 8e 00 00 00    	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 10, 1);
801006ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006cd:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d2:	8d 48 04             	lea    0x4(%eax),%ecx
801006d5:	8b 00                	mov    (%eax),%eax
801006d7:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801006da:	b9 01 00 00 00       	mov    $0x1,%ecx
801006df:	e8 9c fe ff ff       	call   80100580 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e4:	0f b6 06             	movzbl (%esi),%eax
801006e7:	85 c0                	test   %eax,%eax
801006e9:	74 25                	je     80100710 <cprintf+0xb0>
801006eb:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801006ee:	83 f8 25             	cmp    $0x25,%eax
801006f1:	8d 34 17             	lea    (%edi,%edx,1),%esi
801006f4:	74 aa                	je     801006a0 <cprintf+0x40>
801006f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801006f9:	e8 12 fd ff ff       	call   80100410 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fe:	0f b6 06             	movzbl (%esi),%eax
      continue;
80100701:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100704:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100706:	85 c0                	test   %eax,%eax
80100708:	75 e1                	jne    801006eb <cprintf+0x8b>
8010070a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(locking)
80100710:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100713:	85 c0                	test   %eax,%eax
80100715:	74 10                	je     80100727 <cprintf+0xc7>
    release(&cons.lock);
80100717:	83 ec 0c             	sub    $0xc,%esp
8010071a:	68 20 c5 10 80       	push   $0x8010c520
8010071f:	e8 9c 42 00 00       	call   801049c0 <release>
80100724:	83 c4 10             	add    $0x10,%esp
}
80100727:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010072a:	5b                   	pop    %ebx
8010072b:	5e                   	pop    %esi
8010072c:	5f                   	pop    %edi
8010072d:	5d                   	pop    %ebp
8010072e:	c3                   	ret    
8010072f:	90                   	nop
    switch(c){
80100730:	83 fa 73             	cmp    $0x73,%edx
80100733:	74 43                	je     80100778 <cprintf+0x118>
80100735:	83 fa 78             	cmp    $0x78,%edx
80100738:	75 1e                	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 16, 0);
8010073a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010073d:	ba 10 00 00 00       	mov    $0x10,%edx
80100742:	8d 48 04             	lea    0x4(%eax),%ecx
80100745:	8b 00                	mov    (%eax),%eax
80100747:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010074a:	31 c9                	xor    %ecx,%ecx
8010074c:	e8 2f fe ff ff       	call   80100580 <printint>
      break;
80100751:	eb 91                	jmp    801006e4 <cprintf+0x84>
80100753:	90                   	nop
80100754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100758:	b8 25 00 00 00       	mov    $0x25,%eax
8010075d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100760:	e8 ab fc ff ff       	call   80100410 <consputc>
      consputc(c);
80100765:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100768:	89 d0                	mov    %edx,%eax
8010076a:	e8 a1 fc ff ff       	call   80100410 <consputc>
      break;
8010076f:	e9 70 ff ff ff       	jmp    801006e4 <cprintf+0x84>
80100774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100778:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010077b:	8b 10                	mov    (%eax),%edx
8010077d:	8d 48 04             	lea    0x4(%eax),%ecx
80100780:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100783:	85 d2                	test   %edx,%edx
80100785:	74 49                	je     801007d0 <cprintf+0x170>
      for(; *s; s++)
80100787:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
8010078a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      for(; *s; s++)
8010078d:	84 c0                	test   %al,%al
8010078f:	0f 84 4f ff ff ff    	je     801006e4 <cprintf+0x84>
80100795:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100798:	89 d3                	mov    %edx,%ebx
8010079a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801007a0:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
801007a3:	e8 68 fc ff ff       	call   80100410 <consputc>
      for(; *s; s++)
801007a8:	0f be 03             	movsbl (%ebx),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
      if((s = (char*)*argp++) == 0)
801007af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007b2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801007b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801007b8:	e9 27 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007bd:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
801007c0:	b8 25 00 00 00       	mov    $0x25,%eax
801007c5:	e8 46 fc ff ff       	call   80100410 <consputc>
      break;
801007ca:	e9 15 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007cf:	90                   	nop
        s = "(null)";
801007d0:	ba 18 85 10 80       	mov    $0x80108518,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 c5 10 80       	push   $0x8010c520
801007f0:	e8 0b 41 00 00       	call   80104900 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 1f 85 10 80       	push   $0x8010851f
80100805:	e8 86 fb ff ff       	call   80100390 <panic>
8010080a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100810 <consoleintr>:
{
80100810:	55                   	push   %ebp
80100811:	89 e5                	mov    %esp,%ebp
80100813:	57                   	push   %edi
80100814:	56                   	push   %esi
80100815:	53                   	push   %ebx
  int c, doprocdump = 0;
80100816:	31 f6                	xor    %esi,%esi
{
80100818:	83 ec 18             	sub    $0x18,%esp
8010081b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
8010081e:	68 20 c5 10 80       	push   $0x8010c520
80100823:	e8 d8 40 00 00       	call   80104900 <acquire>
  while((c = getc()) >= 0){
80100828:	83 c4 10             	add    $0x10,%esp
8010082b:	90                   	nop
8010082c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100830:	ff d3                	call   *%ebx
80100832:	85 c0                	test   %eax,%eax
80100834:	89 c7                	mov    %eax,%edi
80100836:	78 48                	js     80100880 <consoleintr+0x70>
    switch(c){
80100838:	83 ff 10             	cmp    $0x10,%edi
8010083b:	0f 84 e7 00 00 00    	je     80100928 <consoleintr+0x118>
80100841:	7e 5d                	jle    801008a0 <consoleintr+0x90>
80100843:	83 ff 15             	cmp    $0x15,%edi
80100846:	0f 84 ec 00 00 00    	je     80100938 <consoleintr+0x128>
8010084c:	83 ff 7f             	cmp    $0x7f,%edi
8010084f:	75 54                	jne    801008a5 <consoleintr+0x95>
      if(input.e != input.w){
80100851:	a1 e8 05 13 80       	mov    0x801305e8,%eax
80100856:	3b 05 e4 05 13 80    	cmp    0x801305e4,%eax
8010085c:	74 d2                	je     80100830 <consoleintr+0x20>
        input.e--;
8010085e:	83 e8 01             	sub    $0x1,%eax
80100861:	a3 e8 05 13 80       	mov    %eax,0x801305e8
        consputc(BACKSPACE);
80100866:	b8 00 01 00 00       	mov    $0x100,%eax
8010086b:	e8 a0 fb ff ff       	call   80100410 <consputc>
  while((c = getc()) >= 0){
80100870:	ff d3                	call   *%ebx
80100872:	85 c0                	test   %eax,%eax
80100874:	89 c7                	mov    %eax,%edi
80100876:	79 c0                	jns    80100838 <consoleintr+0x28>
80100878:	90                   	nop
80100879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100880:	83 ec 0c             	sub    $0xc,%esp
80100883:	68 20 c5 10 80       	push   $0x8010c520
80100888:	e8 33 41 00 00       	call   801049c0 <release>
  if(doprocdump) {
8010088d:	83 c4 10             	add    $0x10,%esp
80100890:	85 f6                	test   %esi,%esi
80100892:	0f 85 f8 00 00 00    	jne    80100990 <consoleintr+0x180>
}
80100898:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010089b:	5b                   	pop    %ebx
8010089c:	5e                   	pop    %esi
8010089d:	5f                   	pop    %edi
8010089e:	5d                   	pop    %ebp
8010089f:	c3                   	ret    
    switch(c){
801008a0:	83 ff 08             	cmp    $0x8,%edi
801008a3:	74 ac                	je     80100851 <consoleintr+0x41>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008a5:	85 ff                	test   %edi,%edi
801008a7:	74 87                	je     80100830 <consoleintr+0x20>
801008a9:	a1 e8 05 13 80       	mov    0x801305e8,%eax
801008ae:	89 c2                	mov    %eax,%edx
801008b0:	2b 15 e0 05 13 80    	sub    0x801305e0,%edx
801008b6:	83 fa 7f             	cmp    $0x7f,%edx
801008b9:	0f 87 71 ff ff ff    	ja     80100830 <consoleintr+0x20>
801008bf:	8d 50 01             	lea    0x1(%eax),%edx
801008c2:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801008c5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008c8:	89 15 e8 05 13 80    	mov    %edx,0x801305e8
        c = (c == '\r') ? '\n' : c;
801008ce:	0f 84 cc 00 00 00    	je     801009a0 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d4:	89 f9                	mov    %edi,%ecx
801008d6:	88 88 60 05 13 80    	mov    %cl,-0x7fecfaa0(%eax)
        consputc(c);
801008dc:	89 f8                	mov    %edi,%eax
801008de:	e8 2d fb ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e3:	83 ff 0a             	cmp    $0xa,%edi
801008e6:	0f 84 c5 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008ec:	83 ff 04             	cmp    $0x4,%edi
801008ef:	0f 84 bc 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008f5:	a1 e0 05 13 80       	mov    0x801305e0,%eax
801008fa:	83 e8 80             	sub    $0xffffff80,%eax
801008fd:	39 05 e8 05 13 80    	cmp    %eax,0x801305e8
80100903:	0f 85 27 ff ff ff    	jne    80100830 <consoleintr+0x20>
          wakeup(&input.r);
80100909:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
8010090c:	a3 e4 05 13 80       	mov    %eax,0x801305e4
          wakeup(&input.r);
80100911:	68 e0 05 13 80       	push   $0x801305e0
80100916:	e8 05 37 00 00       	call   80104020 <wakeup>
8010091b:	83 c4 10             	add    $0x10,%esp
8010091e:	e9 0d ff ff ff       	jmp    80100830 <consoleintr+0x20>
80100923:	90                   	nop
80100924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
80100928:	be 01 00 00 00       	mov    $0x1,%esi
8010092d:	e9 fe fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100938:	a1 e8 05 13 80       	mov    0x801305e8,%eax
8010093d:	39 05 e4 05 13 80    	cmp    %eax,0x801305e4
80100943:	75 2b                	jne    80100970 <consoleintr+0x160>
80100945:	e9 e6 fe ff ff       	jmp    80100830 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100950:	a3 e8 05 13 80       	mov    %eax,0x801305e8
        consputc(BACKSPACE);
80100955:	b8 00 01 00 00       	mov    $0x100,%eax
8010095a:	e8 b1 fa ff ff       	call   80100410 <consputc>
      while(input.e != input.w &&
8010095f:	a1 e8 05 13 80       	mov    0x801305e8,%eax
80100964:	3b 05 e4 05 13 80    	cmp    0x801305e4,%eax
8010096a:	0f 84 c0 fe ff ff    	je     80100830 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100970:	83 e8 01             	sub    $0x1,%eax
80100973:	89 c2                	mov    %eax,%edx
80100975:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100978:	80 ba 60 05 13 80 0a 	cmpb   $0xa,-0x7fecfaa0(%edx)
8010097f:	75 cf                	jne    80100950 <consoleintr+0x140>
80100981:	e9 aa fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100986:	8d 76 00             	lea    0x0(%esi),%esi
80100989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80100990:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100993:	5b                   	pop    %ebx
80100994:	5e                   	pop    %esi
80100995:	5f                   	pop    %edi
80100996:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100997:	e9 64 37 00 00       	jmp    80104100 <procdump>
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
801009a0:	c6 80 60 05 13 80 0a 	movb   $0xa,-0x7fecfaa0(%eax)
        consputc(c);
801009a7:	b8 0a 00 00 00       	mov    $0xa,%eax
801009ac:	e8 5f fa ff ff       	call   80100410 <consputc>
801009b1:	a1 e8 05 13 80       	mov    0x801305e8,%eax
801009b6:	e9 4e ff ff ff       	jmp    80100909 <consoleintr+0xf9>
801009bb:	90                   	nop
801009bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009c0 <consoleinit>:

void
consoleinit(void)
{
801009c0:	55                   	push   %ebp
801009c1:	89 e5                	mov    %esp,%ebp
801009c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009c6:	68 28 85 10 80       	push   $0x80108528
801009cb:	68 20 c5 10 80       	push   $0x8010c520
801009d0:	e8 eb 3d 00 00       	call   801047c0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009d5:	58                   	pop    %eax
801009d6:	5a                   	pop    %edx
801009d7:	6a 00                	push   $0x0
801009d9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801009db:	c7 05 6c 14 13 80 00 	movl   $0x80100600,0x8013146c
801009e2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009e5:	c7 05 68 14 13 80 70 	movl   $0x80100270,0x80131468
801009ec:	02 10 80 
  cons.locking = 1;
801009ef:	c7 05 54 c5 10 80 01 	movl   $0x1,0x8010c554
801009f6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801009f9:	e8 f2 18 00 00       	call   801022f0 <ioapicenable>
}
801009fe:	83 c4 10             	add    $0x10,%esp
80100a01:	c9                   	leave  
80100a02:	c3                   	ret    
80100a03:	66 90                	xchg   %ax,%ax
80100a05:	66 90                	xchg   %ax,%ax
80100a07:	66 90                	xchg   %ax,%ax
80100a09:	66 90                	xchg   %ax,%ax
80100a0b:	66 90                	xchg   %ax,%ax
80100a0d:	66 90                	xchg   %ax,%ax
80100a0f:	90                   	nop

80100a10 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a10:	55                   	push   %ebp
80100a11:	89 e5                	mov    %esp,%ebp
80100a13:	57                   	push   %edi
80100a14:	56                   	push   %esi
80100a15:	53                   	push   %ebx
80100a16:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a1c:	e8 df 2d 00 00       	call   80103800 <myproc>
80100a21:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100a27:	e8 94 21 00 00       	call   80102bc0 <begin_op>

  if((ip = namei(path)) == 0){
80100a2c:	83 ec 0c             	sub    $0xc,%esp
80100a2f:	ff 75 08             	pushl  0x8(%ebp)
80100a32:	e8 c9 14 00 00       	call   80101f00 <namei>
80100a37:	83 c4 10             	add    $0x10,%esp
80100a3a:	85 c0                	test   %eax,%eax
80100a3c:	0f 84 91 01 00 00    	je     80100bd3 <exec+0x1c3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a42:	83 ec 0c             	sub    $0xc,%esp
80100a45:	89 c3                	mov    %eax,%ebx
80100a47:	50                   	push   %eax
80100a48:	e8 43 0c 00 00       	call   80101690 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a4d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a53:	6a 34                	push   $0x34
80100a55:	6a 00                	push   $0x0
80100a57:	50                   	push   %eax
80100a58:	53                   	push   %ebx
80100a59:	e8 12 0f 00 00       	call   80101970 <readi>
80100a5e:	83 c4 20             	add    $0x20,%esp
80100a61:	83 f8 34             	cmp    $0x34,%eax
80100a64:	74 22                	je     80100a88 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a66:	83 ec 0c             	sub    $0xc,%esp
80100a69:	53                   	push   %ebx
80100a6a:	e8 b1 0e 00 00       	call   80101920 <iunlockput>
    end_op();
80100a6f:	e8 bc 21 00 00       	call   80102c30 <end_op>
80100a74:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a7f:	5b                   	pop    %ebx
80100a80:	5e                   	pop    %esi
80100a81:	5f                   	pop    %edi
80100a82:	5d                   	pop    %ebp
80100a83:	c3                   	ret    
80100a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100a88:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a8f:	45 4c 46 
80100a92:	75 d2                	jne    80100a66 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100a94:	e8 77 77 00 00       	call   80108210 <setupkvm>
80100a99:	85 c0                	test   %eax,%eax
80100a9b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100aa1:	74 c3                	je     80100a66 <exec+0x56>
  sz = 0;
80100aa3:	31 ff                	xor    %edi,%edi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100aa5:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100aac:	00 
80100aad:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100ab3:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100ab9:	0f 84 8e 02 00 00    	je     80100d4d <exec+0x33d>
80100abf:	31 f6                	xor    %esi,%esi
80100ac1:	eb 7f                	jmp    80100b42 <exec+0x132>
80100ac3:	90                   	nop
80100ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100ac8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100acf:	75 63                	jne    80100b34 <exec+0x124>
    if(ph.memsz < ph.filesz)
80100ad1:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ad7:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100add:	0f 82 86 00 00 00    	jb     80100b69 <exec+0x159>
80100ae3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ae9:	72 7e                	jb     80100b69 <exec+0x159>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100aeb:	83 ec 04             	sub    $0x4,%esp
80100aee:	50                   	push   %eax
80100aef:	57                   	push   %edi
80100af0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100af6:	e8 35 75 00 00       	call   80108030 <allocuvm>
80100afb:	83 c4 10             	add    $0x10,%esp
80100afe:	85 c0                	test   %eax,%eax
80100b00:	89 c7                	mov    %eax,%edi
80100b02:	74 65                	je     80100b69 <exec+0x159>
    if(ph.vaddr % PGSIZE != 0)
80100b04:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b0a:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b0f:	75 58                	jne    80100b69 <exec+0x159>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b11:	83 ec 0c             	sub    $0xc,%esp
80100b14:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b1a:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b20:	53                   	push   %ebx
80100b21:	50                   	push   %eax
80100b22:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b28:	e8 43 74 00 00       	call   80107f70 <loaduvm>
80100b2d:	83 c4 20             	add    $0x20,%esp
80100b30:	85 c0                	test   %eax,%eax
80100b32:	78 35                	js     80100b69 <exec+0x159>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b34:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b3b:	83 c6 01             	add    $0x1,%esi
80100b3e:	39 f0                	cmp    %esi,%eax
80100b40:	7e 3d                	jle    80100b7f <exec+0x16f>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b42:	89 f0                	mov    %esi,%eax
80100b44:	6a 20                	push   $0x20
80100b46:	c1 e0 05             	shl    $0x5,%eax
80100b49:	03 85 ec fe ff ff    	add    -0x114(%ebp),%eax
80100b4f:	50                   	push   %eax
80100b50:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b56:	50                   	push   %eax
80100b57:	53                   	push   %ebx
80100b58:	e8 13 0e 00 00       	call   80101970 <readi>
80100b5d:	83 c4 10             	add    $0x10,%esp
80100b60:	83 f8 20             	cmp    $0x20,%eax
80100b63:	0f 84 5f ff ff ff    	je     80100ac8 <exec+0xb8>
    freevm(pgdir);
80100b69:	83 ec 0c             	sub    $0xc,%esp
80100b6c:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b72:	e8 19 76 00 00       	call   80108190 <freevm>
80100b77:	83 c4 10             	add    $0x10,%esp
80100b7a:	e9 e7 fe ff ff       	jmp    80100a66 <exec+0x56>
80100b7f:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100b85:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100b8b:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100b91:	83 ec 0c             	sub    $0xc,%esp
80100b94:	53                   	push   %ebx
80100b95:	e8 86 0d 00 00       	call   80101920 <iunlockput>
  end_op();
80100b9a:	e8 91 20 00 00       	call   80102c30 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b9f:	83 c4 0c             	add    $0xc,%esp
80100ba2:	56                   	push   %esi
80100ba3:	57                   	push   %edi
80100ba4:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100baa:	e8 81 74 00 00       	call   80108030 <allocuvm>
80100baf:	83 c4 10             	add    $0x10,%esp
80100bb2:	85 c0                	test   %eax,%eax
80100bb4:	89 c6                	mov    %eax,%esi
80100bb6:	75 3a                	jne    80100bf2 <exec+0x1e2>
    freevm(pgdir);
80100bb8:	83 ec 0c             	sub    $0xc,%esp
80100bbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bc1:	e8 ca 75 00 00       	call   80108190 <freevm>
80100bc6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100bc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bce:	e9 a9 fe ff ff       	jmp    80100a7c <exec+0x6c>
    end_op();
80100bd3:	e8 58 20 00 00       	call   80102c30 <end_op>
    cprintf("exec: fail\n");
80100bd8:	83 ec 0c             	sub    $0xc,%esp
80100bdb:	68 41 85 10 80       	push   $0x80108541
80100be0:	e8 7b fa ff ff       	call   80100660 <cprintf>
    return -1;
80100be5:	83 c4 10             	add    $0x10,%esp
80100be8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bed:	e9 8a fe ff ff       	jmp    80100a7c <exec+0x6c>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bf2:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100bf8:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100bfb:	31 ff                	xor    %edi,%edi
80100bfd:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bff:	50                   	push   %eax
80100c00:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c06:	e8 a5 76 00 00       	call   801082b0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c0b:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c0e:	83 c4 10             	add    $0x10,%esp
80100c11:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c17:	8b 00                	mov    (%eax),%eax
80100c19:	85 c0                	test   %eax,%eax
80100c1b:	74 70                	je     80100c8d <exec+0x27d>
80100c1d:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100c23:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c29:	eb 0a                	jmp    80100c35 <exec+0x225>
80100c2b:	90                   	nop
80100c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100c30:	83 ff 20             	cmp    $0x20,%edi
80100c33:	74 83                	je     80100bb8 <exec+0x1a8>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c35:	83 ec 0c             	sub    $0xc,%esp
80100c38:	50                   	push   %eax
80100c39:	e8 f2 3f 00 00       	call   80104c30 <strlen>
80100c3e:	f7 d0                	not    %eax
80100c40:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c42:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c45:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c46:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c49:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4c:	e8 df 3f 00 00       	call   80104c30 <strlen>
80100c51:	83 c0 01             	add    $0x1,%eax
80100c54:	50                   	push   %eax
80100c55:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c58:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c5b:	53                   	push   %ebx
80100c5c:	56                   	push   %esi
80100c5d:	e8 ae 77 00 00       	call   80108410 <copyout>
80100c62:	83 c4 20             	add    $0x20,%esp
80100c65:	85 c0                	test   %eax,%eax
80100c67:	0f 88 4b ff ff ff    	js     80100bb8 <exec+0x1a8>
  for(argc = 0; argv[argc]; argc++) {
80100c6d:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c70:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c77:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100c7a:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100c80:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c83:	85 c0                	test   %eax,%eax
80100c85:	75 a9                	jne    80100c30 <exec+0x220>
80100c87:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c8d:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c94:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100c96:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c9d:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100ca1:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100ca8:	ff ff ff 
  ustack[1] = argc;
80100cab:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb1:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100cb3:	83 c0 0c             	add    $0xc,%eax
80100cb6:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cb8:	50                   	push   %eax
80100cb9:	52                   	push   %edx
80100cba:	53                   	push   %ebx
80100cbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cc1:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cc7:	e8 44 77 00 00       	call   80108410 <copyout>
80100ccc:	83 c4 10             	add    $0x10,%esp
80100ccf:	85 c0                	test   %eax,%eax
80100cd1:	0f 88 e1 fe ff ff    	js     80100bb8 <exec+0x1a8>
  for(last=s=path; *s; s++)
80100cd7:	8b 45 08             	mov    0x8(%ebp),%eax
80100cda:	0f b6 00             	movzbl (%eax),%eax
80100cdd:	84 c0                	test   %al,%al
80100cdf:	74 17                	je     80100cf8 <exec+0x2e8>
80100ce1:	8b 55 08             	mov    0x8(%ebp),%edx
80100ce4:	89 d1                	mov    %edx,%ecx
80100ce6:	83 c1 01             	add    $0x1,%ecx
80100ce9:	3c 2f                	cmp    $0x2f,%al
80100ceb:	0f b6 01             	movzbl (%ecx),%eax
80100cee:	0f 44 d1             	cmove  %ecx,%edx
80100cf1:	84 c0                	test   %al,%al
80100cf3:	75 f1                	jne    80100ce6 <exec+0x2d6>
80100cf5:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cf8:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cfe:	50                   	push   %eax
80100cff:	6a 10                	push   $0x10
80100d01:	ff 75 08             	pushl  0x8(%ebp)
80100d04:	89 f8                	mov    %edi,%eax
80100d06:	05 bc 01 00 00       	add    $0x1bc,%eax
80100d0b:	50                   	push   %eax
80100d0c:	e8 df 3e 00 00       	call   80104bf0 <safestrcpy>
  curproc->pgdir = pgdir;
80100d11:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  oldpgdir = curproc->pgdir;
80100d17:	89 f9                	mov    %edi,%ecx
80100d19:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->tf->eip = elf.entry;  // main
80100d1c:	8b 41 18             	mov    0x18(%ecx),%eax
  curproc->sz = sz;
80100d1f:	89 31                	mov    %esi,(%ecx)
  curproc->pgdir = pgdir;
80100d21:	89 51 04             	mov    %edx,0x4(%ecx)
  curproc->tf->eip = elf.entry;  // main
80100d24:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d2a:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d2d:	8b 41 18             	mov    0x18(%ecx),%eax
80100d30:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d33:	89 0c 24             	mov    %ecx,(%esp)
80100d36:	e8 a5 70 00 00       	call   80107de0 <switchuvm>
  freevm(oldpgdir);
80100d3b:	89 3c 24             	mov    %edi,(%esp)
80100d3e:	e8 4d 74 00 00       	call   80108190 <freevm>
  return 0;
80100d43:	83 c4 10             	add    $0x10,%esp
80100d46:	31 c0                	xor    %eax,%eax
80100d48:	e9 2f fd ff ff       	jmp    80100a7c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d4d:	be 00 20 00 00       	mov    $0x2000,%esi
80100d52:	e9 3a fe ff ff       	jmp    80100b91 <exec+0x181>
80100d57:	66 90                	xchg   %ax,%ax
80100d59:	66 90                	xchg   %ax,%ax
80100d5b:	66 90                	xchg   %ax,%ax
80100d5d:	66 90                	xchg   %ax,%ax
80100d5f:	90                   	nop

80100d60 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d60:	55                   	push   %ebp
80100d61:	89 e5                	mov    %esp,%ebp
80100d63:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d66:	68 4d 85 10 80       	push   $0x8010854d
80100d6b:	68 a0 07 13 80       	push   $0x801307a0
80100d70:	e8 4b 3a 00 00       	call   801047c0 <initlock>
}
80100d75:	83 c4 10             	add    $0x10,%esp
80100d78:	c9                   	leave  
80100d79:	c3                   	ret    
80100d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d80 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d80:	55                   	push   %ebp
80100d81:	89 e5                	mov    %esp,%ebp
80100d83:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d84:	bb d4 07 13 80       	mov    $0x801307d4,%ebx
{
80100d89:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100d8c:	68 a0 07 13 80       	push   $0x801307a0
80100d91:	e8 6a 3b 00 00       	call   80104900 <acquire>
80100d96:	83 c4 10             	add    $0x10,%esp
80100d99:	eb 10                	jmp    80100dab <filealloc+0x2b>
80100d9b:	90                   	nop
80100d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100da0:	83 c3 20             	add    $0x20,%ebx
80100da3:	81 fb 54 14 13 80    	cmp    $0x80131454,%ebx
80100da9:	73 25                	jae    80100dd0 <filealloc+0x50>
    if(f->ref == 0){
80100dab:	8b 43 04             	mov    0x4(%ebx),%eax
80100dae:	85 c0                	test   %eax,%eax
80100db0:	75 ee                	jne    80100da0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100db2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100db5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100dbc:	68 a0 07 13 80       	push   $0x801307a0
80100dc1:	e8 fa 3b 00 00       	call   801049c0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100dc6:	89 d8                	mov    %ebx,%eax
      return f;
80100dc8:	83 c4 10             	add    $0x10,%esp
}
80100dcb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dce:	c9                   	leave  
80100dcf:	c3                   	ret    
  release(&ftable.lock);
80100dd0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100dd3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100dd5:	68 a0 07 13 80       	push   $0x801307a0
80100dda:	e8 e1 3b 00 00       	call   801049c0 <release>
}
80100ddf:	89 d8                	mov    %ebx,%eax
  return 0;
80100de1:	83 c4 10             	add    $0x10,%esp
}
80100de4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100de7:	c9                   	leave  
80100de8:	c3                   	ret    
80100de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100df0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100df0:	55                   	push   %ebp
80100df1:	89 e5                	mov    %esp,%ebp
80100df3:	53                   	push   %ebx
80100df4:	83 ec 10             	sub    $0x10,%esp
80100df7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dfa:	68 a0 07 13 80       	push   $0x801307a0
80100dff:	e8 fc 3a 00 00       	call   80104900 <acquire>
  if(f->ref < 1)
80100e04:	8b 43 04             	mov    0x4(%ebx),%eax
80100e07:	83 c4 10             	add    $0x10,%esp
80100e0a:	85 c0                	test   %eax,%eax
80100e0c:	7e 1a                	jle    80100e28 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e0e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e11:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100e14:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e17:	68 a0 07 13 80       	push   $0x801307a0
80100e1c:	e8 9f 3b 00 00       	call   801049c0 <release>
  return f;
}
80100e21:	89 d8                	mov    %ebx,%eax
80100e23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e26:	c9                   	leave  
80100e27:	c3                   	ret    
    panic("filedup");
80100e28:	83 ec 0c             	sub    $0xc,%esp
80100e2b:	68 54 85 10 80       	push   $0x80108554
80100e30:	e8 5b f5 ff ff       	call   80100390 <panic>
80100e35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e40 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e40:	55                   	push   %ebp
80100e41:	89 e5                	mov    %esp,%ebp
80100e43:	57                   	push   %edi
80100e44:	56                   	push   %esi
80100e45:	53                   	push   %ebx
80100e46:	83 ec 28             	sub    $0x28,%esp
80100e49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100e4c:	68 a0 07 13 80       	push   $0x801307a0
80100e51:	e8 aa 3a 00 00       	call   80104900 <acquire>
  if(f->ref < 1)
80100e56:	8b 43 04             	mov    0x4(%ebx),%eax
80100e59:	83 c4 10             	add    $0x10,%esp
80100e5c:	85 c0                	test   %eax,%eax
80100e5e:	0f 8e 9b 00 00 00    	jle    80100eff <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e64:	83 e8 01             	sub    $0x1,%eax
80100e67:	85 c0                	test   %eax,%eax
80100e69:	89 43 04             	mov    %eax,0x4(%ebx)
80100e6c:	74 1a                	je     80100e88 <fileclose+0x48>
    release(&ftable.lock);
80100e6e:	c7 45 08 a0 07 13 80 	movl   $0x801307a0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e75:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e78:	5b                   	pop    %ebx
80100e79:	5e                   	pop    %esi
80100e7a:	5f                   	pop    %edi
80100e7b:	5d                   	pop    %ebp
    release(&ftable.lock);
80100e7c:	e9 3f 3b 00 00       	jmp    801049c0 <release>
80100e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100e88:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100e8c:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100e8e:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100e91:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100e94:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100e9a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e9d:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100ea0:	68 a0 07 13 80       	push   $0x801307a0
  ff = *f;
80100ea5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100ea8:	e8 13 3b 00 00       	call   801049c0 <release>
  if(ff.type == FD_PIPE)
80100ead:	83 c4 10             	add    $0x10,%esp
80100eb0:	83 ff 01             	cmp    $0x1,%edi
80100eb3:	74 13                	je     80100ec8 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100eb5:	83 ff 02             	cmp    $0x2,%edi
80100eb8:	74 26                	je     80100ee0 <fileclose+0xa0>
}
80100eba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ebd:	5b                   	pop    %ebx
80100ebe:	5e                   	pop    %esi
80100ebf:	5f                   	pop    %edi
80100ec0:	5d                   	pop    %ebp
80100ec1:	c3                   	ret    
80100ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100ec8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100ecc:	83 ec 08             	sub    $0x8,%esp
80100ecf:	53                   	push   %ebx
80100ed0:	56                   	push   %esi
80100ed1:	e8 9a 24 00 00       	call   80103370 <pipeclose>
80100ed6:	83 c4 10             	add    $0x10,%esp
80100ed9:	eb df                	jmp    80100eba <fileclose+0x7a>
80100edb:	90                   	nop
80100edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100ee0:	e8 db 1c 00 00       	call   80102bc0 <begin_op>
    iput(ff.ip);
80100ee5:	83 ec 0c             	sub    $0xc,%esp
80100ee8:	ff 75 e0             	pushl  -0x20(%ebp)
80100eeb:	e8 d0 08 00 00       	call   801017c0 <iput>
    end_op();
80100ef0:	83 c4 10             	add    $0x10,%esp
}
80100ef3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ef6:	5b                   	pop    %ebx
80100ef7:	5e                   	pop    %esi
80100ef8:	5f                   	pop    %edi
80100ef9:	5d                   	pop    %ebp
    end_op();
80100efa:	e9 31 1d 00 00       	jmp    80102c30 <end_op>
    panic("fileclose");
80100eff:	83 ec 0c             	sub    $0xc,%esp
80100f02:	68 5c 85 10 80       	push   $0x8010855c
80100f07:	e8 84 f4 ff ff       	call   80100390 <panic>
80100f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f10 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f10:	55                   	push   %ebp
80100f11:	89 e5                	mov    %esp,%ebp
80100f13:	53                   	push   %ebx
80100f14:	83 ec 04             	sub    $0x4,%esp
80100f17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f1a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f1d:	75 31                	jne    80100f50 <filestat+0x40>
    ilock(f->ip);
80100f1f:	83 ec 0c             	sub    $0xc,%esp
80100f22:	ff 73 10             	pushl  0x10(%ebx)
80100f25:	e8 66 07 00 00       	call   80101690 <ilock>
    stati(f->ip, st);
80100f2a:	58                   	pop    %eax
80100f2b:	5a                   	pop    %edx
80100f2c:	ff 75 0c             	pushl  0xc(%ebp)
80100f2f:	ff 73 10             	pushl  0x10(%ebx)
80100f32:	e8 09 0a 00 00       	call   80101940 <stati>
    iunlock(f->ip);
80100f37:	59                   	pop    %ecx
80100f38:	ff 73 10             	pushl  0x10(%ebx)
80100f3b:	e8 30 08 00 00       	call   80101770 <iunlock>
    return 0;
80100f40:	83 c4 10             	add    $0x10,%esp
80100f43:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f48:	c9                   	leave  
80100f49:	c3                   	ret    
80100f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80100f50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f55:	eb ee                	jmp    80100f45 <filestat+0x35>
80100f57:	89 f6                	mov    %esi,%esi
80100f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f60 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f60:	55                   	push   %ebp
80100f61:	89 e5                	mov    %esp,%ebp
80100f63:	57                   	push   %edi
80100f64:	56                   	push   %esi
80100f65:	53                   	push   %ebx
80100f66:	83 ec 0c             	sub    $0xc,%esp
80100f69:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f6c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f6f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f72:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f76:	74 60                	je     80100fd8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f78:	8b 03                	mov    (%ebx),%eax
80100f7a:	83 f8 01             	cmp    $0x1,%eax
80100f7d:	74 41                	je     80100fc0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f7f:	83 f8 02             	cmp    $0x2,%eax
80100f82:	75 5b                	jne    80100fdf <fileread+0x7f>
    ilock(f->ip);
80100f84:	83 ec 0c             	sub    $0xc,%esp
80100f87:	ff 73 10             	pushl  0x10(%ebx)
80100f8a:	e8 01 07 00 00       	call   80101690 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f8f:	57                   	push   %edi
80100f90:	ff 73 14             	pushl  0x14(%ebx)
80100f93:	56                   	push   %esi
80100f94:	ff 73 10             	pushl  0x10(%ebx)
80100f97:	e8 d4 09 00 00       	call   80101970 <readi>
80100f9c:	83 c4 20             	add    $0x20,%esp
80100f9f:	85 c0                	test   %eax,%eax
80100fa1:	89 c6                	mov    %eax,%esi
80100fa3:	7e 03                	jle    80100fa8 <fileread+0x48>
      f->off += r;
80100fa5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100fa8:	83 ec 0c             	sub    $0xc,%esp
80100fab:	ff 73 10             	pushl  0x10(%ebx)
80100fae:	e8 bd 07 00 00       	call   80101770 <iunlock>
    return r;
80100fb3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80100fb6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb9:	89 f0                	mov    %esi,%eax
80100fbb:	5b                   	pop    %ebx
80100fbc:	5e                   	pop    %esi
80100fbd:	5f                   	pop    %edi
80100fbe:	5d                   	pop    %ebp
80100fbf:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80100fc0:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fc3:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100fc6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fc9:	5b                   	pop    %ebx
80100fca:	5e                   	pop    %esi
80100fcb:	5f                   	pop    %edi
80100fcc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100fcd:	e9 4e 25 00 00       	jmp    80103520 <piperead>
80100fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80100fd8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80100fdd:	eb d7                	jmp    80100fb6 <fileread+0x56>
  panic("fileread");
80100fdf:	83 ec 0c             	sub    $0xc,%esp
80100fe2:	68 66 85 10 80       	push   $0x80108566
80100fe7:	e8 a4 f3 ff ff       	call   80100390 <panic>
80100fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ff0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100ff0:	55                   	push   %ebp
80100ff1:	89 e5                	mov    %esp,%ebp
80100ff3:	57                   	push   %edi
80100ff4:	56                   	push   %esi
80100ff5:	53                   	push   %ebx
80100ff6:	83 ec 1c             	sub    $0x1c,%esp
80100ff9:	8b 75 08             	mov    0x8(%ebp),%esi
80100ffc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80100fff:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101003:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101006:	8b 45 10             	mov    0x10(%ebp),%eax
80101009:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010100c:	0f 84 aa 00 00 00    	je     801010bc <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101012:	8b 06                	mov    (%esi),%eax
80101014:	83 f8 01             	cmp    $0x1,%eax
80101017:	0f 84 c3 00 00 00    	je     801010e0 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010101d:	83 f8 02             	cmp    $0x2,%eax
80101020:	0f 85 d9 00 00 00    	jne    801010ff <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101026:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101029:	31 ff                	xor    %edi,%edi
    while(i < n){
8010102b:	85 c0                	test   %eax,%eax
8010102d:	7f 34                	jg     80101063 <filewrite+0x73>
8010102f:	e9 9c 00 00 00       	jmp    801010d0 <filewrite+0xe0>
80101034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101038:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010103b:	83 ec 0c             	sub    $0xc,%esp
8010103e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101041:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101044:	e8 27 07 00 00       	call   80101770 <iunlock>
      end_op();
80101049:	e8 e2 1b 00 00       	call   80102c30 <end_op>
8010104e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101051:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101054:	39 c3                	cmp    %eax,%ebx
80101056:	0f 85 96 00 00 00    	jne    801010f2 <filewrite+0x102>
        panic("short filewrite");
      i += r;
8010105c:	01 df                	add    %ebx,%edi
    while(i < n){
8010105e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101061:	7e 6d                	jle    801010d0 <filewrite+0xe0>
      int n1 = n - i;
80101063:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101066:	b8 00 06 00 00       	mov    $0x600,%eax
8010106b:	29 fb                	sub    %edi,%ebx
8010106d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101073:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101076:	e8 45 1b 00 00       	call   80102bc0 <begin_op>
      ilock(f->ip);
8010107b:	83 ec 0c             	sub    $0xc,%esp
8010107e:	ff 76 10             	pushl  0x10(%esi)
80101081:	e8 0a 06 00 00       	call   80101690 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101086:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101089:	53                   	push   %ebx
8010108a:	ff 76 14             	pushl  0x14(%esi)
8010108d:	01 f8                	add    %edi,%eax
8010108f:	50                   	push   %eax
80101090:	ff 76 10             	pushl  0x10(%esi)
80101093:	e8 d8 09 00 00       	call   80101a70 <writei>
80101098:	83 c4 20             	add    $0x20,%esp
8010109b:	85 c0                	test   %eax,%eax
8010109d:	7f 99                	jg     80101038 <filewrite+0x48>
      iunlock(f->ip);
8010109f:	83 ec 0c             	sub    $0xc,%esp
801010a2:	ff 76 10             	pushl  0x10(%esi)
801010a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010a8:	e8 c3 06 00 00       	call   80101770 <iunlock>
      end_op();
801010ad:	e8 7e 1b 00 00       	call   80102c30 <end_op>
      if(r < 0)
801010b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010b5:	83 c4 10             	add    $0x10,%esp
801010b8:	85 c0                	test   %eax,%eax
801010ba:	74 98                	je     80101054 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801010bf:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
801010c4:	89 f8                	mov    %edi,%eax
801010c6:	5b                   	pop    %ebx
801010c7:	5e                   	pop    %esi
801010c8:	5f                   	pop    %edi
801010c9:	5d                   	pop    %ebp
801010ca:	c3                   	ret    
801010cb:	90                   	nop
801010cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
801010d0:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010d3:	75 e7                	jne    801010bc <filewrite+0xcc>
}
801010d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010d8:	89 f8                	mov    %edi,%eax
801010da:	5b                   	pop    %ebx
801010db:	5e                   	pop    %esi
801010dc:	5f                   	pop    %edi
801010dd:	5d                   	pop    %ebp
801010de:	c3                   	ret    
801010df:	90                   	nop
    return pipewrite(f->pipe, addr, n);
801010e0:	8b 46 0c             	mov    0xc(%esi),%eax
801010e3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010e9:	5b                   	pop    %ebx
801010ea:	5e                   	pop    %esi
801010eb:	5f                   	pop    %edi
801010ec:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801010ed:	e9 1e 23 00 00       	jmp    80103410 <pipewrite>
        panic("short filewrite");
801010f2:	83 ec 0c             	sub    $0xc,%esp
801010f5:	68 6f 85 10 80       	push   $0x8010856f
801010fa:	e8 91 f2 ff ff       	call   80100390 <panic>
  panic("filewrite");
801010ff:	83 ec 0c             	sub    $0xc,%esp
80101102:	68 75 85 10 80       	push   $0x80108575
80101107:	e8 84 f2 ff ff       	call   80100390 <panic>
8010110c:	66 90                	xchg   %ax,%ax
8010110e:	66 90                	xchg   %ax,%ax

80101110 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101110:	55                   	push   %ebp
80101111:	89 e5                	mov    %esp,%ebp
80101113:	57                   	push   %edi
80101114:	56                   	push   %esi
80101115:	53                   	push   %ebx
80101116:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101119:	8b 0d c0 14 13 80    	mov    0x801314c0,%ecx
{
8010111f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101122:	85 c9                	test   %ecx,%ecx
80101124:	0f 84 87 00 00 00    	je     801011b1 <balloc+0xa1>
8010112a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101131:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101134:	83 ec 08             	sub    $0x8,%esp
80101137:	89 f0                	mov    %esi,%eax
80101139:	c1 f8 0c             	sar    $0xc,%eax
8010113c:	03 05 d8 14 13 80    	add    0x801314d8,%eax
80101142:	50                   	push   %eax
80101143:	ff 75 d8             	pushl  -0x28(%ebp)
80101146:	e8 85 ef ff ff       	call   801000d0 <bread>
8010114b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010114e:	a1 c0 14 13 80       	mov    0x801314c0,%eax
80101153:	83 c4 10             	add    $0x10,%esp
80101156:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101159:	31 c0                	xor    %eax,%eax
8010115b:	eb 2f                	jmp    8010118c <balloc+0x7c>
8010115d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101160:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101162:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101165:	bb 01 00 00 00       	mov    $0x1,%ebx
8010116a:	83 e1 07             	and    $0x7,%ecx
8010116d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010116f:	89 c1                	mov    %eax,%ecx
80101171:	c1 f9 03             	sar    $0x3,%ecx
80101174:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101179:	85 df                	test   %ebx,%edi
8010117b:	89 fa                	mov    %edi,%edx
8010117d:	74 41                	je     801011c0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010117f:	83 c0 01             	add    $0x1,%eax
80101182:	83 c6 01             	add    $0x1,%esi
80101185:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010118a:	74 05                	je     80101191 <balloc+0x81>
8010118c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010118f:	77 cf                	ja     80101160 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101191:	83 ec 0c             	sub    $0xc,%esp
80101194:	ff 75 e4             	pushl  -0x1c(%ebp)
80101197:	e8 44 f0 ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010119c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801011a3:	83 c4 10             	add    $0x10,%esp
801011a6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011a9:	39 05 c0 14 13 80    	cmp    %eax,0x801314c0
801011af:	77 80                	ja     80101131 <balloc+0x21>
  }
  panic("balloc: out of blocks");
801011b1:	83 ec 0c             	sub    $0xc,%esp
801011b4:	68 7f 85 10 80       	push   $0x8010857f
801011b9:	e8 d2 f1 ff ff       	call   80100390 <panic>
801011be:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
801011c0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801011c3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801011c6:	09 da                	or     %ebx,%edx
801011c8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801011cc:	57                   	push   %edi
801011cd:	e8 be 1b 00 00       	call   80102d90 <log_write>
        brelse(bp);
801011d2:	89 3c 24             	mov    %edi,(%esp)
801011d5:	e8 06 f0 ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
801011da:	58                   	pop    %eax
801011db:	5a                   	pop    %edx
801011dc:	56                   	push   %esi
801011dd:	ff 75 d8             	pushl  -0x28(%ebp)
801011e0:	e8 eb ee ff ff       	call   801000d0 <bread>
801011e5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801011e7:	8d 40 5c             	lea    0x5c(%eax),%eax
801011ea:	83 c4 0c             	add    $0xc,%esp
801011ed:	68 00 02 00 00       	push   $0x200
801011f2:	6a 00                	push   $0x0
801011f4:	50                   	push   %eax
801011f5:	e8 16 38 00 00       	call   80104a10 <memset>
  log_write(bp);
801011fa:	89 1c 24             	mov    %ebx,(%esp)
801011fd:	e8 8e 1b 00 00       	call   80102d90 <log_write>
  brelse(bp);
80101202:	89 1c 24             	mov    %ebx,(%esp)
80101205:	e8 d6 ef ff ff       	call   801001e0 <brelse>
}
8010120a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010120d:	89 f0                	mov    %esi,%eax
8010120f:	5b                   	pop    %ebx
80101210:	5e                   	pop    %esi
80101211:	5f                   	pop    %edi
80101212:	5d                   	pop    %ebp
80101213:	c3                   	ret    
80101214:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010121a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101220 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101220:	55                   	push   %ebp
80101221:	89 e5                	mov    %esp,%ebp
80101223:	57                   	push   %edi
80101224:	56                   	push   %esi
80101225:	53                   	push   %ebx
80101226:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101228:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010122a:	bb 14 15 13 80       	mov    $0x80131514,%ebx
{
8010122f:	83 ec 28             	sub    $0x28,%esp
80101232:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101235:	68 e0 14 13 80       	push   $0x801314e0
8010123a:	e8 c1 36 00 00       	call   80104900 <acquire>
8010123f:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101242:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101245:	eb 17                	jmp    8010125e <iget+0x3e>
80101247:	89 f6                	mov    %esi,%esi
80101249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101250:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101256:	81 fb 34 31 13 80    	cmp    $0x80133134,%ebx
8010125c:	73 22                	jae    80101280 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010125e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101261:	85 c9                	test   %ecx,%ecx
80101263:	7e 04                	jle    80101269 <iget+0x49>
80101265:	39 3b                	cmp    %edi,(%ebx)
80101267:	74 4f                	je     801012b8 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101269:	85 f6                	test   %esi,%esi
8010126b:	75 e3                	jne    80101250 <iget+0x30>
8010126d:	85 c9                	test   %ecx,%ecx
8010126f:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101272:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101278:	81 fb 34 31 13 80    	cmp    $0x80133134,%ebx
8010127e:	72 de                	jb     8010125e <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101280:	85 f6                	test   %esi,%esi
80101282:	74 5b                	je     801012df <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101284:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101287:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101289:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010128c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101293:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010129a:	68 e0 14 13 80       	push   $0x801314e0
8010129f:	e8 1c 37 00 00       	call   801049c0 <release>

  return ip;
801012a4:	83 c4 10             	add    $0x10,%esp
}
801012a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012aa:	89 f0                	mov    %esi,%eax
801012ac:	5b                   	pop    %ebx
801012ad:	5e                   	pop    %esi
801012ae:	5f                   	pop    %edi
801012af:	5d                   	pop    %ebp
801012b0:	c3                   	ret    
801012b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012b8:	39 53 04             	cmp    %edx,0x4(%ebx)
801012bb:	75 ac                	jne    80101269 <iget+0x49>
      release(&icache.lock);
801012bd:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
801012c0:	83 c1 01             	add    $0x1,%ecx
      return ip;
801012c3:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801012c5:	68 e0 14 13 80       	push   $0x801314e0
      ip->ref++;
801012ca:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801012cd:	e8 ee 36 00 00       	call   801049c0 <release>
      return ip;
801012d2:	83 c4 10             	add    $0x10,%esp
}
801012d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012d8:	89 f0                	mov    %esi,%eax
801012da:	5b                   	pop    %ebx
801012db:	5e                   	pop    %esi
801012dc:	5f                   	pop    %edi
801012dd:	5d                   	pop    %ebp
801012de:	c3                   	ret    
    panic("iget: no inodes");
801012df:	83 ec 0c             	sub    $0xc,%esp
801012e2:	68 95 85 10 80       	push   $0x80108595
801012e7:	e8 a4 f0 ff ff       	call   80100390 <panic>
801012ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801012f0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801012f0:	55                   	push   %ebp
801012f1:	89 e5                	mov    %esp,%ebp
801012f3:	57                   	push   %edi
801012f4:	56                   	push   %esi
801012f5:	53                   	push   %ebx
801012f6:	89 c6                	mov    %eax,%esi
801012f8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801012fb:	83 fa 0b             	cmp    $0xb,%edx
801012fe:	77 18                	ja     80101318 <bmap+0x28>
80101300:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
80101303:	8b 5f 5c             	mov    0x5c(%edi),%ebx
80101306:	85 db                	test   %ebx,%ebx
80101308:	74 76                	je     80101380 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010130a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010130d:	89 d8                	mov    %ebx,%eax
8010130f:	5b                   	pop    %ebx
80101310:	5e                   	pop    %esi
80101311:	5f                   	pop    %edi
80101312:	5d                   	pop    %ebp
80101313:	c3                   	ret    
80101314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
80101318:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
8010131b:	83 fb 7f             	cmp    $0x7f,%ebx
8010131e:	0f 87 90 00 00 00    	ja     801013b4 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101324:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
8010132a:	8b 00                	mov    (%eax),%eax
8010132c:	85 d2                	test   %edx,%edx
8010132e:	74 70                	je     801013a0 <bmap+0xb0>
    bp = bread(ip->dev, addr);
80101330:	83 ec 08             	sub    $0x8,%esp
80101333:	52                   	push   %edx
80101334:	50                   	push   %eax
80101335:	e8 96 ed ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
8010133a:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010133e:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
80101341:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
80101343:	8b 1a                	mov    (%edx),%ebx
80101345:	85 db                	test   %ebx,%ebx
80101347:	75 1d                	jne    80101366 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
80101349:	8b 06                	mov    (%esi),%eax
8010134b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010134e:	e8 bd fd ff ff       	call   80101110 <balloc>
80101353:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101356:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101359:	89 c3                	mov    %eax,%ebx
8010135b:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010135d:	57                   	push   %edi
8010135e:	e8 2d 1a 00 00       	call   80102d90 <log_write>
80101363:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101366:	83 ec 0c             	sub    $0xc,%esp
80101369:	57                   	push   %edi
8010136a:	e8 71 ee ff ff       	call   801001e0 <brelse>
8010136f:	83 c4 10             	add    $0x10,%esp
}
80101372:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101375:	89 d8                	mov    %ebx,%eax
80101377:	5b                   	pop    %ebx
80101378:	5e                   	pop    %esi
80101379:	5f                   	pop    %edi
8010137a:	5d                   	pop    %ebp
8010137b:	c3                   	ret    
8010137c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
80101380:	8b 00                	mov    (%eax),%eax
80101382:	e8 89 fd ff ff       	call   80101110 <balloc>
80101387:	89 47 5c             	mov    %eax,0x5c(%edi)
}
8010138a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
8010138d:	89 c3                	mov    %eax,%ebx
}
8010138f:	89 d8                	mov    %ebx,%eax
80101391:	5b                   	pop    %ebx
80101392:	5e                   	pop    %esi
80101393:	5f                   	pop    %edi
80101394:	5d                   	pop    %ebp
80101395:	c3                   	ret    
80101396:	8d 76 00             	lea    0x0(%esi),%esi
80101399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801013a0:	e8 6b fd ff ff       	call   80101110 <balloc>
801013a5:	89 c2                	mov    %eax,%edx
801013a7:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801013ad:	8b 06                	mov    (%esi),%eax
801013af:	e9 7c ff ff ff       	jmp    80101330 <bmap+0x40>
  panic("bmap: out of range");
801013b4:	83 ec 0c             	sub    $0xc,%esp
801013b7:	68 a5 85 10 80       	push   $0x801085a5
801013bc:	e8 cf ef ff ff       	call   80100390 <panic>
801013c1:	eb 0d                	jmp    801013d0 <readsb>
801013c3:	90                   	nop
801013c4:	90                   	nop
801013c5:	90                   	nop
801013c6:	90                   	nop
801013c7:	90                   	nop
801013c8:	90                   	nop
801013c9:	90                   	nop
801013ca:	90                   	nop
801013cb:	90                   	nop
801013cc:	90                   	nop
801013cd:	90                   	nop
801013ce:	90                   	nop
801013cf:	90                   	nop

801013d0 <readsb>:
{
801013d0:	55                   	push   %ebp
801013d1:	89 e5                	mov    %esp,%ebp
801013d3:	56                   	push   %esi
801013d4:	53                   	push   %ebx
801013d5:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801013d8:	83 ec 08             	sub    $0x8,%esp
801013db:	6a 01                	push   $0x1
801013dd:	ff 75 08             	pushl  0x8(%ebp)
801013e0:	e8 eb ec ff ff       	call   801000d0 <bread>
801013e5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801013e7:	8d 40 5c             	lea    0x5c(%eax),%eax
801013ea:	83 c4 0c             	add    $0xc,%esp
801013ed:	6a 1c                	push   $0x1c
801013ef:	50                   	push   %eax
801013f0:	56                   	push   %esi
801013f1:	e8 ca 36 00 00       	call   80104ac0 <memmove>
  brelse(bp);
801013f6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801013f9:	83 c4 10             	add    $0x10,%esp
}
801013fc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801013ff:	5b                   	pop    %ebx
80101400:	5e                   	pop    %esi
80101401:	5d                   	pop    %ebp
  brelse(bp);
80101402:	e9 d9 ed ff ff       	jmp    801001e0 <brelse>
80101407:	89 f6                	mov    %esi,%esi
80101409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101410 <bfree>:
{
80101410:	55                   	push   %ebp
80101411:	89 e5                	mov    %esp,%ebp
80101413:	56                   	push   %esi
80101414:	53                   	push   %ebx
80101415:	89 d3                	mov    %edx,%ebx
80101417:	89 c6                	mov    %eax,%esi
  readsb(dev, &sb);
80101419:	83 ec 08             	sub    $0x8,%esp
8010141c:	68 c0 14 13 80       	push   $0x801314c0
80101421:	50                   	push   %eax
80101422:	e8 a9 ff ff ff       	call   801013d0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101427:	58                   	pop    %eax
80101428:	5a                   	pop    %edx
80101429:	89 da                	mov    %ebx,%edx
8010142b:	c1 ea 0c             	shr    $0xc,%edx
8010142e:	03 15 d8 14 13 80    	add    0x801314d8,%edx
80101434:	52                   	push   %edx
80101435:	56                   	push   %esi
80101436:	e8 95 ec ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
8010143b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010143d:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
80101440:	ba 01 00 00 00       	mov    $0x1,%edx
80101445:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101448:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010144e:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101451:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101453:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101458:	85 d1                	test   %edx,%ecx
8010145a:	74 25                	je     80101481 <bfree+0x71>
  bp->data[bi/8] &= ~m;
8010145c:	f7 d2                	not    %edx
8010145e:	89 c6                	mov    %eax,%esi
  log_write(bp);
80101460:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101463:	21 ca                	and    %ecx,%edx
80101465:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101469:	56                   	push   %esi
8010146a:	e8 21 19 00 00       	call   80102d90 <log_write>
  brelse(bp);
8010146f:	89 34 24             	mov    %esi,(%esp)
80101472:	e8 69 ed ff ff       	call   801001e0 <brelse>
}
80101477:	83 c4 10             	add    $0x10,%esp
8010147a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010147d:	5b                   	pop    %ebx
8010147e:	5e                   	pop    %esi
8010147f:	5d                   	pop    %ebp
80101480:	c3                   	ret    
    panic("freeing free block");
80101481:	83 ec 0c             	sub    $0xc,%esp
80101484:	68 b8 85 10 80       	push   $0x801085b8
80101489:	e8 02 ef ff ff       	call   80100390 <panic>
8010148e:	66 90                	xchg   %ax,%ax

80101490 <iinit>:
{
80101490:	55                   	push   %ebp
80101491:	89 e5                	mov    %esp,%ebp
80101493:	53                   	push   %ebx
80101494:	bb 20 15 13 80       	mov    $0x80131520,%ebx
80101499:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010149c:	68 cb 85 10 80       	push   $0x801085cb
801014a1:	68 e0 14 13 80       	push   $0x801314e0
801014a6:	e8 15 33 00 00       	call   801047c0 <initlock>
801014ab:	83 c4 10             	add    $0x10,%esp
801014ae:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801014b0:	83 ec 08             	sub    $0x8,%esp
801014b3:	68 d2 85 10 80       	push   $0x801085d2
801014b8:	53                   	push   %ebx
801014b9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014bf:	e8 cc 31 00 00       	call   80104690 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014c4:	83 c4 10             	add    $0x10,%esp
801014c7:	81 fb 40 31 13 80    	cmp    $0x80133140,%ebx
801014cd:	75 e1                	jne    801014b0 <iinit+0x20>
  readsb(dev, &sb);
801014cf:	83 ec 08             	sub    $0x8,%esp
801014d2:	68 c0 14 13 80       	push   $0x801314c0
801014d7:	ff 75 08             	pushl  0x8(%ebp)
801014da:	e8 f1 fe ff ff       	call   801013d0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014df:	ff 35 d8 14 13 80    	pushl  0x801314d8
801014e5:	ff 35 d4 14 13 80    	pushl  0x801314d4
801014eb:	ff 35 d0 14 13 80    	pushl  0x801314d0
801014f1:	ff 35 cc 14 13 80    	pushl  0x801314cc
801014f7:	ff 35 c8 14 13 80    	pushl  0x801314c8
801014fd:	ff 35 c4 14 13 80    	pushl  0x801314c4
80101503:	ff 35 c0 14 13 80    	pushl  0x801314c0
80101509:	68 38 86 10 80       	push   $0x80108638
8010150e:	e8 4d f1 ff ff       	call   80100660 <cprintf>
}
80101513:	83 c4 30             	add    $0x30,%esp
80101516:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101519:	c9                   	leave  
8010151a:	c3                   	ret    
8010151b:	90                   	nop
8010151c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101520 <ialloc>:
{
80101520:	55                   	push   %ebp
80101521:	89 e5                	mov    %esp,%ebp
80101523:	57                   	push   %edi
80101524:	56                   	push   %esi
80101525:	53                   	push   %ebx
80101526:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101529:	83 3d c8 14 13 80 01 	cmpl   $0x1,0x801314c8
{
80101530:	8b 45 0c             	mov    0xc(%ebp),%eax
80101533:	8b 75 08             	mov    0x8(%ebp),%esi
80101536:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101539:	0f 86 91 00 00 00    	jbe    801015d0 <ialloc+0xb0>
8010153f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101544:	eb 21                	jmp    80101567 <ialloc+0x47>
80101546:	8d 76 00             	lea    0x0(%esi),%esi
80101549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101550:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101553:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101556:	57                   	push   %edi
80101557:	e8 84 ec ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010155c:	83 c4 10             	add    $0x10,%esp
8010155f:	39 1d c8 14 13 80    	cmp    %ebx,0x801314c8
80101565:	76 69                	jbe    801015d0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101567:	89 d8                	mov    %ebx,%eax
80101569:	83 ec 08             	sub    $0x8,%esp
8010156c:	c1 e8 03             	shr    $0x3,%eax
8010156f:	03 05 d4 14 13 80    	add    0x801314d4,%eax
80101575:	50                   	push   %eax
80101576:	56                   	push   %esi
80101577:	e8 54 eb ff ff       	call   801000d0 <bread>
8010157c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010157e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101580:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
80101583:	83 e0 07             	and    $0x7,%eax
80101586:	c1 e0 06             	shl    $0x6,%eax
80101589:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010158d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101591:	75 bd                	jne    80101550 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101593:	83 ec 04             	sub    $0x4,%esp
80101596:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101599:	6a 40                	push   $0x40
8010159b:	6a 00                	push   $0x0
8010159d:	51                   	push   %ecx
8010159e:	e8 6d 34 00 00       	call   80104a10 <memset>
      dip->type = type;
801015a3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801015a7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801015aa:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801015ad:	89 3c 24             	mov    %edi,(%esp)
801015b0:	e8 db 17 00 00       	call   80102d90 <log_write>
      brelse(bp);
801015b5:	89 3c 24             	mov    %edi,(%esp)
801015b8:	e8 23 ec ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801015bd:	83 c4 10             	add    $0x10,%esp
}
801015c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801015c3:	89 da                	mov    %ebx,%edx
801015c5:	89 f0                	mov    %esi,%eax
}
801015c7:	5b                   	pop    %ebx
801015c8:	5e                   	pop    %esi
801015c9:	5f                   	pop    %edi
801015ca:	5d                   	pop    %ebp
      return iget(dev, inum);
801015cb:	e9 50 fc ff ff       	jmp    80101220 <iget>
  panic("ialloc: no inodes");
801015d0:	83 ec 0c             	sub    $0xc,%esp
801015d3:	68 d8 85 10 80       	push   $0x801085d8
801015d8:	e8 b3 ed ff ff       	call   80100390 <panic>
801015dd:	8d 76 00             	lea    0x0(%esi),%esi

801015e0 <iupdate>:
{
801015e0:	55                   	push   %ebp
801015e1:	89 e5                	mov    %esp,%ebp
801015e3:	56                   	push   %esi
801015e4:	53                   	push   %ebx
801015e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015e8:	83 ec 08             	sub    $0x8,%esp
801015eb:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015ee:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015f1:	c1 e8 03             	shr    $0x3,%eax
801015f4:	03 05 d4 14 13 80    	add    0x801314d4,%eax
801015fa:	50                   	push   %eax
801015fb:	ff 73 a4             	pushl  -0x5c(%ebx)
801015fe:	e8 cd ea ff ff       	call   801000d0 <bread>
80101603:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101605:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
80101608:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010160c:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010160f:	83 e0 07             	and    $0x7,%eax
80101612:	c1 e0 06             	shl    $0x6,%eax
80101615:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101619:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010161c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101620:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101623:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101627:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010162b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010162f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101633:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101637:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010163a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010163d:	6a 34                	push   $0x34
8010163f:	53                   	push   %ebx
80101640:	50                   	push   %eax
80101641:	e8 7a 34 00 00       	call   80104ac0 <memmove>
  log_write(bp);
80101646:	89 34 24             	mov    %esi,(%esp)
80101649:	e8 42 17 00 00       	call   80102d90 <log_write>
  brelse(bp);
8010164e:	89 75 08             	mov    %esi,0x8(%ebp)
80101651:	83 c4 10             	add    $0x10,%esp
}
80101654:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101657:	5b                   	pop    %ebx
80101658:	5e                   	pop    %esi
80101659:	5d                   	pop    %ebp
  brelse(bp);
8010165a:	e9 81 eb ff ff       	jmp    801001e0 <brelse>
8010165f:	90                   	nop

80101660 <idup>:
{
80101660:	55                   	push   %ebp
80101661:	89 e5                	mov    %esp,%ebp
80101663:	53                   	push   %ebx
80101664:	83 ec 10             	sub    $0x10,%esp
80101667:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010166a:	68 e0 14 13 80       	push   $0x801314e0
8010166f:	e8 8c 32 00 00       	call   80104900 <acquire>
  ip->ref++;
80101674:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101678:	c7 04 24 e0 14 13 80 	movl   $0x801314e0,(%esp)
8010167f:	e8 3c 33 00 00       	call   801049c0 <release>
}
80101684:	89 d8                	mov    %ebx,%eax
80101686:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101689:	c9                   	leave  
8010168a:	c3                   	ret    
8010168b:	90                   	nop
8010168c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101690 <ilock>:
{
80101690:	55                   	push   %ebp
80101691:	89 e5                	mov    %esp,%ebp
80101693:	56                   	push   %esi
80101694:	53                   	push   %ebx
80101695:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101698:	85 db                	test   %ebx,%ebx
8010169a:	0f 84 b7 00 00 00    	je     80101757 <ilock+0xc7>
801016a0:	8b 53 08             	mov    0x8(%ebx),%edx
801016a3:	85 d2                	test   %edx,%edx
801016a5:	0f 8e ac 00 00 00    	jle    80101757 <ilock+0xc7>
  acquiresleep(&ip->lock);
801016ab:	8d 43 0c             	lea    0xc(%ebx),%eax
801016ae:	83 ec 0c             	sub    $0xc,%esp
801016b1:	50                   	push   %eax
801016b2:	e8 19 30 00 00       	call   801046d0 <acquiresleep>
  if(ip->valid == 0){
801016b7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801016ba:	83 c4 10             	add    $0x10,%esp
801016bd:	85 c0                	test   %eax,%eax
801016bf:	74 0f                	je     801016d0 <ilock+0x40>
}
801016c1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016c4:	5b                   	pop    %ebx
801016c5:	5e                   	pop    %esi
801016c6:	5d                   	pop    %ebp
801016c7:	c3                   	ret    
801016c8:	90                   	nop
801016c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016d0:	8b 43 04             	mov    0x4(%ebx),%eax
801016d3:	83 ec 08             	sub    $0x8,%esp
801016d6:	c1 e8 03             	shr    $0x3,%eax
801016d9:	03 05 d4 14 13 80    	add    0x801314d4,%eax
801016df:	50                   	push   %eax
801016e0:	ff 33                	pushl  (%ebx)
801016e2:	e8 e9 e9 ff ff       	call   801000d0 <bread>
801016e7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016e9:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016ec:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016ef:	83 e0 07             	and    $0x7,%eax
801016f2:	c1 e0 06             	shl    $0x6,%eax
801016f5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801016f9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016fc:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801016ff:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101703:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101707:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010170b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010170f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101713:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101717:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010171b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010171e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101721:	6a 34                	push   $0x34
80101723:	50                   	push   %eax
80101724:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101727:	50                   	push   %eax
80101728:	e8 93 33 00 00       	call   80104ac0 <memmove>
    brelse(bp);
8010172d:	89 34 24             	mov    %esi,(%esp)
80101730:	e8 ab ea ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101735:	83 c4 10             	add    $0x10,%esp
80101738:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010173d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101744:	0f 85 77 ff ff ff    	jne    801016c1 <ilock+0x31>
      panic("ilock: no type");
8010174a:	83 ec 0c             	sub    $0xc,%esp
8010174d:	68 f0 85 10 80       	push   $0x801085f0
80101752:	e8 39 ec ff ff       	call   80100390 <panic>
    panic("ilock");
80101757:	83 ec 0c             	sub    $0xc,%esp
8010175a:	68 ea 85 10 80       	push   $0x801085ea
8010175f:	e8 2c ec ff ff       	call   80100390 <panic>
80101764:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010176a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101770 <iunlock>:
{
80101770:	55                   	push   %ebp
80101771:	89 e5                	mov    %esp,%ebp
80101773:	56                   	push   %esi
80101774:	53                   	push   %ebx
80101775:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101778:	85 db                	test   %ebx,%ebx
8010177a:	74 28                	je     801017a4 <iunlock+0x34>
8010177c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010177f:	83 ec 0c             	sub    $0xc,%esp
80101782:	56                   	push   %esi
80101783:	e8 e8 2f 00 00       	call   80104770 <holdingsleep>
80101788:	83 c4 10             	add    $0x10,%esp
8010178b:	85 c0                	test   %eax,%eax
8010178d:	74 15                	je     801017a4 <iunlock+0x34>
8010178f:	8b 43 08             	mov    0x8(%ebx),%eax
80101792:	85 c0                	test   %eax,%eax
80101794:	7e 0e                	jle    801017a4 <iunlock+0x34>
  releasesleep(&ip->lock);
80101796:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101799:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010179c:	5b                   	pop    %ebx
8010179d:	5e                   	pop    %esi
8010179e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010179f:	e9 8c 2f 00 00       	jmp    80104730 <releasesleep>
    panic("iunlock");
801017a4:	83 ec 0c             	sub    $0xc,%esp
801017a7:	68 ff 85 10 80       	push   $0x801085ff
801017ac:	e8 df eb ff ff       	call   80100390 <panic>
801017b1:	eb 0d                	jmp    801017c0 <iput>
801017b3:	90                   	nop
801017b4:	90                   	nop
801017b5:	90                   	nop
801017b6:	90                   	nop
801017b7:	90                   	nop
801017b8:	90                   	nop
801017b9:	90                   	nop
801017ba:	90                   	nop
801017bb:	90                   	nop
801017bc:	90                   	nop
801017bd:	90                   	nop
801017be:	90                   	nop
801017bf:	90                   	nop

801017c0 <iput>:
{
801017c0:	55                   	push   %ebp
801017c1:	89 e5                	mov    %esp,%ebp
801017c3:	57                   	push   %edi
801017c4:	56                   	push   %esi
801017c5:	53                   	push   %ebx
801017c6:	83 ec 28             	sub    $0x28,%esp
801017c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801017cc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801017cf:	57                   	push   %edi
801017d0:	e8 fb 2e 00 00       	call   801046d0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801017d5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801017d8:	83 c4 10             	add    $0x10,%esp
801017db:	85 d2                	test   %edx,%edx
801017dd:	74 07                	je     801017e6 <iput+0x26>
801017df:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801017e4:	74 32                	je     80101818 <iput+0x58>
  releasesleep(&ip->lock);
801017e6:	83 ec 0c             	sub    $0xc,%esp
801017e9:	57                   	push   %edi
801017ea:	e8 41 2f 00 00       	call   80104730 <releasesleep>
  acquire(&icache.lock);
801017ef:	c7 04 24 e0 14 13 80 	movl   $0x801314e0,(%esp)
801017f6:	e8 05 31 00 00       	call   80104900 <acquire>
  ip->ref--;
801017fb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801017ff:	83 c4 10             	add    $0x10,%esp
80101802:	c7 45 08 e0 14 13 80 	movl   $0x801314e0,0x8(%ebp)
}
80101809:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010180c:	5b                   	pop    %ebx
8010180d:	5e                   	pop    %esi
8010180e:	5f                   	pop    %edi
8010180f:	5d                   	pop    %ebp
  release(&icache.lock);
80101810:	e9 ab 31 00 00       	jmp    801049c0 <release>
80101815:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101818:	83 ec 0c             	sub    $0xc,%esp
8010181b:	68 e0 14 13 80       	push   $0x801314e0
80101820:	e8 db 30 00 00       	call   80104900 <acquire>
    int r = ip->ref;
80101825:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101828:	c7 04 24 e0 14 13 80 	movl   $0x801314e0,(%esp)
8010182f:	e8 8c 31 00 00       	call   801049c0 <release>
    if(r == 1){
80101834:	83 c4 10             	add    $0x10,%esp
80101837:	83 fe 01             	cmp    $0x1,%esi
8010183a:	75 aa                	jne    801017e6 <iput+0x26>
8010183c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101842:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101845:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101848:	89 cf                	mov    %ecx,%edi
8010184a:	eb 0b                	jmp    80101857 <iput+0x97>
8010184c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101850:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101853:	39 fe                	cmp    %edi,%esi
80101855:	74 19                	je     80101870 <iput+0xb0>
    if(ip->addrs[i]){
80101857:	8b 16                	mov    (%esi),%edx
80101859:	85 d2                	test   %edx,%edx
8010185b:	74 f3                	je     80101850 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010185d:	8b 03                	mov    (%ebx),%eax
8010185f:	e8 ac fb ff ff       	call   80101410 <bfree>
      ip->addrs[i] = 0;
80101864:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010186a:	eb e4                	jmp    80101850 <iput+0x90>
8010186c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101870:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101876:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101879:	85 c0                	test   %eax,%eax
8010187b:	75 33                	jne    801018b0 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010187d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101880:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101887:	53                   	push   %ebx
80101888:	e8 53 fd ff ff       	call   801015e0 <iupdate>
      ip->type = 0;
8010188d:	31 c0                	xor    %eax,%eax
8010188f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101893:	89 1c 24             	mov    %ebx,(%esp)
80101896:	e8 45 fd ff ff       	call   801015e0 <iupdate>
      ip->valid = 0;
8010189b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801018a2:	83 c4 10             	add    $0x10,%esp
801018a5:	e9 3c ff ff ff       	jmp    801017e6 <iput+0x26>
801018aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018b0:	83 ec 08             	sub    $0x8,%esp
801018b3:	50                   	push   %eax
801018b4:	ff 33                	pushl  (%ebx)
801018b6:	e8 15 e8 ff ff       	call   801000d0 <bread>
801018bb:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801018c1:	89 7d e0             	mov    %edi,-0x20(%ebp)
801018c4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801018c7:	8d 70 5c             	lea    0x5c(%eax),%esi
801018ca:	83 c4 10             	add    $0x10,%esp
801018cd:	89 cf                	mov    %ecx,%edi
801018cf:	eb 0e                	jmp    801018df <iput+0x11f>
801018d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018d8:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
801018db:	39 fe                	cmp    %edi,%esi
801018dd:	74 0f                	je     801018ee <iput+0x12e>
      if(a[j])
801018df:	8b 16                	mov    (%esi),%edx
801018e1:	85 d2                	test   %edx,%edx
801018e3:	74 f3                	je     801018d8 <iput+0x118>
        bfree(ip->dev, a[j]);
801018e5:	8b 03                	mov    (%ebx),%eax
801018e7:	e8 24 fb ff ff       	call   80101410 <bfree>
801018ec:	eb ea                	jmp    801018d8 <iput+0x118>
    brelse(bp);
801018ee:	83 ec 0c             	sub    $0xc,%esp
801018f1:	ff 75 e4             	pushl  -0x1c(%ebp)
801018f4:	8b 7d e0             	mov    -0x20(%ebp),%edi
801018f7:	e8 e4 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801018fc:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101902:	8b 03                	mov    (%ebx),%eax
80101904:	e8 07 fb ff ff       	call   80101410 <bfree>
    ip->addrs[NDIRECT] = 0;
80101909:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101910:	00 00 00 
80101913:	83 c4 10             	add    $0x10,%esp
80101916:	e9 62 ff ff ff       	jmp    8010187d <iput+0xbd>
8010191b:	90                   	nop
8010191c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101920 <iunlockput>:
{
80101920:	55                   	push   %ebp
80101921:	89 e5                	mov    %esp,%ebp
80101923:	53                   	push   %ebx
80101924:	83 ec 10             	sub    $0x10,%esp
80101927:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010192a:	53                   	push   %ebx
8010192b:	e8 40 fe ff ff       	call   80101770 <iunlock>
  iput(ip);
80101930:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101933:	83 c4 10             	add    $0x10,%esp
}
80101936:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101939:	c9                   	leave  
  iput(ip);
8010193a:	e9 81 fe ff ff       	jmp    801017c0 <iput>
8010193f:	90                   	nop

80101940 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101940:	55                   	push   %ebp
80101941:	89 e5                	mov    %esp,%ebp
80101943:	8b 55 08             	mov    0x8(%ebp),%edx
80101946:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101949:	8b 0a                	mov    (%edx),%ecx
8010194b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010194e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101951:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101954:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101958:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010195b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010195f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101963:	8b 52 58             	mov    0x58(%edx),%edx
80101966:	89 50 10             	mov    %edx,0x10(%eax)
}
80101969:	5d                   	pop    %ebp
8010196a:	c3                   	ret    
8010196b:	90                   	nop
8010196c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101970 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101970:	55                   	push   %ebp
80101971:	89 e5                	mov    %esp,%ebp
80101973:	57                   	push   %edi
80101974:	56                   	push   %esi
80101975:	53                   	push   %ebx
80101976:	83 ec 1c             	sub    $0x1c,%esp
80101979:	8b 45 08             	mov    0x8(%ebp),%eax
8010197c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010197f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101982:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101987:	89 75 e0             	mov    %esi,-0x20(%ebp)
8010198a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010198d:	8b 75 10             	mov    0x10(%ebp),%esi
80101990:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101993:	0f 84 a7 00 00 00    	je     80101a40 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101999:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010199c:	8b 40 58             	mov    0x58(%eax),%eax
8010199f:	39 c6                	cmp    %eax,%esi
801019a1:	0f 87 ba 00 00 00    	ja     80101a61 <readi+0xf1>
801019a7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801019aa:	89 f9                	mov    %edi,%ecx
801019ac:	01 f1                	add    %esi,%ecx
801019ae:	0f 82 ad 00 00 00    	jb     80101a61 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801019b4:	89 c2                	mov    %eax,%edx
801019b6:	29 f2                	sub    %esi,%edx
801019b8:	39 c8                	cmp    %ecx,%eax
801019ba:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019bd:	31 ff                	xor    %edi,%edi
801019bf:	85 d2                	test   %edx,%edx
    n = ip->size - off;
801019c1:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019c4:	74 6c                	je     80101a32 <readi+0xc2>
801019c6:	8d 76 00             	lea    0x0(%esi),%esi
801019c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019d0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801019d3:	89 f2                	mov    %esi,%edx
801019d5:	c1 ea 09             	shr    $0x9,%edx
801019d8:	89 d8                	mov    %ebx,%eax
801019da:	e8 11 f9 ff ff       	call   801012f0 <bmap>
801019df:	83 ec 08             	sub    $0x8,%esp
801019e2:	50                   	push   %eax
801019e3:	ff 33                	pushl  (%ebx)
801019e5:	e8 e6 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801019ea:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019ed:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801019ef:	89 f0                	mov    %esi,%eax
801019f1:	25 ff 01 00 00       	and    $0x1ff,%eax
801019f6:	b9 00 02 00 00       	mov    $0x200,%ecx
801019fb:	83 c4 0c             	add    $0xc,%esp
801019fe:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101a00:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101a04:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101a07:	29 fb                	sub    %edi,%ebx
80101a09:	39 d9                	cmp    %ebx,%ecx
80101a0b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a0e:	53                   	push   %ebx
80101a0f:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a10:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101a12:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a15:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101a17:	e8 a4 30 00 00       	call   80104ac0 <memmove>
    brelse(bp);
80101a1c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a1f:	89 14 24             	mov    %edx,(%esp)
80101a22:	e8 b9 e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a27:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a2a:	83 c4 10             	add    $0x10,%esp
80101a2d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a30:	77 9e                	ja     801019d0 <readi+0x60>
  }
  return n;
80101a32:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a35:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a38:	5b                   	pop    %ebx
80101a39:	5e                   	pop    %esi
80101a3a:	5f                   	pop    %edi
80101a3b:	5d                   	pop    %ebp
80101a3c:	c3                   	ret    
80101a3d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a40:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101a44:	66 83 f8 09          	cmp    $0x9,%ax
80101a48:	77 17                	ja     80101a61 <readi+0xf1>
80101a4a:	8b 04 c5 60 14 13 80 	mov    -0x7feceba0(,%eax,8),%eax
80101a51:	85 c0                	test   %eax,%eax
80101a53:	74 0c                	je     80101a61 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101a55:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101a58:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a5b:	5b                   	pop    %ebx
80101a5c:	5e                   	pop    %esi
80101a5d:	5f                   	pop    %edi
80101a5e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101a5f:	ff e0                	jmp    *%eax
      return -1;
80101a61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a66:	eb cd                	jmp    80101a35 <readi+0xc5>
80101a68:	90                   	nop
80101a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101a70 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a70:	55                   	push   %ebp
80101a71:	89 e5                	mov    %esp,%ebp
80101a73:	57                   	push   %edi
80101a74:	56                   	push   %esi
80101a75:	53                   	push   %ebx
80101a76:	83 ec 1c             	sub    $0x1c,%esp
80101a79:	8b 45 08             	mov    0x8(%ebp),%eax
80101a7c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a7f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a82:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a87:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a8a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a8d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a90:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101a93:	0f 84 b7 00 00 00    	je     80101b50 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101a99:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a9c:	39 70 58             	cmp    %esi,0x58(%eax)
80101a9f:	0f 82 eb 00 00 00    	jb     80101b90 <writei+0x120>
80101aa5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101aa8:	31 d2                	xor    %edx,%edx
80101aaa:	89 f8                	mov    %edi,%eax
80101aac:	01 f0                	add    %esi,%eax
80101aae:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101ab1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101ab6:	0f 87 d4 00 00 00    	ja     80101b90 <writei+0x120>
80101abc:	85 d2                	test   %edx,%edx
80101abe:	0f 85 cc 00 00 00    	jne    80101b90 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ac4:	85 ff                	test   %edi,%edi
80101ac6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101acd:	74 72                	je     80101b41 <writei+0xd1>
80101acf:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ad0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101ad3:	89 f2                	mov    %esi,%edx
80101ad5:	c1 ea 09             	shr    $0x9,%edx
80101ad8:	89 f8                	mov    %edi,%eax
80101ada:	e8 11 f8 ff ff       	call   801012f0 <bmap>
80101adf:	83 ec 08             	sub    $0x8,%esp
80101ae2:	50                   	push   %eax
80101ae3:	ff 37                	pushl  (%edi)
80101ae5:	e8 e6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101aea:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101aed:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101af0:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101af2:	89 f0                	mov    %esi,%eax
80101af4:	b9 00 02 00 00       	mov    $0x200,%ecx
80101af9:	83 c4 0c             	add    $0xc,%esp
80101afc:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b01:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101b03:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b07:	39 d9                	cmp    %ebx,%ecx
80101b09:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101b0c:	53                   	push   %ebx
80101b0d:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b10:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101b12:	50                   	push   %eax
80101b13:	e8 a8 2f 00 00       	call   80104ac0 <memmove>
    log_write(bp);
80101b18:	89 3c 24             	mov    %edi,(%esp)
80101b1b:	e8 70 12 00 00       	call   80102d90 <log_write>
    brelse(bp);
80101b20:	89 3c 24             	mov    %edi,(%esp)
80101b23:	e8 b8 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b28:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b2b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b2e:	83 c4 10             	add    $0x10,%esp
80101b31:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b34:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101b37:	77 97                	ja     80101ad0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101b39:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b3c:	3b 70 58             	cmp    0x58(%eax),%esi
80101b3f:	77 37                	ja     80101b78 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b41:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b44:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b47:	5b                   	pop    %ebx
80101b48:	5e                   	pop    %esi
80101b49:	5f                   	pop    %edi
80101b4a:	5d                   	pop    %ebp
80101b4b:	c3                   	ret    
80101b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b50:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b54:	66 83 f8 09          	cmp    $0x9,%ax
80101b58:	77 36                	ja     80101b90 <writei+0x120>
80101b5a:	8b 04 c5 64 14 13 80 	mov    -0x7feceb9c(,%eax,8),%eax
80101b61:	85 c0                	test   %eax,%eax
80101b63:	74 2b                	je     80101b90 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101b65:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b68:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b6b:	5b                   	pop    %ebx
80101b6c:	5e                   	pop    %esi
80101b6d:	5f                   	pop    %edi
80101b6e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101b6f:	ff e0                	jmp    *%eax
80101b71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101b78:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101b7b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101b7e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b81:	50                   	push   %eax
80101b82:	e8 59 fa ff ff       	call   801015e0 <iupdate>
80101b87:	83 c4 10             	add    $0x10,%esp
80101b8a:	eb b5                	jmp    80101b41 <writei+0xd1>
80101b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101b90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b95:	eb ad                	jmp    80101b44 <writei+0xd4>
80101b97:	89 f6                	mov    %esi,%esi
80101b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ba0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101ba0:	55                   	push   %ebp
80101ba1:	89 e5                	mov    %esp,%ebp
80101ba3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101ba6:	6a 0e                	push   $0xe
80101ba8:	ff 75 0c             	pushl  0xc(%ebp)
80101bab:	ff 75 08             	pushl  0x8(%ebp)
80101bae:	e8 7d 2f 00 00       	call   80104b30 <strncmp>
}
80101bb3:	c9                   	leave  
80101bb4:	c3                   	ret    
80101bb5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bc0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101bc0:	55                   	push   %ebp
80101bc1:	89 e5                	mov    %esp,%ebp
80101bc3:	57                   	push   %edi
80101bc4:	56                   	push   %esi
80101bc5:	53                   	push   %ebx
80101bc6:	83 ec 1c             	sub    $0x1c,%esp
80101bc9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bcc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101bd1:	0f 85 85 00 00 00    	jne    80101c5c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101bd7:	8b 53 58             	mov    0x58(%ebx),%edx
80101bda:	31 ff                	xor    %edi,%edi
80101bdc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101bdf:	85 d2                	test   %edx,%edx
80101be1:	74 3e                	je     80101c21 <dirlookup+0x61>
80101be3:	90                   	nop
80101be4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101be8:	6a 10                	push   $0x10
80101bea:	57                   	push   %edi
80101beb:	56                   	push   %esi
80101bec:	53                   	push   %ebx
80101bed:	e8 7e fd ff ff       	call   80101970 <readi>
80101bf2:	83 c4 10             	add    $0x10,%esp
80101bf5:	83 f8 10             	cmp    $0x10,%eax
80101bf8:	75 55                	jne    80101c4f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101bfa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101bff:	74 18                	je     80101c19 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101c01:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c04:	83 ec 04             	sub    $0x4,%esp
80101c07:	6a 0e                	push   $0xe
80101c09:	50                   	push   %eax
80101c0a:	ff 75 0c             	pushl  0xc(%ebp)
80101c0d:	e8 1e 2f 00 00       	call   80104b30 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101c12:	83 c4 10             	add    $0x10,%esp
80101c15:	85 c0                	test   %eax,%eax
80101c17:	74 17                	je     80101c30 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101c19:	83 c7 10             	add    $0x10,%edi
80101c1c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101c1f:	72 c7                	jb     80101be8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101c21:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101c24:	31 c0                	xor    %eax,%eax
}
80101c26:	5b                   	pop    %ebx
80101c27:	5e                   	pop    %esi
80101c28:	5f                   	pop    %edi
80101c29:	5d                   	pop    %ebp
80101c2a:	c3                   	ret    
80101c2b:	90                   	nop
80101c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101c30:	8b 45 10             	mov    0x10(%ebp),%eax
80101c33:	85 c0                	test   %eax,%eax
80101c35:	74 05                	je     80101c3c <dirlookup+0x7c>
        *poff = off;
80101c37:	8b 45 10             	mov    0x10(%ebp),%eax
80101c3a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101c3c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101c40:	8b 03                	mov    (%ebx),%eax
80101c42:	e8 d9 f5 ff ff       	call   80101220 <iget>
}
80101c47:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c4a:	5b                   	pop    %ebx
80101c4b:	5e                   	pop    %esi
80101c4c:	5f                   	pop    %edi
80101c4d:	5d                   	pop    %ebp
80101c4e:	c3                   	ret    
      panic("dirlookup read");
80101c4f:	83 ec 0c             	sub    $0xc,%esp
80101c52:	68 19 86 10 80       	push   $0x80108619
80101c57:	e8 34 e7 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101c5c:	83 ec 0c             	sub    $0xc,%esp
80101c5f:	68 07 86 10 80       	push   $0x80108607
80101c64:	e8 27 e7 ff ff       	call   80100390 <panic>
80101c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101c70 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c70:	55                   	push   %ebp
80101c71:	89 e5                	mov    %esp,%ebp
80101c73:	57                   	push   %edi
80101c74:	56                   	push   %esi
80101c75:	53                   	push   %ebx
80101c76:	89 cf                	mov    %ecx,%edi
80101c78:	89 c3                	mov    %eax,%ebx
80101c7a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c7d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101c80:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101c83:	0f 84 77 01 00 00    	je     80101e00 <namex+0x190>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c89:	e8 72 1b 00 00       	call   80103800 <myproc>
  acquire(&icache.lock);
80101c8e:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101c91:	8b b0 b8 01 00 00    	mov    0x1b8(%eax),%esi
  acquire(&icache.lock);
80101c97:	68 e0 14 13 80       	push   $0x801314e0
80101c9c:	e8 5f 2c 00 00       	call   80104900 <acquire>
  ip->ref++;
80101ca1:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101ca5:	c7 04 24 e0 14 13 80 	movl   $0x801314e0,(%esp)
80101cac:	e8 0f 2d 00 00       	call   801049c0 <release>
80101cb1:	83 c4 10             	add    $0x10,%esp
80101cb4:	eb 0d                	jmp    80101cc3 <namex+0x53>
80101cb6:	8d 76 00             	lea    0x0(%esi),%esi
80101cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101cc0:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101cc3:	0f b6 03             	movzbl (%ebx),%eax
80101cc6:	3c 2f                	cmp    $0x2f,%al
80101cc8:	74 f6                	je     80101cc0 <namex+0x50>
  if(*path == 0)
80101cca:	84 c0                	test   %al,%al
80101ccc:	0f 84 f6 00 00 00    	je     80101dc8 <namex+0x158>
  while(*path != '/' && *path != 0)
80101cd2:	0f b6 03             	movzbl (%ebx),%eax
80101cd5:	3c 2f                	cmp    $0x2f,%al
80101cd7:	0f 84 bb 00 00 00    	je     80101d98 <namex+0x128>
80101cdd:	84 c0                	test   %al,%al
80101cdf:	89 da                	mov    %ebx,%edx
80101ce1:	75 11                	jne    80101cf4 <namex+0x84>
80101ce3:	e9 b0 00 00 00       	jmp    80101d98 <namex+0x128>
80101ce8:	90                   	nop
80101ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cf0:	84 c0                	test   %al,%al
80101cf2:	74 0a                	je     80101cfe <namex+0x8e>
    path++;
80101cf4:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101cf7:	0f b6 02             	movzbl (%edx),%eax
80101cfa:	3c 2f                	cmp    $0x2f,%al
80101cfc:	75 f2                	jne    80101cf0 <namex+0x80>
80101cfe:	89 d1                	mov    %edx,%ecx
80101d00:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101d02:	83 f9 0d             	cmp    $0xd,%ecx
80101d05:	0f 8e 91 00 00 00    	jle    80101d9c <namex+0x12c>
    memmove(name, s, DIRSIZ);
80101d0b:	83 ec 04             	sub    $0x4,%esp
80101d0e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101d11:	6a 0e                	push   $0xe
80101d13:	53                   	push   %ebx
80101d14:	57                   	push   %edi
80101d15:	e8 a6 2d 00 00       	call   80104ac0 <memmove>
    path++;
80101d1a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101d1d:	83 c4 10             	add    $0x10,%esp
    path++;
80101d20:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101d22:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d25:	75 11                	jne    80101d38 <namex+0xc8>
80101d27:	89 f6                	mov    %esi,%esi
80101d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101d30:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d33:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d36:	74 f8                	je     80101d30 <namex+0xc0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d38:	83 ec 0c             	sub    $0xc,%esp
80101d3b:	56                   	push   %esi
80101d3c:	e8 4f f9 ff ff       	call   80101690 <ilock>
    if(ip->type != T_DIR){
80101d41:	83 c4 10             	add    $0x10,%esp
80101d44:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d49:	0f 85 91 00 00 00    	jne    80101de0 <namex+0x170>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d4f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d52:	85 d2                	test   %edx,%edx
80101d54:	74 09                	je     80101d5f <namex+0xef>
80101d56:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d59:	0f 84 b7 00 00 00    	je     80101e16 <namex+0x1a6>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d5f:	83 ec 04             	sub    $0x4,%esp
80101d62:	6a 00                	push   $0x0
80101d64:	57                   	push   %edi
80101d65:	56                   	push   %esi
80101d66:	e8 55 fe ff ff       	call   80101bc0 <dirlookup>
80101d6b:	83 c4 10             	add    $0x10,%esp
80101d6e:	85 c0                	test   %eax,%eax
80101d70:	74 6e                	je     80101de0 <namex+0x170>
  iunlock(ip);
80101d72:	83 ec 0c             	sub    $0xc,%esp
80101d75:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d78:	56                   	push   %esi
80101d79:	e8 f2 f9 ff ff       	call   80101770 <iunlock>
  iput(ip);
80101d7e:	89 34 24             	mov    %esi,(%esp)
80101d81:	e8 3a fa ff ff       	call   801017c0 <iput>
80101d86:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d89:	83 c4 10             	add    $0x10,%esp
80101d8c:	89 c6                	mov    %eax,%esi
80101d8e:	e9 30 ff ff ff       	jmp    80101cc3 <namex+0x53>
80101d93:	90                   	nop
80101d94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101d98:	89 da                	mov    %ebx,%edx
80101d9a:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101d9c:	83 ec 04             	sub    $0x4,%esp
80101d9f:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101da2:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101da5:	51                   	push   %ecx
80101da6:	53                   	push   %ebx
80101da7:	57                   	push   %edi
80101da8:	e8 13 2d 00 00       	call   80104ac0 <memmove>
    name[len] = 0;
80101dad:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101db0:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101db3:	83 c4 10             	add    $0x10,%esp
80101db6:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101dba:	89 d3                	mov    %edx,%ebx
80101dbc:	e9 61 ff ff ff       	jmp    80101d22 <namex+0xb2>
80101dc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101dc8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101dcb:	85 c0                	test   %eax,%eax
80101dcd:	75 5d                	jne    80101e2c <namex+0x1bc>
    iput(ip);
    return 0;
  }
  return ip;
}
80101dcf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dd2:	89 f0                	mov    %esi,%eax
80101dd4:	5b                   	pop    %ebx
80101dd5:	5e                   	pop    %esi
80101dd6:	5f                   	pop    %edi
80101dd7:	5d                   	pop    %ebp
80101dd8:	c3                   	ret    
80101dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101de0:	83 ec 0c             	sub    $0xc,%esp
80101de3:	56                   	push   %esi
80101de4:	e8 87 f9 ff ff       	call   80101770 <iunlock>
  iput(ip);
80101de9:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101dec:	31 f6                	xor    %esi,%esi
  iput(ip);
80101dee:	e8 cd f9 ff ff       	call   801017c0 <iput>
      return 0;
80101df3:	83 c4 10             	add    $0x10,%esp
}
80101df6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101df9:	89 f0                	mov    %esi,%eax
80101dfb:	5b                   	pop    %ebx
80101dfc:	5e                   	pop    %esi
80101dfd:	5f                   	pop    %edi
80101dfe:	5d                   	pop    %ebp
80101dff:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101e00:	ba 01 00 00 00       	mov    $0x1,%edx
80101e05:	b8 01 00 00 00       	mov    $0x1,%eax
80101e0a:	e8 11 f4 ff ff       	call   80101220 <iget>
80101e0f:	89 c6                	mov    %eax,%esi
80101e11:	e9 ad fe ff ff       	jmp    80101cc3 <namex+0x53>
      iunlock(ip);
80101e16:	83 ec 0c             	sub    $0xc,%esp
80101e19:	56                   	push   %esi
80101e1a:	e8 51 f9 ff ff       	call   80101770 <iunlock>
      return ip;
80101e1f:	83 c4 10             	add    $0x10,%esp
}
80101e22:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e25:	89 f0                	mov    %esi,%eax
80101e27:	5b                   	pop    %ebx
80101e28:	5e                   	pop    %esi
80101e29:	5f                   	pop    %edi
80101e2a:	5d                   	pop    %ebp
80101e2b:	c3                   	ret    
    iput(ip);
80101e2c:	83 ec 0c             	sub    $0xc,%esp
80101e2f:	56                   	push   %esi
    return 0;
80101e30:	31 f6                	xor    %esi,%esi
    iput(ip);
80101e32:	e8 89 f9 ff ff       	call   801017c0 <iput>
    return 0;
80101e37:	83 c4 10             	add    $0x10,%esp
80101e3a:	eb 93                	jmp    80101dcf <namex+0x15f>
80101e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101e40 <dirlink>:
{
80101e40:	55                   	push   %ebp
80101e41:	89 e5                	mov    %esp,%ebp
80101e43:	57                   	push   %edi
80101e44:	56                   	push   %esi
80101e45:	53                   	push   %ebx
80101e46:	83 ec 20             	sub    $0x20,%esp
80101e49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e4c:	6a 00                	push   $0x0
80101e4e:	ff 75 0c             	pushl  0xc(%ebp)
80101e51:	53                   	push   %ebx
80101e52:	e8 69 fd ff ff       	call   80101bc0 <dirlookup>
80101e57:	83 c4 10             	add    $0x10,%esp
80101e5a:	85 c0                	test   %eax,%eax
80101e5c:	75 67                	jne    80101ec5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e5e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101e61:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e64:	85 ff                	test   %edi,%edi
80101e66:	74 29                	je     80101e91 <dirlink+0x51>
80101e68:	31 ff                	xor    %edi,%edi
80101e6a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e6d:	eb 09                	jmp    80101e78 <dirlink+0x38>
80101e6f:	90                   	nop
80101e70:	83 c7 10             	add    $0x10,%edi
80101e73:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101e76:	73 19                	jae    80101e91 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e78:	6a 10                	push   $0x10
80101e7a:	57                   	push   %edi
80101e7b:	56                   	push   %esi
80101e7c:	53                   	push   %ebx
80101e7d:	e8 ee fa ff ff       	call   80101970 <readi>
80101e82:	83 c4 10             	add    $0x10,%esp
80101e85:	83 f8 10             	cmp    $0x10,%eax
80101e88:	75 4e                	jne    80101ed8 <dirlink+0x98>
    if(de.inum == 0)
80101e8a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e8f:	75 df                	jne    80101e70 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101e91:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e94:	83 ec 04             	sub    $0x4,%esp
80101e97:	6a 0e                	push   $0xe
80101e99:	ff 75 0c             	pushl  0xc(%ebp)
80101e9c:	50                   	push   %eax
80101e9d:	e8 ee 2c 00 00       	call   80104b90 <strncpy>
  de.inum = inum;
80101ea2:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ea5:	6a 10                	push   $0x10
80101ea7:	57                   	push   %edi
80101ea8:	56                   	push   %esi
80101ea9:	53                   	push   %ebx
  de.inum = inum;
80101eaa:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101eae:	e8 bd fb ff ff       	call   80101a70 <writei>
80101eb3:	83 c4 20             	add    $0x20,%esp
80101eb6:	83 f8 10             	cmp    $0x10,%eax
80101eb9:	75 2a                	jne    80101ee5 <dirlink+0xa5>
  return 0;
80101ebb:	31 c0                	xor    %eax,%eax
}
80101ebd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ec0:	5b                   	pop    %ebx
80101ec1:	5e                   	pop    %esi
80101ec2:	5f                   	pop    %edi
80101ec3:	5d                   	pop    %ebp
80101ec4:	c3                   	ret    
    iput(ip);
80101ec5:	83 ec 0c             	sub    $0xc,%esp
80101ec8:	50                   	push   %eax
80101ec9:	e8 f2 f8 ff ff       	call   801017c0 <iput>
    return -1;
80101ece:	83 c4 10             	add    $0x10,%esp
80101ed1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ed6:	eb e5                	jmp    80101ebd <dirlink+0x7d>
      panic("dirlink read");
80101ed8:	83 ec 0c             	sub    $0xc,%esp
80101edb:	68 28 86 10 80       	push   $0x80108628
80101ee0:	e8 ab e4 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101ee5:	83 ec 0c             	sub    $0xc,%esp
80101ee8:	68 86 8c 10 80       	push   $0x80108c86
80101eed:	e8 9e e4 ff ff       	call   80100390 <panic>
80101ef2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f00 <namei>:

struct inode*
namei(char *path)
{
80101f00:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101f01:	31 d2                	xor    %edx,%edx
{
80101f03:	89 e5                	mov    %esp,%ebp
80101f05:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101f08:	8b 45 08             	mov    0x8(%ebp),%eax
80101f0b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101f0e:	e8 5d fd ff ff       	call   80101c70 <namex>
}
80101f13:	c9                   	leave  
80101f14:	c3                   	ret    
80101f15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f20 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f20:	55                   	push   %ebp
  return namex(path, 1, name);
80101f21:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101f26:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f28:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f2b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f2e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101f2f:	e9 3c fd ff ff       	jmp    80101c70 <namex>
80101f34:	66 90                	xchg   %ax,%ax
80101f36:	66 90                	xchg   %ax,%ax
80101f38:	66 90                	xchg   %ax,%ax
80101f3a:	66 90                	xchg   %ax,%ax
80101f3c:	66 90                	xchg   %ax,%ax
80101f3e:	66 90                	xchg   %ax,%ax

80101f40 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f40:	55                   	push   %ebp
80101f41:	89 e5                	mov    %esp,%ebp
80101f43:	57                   	push   %edi
80101f44:	56                   	push   %esi
80101f45:	53                   	push   %ebx
80101f46:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80101f49:	85 c0                	test   %eax,%eax
80101f4b:	0f 84 b4 00 00 00    	je     80102005 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f51:	8b 58 08             	mov    0x8(%eax),%ebx
80101f54:	89 c6                	mov    %eax,%esi
80101f56:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f5c:	0f 87 96 00 00 00    	ja     80101ff8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f62:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80101f67:	89 f6                	mov    %esi,%esi
80101f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101f70:	89 ca                	mov    %ecx,%edx
80101f72:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f73:	83 e0 c0             	and    $0xffffffc0,%eax
80101f76:	3c 40                	cmp    $0x40,%al
80101f78:	75 f6                	jne    80101f70 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f7a:	31 ff                	xor    %edi,%edi
80101f7c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f81:	89 f8                	mov    %edi,%eax
80101f83:	ee                   	out    %al,(%dx)
80101f84:	b8 01 00 00 00       	mov    $0x1,%eax
80101f89:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f8e:	ee                   	out    %al,(%dx)
80101f8f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101f94:	89 d8                	mov    %ebx,%eax
80101f96:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101f97:	89 d8                	mov    %ebx,%eax
80101f99:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101f9e:	c1 f8 08             	sar    $0x8,%eax
80101fa1:	ee                   	out    %al,(%dx)
80101fa2:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101fa7:	89 f8                	mov    %edi,%eax
80101fa9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101faa:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80101fae:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101fb3:	c1 e0 04             	shl    $0x4,%eax
80101fb6:	83 e0 10             	and    $0x10,%eax
80101fb9:	83 c8 e0             	or     $0xffffffe0,%eax
80101fbc:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101fbd:	f6 06 04             	testb  $0x4,(%esi)
80101fc0:	75 16                	jne    80101fd8 <idestart+0x98>
80101fc2:	b8 20 00 00 00       	mov    $0x20,%eax
80101fc7:	89 ca                	mov    %ecx,%edx
80101fc9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101fca:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fcd:	5b                   	pop    %ebx
80101fce:	5e                   	pop    %esi
80101fcf:	5f                   	pop    %edi
80101fd0:	5d                   	pop    %ebp
80101fd1:	c3                   	ret    
80101fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101fd8:	b8 30 00 00 00       	mov    $0x30,%eax
80101fdd:	89 ca                	mov    %ecx,%edx
80101fdf:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80101fe0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80101fe5:	83 c6 5c             	add    $0x5c,%esi
80101fe8:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101fed:	fc                   	cld    
80101fee:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80101ff0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ff3:	5b                   	pop    %ebx
80101ff4:	5e                   	pop    %esi
80101ff5:	5f                   	pop    %edi
80101ff6:	5d                   	pop    %ebp
80101ff7:	c3                   	ret    
    panic("incorrect blockno");
80101ff8:	83 ec 0c             	sub    $0xc,%esp
80101ffb:	68 94 86 10 80       	push   $0x80108694
80102000:	e8 8b e3 ff ff       	call   80100390 <panic>
    panic("idestart");
80102005:	83 ec 0c             	sub    $0xc,%esp
80102008:	68 8b 86 10 80       	push   $0x8010868b
8010200d:	e8 7e e3 ff ff       	call   80100390 <panic>
80102012:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102020 <ideinit>:
{
80102020:	55                   	push   %ebp
80102021:	89 e5                	mov    %esp,%ebp
80102023:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102026:	68 a6 86 10 80       	push   $0x801086a6
8010202b:	68 80 c5 10 80       	push   $0x8010c580
80102030:	e8 8b 27 00 00       	call   801047c0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102035:	58                   	pop    %eax
80102036:	a1 00 38 13 80       	mov    0x80133800,%eax
8010203b:	5a                   	pop    %edx
8010203c:	83 e8 01             	sub    $0x1,%eax
8010203f:	50                   	push   %eax
80102040:	6a 0e                	push   $0xe
80102042:	e8 a9 02 00 00       	call   801022f0 <ioapicenable>
80102047:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010204a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010204f:	90                   	nop
80102050:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102051:	83 e0 c0             	and    $0xffffffc0,%eax
80102054:	3c 40                	cmp    $0x40,%al
80102056:	75 f8                	jne    80102050 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102058:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010205d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102062:	ee                   	out    %al,(%dx)
80102063:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102068:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010206d:	eb 06                	jmp    80102075 <ideinit+0x55>
8010206f:	90                   	nop
  for(i=0; i<1000; i++){
80102070:	83 e9 01             	sub    $0x1,%ecx
80102073:	74 0f                	je     80102084 <ideinit+0x64>
80102075:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102076:	84 c0                	test   %al,%al
80102078:	74 f6                	je     80102070 <ideinit+0x50>
      havedisk1 = 1;
8010207a:	c7 05 60 c5 10 80 01 	movl   $0x1,0x8010c560
80102081:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102084:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102089:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010208e:	ee                   	out    %al,(%dx)
}
8010208f:	c9                   	leave  
80102090:	c3                   	ret    
80102091:	eb 0d                	jmp    801020a0 <ideintr>
80102093:	90                   	nop
80102094:	90                   	nop
80102095:	90                   	nop
80102096:	90                   	nop
80102097:	90                   	nop
80102098:	90                   	nop
80102099:	90                   	nop
8010209a:	90                   	nop
8010209b:	90                   	nop
8010209c:	90                   	nop
8010209d:	90                   	nop
8010209e:	90                   	nop
8010209f:	90                   	nop

801020a0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801020a0:	55                   	push   %ebp
801020a1:	89 e5                	mov    %esp,%ebp
801020a3:	57                   	push   %edi
801020a4:	56                   	push   %esi
801020a5:	53                   	push   %ebx
801020a6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801020a9:	68 80 c5 10 80       	push   $0x8010c580
801020ae:	e8 4d 28 00 00       	call   80104900 <acquire>

  if((b = idequeue) == 0){
801020b3:	8b 1d 64 c5 10 80    	mov    0x8010c564,%ebx
801020b9:	83 c4 10             	add    $0x10,%esp
801020bc:	85 db                	test   %ebx,%ebx
801020be:	74 67                	je     80102127 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801020c0:	8b 43 58             	mov    0x58(%ebx),%eax
801020c3:	a3 64 c5 10 80       	mov    %eax,0x8010c564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801020c8:	8b 3b                	mov    (%ebx),%edi
801020ca:	f7 c7 04 00 00 00    	test   $0x4,%edi
801020d0:	75 31                	jne    80102103 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020d2:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020d7:	89 f6                	mov    %esi,%esi
801020d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801020e0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020e1:	89 c6                	mov    %eax,%esi
801020e3:	83 e6 c0             	and    $0xffffffc0,%esi
801020e6:	89 f1                	mov    %esi,%ecx
801020e8:	80 f9 40             	cmp    $0x40,%cl
801020eb:	75 f3                	jne    801020e0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801020ed:	a8 21                	test   $0x21,%al
801020ef:	75 12                	jne    80102103 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
801020f1:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801020f4:	b9 80 00 00 00       	mov    $0x80,%ecx
801020f9:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020fe:	fc                   	cld    
801020ff:	f3 6d                	rep insl (%dx),%es:(%edi)
80102101:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102103:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
80102106:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102109:	89 f9                	mov    %edi,%ecx
8010210b:	83 c9 02             	or     $0x2,%ecx
8010210e:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
80102110:	53                   	push   %ebx
80102111:	e8 0a 1f 00 00       	call   80104020 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102116:	a1 64 c5 10 80       	mov    0x8010c564,%eax
8010211b:	83 c4 10             	add    $0x10,%esp
8010211e:	85 c0                	test   %eax,%eax
80102120:	74 05                	je     80102127 <ideintr+0x87>
    idestart(idequeue);
80102122:	e8 19 fe ff ff       	call   80101f40 <idestart>
    release(&idelock);
80102127:	83 ec 0c             	sub    $0xc,%esp
8010212a:	68 80 c5 10 80       	push   $0x8010c580
8010212f:	e8 8c 28 00 00       	call   801049c0 <release>

  release(&idelock);
}
80102134:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102137:	5b                   	pop    %ebx
80102138:	5e                   	pop    %esi
80102139:	5f                   	pop    %edi
8010213a:	5d                   	pop    %ebp
8010213b:	c3                   	ret    
8010213c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102140 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102140:	55                   	push   %ebp
80102141:	89 e5                	mov    %esp,%ebp
80102143:	53                   	push   %ebx
80102144:	83 ec 10             	sub    $0x10,%esp
80102147:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010214a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010214d:	50                   	push   %eax
8010214e:	e8 1d 26 00 00       	call   80104770 <holdingsleep>
80102153:	83 c4 10             	add    $0x10,%esp
80102156:	85 c0                	test   %eax,%eax
80102158:	0f 84 c6 00 00 00    	je     80102224 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010215e:	8b 03                	mov    (%ebx),%eax
80102160:	83 e0 06             	and    $0x6,%eax
80102163:	83 f8 02             	cmp    $0x2,%eax
80102166:	0f 84 ab 00 00 00    	je     80102217 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010216c:	8b 53 04             	mov    0x4(%ebx),%edx
8010216f:	85 d2                	test   %edx,%edx
80102171:	74 0d                	je     80102180 <iderw+0x40>
80102173:	a1 60 c5 10 80       	mov    0x8010c560,%eax
80102178:	85 c0                	test   %eax,%eax
8010217a:	0f 84 b1 00 00 00    	je     80102231 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102180:	83 ec 0c             	sub    $0xc,%esp
80102183:	68 80 c5 10 80       	push   $0x8010c580
80102188:	e8 73 27 00 00       	call   80104900 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010218d:	8b 15 64 c5 10 80    	mov    0x8010c564,%edx
80102193:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
80102196:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010219d:	85 d2                	test   %edx,%edx
8010219f:	75 09                	jne    801021aa <iderw+0x6a>
801021a1:	eb 6d                	jmp    80102210 <iderw+0xd0>
801021a3:	90                   	nop
801021a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801021a8:	89 c2                	mov    %eax,%edx
801021aa:	8b 42 58             	mov    0x58(%edx),%eax
801021ad:	85 c0                	test   %eax,%eax
801021af:	75 f7                	jne    801021a8 <iderw+0x68>
801021b1:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801021b4:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801021b6:	39 1d 64 c5 10 80    	cmp    %ebx,0x8010c564
801021bc:	74 42                	je     80102200 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021be:	8b 03                	mov    (%ebx),%eax
801021c0:	83 e0 06             	and    $0x6,%eax
801021c3:	83 f8 02             	cmp    $0x2,%eax
801021c6:	74 23                	je     801021eb <iderw+0xab>
801021c8:	90                   	nop
801021c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
801021d0:	83 ec 08             	sub    $0x8,%esp
801021d3:	68 80 c5 10 80       	push   $0x8010c580
801021d8:	53                   	push   %ebx
801021d9:	e8 82 1c 00 00       	call   80103e60 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021de:	8b 03                	mov    (%ebx),%eax
801021e0:	83 c4 10             	add    $0x10,%esp
801021e3:	83 e0 06             	and    $0x6,%eax
801021e6:	83 f8 02             	cmp    $0x2,%eax
801021e9:	75 e5                	jne    801021d0 <iderw+0x90>
  }


  release(&idelock);
801021eb:	c7 45 08 80 c5 10 80 	movl   $0x8010c580,0x8(%ebp)
}
801021f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021f5:	c9                   	leave  
  release(&idelock);
801021f6:	e9 c5 27 00 00       	jmp    801049c0 <release>
801021fb:	90                   	nop
801021fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
80102200:	89 d8                	mov    %ebx,%eax
80102202:	e8 39 fd ff ff       	call   80101f40 <idestart>
80102207:	eb b5                	jmp    801021be <iderw+0x7e>
80102209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102210:	ba 64 c5 10 80       	mov    $0x8010c564,%edx
80102215:	eb 9d                	jmp    801021b4 <iderw+0x74>
    panic("iderw: nothing to do");
80102217:	83 ec 0c             	sub    $0xc,%esp
8010221a:	68 c0 86 10 80       	push   $0x801086c0
8010221f:	e8 6c e1 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102224:	83 ec 0c             	sub    $0xc,%esp
80102227:	68 aa 86 10 80       	push   $0x801086aa
8010222c:	e8 5f e1 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102231:	83 ec 0c             	sub    $0xc,%esp
80102234:	68 d5 86 10 80       	push   $0x801086d5
80102239:	e8 52 e1 ff ff       	call   80100390 <panic>
8010223e:	66 90                	xchg   %ax,%ax

80102240 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102240:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102241:	c7 05 34 31 13 80 00 	movl   $0xfec00000,0x80133134
80102248:	00 c0 fe 
{
8010224b:	89 e5                	mov    %esp,%ebp
8010224d:	56                   	push   %esi
8010224e:	53                   	push   %ebx
  ioapic->reg = reg;
8010224f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102256:	00 00 00 
  return ioapic->data;
80102259:	a1 34 31 13 80       	mov    0x80133134,%eax
8010225e:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102261:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102267:	8b 0d 34 31 13 80    	mov    0x80133134,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010226d:	0f b6 15 60 32 13 80 	movzbl 0x80133260,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102274:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
80102277:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
8010227a:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
8010227d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102280:	39 c2                	cmp    %eax,%edx
80102282:	74 16                	je     8010229a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102284:	83 ec 0c             	sub    $0xc,%esp
80102287:	68 f4 86 10 80       	push   $0x801086f4
8010228c:	e8 cf e3 ff ff       	call   80100660 <cprintf>
80102291:	8b 0d 34 31 13 80    	mov    0x80133134,%ecx
80102297:	83 c4 10             	add    $0x10,%esp
8010229a:	83 c3 21             	add    $0x21,%ebx
{
8010229d:	ba 10 00 00 00       	mov    $0x10,%edx
801022a2:	b8 20 00 00 00       	mov    $0x20,%eax
801022a7:	89 f6                	mov    %esi,%esi
801022a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
801022b0:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
801022b2:	8b 0d 34 31 13 80    	mov    0x80133134,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801022b8:	89 c6                	mov    %eax,%esi
801022ba:	81 ce 00 00 01 00    	or     $0x10000,%esi
801022c0:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022c3:	89 71 10             	mov    %esi,0x10(%ecx)
801022c6:	8d 72 01             	lea    0x1(%edx),%esi
801022c9:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
801022cc:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
801022ce:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
801022d0:	8b 0d 34 31 13 80    	mov    0x80133134,%ecx
801022d6:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801022dd:	75 d1                	jne    801022b0 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801022df:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022e2:	5b                   	pop    %ebx
801022e3:	5e                   	pop    %esi
801022e4:	5d                   	pop    %ebp
801022e5:	c3                   	ret    
801022e6:	8d 76 00             	lea    0x0(%esi),%esi
801022e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801022f0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801022f0:	55                   	push   %ebp
  ioapic->reg = reg;
801022f1:	8b 0d 34 31 13 80    	mov    0x80133134,%ecx
{
801022f7:	89 e5                	mov    %esp,%ebp
801022f9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801022fc:	8d 50 20             	lea    0x20(%eax),%edx
801022ff:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102303:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102305:	8b 0d 34 31 13 80    	mov    0x80133134,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010230b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010230e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102311:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102314:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102316:	a1 34 31 13 80       	mov    0x80133134,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010231b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010231e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102321:	5d                   	pop    %ebp
80102322:	c3                   	ret    
80102323:	66 90                	xchg   %ax,%ax
80102325:	66 90                	xchg   %ax,%ax
80102327:	66 90                	xchg   %ax,%ax
80102329:	66 90                	xchg   %ax,%ax
8010232b:	66 90                	xchg   %ax,%ax
8010232d:	66 90                	xchg   %ax,%ax
8010232f:	90                   	nop

80102330 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102330:	55                   	push   %ebp
80102331:	89 e5                	mov    %esp,%ebp
80102333:	53                   	push   %ebx
80102334:	83 ec 04             	sub    $0x4,%esp
80102337:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010233a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102340:	75 70                	jne    801023b2 <kfree+0x82>
80102342:	81 fb a8 b4 13 80    	cmp    $0x8013b4a8,%ebx
80102348:	72 68                	jb     801023b2 <kfree+0x82>
8010234a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102350:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102355:	77 5b                	ja     801023b2 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102357:	83 ec 04             	sub    $0x4,%esp
8010235a:	68 00 10 00 00       	push   $0x1000
8010235f:	6a 01                	push   $0x1
80102361:	53                   	push   %ebx
80102362:	e8 a9 26 00 00       	call   80104a10 <memset>

  if(kmem.use_lock)
80102367:	8b 15 74 31 13 80    	mov    0x80133174,%edx
8010236d:	83 c4 10             	add    $0x10,%esp
80102370:	85 d2                	test   %edx,%edx
80102372:	75 2c                	jne    801023a0 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102374:	a1 78 31 13 80       	mov    0x80133178,%eax
80102379:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010237b:	a1 74 31 13 80       	mov    0x80133174,%eax
  kmem.freelist = r;
80102380:	89 1d 78 31 13 80    	mov    %ebx,0x80133178
  if(kmem.use_lock)
80102386:	85 c0                	test   %eax,%eax
80102388:	75 06                	jne    80102390 <kfree+0x60>
    release(&kmem.lock);
}
8010238a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010238d:	c9                   	leave  
8010238e:	c3                   	ret    
8010238f:	90                   	nop
    release(&kmem.lock);
80102390:	c7 45 08 40 31 13 80 	movl   $0x80133140,0x8(%ebp)
}
80102397:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010239a:	c9                   	leave  
    release(&kmem.lock);
8010239b:	e9 20 26 00 00       	jmp    801049c0 <release>
    acquire(&kmem.lock);
801023a0:	83 ec 0c             	sub    $0xc,%esp
801023a3:	68 40 31 13 80       	push   $0x80133140
801023a8:	e8 53 25 00 00       	call   80104900 <acquire>
801023ad:	83 c4 10             	add    $0x10,%esp
801023b0:	eb c2                	jmp    80102374 <kfree+0x44>
    panic("kfree");
801023b2:	83 ec 0c             	sub    $0xc,%esp
801023b5:	68 26 87 10 80       	push   $0x80108726
801023ba:	e8 d1 df ff ff       	call   80100390 <panic>
801023bf:	90                   	nop

801023c0 <freerange>:
{
801023c0:	55                   	push   %ebp
801023c1:	89 e5                	mov    %esp,%ebp
801023c3:	56                   	push   %esi
801023c4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801023c5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801023c8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801023cb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023d1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023d7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023dd:	39 de                	cmp    %ebx,%esi
801023df:	72 23                	jb     80102404 <freerange+0x44>
801023e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801023e8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023ee:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023f1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801023f7:	50                   	push   %eax
801023f8:	e8 33 ff ff ff       	call   80102330 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023fd:	83 c4 10             	add    $0x10,%esp
80102400:	39 f3                	cmp    %esi,%ebx
80102402:	76 e4                	jbe    801023e8 <freerange+0x28>
}
80102404:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102407:	5b                   	pop    %ebx
80102408:	5e                   	pop    %esi
80102409:	5d                   	pop    %ebp
8010240a:	c3                   	ret    
8010240b:	90                   	nop
8010240c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102410 <kinit1>:
{
80102410:	55                   	push   %ebp
80102411:	89 e5                	mov    %esp,%ebp
80102413:	56                   	push   %esi
80102414:	53                   	push   %ebx
80102415:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102418:	83 ec 08             	sub    $0x8,%esp
8010241b:	68 2c 87 10 80       	push   $0x8010872c
80102420:	68 40 31 13 80       	push   $0x80133140
80102425:	e8 96 23 00 00       	call   801047c0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010242a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010242d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102430:	c7 05 74 31 13 80 00 	movl   $0x0,0x80133174
80102437:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010243a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102440:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102446:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010244c:	39 de                	cmp    %ebx,%esi
8010244e:	72 1c                	jb     8010246c <kinit1+0x5c>
    kfree(p);
80102450:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102456:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102459:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010245f:	50                   	push   %eax
80102460:	e8 cb fe ff ff       	call   80102330 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102465:	83 c4 10             	add    $0x10,%esp
80102468:	39 de                	cmp    %ebx,%esi
8010246a:	73 e4                	jae    80102450 <kinit1+0x40>
}
8010246c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010246f:	5b                   	pop    %ebx
80102470:	5e                   	pop    %esi
80102471:	5d                   	pop    %ebp
80102472:	c3                   	ret    
80102473:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102480 <kinit2>:
{
80102480:	55                   	push   %ebp
80102481:	89 e5                	mov    %esp,%ebp
80102483:	56                   	push   %esi
80102484:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102485:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102488:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010248b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102491:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102497:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010249d:	39 de                	cmp    %ebx,%esi
8010249f:	72 23                	jb     801024c4 <kinit2+0x44>
801024a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801024a8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801024ae:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024b1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024b7:	50                   	push   %eax
801024b8:	e8 73 fe ff ff       	call   80102330 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024bd:	83 c4 10             	add    $0x10,%esp
801024c0:	39 de                	cmp    %ebx,%esi
801024c2:	73 e4                	jae    801024a8 <kinit2+0x28>
  kmem.use_lock = 1;
801024c4:	c7 05 74 31 13 80 01 	movl   $0x1,0x80133174
801024cb:	00 00 00 
}
801024ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024d1:	5b                   	pop    %ebx
801024d2:	5e                   	pop    %esi
801024d3:	5d                   	pop    %ebp
801024d4:	c3                   	ret    
801024d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024e0 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
801024e0:	a1 74 31 13 80       	mov    0x80133174,%eax
801024e5:	85 c0                	test   %eax,%eax
801024e7:	75 1f                	jne    80102508 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801024e9:	a1 78 31 13 80       	mov    0x80133178,%eax
  if(r)
801024ee:	85 c0                	test   %eax,%eax
801024f0:	74 0e                	je     80102500 <kalloc+0x20>
    kmem.freelist = r->next;
801024f2:	8b 10                	mov    (%eax),%edx
801024f4:	89 15 78 31 13 80    	mov    %edx,0x80133178
801024fa:	c3                   	ret    
801024fb:	90                   	nop
801024fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102500:	f3 c3                	repz ret 
80102502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
80102508:	55                   	push   %ebp
80102509:	89 e5                	mov    %esp,%ebp
8010250b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
8010250e:	68 40 31 13 80       	push   $0x80133140
80102513:	e8 e8 23 00 00       	call   80104900 <acquire>
  r = kmem.freelist;
80102518:	a1 78 31 13 80       	mov    0x80133178,%eax
  if(r)
8010251d:	83 c4 10             	add    $0x10,%esp
80102520:	8b 15 74 31 13 80    	mov    0x80133174,%edx
80102526:	85 c0                	test   %eax,%eax
80102528:	74 08                	je     80102532 <kalloc+0x52>
    kmem.freelist = r->next;
8010252a:	8b 08                	mov    (%eax),%ecx
8010252c:	89 0d 78 31 13 80    	mov    %ecx,0x80133178
  if(kmem.use_lock)
80102532:	85 d2                	test   %edx,%edx
80102534:	74 16                	je     8010254c <kalloc+0x6c>
    release(&kmem.lock);
80102536:	83 ec 0c             	sub    $0xc,%esp
80102539:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010253c:	68 40 31 13 80       	push   $0x80133140
80102541:	e8 7a 24 00 00       	call   801049c0 <release>
  return (char*)r;
80102546:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102549:	83 c4 10             	add    $0x10,%esp
}
8010254c:	c9                   	leave  
8010254d:	c3                   	ret    
8010254e:	66 90                	xchg   %ax,%ax

80102550 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102550:	ba 64 00 00 00       	mov    $0x64,%edx
80102555:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102556:	a8 01                	test   $0x1,%al
80102558:	0f 84 c2 00 00 00    	je     80102620 <kbdgetc+0xd0>
8010255e:	ba 60 00 00 00       	mov    $0x60,%edx
80102563:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102564:	0f b6 d0             	movzbl %al,%edx
80102567:	8b 0d b4 c5 10 80    	mov    0x8010c5b4,%ecx

  if(data == 0xE0){
8010256d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102573:	0f 84 7f 00 00 00    	je     801025f8 <kbdgetc+0xa8>
{
80102579:	55                   	push   %ebp
8010257a:	89 e5                	mov    %esp,%ebp
8010257c:	53                   	push   %ebx
8010257d:	89 cb                	mov    %ecx,%ebx
8010257f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102582:	84 c0                	test   %al,%al
80102584:	78 4a                	js     801025d0 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102586:	85 db                	test   %ebx,%ebx
80102588:	74 09                	je     80102593 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010258a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
8010258d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102590:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102593:	0f b6 82 60 88 10 80 	movzbl -0x7fef77a0(%edx),%eax
8010259a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
8010259c:	0f b6 82 60 87 10 80 	movzbl -0x7fef78a0(%edx),%eax
801025a3:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801025a5:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
801025a7:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
  c = charcode[shift & (CTL | SHIFT)][data];
801025ad:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801025b0:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801025b3:	8b 04 85 40 87 10 80 	mov    -0x7fef78c0(,%eax,4),%eax
801025ba:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
801025be:	74 31                	je     801025f1 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
801025c0:	8d 50 9f             	lea    -0x61(%eax),%edx
801025c3:	83 fa 19             	cmp    $0x19,%edx
801025c6:	77 40                	ja     80102608 <kbdgetc+0xb8>
      c += 'A' - 'a';
801025c8:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025cb:	5b                   	pop    %ebx
801025cc:	5d                   	pop    %ebp
801025cd:	c3                   	ret    
801025ce:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
801025d0:	83 e0 7f             	and    $0x7f,%eax
801025d3:	85 db                	test   %ebx,%ebx
801025d5:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
801025d8:	0f b6 82 60 88 10 80 	movzbl -0x7fef77a0(%edx),%eax
801025df:	83 c8 40             	or     $0x40,%eax
801025e2:	0f b6 c0             	movzbl %al,%eax
801025e5:	f7 d0                	not    %eax
801025e7:	21 c1                	and    %eax,%ecx
    return 0;
801025e9:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801025eb:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
}
801025f1:	5b                   	pop    %ebx
801025f2:	5d                   	pop    %ebp
801025f3:	c3                   	ret    
801025f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801025f8:	83 c9 40             	or     $0x40,%ecx
    return 0;
801025fb:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801025fd:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
    return 0;
80102603:	c3                   	ret    
80102604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102608:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010260b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010260e:	5b                   	pop    %ebx
      c += 'a' - 'A';
8010260f:	83 f9 1a             	cmp    $0x1a,%ecx
80102612:	0f 42 c2             	cmovb  %edx,%eax
}
80102615:	5d                   	pop    %ebp
80102616:	c3                   	ret    
80102617:	89 f6                	mov    %esi,%esi
80102619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102620:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102625:	c3                   	ret    
80102626:	8d 76 00             	lea    0x0(%esi),%esi
80102629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102630 <kbdintr>:

void
kbdintr(void)
{
80102630:	55                   	push   %ebp
80102631:	89 e5                	mov    %esp,%ebp
80102633:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102636:	68 50 25 10 80       	push   $0x80102550
8010263b:	e8 d0 e1 ff ff       	call   80100810 <consoleintr>
}
80102640:	83 c4 10             	add    $0x10,%esp
80102643:	c9                   	leave  
80102644:	c3                   	ret    
80102645:	66 90                	xchg   %ax,%ax
80102647:	66 90                	xchg   %ax,%ax
80102649:	66 90                	xchg   %ax,%ax
8010264b:	66 90                	xchg   %ax,%ax
8010264d:	66 90                	xchg   %ax,%ax
8010264f:	90                   	nop

80102650 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102650:	a1 7c 31 13 80       	mov    0x8013317c,%eax
{
80102655:	55                   	push   %ebp
80102656:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102658:	85 c0                	test   %eax,%eax
8010265a:	0f 84 c8 00 00 00    	je     80102728 <lapicinit+0xd8>
  lapic[index] = value;
80102660:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102667:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010266a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010266d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102674:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102677:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010267a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102681:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102684:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102687:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010268e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102691:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102694:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010269b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010269e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026a1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801026a8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026ab:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801026ae:	8b 50 30             	mov    0x30(%eax),%edx
801026b1:	c1 ea 10             	shr    $0x10,%edx
801026b4:	80 fa 03             	cmp    $0x3,%dl
801026b7:	77 77                	ja     80102730 <lapicinit+0xe0>
  lapic[index] = value;
801026b9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801026c0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026c3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026c6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026cd:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026d0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026d3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026da:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026dd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026e0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801026e7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026ea:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026ed:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801026f4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026f7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026fa:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102701:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102704:	8b 50 20             	mov    0x20(%eax),%edx
80102707:	89 f6                	mov    %esi,%esi
80102709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102710:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102716:	80 e6 10             	and    $0x10,%dh
80102719:	75 f5                	jne    80102710 <lapicinit+0xc0>
  lapic[index] = value;
8010271b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102722:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102725:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102728:	5d                   	pop    %ebp
80102729:	c3                   	ret    
8010272a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102730:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102737:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010273a:	8b 50 20             	mov    0x20(%eax),%edx
8010273d:	e9 77 ff ff ff       	jmp    801026b9 <lapicinit+0x69>
80102742:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102750 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102750:	8b 15 7c 31 13 80    	mov    0x8013317c,%edx
{
80102756:	55                   	push   %ebp
80102757:	31 c0                	xor    %eax,%eax
80102759:	89 e5                	mov    %esp,%ebp
  if (!lapic)
8010275b:	85 d2                	test   %edx,%edx
8010275d:	74 06                	je     80102765 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
8010275f:	8b 42 20             	mov    0x20(%edx),%eax
80102762:	c1 e8 18             	shr    $0x18,%eax
}
80102765:	5d                   	pop    %ebp
80102766:	c3                   	ret    
80102767:	89 f6                	mov    %esi,%esi
80102769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102770 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102770:	a1 7c 31 13 80       	mov    0x8013317c,%eax
{
80102775:	55                   	push   %ebp
80102776:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102778:	85 c0                	test   %eax,%eax
8010277a:	74 0d                	je     80102789 <lapiceoi+0x19>
  lapic[index] = value;
8010277c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102783:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102786:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102789:	5d                   	pop    %ebp
8010278a:	c3                   	ret    
8010278b:	90                   	nop
8010278c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102790 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102790:	55                   	push   %ebp
80102791:	89 e5                	mov    %esp,%ebp
}
80102793:	5d                   	pop    %ebp
80102794:	c3                   	ret    
80102795:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027a0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801027a0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801027a1:	b8 0f 00 00 00       	mov    $0xf,%eax
801027a6:	ba 70 00 00 00       	mov    $0x70,%edx
801027ab:	89 e5                	mov    %esp,%ebp
801027ad:	53                   	push   %ebx
801027ae:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801027b1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801027b4:	ee                   	out    %al,(%dx)
801027b5:	b8 0a 00 00 00       	mov    $0xa,%eax
801027ba:	ba 71 00 00 00       	mov    $0x71,%edx
801027bf:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801027c0:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801027c2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
801027c5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801027cb:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801027cd:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
801027d0:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
801027d3:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
801027d5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
801027d8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
801027de:	a1 7c 31 13 80       	mov    0x8013317c,%eax
801027e3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027e9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027ec:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801027f3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027f6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027f9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102800:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102803:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102806:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010280c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010280f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102815:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102818:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010281e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102821:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102827:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010282a:	5b                   	pop    %ebx
8010282b:	5d                   	pop    %ebp
8010282c:	c3                   	ret    
8010282d:	8d 76 00             	lea    0x0(%esi),%esi

80102830 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102830:	55                   	push   %ebp
80102831:	b8 0b 00 00 00       	mov    $0xb,%eax
80102836:	ba 70 00 00 00       	mov    $0x70,%edx
8010283b:	89 e5                	mov    %esp,%ebp
8010283d:	57                   	push   %edi
8010283e:	56                   	push   %esi
8010283f:	53                   	push   %ebx
80102840:	83 ec 4c             	sub    $0x4c,%esp
80102843:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102844:	ba 71 00 00 00       	mov    $0x71,%edx
80102849:	ec                   	in     (%dx),%al
8010284a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010284d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102852:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102855:	8d 76 00             	lea    0x0(%esi),%esi
80102858:	31 c0                	xor    %eax,%eax
8010285a:	89 da                	mov    %ebx,%edx
8010285c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010285d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102862:	89 ca                	mov    %ecx,%edx
80102864:	ec                   	in     (%dx),%al
80102865:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102868:	89 da                	mov    %ebx,%edx
8010286a:	b8 02 00 00 00       	mov    $0x2,%eax
8010286f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102870:	89 ca                	mov    %ecx,%edx
80102872:	ec                   	in     (%dx),%al
80102873:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102876:	89 da                	mov    %ebx,%edx
80102878:	b8 04 00 00 00       	mov    $0x4,%eax
8010287d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010287e:	89 ca                	mov    %ecx,%edx
80102880:	ec                   	in     (%dx),%al
80102881:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102884:	89 da                	mov    %ebx,%edx
80102886:	b8 07 00 00 00       	mov    $0x7,%eax
8010288b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010288c:	89 ca                	mov    %ecx,%edx
8010288e:	ec                   	in     (%dx),%al
8010288f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102892:	89 da                	mov    %ebx,%edx
80102894:	b8 08 00 00 00       	mov    $0x8,%eax
80102899:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010289a:	89 ca                	mov    %ecx,%edx
8010289c:	ec                   	in     (%dx),%al
8010289d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010289f:	89 da                	mov    %ebx,%edx
801028a1:	b8 09 00 00 00       	mov    $0x9,%eax
801028a6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028a7:	89 ca                	mov    %ecx,%edx
801028a9:	ec                   	in     (%dx),%al
801028aa:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028ac:	89 da                	mov    %ebx,%edx
801028ae:	b8 0a 00 00 00       	mov    $0xa,%eax
801028b3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028b4:	89 ca                	mov    %ecx,%edx
801028b6:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801028b7:	84 c0                	test   %al,%al
801028b9:	78 9d                	js     80102858 <cmostime+0x28>
  return inb(CMOS_RETURN);
801028bb:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
801028bf:	89 fa                	mov    %edi,%edx
801028c1:	0f b6 fa             	movzbl %dl,%edi
801028c4:	89 f2                	mov    %esi,%edx
801028c6:	0f b6 f2             	movzbl %dl,%esi
801028c9:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028cc:	89 da                	mov    %ebx,%edx
801028ce:	89 75 cc             	mov    %esi,-0x34(%ebp)
801028d1:	89 45 b8             	mov    %eax,-0x48(%ebp)
801028d4:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
801028d8:	89 45 bc             	mov    %eax,-0x44(%ebp)
801028db:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
801028df:	89 45 c0             	mov    %eax,-0x40(%ebp)
801028e2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801028e6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801028e9:	31 c0                	xor    %eax,%eax
801028eb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ec:	89 ca                	mov    %ecx,%edx
801028ee:	ec                   	in     (%dx),%al
801028ef:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028f2:	89 da                	mov    %ebx,%edx
801028f4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801028f7:	b8 02 00 00 00       	mov    $0x2,%eax
801028fc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028fd:	89 ca                	mov    %ecx,%edx
801028ff:	ec                   	in     (%dx),%al
80102900:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102903:	89 da                	mov    %ebx,%edx
80102905:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102908:	b8 04 00 00 00       	mov    $0x4,%eax
8010290d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010290e:	89 ca                	mov    %ecx,%edx
80102910:	ec                   	in     (%dx),%al
80102911:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102914:	89 da                	mov    %ebx,%edx
80102916:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102919:	b8 07 00 00 00       	mov    $0x7,%eax
8010291e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010291f:	89 ca                	mov    %ecx,%edx
80102921:	ec                   	in     (%dx),%al
80102922:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102925:	89 da                	mov    %ebx,%edx
80102927:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010292a:	b8 08 00 00 00       	mov    $0x8,%eax
8010292f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102930:	89 ca                	mov    %ecx,%edx
80102932:	ec                   	in     (%dx),%al
80102933:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102936:	89 da                	mov    %ebx,%edx
80102938:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010293b:	b8 09 00 00 00       	mov    $0x9,%eax
80102940:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102941:	89 ca                	mov    %ecx,%edx
80102943:	ec                   	in     (%dx),%al
80102944:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102947:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
8010294a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010294d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102950:	6a 18                	push   $0x18
80102952:	50                   	push   %eax
80102953:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102956:	50                   	push   %eax
80102957:	e8 04 21 00 00       	call   80104a60 <memcmp>
8010295c:	83 c4 10             	add    $0x10,%esp
8010295f:	85 c0                	test   %eax,%eax
80102961:	0f 85 f1 fe ff ff    	jne    80102858 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102967:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
8010296b:	75 78                	jne    801029e5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010296d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102970:	89 c2                	mov    %eax,%edx
80102972:	83 e0 0f             	and    $0xf,%eax
80102975:	c1 ea 04             	shr    $0x4,%edx
80102978:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010297b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010297e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102981:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102984:	89 c2                	mov    %eax,%edx
80102986:	83 e0 0f             	and    $0xf,%eax
80102989:	c1 ea 04             	shr    $0x4,%edx
8010298c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010298f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102992:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102995:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102998:	89 c2                	mov    %eax,%edx
8010299a:	83 e0 0f             	and    $0xf,%eax
8010299d:	c1 ea 04             	shr    $0x4,%edx
801029a0:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029a3:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029a6:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
801029a9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029ac:	89 c2                	mov    %eax,%edx
801029ae:	83 e0 0f             	and    $0xf,%eax
801029b1:	c1 ea 04             	shr    $0x4,%edx
801029b4:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029b7:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029ba:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
801029bd:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029c0:	89 c2                	mov    %eax,%edx
801029c2:	83 e0 0f             	and    $0xf,%eax
801029c5:	c1 ea 04             	shr    $0x4,%edx
801029c8:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029cb:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029ce:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801029d1:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029d4:	89 c2                	mov    %eax,%edx
801029d6:	83 e0 0f             	and    $0xf,%eax
801029d9:	c1 ea 04             	shr    $0x4,%edx
801029dc:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029df:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029e2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
801029e5:	8b 75 08             	mov    0x8(%ebp),%esi
801029e8:	8b 45 b8             	mov    -0x48(%ebp),%eax
801029eb:	89 06                	mov    %eax,(%esi)
801029ed:	8b 45 bc             	mov    -0x44(%ebp),%eax
801029f0:	89 46 04             	mov    %eax,0x4(%esi)
801029f3:	8b 45 c0             	mov    -0x40(%ebp),%eax
801029f6:	89 46 08             	mov    %eax,0x8(%esi)
801029f9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029fc:	89 46 0c             	mov    %eax,0xc(%esi)
801029ff:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a02:	89 46 10             	mov    %eax,0x10(%esi)
80102a05:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a08:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102a0b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102a12:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a15:	5b                   	pop    %ebx
80102a16:	5e                   	pop    %esi
80102a17:	5f                   	pop    %edi
80102a18:	5d                   	pop    %ebp
80102a19:	c3                   	ret    
80102a1a:	66 90                	xchg   %ax,%ax
80102a1c:	66 90                	xchg   %ax,%ax
80102a1e:	66 90                	xchg   %ax,%ax

80102a20 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a20:	8b 0d c8 31 13 80    	mov    0x801331c8,%ecx
80102a26:	85 c9                	test   %ecx,%ecx
80102a28:	0f 8e 8a 00 00 00    	jle    80102ab8 <install_trans+0x98>
{
80102a2e:	55                   	push   %ebp
80102a2f:	89 e5                	mov    %esp,%ebp
80102a31:	57                   	push   %edi
80102a32:	56                   	push   %esi
80102a33:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102a34:	31 db                	xor    %ebx,%ebx
{
80102a36:	83 ec 0c             	sub    $0xc,%esp
80102a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102a40:	a1 b4 31 13 80       	mov    0x801331b4,%eax
80102a45:	83 ec 08             	sub    $0x8,%esp
80102a48:	01 d8                	add    %ebx,%eax
80102a4a:	83 c0 01             	add    $0x1,%eax
80102a4d:	50                   	push   %eax
80102a4e:	ff 35 c4 31 13 80    	pushl  0x801331c4
80102a54:	e8 77 d6 ff ff       	call   801000d0 <bread>
80102a59:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a5b:	58                   	pop    %eax
80102a5c:	5a                   	pop    %edx
80102a5d:	ff 34 9d cc 31 13 80 	pushl  -0x7fecce34(,%ebx,4)
80102a64:	ff 35 c4 31 13 80    	pushl  0x801331c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102a6a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a6d:	e8 5e d6 ff ff       	call   801000d0 <bread>
80102a72:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102a74:	8d 47 5c             	lea    0x5c(%edi),%eax
80102a77:	83 c4 0c             	add    $0xc,%esp
80102a7a:	68 00 02 00 00       	push   $0x200
80102a7f:	50                   	push   %eax
80102a80:	8d 46 5c             	lea    0x5c(%esi),%eax
80102a83:	50                   	push   %eax
80102a84:	e8 37 20 00 00       	call   80104ac0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102a89:	89 34 24             	mov    %esi,(%esp)
80102a8c:	e8 0f d7 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102a91:	89 3c 24             	mov    %edi,(%esp)
80102a94:	e8 47 d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102a99:	89 34 24             	mov    %esi,(%esp)
80102a9c:	e8 3f d7 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102aa1:	83 c4 10             	add    $0x10,%esp
80102aa4:	39 1d c8 31 13 80    	cmp    %ebx,0x801331c8
80102aaa:	7f 94                	jg     80102a40 <install_trans+0x20>
  }
}
80102aac:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102aaf:	5b                   	pop    %ebx
80102ab0:	5e                   	pop    %esi
80102ab1:	5f                   	pop    %edi
80102ab2:	5d                   	pop    %ebp
80102ab3:	c3                   	ret    
80102ab4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102ab8:	f3 c3                	repz ret 
80102aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102ac0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102ac0:	55                   	push   %ebp
80102ac1:	89 e5                	mov    %esp,%ebp
80102ac3:	56                   	push   %esi
80102ac4:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102ac5:	83 ec 08             	sub    $0x8,%esp
80102ac8:	ff 35 b4 31 13 80    	pushl  0x801331b4
80102ace:	ff 35 c4 31 13 80    	pushl  0x801331c4
80102ad4:	e8 f7 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102ad9:	8b 1d c8 31 13 80    	mov    0x801331c8,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102adf:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102ae2:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102ae4:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102ae6:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102ae9:	7e 16                	jle    80102b01 <write_head+0x41>
80102aeb:	c1 e3 02             	shl    $0x2,%ebx
80102aee:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102af0:	8b 8a cc 31 13 80    	mov    -0x7fecce34(%edx),%ecx
80102af6:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102afa:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102afd:	39 da                	cmp    %ebx,%edx
80102aff:	75 ef                	jne    80102af0 <write_head+0x30>
  }
  bwrite(buf);
80102b01:	83 ec 0c             	sub    $0xc,%esp
80102b04:	56                   	push   %esi
80102b05:	e8 96 d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102b0a:	89 34 24             	mov    %esi,(%esp)
80102b0d:	e8 ce d6 ff ff       	call   801001e0 <brelse>
}
80102b12:	83 c4 10             	add    $0x10,%esp
80102b15:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b18:	5b                   	pop    %ebx
80102b19:	5e                   	pop    %esi
80102b1a:	5d                   	pop    %ebp
80102b1b:	c3                   	ret    
80102b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102b20 <initlog>:
{
80102b20:	55                   	push   %ebp
80102b21:	89 e5                	mov    %esp,%ebp
80102b23:	53                   	push   %ebx
80102b24:	83 ec 2c             	sub    $0x2c,%esp
80102b27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102b2a:	68 60 89 10 80       	push   $0x80108960
80102b2f:	68 80 31 13 80       	push   $0x80133180
80102b34:	e8 87 1c 00 00       	call   801047c0 <initlock>
  readsb(dev, &sb);
80102b39:	58                   	pop    %eax
80102b3a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102b3d:	5a                   	pop    %edx
80102b3e:	50                   	push   %eax
80102b3f:	53                   	push   %ebx
80102b40:	e8 8b e8 ff ff       	call   801013d0 <readsb>
  log.size = sb.nlog;
80102b45:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102b48:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102b4b:	59                   	pop    %ecx
  log.dev = dev;
80102b4c:	89 1d c4 31 13 80    	mov    %ebx,0x801331c4
  log.size = sb.nlog;
80102b52:	89 15 b8 31 13 80    	mov    %edx,0x801331b8
  log.start = sb.logstart;
80102b58:	a3 b4 31 13 80       	mov    %eax,0x801331b4
  struct buf *buf = bread(log.dev, log.start);
80102b5d:	5a                   	pop    %edx
80102b5e:	50                   	push   %eax
80102b5f:	53                   	push   %ebx
80102b60:	e8 6b d5 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102b65:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102b68:	83 c4 10             	add    $0x10,%esp
80102b6b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102b6d:	89 1d c8 31 13 80    	mov    %ebx,0x801331c8
  for (i = 0; i < log.lh.n; i++) {
80102b73:	7e 1c                	jle    80102b91 <initlog+0x71>
80102b75:	c1 e3 02             	shl    $0x2,%ebx
80102b78:	31 d2                	xor    %edx,%edx
80102b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102b80:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102b84:	83 c2 04             	add    $0x4,%edx
80102b87:	89 8a c8 31 13 80    	mov    %ecx,-0x7fecce38(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102b8d:	39 d3                	cmp    %edx,%ebx
80102b8f:	75 ef                	jne    80102b80 <initlog+0x60>
  brelse(buf);
80102b91:	83 ec 0c             	sub    $0xc,%esp
80102b94:	50                   	push   %eax
80102b95:	e8 46 d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102b9a:	e8 81 fe ff ff       	call   80102a20 <install_trans>
  log.lh.n = 0;
80102b9f:	c7 05 c8 31 13 80 00 	movl   $0x0,0x801331c8
80102ba6:	00 00 00 
  write_head(); // clear the log
80102ba9:	e8 12 ff ff ff       	call   80102ac0 <write_head>
}
80102bae:	83 c4 10             	add    $0x10,%esp
80102bb1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102bb4:	c9                   	leave  
80102bb5:	c3                   	ret    
80102bb6:	8d 76 00             	lea    0x0(%esi),%esi
80102bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102bc0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102bc0:	55                   	push   %ebp
80102bc1:	89 e5                	mov    %esp,%ebp
80102bc3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102bc6:	68 80 31 13 80       	push   $0x80133180
80102bcb:	e8 30 1d 00 00       	call   80104900 <acquire>
80102bd0:	83 c4 10             	add    $0x10,%esp
80102bd3:	eb 18                	jmp    80102bed <begin_op+0x2d>
80102bd5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102bd8:	83 ec 08             	sub    $0x8,%esp
80102bdb:	68 80 31 13 80       	push   $0x80133180
80102be0:	68 80 31 13 80       	push   $0x80133180
80102be5:	e8 76 12 00 00       	call   80103e60 <sleep>
80102bea:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102bed:	a1 c0 31 13 80       	mov    0x801331c0,%eax
80102bf2:	85 c0                	test   %eax,%eax
80102bf4:	75 e2                	jne    80102bd8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102bf6:	a1 bc 31 13 80       	mov    0x801331bc,%eax
80102bfb:	8b 15 c8 31 13 80    	mov    0x801331c8,%edx
80102c01:	83 c0 01             	add    $0x1,%eax
80102c04:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102c07:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102c0a:	83 fa 1e             	cmp    $0x1e,%edx
80102c0d:	7f c9                	jg     80102bd8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102c0f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102c12:	a3 bc 31 13 80       	mov    %eax,0x801331bc
      release(&log.lock);
80102c17:	68 80 31 13 80       	push   $0x80133180
80102c1c:	e8 9f 1d 00 00       	call   801049c0 <release>
      break;
    }
  }
}
80102c21:	83 c4 10             	add    $0x10,%esp
80102c24:	c9                   	leave  
80102c25:	c3                   	ret    
80102c26:	8d 76 00             	lea    0x0(%esi),%esi
80102c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c30 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102c30:	55                   	push   %ebp
80102c31:	89 e5                	mov    %esp,%ebp
80102c33:	57                   	push   %edi
80102c34:	56                   	push   %esi
80102c35:	53                   	push   %ebx
80102c36:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102c39:	68 80 31 13 80       	push   $0x80133180
80102c3e:	e8 bd 1c 00 00       	call   80104900 <acquire>
  log.outstanding -= 1;
80102c43:	a1 bc 31 13 80       	mov    0x801331bc,%eax
  if(log.committing)
80102c48:	8b 35 c0 31 13 80    	mov    0x801331c0,%esi
80102c4e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102c51:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102c54:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102c56:	89 1d bc 31 13 80    	mov    %ebx,0x801331bc
  if(log.committing)
80102c5c:	0f 85 1a 01 00 00    	jne    80102d7c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80102c62:	85 db                	test   %ebx,%ebx
80102c64:	0f 85 ee 00 00 00    	jne    80102d58 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102c6a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102c6d:	c7 05 c0 31 13 80 01 	movl   $0x1,0x801331c0
80102c74:	00 00 00 
  release(&log.lock);
80102c77:	68 80 31 13 80       	push   $0x80133180
80102c7c:	e8 3f 1d 00 00       	call   801049c0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c81:	8b 0d c8 31 13 80    	mov    0x801331c8,%ecx
80102c87:	83 c4 10             	add    $0x10,%esp
80102c8a:	85 c9                	test   %ecx,%ecx
80102c8c:	0f 8e 85 00 00 00    	jle    80102d17 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102c92:	a1 b4 31 13 80       	mov    0x801331b4,%eax
80102c97:	83 ec 08             	sub    $0x8,%esp
80102c9a:	01 d8                	add    %ebx,%eax
80102c9c:	83 c0 01             	add    $0x1,%eax
80102c9f:	50                   	push   %eax
80102ca0:	ff 35 c4 31 13 80    	pushl  0x801331c4
80102ca6:	e8 25 d4 ff ff       	call   801000d0 <bread>
80102cab:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102cad:	58                   	pop    %eax
80102cae:	5a                   	pop    %edx
80102caf:	ff 34 9d cc 31 13 80 	pushl  -0x7fecce34(,%ebx,4)
80102cb6:	ff 35 c4 31 13 80    	pushl  0x801331c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102cbc:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102cbf:	e8 0c d4 ff ff       	call   801000d0 <bread>
80102cc4:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102cc6:	8d 40 5c             	lea    0x5c(%eax),%eax
80102cc9:	83 c4 0c             	add    $0xc,%esp
80102ccc:	68 00 02 00 00       	push   $0x200
80102cd1:	50                   	push   %eax
80102cd2:	8d 46 5c             	lea    0x5c(%esi),%eax
80102cd5:	50                   	push   %eax
80102cd6:	e8 e5 1d 00 00       	call   80104ac0 <memmove>
    bwrite(to);  // write the log
80102cdb:	89 34 24             	mov    %esi,(%esp)
80102cde:	e8 bd d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102ce3:	89 3c 24             	mov    %edi,(%esp)
80102ce6:	e8 f5 d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102ceb:	89 34 24             	mov    %esi,(%esp)
80102cee:	e8 ed d4 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102cf3:	83 c4 10             	add    $0x10,%esp
80102cf6:	3b 1d c8 31 13 80    	cmp    0x801331c8,%ebx
80102cfc:	7c 94                	jl     80102c92 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102cfe:	e8 bd fd ff ff       	call   80102ac0 <write_head>
    install_trans(); // Now install writes to home locations
80102d03:	e8 18 fd ff ff       	call   80102a20 <install_trans>
    log.lh.n = 0;
80102d08:	c7 05 c8 31 13 80 00 	movl   $0x0,0x801331c8
80102d0f:	00 00 00 
    write_head();    // Erase the transaction from the log
80102d12:	e8 a9 fd ff ff       	call   80102ac0 <write_head>
    acquire(&log.lock);
80102d17:	83 ec 0c             	sub    $0xc,%esp
80102d1a:	68 80 31 13 80       	push   $0x80133180
80102d1f:	e8 dc 1b 00 00       	call   80104900 <acquire>
    wakeup(&log);
80102d24:	c7 04 24 80 31 13 80 	movl   $0x80133180,(%esp)
    log.committing = 0;
80102d2b:	c7 05 c0 31 13 80 00 	movl   $0x0,0x801331c0
80102d32:	00 00 00 
    wakeup(&log);
80102d35:	e8 e6 12 00 00       	call   80104020 <wakeup>
    release(&log.lock);
80102d3a:	c7 04 24 80 31 13 80 	movl   $0x80133180,(%esp)
80102d41:	e8 7a 1c 00 00       	call   801049c0 <release>
80102d46:	83 c4 10             	add    $0x10,%esp
}
80102d49:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d4c:	5b                   	pop    %ebx
80102d4d:	5e                   	pop    %esi
80102d4e:	5f                   	pop    %edi
80102d4f:	5d                   	pop    %ebp
80102d50:	c3                   	ret    
80102d51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80102d58:	83 ec 0c             	sub    $0xc,%esp
80102d5b:	68 80 31 13 80       	push   $0x80133180
80102d60:	e8 bb 12 00 00       	call   80104020 <wakeup>
  release(&log.lock);
80102d65:	c7 04 24 80 31 13 80 	movl   $0x80133180,(%esp)
80102d6c:	e8 4f 1c 00 00       	call   801049c0 <release>
80102d71:	83 c4 10             	add    $0x10,%esp
}
80102d74:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d77:	5b                   	pop    %ebx
80102d78:	5e                   	pop    %esi
80102d79:	5f                   	pop    %edi
80102d7a:	5d                   	pop    %ebp
80102d7b:	c3                   	ret    
    panic("log.committing");
80102d7c:	83 ec 0c             	sub    $0xc,%esp
80102d7f:	68 64 89 10 80       	push   $0x80108964
80102d84:	e8 07 d6 ff ff       	call   80100390 <panic>
80102d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102d90 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d90:	55                   	push   %ebp
80102d91:	89 e5                	mov    %esp,%ebp
80102d93:	53                   	push   %ebx
80102d94:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d97:	8b 15 c8 31 13 80    	mov    0x801331c8,%edx
{
80102d9d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102da0:	83 fa 1d             	cmp    $0x1d,%edx
80102da3:	0f 8f 9d 00 00 00    	jg     80102e46 <log_write+0xb6>
80102da9:	a1 b8 31 13 80       	mov    0x801331b8,%eax
80102dae:	83 e8 01             	sub    $0x1,%eax
80102db1:	39 c2                	cmp    %eax,%edx
80102db3:	0f 8d 8d 00 00 00    	jge    80102e46 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102db9:	a1 bc 31 13 80       	mov    0x801331bc,%eax
80102dbe:	85 c0                	test   %eax,%eax
80102dc0:	0f 8e 8d 00 00 00    	jle    80102e53 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102dc6:	83 ec 0c             	sub    $0xc,%esp
80102dc9:	68 80 31 13 80       	push   $0x80133180
80102dce:	e8 2d 1b 00 00       	call   80104900 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102dd3:	8b 0d c8 31 13 80    	mov    0x801331c8,%ecx
80102dd9:	83 c4 10             	add    $0x10,%esp
80102ddc:	83 f9 00             	cmp    $0x0,%ecx
80102ddf:	7e 57                	jle    80102e38 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102de1:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102de4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102de6:	3b 15 cc 31 13 80    	cmp    0x801331cc,%edx
80102dec:	75 0b                	jne    80102df9 <log_write+0x69>
80102dee:	eb 38                	jmp    80102e28 <log_write+0x98>
80102df0:	39 14 85 cc 31 13 80 	cmp    %edx,-0x7fecce34(,%eax,4)
80102df7:	74 2f                	je     80102e28 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102df9:	83 c0 01             	add    $0x1,%eax
80102dfc:	39 c1                	cmp    %eax,%ecx
80102dfe:	75 f0                	jne    80102df0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102e00:	89 14 85 cc 31 13 80 	mov    %edx,-0x7fecce34(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102e07:	83 c0 01             	add    $0x1,%eax
80102e0a:	a3 c8 31 13 80       	mov    %eax,0x801331c8
  b->flags |= B_DIRTY; // prevent eviction
80102e0f:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102e12:	c7 45 08 80 31 13 80 	movl   $0x80133180,0x8(%ebp)
}
80102e19:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e1c:	c9                   	leave  
  release(&log.lock);
80102e1d:	e9 9e 1b 00 00       	jmp    801049c0 <release>
80102e22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102e28:	89 14 85 cc 31 13 80 	mov    %edx,-0x7fecce34(,%eax,4)
80102e2f:	eb de                	jmp    80102e0f <log_write+0x7f>
80102e31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e38:	8b 43 08             	mov    0x8(%ebx),%eax
80102e3b:	a3 cc 31 13 80       	mov    %eax,0x801331cc
  if (i == log.lh.n)
80102e40:	75 cd                	jne    80102e0f <log_write+0x7f>
80102e42:	31 c0                	xor    %eax,%eax
80102e44:	eb c1                	jmp    80102e07 <log_write+0x77>
    panic("too big a transaction");
80102e46:	83 ec 0c             	sub    $0xc,%esp
80102e49:	68 73 89 10 80       	push   $0x80108973
80102e4e:	e8 3d d5 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102e53:	83 ec 0c             	sub    $0xc,%esp
80102e56:	68 89 89 10 80       	push   $0x80108989
80102e5b:	e8 30 d5 ff ff       	call   80100390 <panic>

80102e60 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102e60:	55                   	push   %ebp
80102e61:	89 e5                	mov    %esp,%ebp
80102e63:	53                   	push   %ebx
80102e64:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102e67:	e8 74 09 00 00       	call   801037e0 <cpuid>
80102e6c:	89 c3                	mov    %eax,%ebx
80102e6e:	e8 6d 09 00 00       	call   801037e0 <cpuid>
80102e73:	83 ec 04             	sub    $0x4,%esp
80102e76:	53                   	push   %ebx
80102e77:	50                   	push   %eax
80102e78:	68 a4 89 10 80       	push   $0x801089a4
80102e7d:	e8 de d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102e82:	e8 49 3e 00 00       	call   80106cd0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102e87:	e8 d4 08 00 00       	call   80103760 <mycpu>
80102e8c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e8e:	b8 01 00 00 00       	mov    $0x1,%eax
80102e93:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102e9a:	e8 31 0c 00 00       	call   80103ad0 <scheduler>
80102e9f:	90                   	nop

80102ea0 <mpenter>:
{
80102ea0:	55                   	push   %ebp
80102ea1:	89 e5                	mov    %esp,%ebp
80102ea3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102ea6:	e8 15 4f 00 00       	call   80107dc0 <switchkvm>
  seginit();
80102eab:	e8 80 4e 00 00       	call   80107d30 <seginit>
  lapicinit();
80102eb0:	e8 9b f7 ff ff       	call   80102650 <lapicinit>
  mpmain();
80102eb5:	e8 a6 ff ff ff       	call   80102e60 <mpmain>
80102eba:	66 90                	xchg   %ax,%ax
80102ebc:	66 90                	xchg   %ax,%ax
80102ebe:	66 90                	xchg   %ax,%ax

80102ec0 <main>:
{
80102ec0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102ec4:	83 e4 f0             	and    $0xfffffff0,%esp
80102ec7:	ff 71 fc             	pushl  -0x4(%ecx)
80102eca:	55                   	push   %ebp
80102ecb:	89 e5                	mov    %esp,%ebp
80102ecd:	53                   	push   %ebx
80102ece:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102ecf:	83 ec 08             	sub    $0x8,%esp
80102ed2:	68 00 00 40 80       	push   $0x80400000
80102ed7:	68 a8 b4 13 80       	push   $0x8013b4a8
80102edc:	e8 2f f5 ff ff       	call   80102410 <kinit1>
  kvmalloc();      // kernel page table
80102ee1:	e8 aa 53 00 00       	call   80108290 <kvmalloc>
  mpinit();        // detect other processors
80102ee6:	e8 75 01 00 00       	call   80103060 <mpinit>
  lapicinit();     // interrupt controller
80102eeb:	e8 60 f7 ff ff       	call   80102650 <lapicinit>
  seginit();       // segment descriptors
80102ef0:	e8 3b 4e 00 00       	call   80107d30 <seginit>
  picinit();       // disable pic
80102ef5:	e8 46 03 00 00       	call   80103240 <picinit>
  ioapicinit();    // another interrupt controller
80102efa:	e8 41 f3 ff ff       	call   80102240 <ioapicinit>
  consoleinit();   // console hardware
80102eff:	e8 bc da ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80102f04:	e8 f7 40 00 00       	call   80107000 <uartinit>
  pinit();         // process table
80102f09:	e8 32 08 00 00       	call   80103740 <pinit>
  tvinit();        // trap vectors
80102f0e:	e8 3d 3d 00 00       	call   80106c50 <tvinit>
  binit();         // buffer cache
80102f13:	e8 28 d1 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102f18:	e8 43 de ff ff       	call   80100d60 <fileinit>
  ideinit();       // disk 
80102f1d:	e8 fe f0 ff ff       	call   80102020 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102f22:	83 c4 0c             	add    $0xc,%esp
80102f25:	68 8a 00 00 00       	push   $0x8a
80102f2a:	68 8c c4 10 80       	push   $0x8010c48c
80102f2f:	68 00 70 00 80       	push   $0x80007000
80102f34:	e8 87 1b 00 00       	call   80104ac0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102f39:	69 05 00 38 13 80 b0 	imul   $0xb0,0x80133800,%eax
80102f40:	00 00 00 
80102f43:	83 c4 10             	add    $0x10,%esp
80102f46:	05 80 32 13 80       	add    $0x80133280,%eax
80102f4b:	3d 80 32 13 80       	cmp    $0x80133280,%eax
80102f50:	76 71                	jbe    80102fc3 <main+0x103>
80102f52:	bb 80 32 13 80       	mov    $0x80133280,%ebx
80102f57:	89 f6                	mov    %esi,%esi
80102f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80102f60:	e8 fb 07 00 00       	call   80103760 <mycpu>
80102f65:	39 d8                	cmp    %ebx,%eax
80102f67:	74 41                	je     80102faa <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102f69:	e8 72 f5 ff ff       	call   801024e0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f6e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80102f73:	c7 05 f8 6f 00 80 a0 	movl   $0x80102ea0,0x80006ff8
80102f7a:	2e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102f7d:	c7 05 f4 6f 00 80 00 	movl   $0x10b000,0x80006ff4
80102f84:	b0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f87:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
80102f8c:	0f b6 03             	movzbl (%ebx),%eax
80102f8f:	83 ec 08             	sub    $0x8,%esp
80102f92:	68 00 70 00 00       	push   $0x7000
80102f97:	50                   	push   %eax
80102f98:	e8 03 f8 ff ff       	call   801027a0 <lapicstartap>
80102f9d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102fa0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102fa6:	85 c0                	test   %eax,%eax
80102fa8:	74 f6                	je     80102fa0 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
80102faa:	69 05 00 38 13 80 b0 	imul   $0xb0,0x80133800,%eax
80102fb1:	00 00 00 
80102fb4:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102fba:	05 80 32 13 80       	add    $0x80133280,%eax
80102fbf:	39 c3                	cmp    %eax,%ebx
80102fc1:	72 9d                	jb     80102f60 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102fc3:	83 ec 08             	sub    $0x8,%esp
80102fc6:	68 00 00 00 8e       	push   $0x8e000000
80102fcb:	68 00 00 40 80       	push   $0x80400000
80102fd0:	e8 ab f4 ff ff       	call   80102480 <kinit2>
  userinit();      // first user process
80102fd5:	e8 56 08 00 00       	call   80103830 <userinit>
  mpmain();        // finish this processor's setup
80102fda:	e8 81 fe ff ff       	call   80102e60 <mpmain>
80102fdf:	90                   	nop

80102fe0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fe0:	55                   	push   %ebp
80102fe1:	89 e5                	mov    %esp,%ebp
80102fe3:	57                   	push   %edi
80102fe4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102fe5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80102feb:	53                   	push   %ebx
  e = addr+len;
80102fec:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80102fef:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80102ff2:	39 de                	cmp    %ebx,%esi
80102ff4:	72 10                	jb     80103006 <mpsearch1+0x26>
80102ff6:	eb 50                	jmp    80103048 <mpsearch1+0x68>
80102ff8:	90                   	nop
80102ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103000:	39 fb                	cmp    %edi,%ebx
80103002:	89 fe                	mov    %edi,%esi
80103004:	76 42                	jbe    80103048 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103006:	83 ec 04             	sub    $0x4,%esp
80103009:	8d 7e 10             	lea    0x10(%esi),%edi
8010300c:	6a 04                	push   $0x4
8010300e:	68 b8 89 10 80       	push   $0x801089b8
80103013:	56                   	push   %esi
80103014:	e8 47 1a 00 00       	call   80104a60 <memcmp>
80103019:	83 c4 10             	add    $0x10,%esp
8010301c:	85 c0                	test   %eax,%eax
8010301e:	75 e0                	jne    80103000 <mpsearch1+0x20>
80103020:	89 f1                	mov    %esi,%ecx
80103022:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103028:	0f b6 11             	movzbl (%ecx),%edx
8010302b:	83 c1 01             	add    $0x1,%ecx
8010302e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
80103030:	39 f9                	cmp    %edi,%ecx
80103032:	75 f4                	jne    80103028 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103034:	84 c0                	test   %al,%al
80103036:	75 c8                	jne    80103000 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103038:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010303b:	89 f0                	mov    %esi,%eax
8010303d:	5b                   	pop    %ebx
8010303e:	5e                   	pop    %esi
8010303f:	5f                   	pop    %edi
80103040:	5d                   	pop    %ebp
80103041:	c3                   	ret    
80103042:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103048:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010304b:	31 f6                	xor    %esi,%esi
}
8010304d:	89 f0                	mov    %esi,%eax
8010304f:	5b                   	pop    %ebx
80103050:	5e                   	pop    %esi
80103051:	5f                   	pop    %edi
80103052:	5d                   	pop    %ebp
80103053:	c3                   	ret    
80103054:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010305a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103060 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103060:	55                   	push   %ebp
80103061:	89 e5                	mov    %esp,%ebp
80103063:	57                   	push   %edi
80103064:	56                   	push   %esi
80103065:	53                   	push   %ebx
80103066:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103069:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103070:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103077:	c1 e0 08             	shl    $0x8,%eax
8010307a:	09 d0                	or     %edx,%eax
8010307c:	c1 e0 04             	shl    $0x4,%eax
8010307f:	85 c0                	test   %eax,%eax
80103081:	75 1b                	jne    8010309e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103083:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010308a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103091:	c1 e0 08             	shl    $0x8,%eax
80103094:	09 d0                	or     %edx,%eax
80103096:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103099:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010309e:	ba 00 04 00 00       	mov    $0x400,%edx
801030a3:	e8 38 ff ff ff       	call   80102fe0 <mpsearch1>
801030a8:	85 c0                	test   %eax,%eax
801030aa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801030ad:	0f 84 3d 01 00 00    	je     801031f0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801030b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801030b6:	8b 58 04             	mov    0x4(%eax),%ebx
801030b9:	85 db                	test   %ebx,%ebx
801030bb:	0f 84 4f 01 00 00    	je     80103210 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801030c1:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
801030c7:	83 ec 04             	sub    $0x4,%esp
801030ca:	6a 04                	push   $0x4
801030cc:	68 d5 89 10 80       	push   $0x801089d5
801030d1:	56                   	push   %esi
801030d2:	e8 89 19 00 00       	call   80104a60 <memcmp>
801030d7:	83 c4 10             	add    $0x10,%esp
801030da:	85 c0                	test   %eax,%eax
801030dc:	0f 85 2e 01 00 00    	jne    80103210 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
801030e2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801030e9:	3c 01                	cmp    $0x1,%al
801030eb:	0f 95 c2             	setne  %dl
801030ee:	3c 04                	cmp    $0x4,%al
801030f0:	0f 95 c0             	setne  %al
801030f3:	20 c2                	and    %al,%dl
801030f5:	0f 85 15 01 00 00    	jne    80103210 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
801030fb:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
80103102:	66 85 ff             	test   %di,%di
80103105:	74 1a                	je     80103121 <mpinit+0xc1>
80103107:	89 f0                	mov    %esi,%eax
80103109:	01 f7                	add    %esi,%edi
  sum = 0;
8010310b:	31 d2                	xor    %edx,%edx
8010310d:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103110:	0f b6 08             	movzbl (%eax),%ecx
80103113:	83 c0 01             	add    $0x1,%eax
80103116:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103118:	39 c7                	cmp    %eax,%edi
8010311a:	75 f4                	jne    80103110 <mpinit+0xb0>
8010311c:	84 d2                	test   %dl,%dl
8010311e:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103121:	85 f6                	test   %esi,%esi
80103123:	0f 84 e7 00 00 00    	je     80103210 <mpinit+0x1b0>
80103129:	84 d2                	test   %dl,%dl
8010312b:	0f 85 df 00 00 00    	jne    80103210 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103131:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103137:	a3 7c 31 13 80       	mov    %eax,0x8013317c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010313c:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103143:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103149:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010314e:	01 d6                	add    %edx,%esi
80103150:	39 c6                	cmp    %eax,%esi
80103152:	76 23                	jbe    80103177 <mpinit+0x117>
    switch(*p){
80103154:	0f b6 10             	movzbl (%eax),%edx
80103157:	80 fa 04             	cmp    $0x4,%dl
8010315a:	0f 87 ca 00 00 00    	ja     8010322a <mpinit+0x1ca>
80103160:	ff 24 95 fc 89 10 80 	jmp    *-0x7fef7604(,%edx,4)
80103167:	89 f6                	mov    %esi,%esi
80103169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103170:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103173:	39 c6                	cmp    %eax,%esi
80103175:	77 dd                	ja     80103154 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103177:	85 db                	test   %ebx,%ebx
80103179:	0f 84 9e 00 00 00    	je     8010321d <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010317f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103182:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103186:	74 15                	je     8010319d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103188:	b8 70 00 00 00       	mov    $0x70,%eax
8010318d:	ba 22 00 00 00       	mov    $0x22,%edx
80103192:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103193:	ba 23 00 00 00       	mov    $0x23,%edx
80103198:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103199:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010319c:	ee                   	out    %al,(%dx)
  }
}
8010319d:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031a0:	5b                   	pop    %ebx
801031a1:	5e                   	pop    %esi
801031a2:	5f                   	pop    %edi
801031a3:	5d                   	pop    %ebp
801031a4:	c3                   	ret    
801031a5:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
801031a8:	8b 0d 00 38 13 80    	mov    0x80133800,%ecx
801031ae:	83 f9 07             	cmp    $0x7,%ecx
801031b1:	7f 19                	jg     801031cc <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031b3:	0f b6 50 01          	movzbl 0x1(%eax),%edx
801031b7:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
801031bd:	83 c1 01             	add    $0x1,%ecx
801031c0:	89 0d 00 38 13 80    	mov    %ecx,0x80133800
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031c6:	88 97 80 32 13 80    	mov    %dl,-0x7feccd80(%edi)
      p += sizeof(struct mpproc);
801031cc:	83 c0 14             	add    $0x14,%eax
      continue;
801031cf:	e9 7c ff ff ff       	jmp    80103150 <mpinit+0xf0>
801031d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
801031d8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801031dc:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801031df:	88 15 60 32 13 80    	mov    %dl,0x80133260
      continue;
801031e5:	e9 66 ff ff ff       	jmp    80103150 <mpinit+0xf0>
801031ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
801031f0:	ba 00 00 01 00       	mov    $0x10000,%edx
801031f5:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801031fa:	e8 e1 fd ff ff       	call   80102fe0 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031ff:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
80103201:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103204:	0f 85 a9 fe ff ff    	jne    801030b3 <mpinit+0x53>
8010320a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103210:	83 ec 0c             	sub    $0xc,%esp
80103213:	68 bd 89 10 80       	push   $0x801089bd
80103218:	e8 73 d1 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010321d:	83 ec 0c             	sub    $0xc,%esp
80103220:	68 dc 89 10 80       	push   $0x801089dc
80103225:	e8 66 d1 ff ff       	call   80100390 <panic>
      ismp = 0;
8010322a:	31 db                	xor    %ebx,%ebx
8010322c:	e9 26 ff ff ff       	jmp    80103157 <mpinit+0xf7>
80103231:	66 90                	xchg   %ax,%ax
80103233:	66 90                	xchg   %ax,%ax
80103235:	66 90                	xchg   %ax,%ax
80103237:	66 90                	xchg   %ax,%ax
80103239:	66 90                	xchg   %ax,%ax
8010323b:	66 90                	xchg   %ax,%ax
8010323d:	66 90                	xchg   %ax,%ax
8010323f:	90                   	nop

80103240 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103240:	55                   	push   %ebp
80103241:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103246:	ba 21 00 00 00       	mov    $0x21,%edx
8010324b:	89 e5                	mov    %esp,%ebp
8010324d:	ee                   	out    %al,(%dx)
8010324e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103253:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103254:	5d                   	pop    %ebp
80103255:	c3                   	ret    
80103256:	66 90                	xchg   %ax,%ax
80103258:	66 90                	xchg   %ax,%ax
8010325a:	66 90                	xchg   %ax,%ax
8010325c:	66 90                	xchg   %ax,%ax
8010325e:	66 90                	xchg   %ax,%ax

80103260 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103260:	55                   	push   %ebp
80103261:	89 e5                	mov    %esp,%ebp
80103263:	57                   	push   %edi
80103264:	56                   	push   %esi
80103265:	53                   	push   %ebx
80103266:	83 ec 0c             	sub    $0xc,%esp
80103269:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010326c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010326f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103275:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010327b:	e8 00 db ff ff       	call   80100d80 <filealloc>
80103280:	85 c0                	test   %eax,%eax
80103282:	89 03                	mov    %eax,(%ebx)
80103284:	74 22                	je     801032a8 <pipealloc+0x48>
80103286:	e8 f5 da ff ff       	call   80100d80 <filealloc>
8010328b:	85 c0                	test   %eax,%eax
8010328d:	89 06                	mov    %eax,(%esi)
8010328f:	74 3f                	je     801032d0 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103291:	e8 4a f2 ff ff       	call   801024e0 <kalloc>
80103296:	85 c0                	test   %eax,%eax
80103298:	89 c7                	mov    %eax,%edi
8010329a:	75 54                	jne    801032f0 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010329c:	8b 03                	mov    (%ebx),%eax
8010329e:	85 c0                	test   %eax,%eax
801032a0:	75 34                	jne    801032d6 <pipealloc+0x76>
801032a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
801032a8:	8b 06                	mov    (%esi),%eax
801032aa:	85 c0                	test   %eax,%eax
801032ac:	74 0c                	je     801032ba <pipealloc+0x5a>
    fileclose(*f1);
801032ae:	83 ec 0c             	sub    $0xc,%esp
801032b1:	50                   	push   %eax
801032b2:	e8 89 db ff ff       	call   80100e40 <fileclose>
801032b7:	83 c4 10             	add    $0x10,%esp
  return -1;
}
801032ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801032bd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801032c2:	5b                   	pop    %ebx
801032c3:	5e                   	pop    %esi
801032c4:	5f                   	pop    %edi
801032c5:	5d                   	pop    %ebp
801032c6:	c3                   	ret    
801032c7:	89 f6                	mov    %esi,%esi
801032c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
801032d0:	8b 03                	mov    (%ebx),%eax
801032d2:	85 c0                	test   %eax,%eax
801032d4:	74 e4                	je     801032ba <pipealloc+0x5a>
    fileclose(*f0);
801032d6:	83 ec 0c             	sub    $0xc,%esp
801032d9:	50                   	push   %eax
801032da:	e8 61 db ff ff       	call   80100e40 <fileclose>
  if(*f1)
801032df:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
801032e1:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801032e4:	85 c0                	test   %eax,%eax
801032e6:	75 c6                	jne    801032ae <pipealloc+0x4e>
801032e8:	eb d0                	jmp    801032ba <pipealloc+0x5a>
801032ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
801032f0:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
801032f3:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801032fa:	00 00 00 
  p->writeopen = 1;
801032fd:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103304:	00 00 00 
  p->nwrite = 0;
80103307:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010330e:	00 00 00 
  p->nread = 0;
80103311:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103318:	00 00 00 
  initlock(&p->lock, "pipe");
8010331b:	68 10 8a 10 80       	push   $0x80108a10
80103320:	50                   	push   %eax
80103321:	e8 9a 14 00 00       	call   801047c0 <initlock>
  (*f0)->type = FD_PIPE;
80103326:	8b 03                	mov    (%ebx),%eax
  return 0;
80103328:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
8010332b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103331:	8b 03                	mov    (%ebx),%eax
80103333:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103337:	8b 03                	mov    (%ebx),%eax
80103339:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010333d:	8b 03                	mov    (%ebx),%eax
8010333f:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103342:	8b 06                	mov    (%esi),%eax
80103344:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010334a:	8b 06                	mov    (%esi),%eax
8010334c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103350:	8b 06                	mov    (%esi),%eax
80103352:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103356:	8b 06                	mov    (%esi),%eax
80103358:	89 78 0c             	mov    %edi,0xc(%eax)
}
8010335b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010335e:	31 c0                	xor    %eax,%eax
}
80103360:	5b                   	pop    %ebx
80103361:	5e                   	pop    %esi
80103362:	5f                   	pop    %edi
80103363:	5d                   	pop    %ebp
80103364:	c3                   	ret    
80103365:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103370 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103370:	55                   	push   %ebp
80103371:	89 e5                	mov    %esp,%ebp
80103373:	56                   	push   %esi
80103374:	53                   	push   %ebx
80103375:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103378:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010337b:	83 ec 0c             	sub    $0xc,%esp
8010337e:	53                   	push   %ebx
8010337f:	e8 7c 15 00 00       	call   80104900 <acquire>
  if(writable){
80103384:	83 c4 10             	add    $0x10,%esp
80103387:	85 f6                	test   %esi,%esi
80103389:	74 45                	je     801033d0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010338b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103391:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103394:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010339b:	00 00 00 
    wakeup(&p->nread);
8010339e:	50                   	push   %eax
8010339f:	e8 7c 0c 00 00       	call   80104020 <wakeup>
801033a4:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801033a7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801033ad:	85 d2                	test   %edx,%edx
801033af:	75 0a                	jne    801033bb <pipeclose+0x4b>
801033b1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801033b7:	85 c0                	test   %eax,%eax
801033b9:	74 35                	je     801033f0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801033bb:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801033be:	8d 65 f8             	lea    -0x8(%ebp),%esp
801033c1:	5b                   	pop    %ebx
801033c2:	5e                   	pop    %esi
801033c3:	5d                   	pop    %ebp
    release(&p->lock);
801033c4:	e9 f7 15 00 00       	jmp    801049c0 <release>
801033c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801033d0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801033d6:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
801033d9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801033e0:	00 00 00 
    wakeup(&p->nwrite);
801033e3:	50                   	push   %eax
801033e4:	e8 37 0c 00 00       	call   80104020 <wakeup>
801033e9:	83 c4 10             	add    $0x10,%esp
801033ec:	eb b9                	jmp    801033a7 <pipeclose+0x37>
801033ee:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801033f0:	83 ec 0c             	sub    $0xc,%esp
801033f3:	53                   	push   %ebx
801033f4:	e8 c7 15 00 00       	call   801049c0 <release>
    kfree((char*)p);
801033f9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801033fc:	83 c4 10             	add    $0x10,%esp
}
801033ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103402:	5b                   	pop    %ebx
80103403:	5e                   	pop    %esi
80103404:	5d                   	pop    %ebp
    kfree((char*)p);
80103405:	e9 26 ef ff ff       	jmp    80102330 <kfree>
8010340a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103410 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103410:	55                   	push   %ebp
80103411:	89 e5                	mov    %esp,%ebp
80103413:	57                   	push   %edi
80103414:	56                   	push   %esi
80103415:	53                   	push   %ebx
80103416:	83 ec 28             	sub    $0x28,%esp
80103419:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010341c:	53                   	push   %ebx
8010341d:	e8 de 14 00 00       	call   80104900 <acquire>
  for(i = 0; i < n; i++){
80103422:	8b 45 10             	mov    0x10(%ebp),%eax
80103425:	83 c4 10             	add    $0x10,%esp
80103428:	85 c0                	test   %eax,%eax
8010342a:	0f 8e c9 00 00 00    	jle    801034f9 <pipewrite+0xe9>
80103430:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103433:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103439:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010343f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103442:	03 4d 10             	add    0x10(%ebp),%ecx
80103445:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103448:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010344e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103454:	39 d0                	cmp    %edx,%eax
80103456:	75 71                	jne    801034c9 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103458:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010345e:	85 c0                	test   %eax,%eax
80103460:	74 4e                	je     801034b0 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103462:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103468:	eb 3a                	jmp    801034a4 <pipewrite+0x94>
8010346a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103470:	83 ec 0c             	sub    $0xc,%esp
80103473:	57                   	push   %edi
80103474:	e8 a7 0b 00 00       	call   80104020 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103479:	5a                   	pop    %edx
8010347a:	59                   	pop    %ecx
8010347b:	53                   	push   %ebx
8010347c:	56                   	push   %esi
8010347d:	e8 de 09 00 00       	call   80103e60 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103482:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103488:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010348e:	83 c4 10             	add    $0x10,%esp
80103491:	05 00 02 00 00       	add    $0x200,%eax
80103496:	39 c2                	cmp    %eax,%edx
80103498:	75 36                	jne    801034d0 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
8010349a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801034a0:	85 c0                	test   %eax,%eax
801034a2:	74 0c                	je     801034b0 <pipewrite+0xa0>
801034a4:	e8 57 03 00 00       	call   80103800 <myproc>
801034a9:	8b 40 24             	mov    0x24(%eax),%eax
801034ac:	85 c0                	test   %eax,%eax
801034ae:	74 c0                	je     80103470 <pipewrite+0x60>
        release(&p->lock);
801034b0:	83 ec 0c             	sub    $0xc,%esp
801034b3:	53                   	push   %ebx
801034b4:	e8 07 15 00 00       	call   801049c0 <release>
        return -1;
801034b9:	83 c4 10             	add    $0x10,%esp
801034bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801034c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801034c4:	5b                   	pop    %ebx
801034c5:	5e                   	pop    %esi
801034c6:	5f                   	pop    %edi
801034c7:	5d                   	pop    %ebp
801034c8:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801034c9:	89 c2                	mov    %eax,%edx
801034cb:	90                   	nop
801034cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034d0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801034d3:	8d 42 01             	lea    0x1(%edx),%eax
801034d6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801034dc:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801034e2:	83 c6 01             	add    $0x1,%esi
801034e5:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
801034e9:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801034ec:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034ef:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801034f3:	0f 85 4f ff ff ff    	jne    80103448 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801034f9:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801034ff:	83 ec 0c             	sub    $0xc,%esp
80103502:	50                   	push   %eax
80103503:	e8 18 0b 00 00       	call   80104020 <wakeup>
  release(&p->lock);
80103508:	89 1c 24             	mov    %ebx,(%esp)
8010350b:	e8 b0 14 00 00       	call   801049c0 <release>
  return n;
80103510:	83 c4 10             	add    $0x10,%esp
80103513:	8b 45 10             	mov    0x10(%ebp),%eax
80103516:	eb a9                	jmp    801034c1 <pipewrite+0xb1>
80103518:	90                   	nop
80103519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103520 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103520:	55                   	push   %ebp
80103521:	89 e5                	mov    %esp,%ebp
80103523:	57                   	push   %edi
80103524:	56                   	push   %esi
80103525:	53                   	push   %ebx
80103526:	83 ec 18             	sub    $0x18,%esp
80103529:	8b 75 08             	mov    0x8(%ebp),%esi
8010352c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010352f:	56                   	push   %esi
80103530:	e8 cb 13 00 00       	call   80104900 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103535:	83 c4 10             	add    $0x10,%esp
80103538:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010353e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103544:	75 6a                	jne    801035b0 <piperead+0x90>
80103546:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010354c:	85 db                	test   %ebx,%ebx
8010354e:	0f 84 c4 00 00 00    	je     80103618 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103554:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010355a:	eb 2d                	jmp    80103589 <piperead+0x69>
8010355c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103560:	83 ec 08             	sub    $0x8,%esp
80103563:	56                   	push   %esi
80103564:	53                   	push   %ebx
80103565:	e8 f6 08 00 00       	call   80103e60 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010356a:	83 c4 10             	add    $0x10,%esp
8010356d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103573:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103579:	75 35                	jne    801035b0 <piperead+0x90>
8010357b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103581:	85 d2                	test   %edx,%edx
80103583:	0f 84 8f 00 00 00    	je     80103618 <piperead+0xf8>
    if(myproc()->killed){
80103589:	e8 72 02 00 00       	call   80103800 <myproc>
8010358e:	8b 48 24             	mov    0x24(%eax),%ecx
80103591:	85 c9                	test   %ecx,%ecx
80103593:	74 cb                	je     80103560 <piperead+0x40>
      release(&p->lock);
80103595:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103598:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
8010359d:	56                   	push   %esi
8010359e:	e8 1d 14 00 00       	call   801049c0 <release>
      return -1;
801035a3:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801035a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035a9:	89 d8                	mov    %ebx,%eax
801035ab:	5b                   	pop    %ebx
801035ac:	5e                   	pop    %esi
801035ad:	5f                   	pop    %edi
801035ae:	5d                   	pop    %ebp
801035af:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035b0:	8b 45 10             	mov    0x10(%ebp),%eax
801035b3:	85 c0                	test   %eax,%eax
801035b5:	7e 61                	jle    80103618 <piperead+0xf8>
    if(p->nread == p->nwrite)
801035b7:	31 db                	xor    %ebx,%ebx
801035b9:	eb 13                	jmp    801035ce <piperead+0xae>
801035bb:	90                   	nop
801035bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035c0:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801035c6:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801035cc:	74 1f                	je     801035ed <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
801035ce:	8d 41 01             	lea    0x1(%ecx),%eax
801035d1:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801035d7:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
801035dd:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
801035e2:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035e5:	83 c3 01             	add    $0x1,%ebx
801035e8:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801035eb:	75 d3                	jne    801035c0 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801035ed:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801035f3:	83 ec 0c             	sub    $0xc,%esp
801035f6:	50                   	push   %eax
801035f7:	e8 24 0a 00 00       	call   80104020 <wakeup>
  release(&p->lock);
801035fc:	89 34 24             	mov    %esi,(%esp)
801035ff:	e8 bc 13 00 00       	call   801049c0 <release>
  return i;
80103604:	83 c4 10             	add    $0x10,%esp
}
80103607:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010360a:	89 d8                	mov    %ebx,%eax
8010360c:	5b                   	pop    %ebx
8010360d:	5e                   	pop    %esi
8010360e:	5f                   	pop    %edi
8010360f:	5d                   	pop    %ebp
80103610:	c3                   	ret    
80103611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103618:	31 db                	xor    %ebx,%ebx
8010361a:	eb d1                	jmp    801035ed <piperead+0xcd>
8010361c:	66 90                	xchg   %ax,%ax
8010361e:	66 90                	xchg   %ax,%ax

80103620 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103620:	55                   	push   %ebp
80103621:	89 e5                	mov    %esp,%ebp
80103623:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103624:	bb 54 38 13 80       	mov    $0x80133854,%ebx
{
80103629:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010362c:	68 20 38 13 80       	push   $0x80133820
80103631:	e8 ca 12 00 00       	call   80104900 <acquire>
80103636:	83 c4 10             	add    $0x10,%esp
80103639:	eb 13                	jmp    8010364e <allocproc+0x2e>
8010363b:	90                   	nop
8010363c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103640:	81 c3 d0 01 00 00    	add    $0x1d0,%ebx
80103646:	81 fb 54 ac 13 80    	cmp    $0x8013ac54,%ebx
8010364c:	73 7a                	jae    801036c8 <allocproc+0xa8>
    if(p->state == UNUSED)
8010364e:	8b 43 0c             	mov    0xc(%ebx),%eax
80103651:	85 c0                	test   %eax,%eax
80103653:	75 eb                	jne    80103640 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103655:	a1 04 c0 10 80       	mov    0x8010c004,%eax

  release(&ptable.lock);
8010365a:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
8010365d:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103664:	8d 50 01             	lea    0x1(%eax),%edx
80103667:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
8010366a:	68 20 38 13 80       	push   $0x80133820
  p->pid = nextpid++;
8010366f:	89 15 04 c0 10 80    	mov    %edx,0x8010c004
  release(&ptable.lock);
80103675:	e8 46 13 00 00       	call   801049c0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010367a:	e8 61 ee ff ff       	call   801024e0 <kalloc>
8010367f:	83 c4 10             	add    $0x10,%esp
80103682:	85 c0                	test   %eax,%eax
80103684:	89 43 08             	mov    %eax,0x8(%ebx)
80103687:	74 58                	je     801036e1 <allocproc+0xc1>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103689:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010368f:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103692:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103697:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
8010369a:	c7 40 14 43 6c 10 80 	movl   $0x80106c43,0x14(%eax)
  p->context = (struct context*)sp;
801036a1:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801036a4:	6a 14                	push   $0x14
801036a6:	6a 00                	push   $0x0
801036a8:	50                   	push   %eax
801036a9:	e8 62 13 00 00       	call   80104a10 <memset>
  p->context->eip = (uint)forkret;
801036ae:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
801036b1:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
801036b4:	c7 40 10 f0 36 10 80 	movl   $0x801036f0,0x10(%eax)
}
801036bb:	89 d8                	mov    %ebx,%eax
801036bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801036c0:	c9                   	leave  
801036c1:	c3                   	ret    
801036c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
801036c8:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801036cb:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
801036cd:	68 20 38 13 80       	push   $0x80133820
801036d2:	e8 e9 12 00 00       	call   801049c0 <release>
}
801036d7:	89 d8                	mov    %ebx,%eax
  return 0;
801036d9:	83 c4 10             	add    $0x10,%esp
}
801036dc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801036df:	c9                   	leave  
801036e0:	c3                   	ret    
    p->state = UNUSED;
801036e1:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801036e8:	31 db                	xor    %ebx,%ebx
801036ea:	eb cf                	jmp    801036bb <allocproc+0x9b>
801036ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801036f0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801036f0:	55                   	push   %ebp
801036f1:	89 e5                	mov    %esp,%ebp
801036f3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801036f6:	68 20 38 13 80       	push   $0x80133820
801036fb:	e8 c0 12 00 00       	call   801049c0 <release>

  if (first) {
80103700:	a1 00 c0 10 80       	mov    0x8010c000,%eax
80103705:	83 c4 10             	add    $0x10,%esp
80103708:	85 c0                	test   %eax,%eax
8010370a:	75 04                	jne    80103710 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010370c:	c9                   	leave  
8010370d:	c3                   	ret    
8010370e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103710:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103713:	c7 05 00 c0 10 80 00 	movl   $0x0,0x8010c000
8010371a:	00 00 00 
    iinit(ROOTDEV);
8010371d:	6a 01                	push   $0x1
8010371f:	e8 6c dd ff ff       	call   80101490 <iinit>
    initlog(ROOTDEV);
80103724:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010372b:	e8 f0 f3 ff ff       	call   80102b20 <initlog>
80103730:	83 c4 10             	add    $0x10,%esp
}
80103733:	c9                   	leave  
80103734:	c3                   	ret    
80103735:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103740 <pinit>:
{
80103740:	55                   	push   %ebp
80103741:	89 e5                	mov    %esp,%ebp
80103743:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103746:	68 15 8a 10 80       	push   $0x80108a15
8010374b:	68 20 38 13 80       	push   $0x80133820
80103750:	e8 6b 10 00 00       	call   801047c0 <initlock>
}
80103755:	83 c4 10             	add    $0x10,%esp
80103758:	c9                   	leave  
80103759:	c3                   	ret    
8010375a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103760 <mycpu>:
{
80103760:	55                   	push   %ebp
80103761:	89 e5                	mov    %esp,%ebp
80103763:	56                   	push   %esi
80103764:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103765:	9c                   	pushf  
80103766:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103767:	f6 c4 02             	test   $0x2,%ah
8010376a:	75 5e                	jne    801037ca <mycpu+0x6a>
  apicid = lapicid();
8010376c:	e8 df ef ff ff       	call   80102750 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103771:	8b 35 00 38 13 80    	mov    0x80133800,%esi
80103777:	85 f6                	test   %esi,%esi
80103779:	7e 42                	jle    801037bd <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
8010377b:	0f b6 15 80 32 13 80 	movzbl 0x80133280,%edx
80103782:	39 d0                	cmp    %edx,%eax
80103784:	74 30                	je     801037b6 <mycpu+0x56>
80103786:	b9 30 33 13 80       	mov    $0x80133330,%ecx
  for (i = 0; i < ncpu; ++i) {
8010378b:	31 d2                	xor    %edx,%edx
8010378d:	8d 76 00             	lea    0x0(%esi),%esi
80103790:	83 c2 01             	add    $0x1,%edx
80103793:	39 f2                	cmp    %esi,%edx
80103795:	74 26                	je     801037bd <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103797:	0f b6 19             	movzbl (%ecx),%ebx
8010379a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
801037a0:	39 c3                	cmp    %eax,%ebx
801037a2:	75 ec                	jne    80103790 <mycpu+0x30>
801037a4:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
801037aa:	05 80 32 13 80       	add    $0x80133280,%eax
}
801037af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801037b2:	5b                   	pop    %ebx
801037b3:	5e                   	pop    %esi
801037b4:	5d                   	pop    %ebp
801037b5:	c3                   	ret    
    if (cpus[i].apicid == apicid)
801037b6:	b8 80 32 13 80       	mov    $0x80133280,%eax
      return &cpus[i];
801037bb:	eb f2                	jmp    801037af <mycpu+0x4f>
  panic("unknown apicid\n");
801037bd:	83 ec 0c             	sub    $0xc,%esp
801037c0:	68 1c 8a 10 80       	push   $0x80108a1c
801037c5:	e8 c6 cb ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
801037ca:	83 ec 0c             	sub    $0xc,%esp
801037cd:	68 20 8b 10 80       	push   $0x80108b20
801037d2:	e8 b9 cb ff ff       	call   80100390 <panic>
801037d7:	89 f6                	mov    %esi,%esi
801037d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801037e0 <cpuid>:
cpuid() {
801037e0:	55                   	push   %ebp
801037e1:	89 e5                	mov    %esp,%ebp
801037e3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801037e6:	e8 75 ff ff ff       	call   80103760 <mycpu>
801037eb:	2d 80 32 13 80       	sub    $0x80133280,%eax
}
801037f0:	c9                   	leave  
  return mycpu()-cpus;
801037f1:	c1 f8 04             	sar    $0x4,%eax
801037f4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801037fa:	c3                   	ret    
801037fb:	90                   	nop
801037fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103800 <myproc>:
myproc(void) {
80103800:	55                   	push   %ebp
80103801:	89 e5                	mov    %esp,%ebp
80103803:	53                   	push   %ebx
80103804:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103807:	e8 24 10 00 00       	call   80104830 <pushcli>
  c = mycpu();
8010380c:	e8 4f ff ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103811:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103817:	e8 54 10 00 00       	call   80104870 <popcli>
}
8010381c:	83 c4 04             	add    $0x4,%esp
8010381f:	89 d8                	mov    %ebx,%eax
80103821:	5b                   	pop    %ebx
80103822:	5d                   	pop    %ebp
80103823:	c3                   	ret    
80103824:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010382a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103830 <userinit>:
{
80103830:	55                   	push   %ebp
80103831:	89 e5                	mov    %esp,%ebp
80103833:	53                   	push   %ebx
80103834:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103837:	e8 e4 fd ff ff       	call   80103620 <allocproc>
8010383c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010383e:	a3 bc c5 10 80       	mov    %eax,0x8010c5bc
  if((p->pgdir = setupkvm()) == 0)
80103843:	e8 c8 49 00 00       	call   80108210 <setupkvm>
80103848:	85 c0                	test   %eax,%eax
8010384a:	89 43 04             	mov    %eax,0x4(%ebx)
8010384d:	0f 84 c3 00 00 00    	je     80103916 <userinit+0xe6>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103853:	83 ec 04             	sub    $0x4,%esp
80103856:	68 2c 00 00 00       	push   $0x2c
8010385b:	68 60 c4 10 80       	push   $0x8010c460
80103860:	50                   	push   %eax
80103861:	e8 8a 46 00 00       	call   80107ef0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103866:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103869:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010386f:	6a 4c                	push   $0x4c
80103871:	6a 00                	push   $0x0
80103873:	ff 73 18             	pushl  0x18(%ebx)
80103876:	e8 95 11 00 00       	call   80104a10 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010387b:	8b 43 18             	mov    0x18(%ebx),%eax
8010387e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103883:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103888:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010388b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010388f:	8b 43 18             	mov    0x18(%ebx),%eax
80103892:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103896:	8b 43 18             	mov    0x18(%ebx),%eax
80103899:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010389d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801038a1:	8b 43 18             	mov    0x18(%ebx),%eax
801038a4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801038a8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801038ac:	8b 43 18             	mov    0x18(%ebx),%eax
801038af:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801038b6:	8b 43 18             	mov    0x18(%ebx),%eax
801038b9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801038c0:	8b 43 18             	mov    0x18(%ebx),%eax
801038c3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
801038ca:	8d 83 bc 01 00 00    	lea    0x1bc(%ebx),%eax
801038d0:	6a 10                	push   $0x10
801038d2:	68 45 8a 10 80       	push   $0x80108a45
801038d7:	50                   	push   %eax
801038d8:	e8 13 13 00 00       	call   80104bf0 <safestrcpy>
  p->cwd = namei("/");
801038dd:	c7 04 24 4e 8a 10 80 	movl   $0x80108a4e,(%esp)
801038e4:	e8 17 e6 ff ff       	call   80101f00 <namei>
801038e9:	89 83 b8 01 00 00    	mov    %eax,0x1b8(%ebx)
  acquire(&ptable.lock);
801038ef:	c7 04 24 20 38 13 80 	movl   $0x80133820,(%esp)
801038f6:	e8 05 10 00 00       	call   80104900 <acquire>
  p->state = RUNNABLE;
801038fb:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103902:	c7 04 24 20 38 13 80 	movl   $0x80133820,(%esp)
80103909:	e8 b2 10 00 00       	call   801049c0 <release>
}
8010390e:	83 c4 10             	add    $0x10,%esp
80103911:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103914:	c9                   	leave  
80103915:	c3                   	ret    
    panic("userinit: out of memory?");
80103916:	83 ec 0c             	sub    $0xc,%esp
80103919:	68 2c 8a 10 80       	push   $0x80108a2c
8010391e:	e8 6d ca ff ff       	call   80100390 <panic>
80103923:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103930 <growproc>:
{
80103930:	55                   	push   %ebp
80103931:	89 e5                	mov    %esp,%ebp
80103933:	56                   	push   %esi
80103934:	53                   	push   %ebx
80103935:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103938:	e8 f3 0e 00 00       	call   80104830 <pushcli>
  c = mycpu();
8010393d:	e8 1e fe ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103942:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103948:	e8 23 0f 00 00       	call   80104870 <popcli>
  if(n > 0){
8010394d:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103950:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103952:	7f 1c                	jg     80103970 <growproc+0x40>
  } else if(n < 0){
80103954:	75 3a                	jne    80103990 <growproc+0x60>
  switchuvm(curproc);
80103956:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103959:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
8010395b:	53                   	push   %ebx
8010395c:	e8 7f 44 00 00       	call   80107de0 <switchuvm>
  return 0;
80103961:	83 c4 10             	add    $0x10,%esp
80103964:	31 c0                	xor    %eax,%eax
}
80103966:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103969:	5b                   	pop    %ebx
8010396a:	5e                   	pop    %esi
8010396b:	5d                   	pop    %ebp
8010396c:	c3                   	ret    
8010396d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103970:	83 ec 04             	sub    $0x4,%esp
80103973:	01 c6                	add    %eax,%esi
80103975:	56                   	push   %esi
80103976:	50                   	push   %eax
80103977:	ff 73 04             	pushl  0x4(%ebx)
8010397a:	e8 b1 46 00 00       	call   80108030 <allocuvm>
8010397f:	83 c4 10             	add    $0x10,%esp
80103982:	85 c0                	test   %eax,%eax
80103984:	75 d0                	jne    80103956 <growproc+0x26>
      return -1;
80103986:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010398b:	eb d9                	jmp    80103966 <growproc+0x36>
8010398d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103990:	83 ec 04             	sub    $0x4,%esp
80103993:	01 c6                	add    %eax,%esi
80103995:	56                   	push   %esi
80103996:	50                   	push   %eax
80103997:	ff 73 04             	pushl  0x4(%ebx)
8010399a:	e8 c1 47 00 00       	call   80108160 <deallocuvm>
8010399f:	83 c4 10             	add    $0x10,%esp
801039a2:	85 c0                	test   %eax,%eax
801039a4:	75 b0                	jne    80103956 <growproc+0x26>
801039a6:	eb de                	jmp    80103986 <growproc+0x56>
801039a8:	90                   	nop
801039a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801039b0 <fork>:
{
801039b0:	55                   	push   %ebp
801039b1:	89 e5                	mov    %esp,%ebp
801039b3:	57                   	push   %edi
801039b4:	56                   	push   %esi
801039b5:	53                   	push   %ebx
801039b6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
801039b9:	e8 72 0e 00 00       	call   80104830 <pushcli>
  c = mycpu();
801039be:	e8 9d fd ff ff       	call   80103760 <mycpu>
  p = c->proc;
801039c3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039c9:	e8 a2 0e 00 00       	call   80104870 <popcli>
  if((np = allocproc()) == 0){
801039ce:	e8 4d fc ff ff       	call   80103620 <allocproc>
801039d3:	85 c0                	test   %eax,%eax
801039d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801039d8:	0f 84 c3 00 00 00    	je     80103aa1 <fork+0xf1>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
801039de:	83 ec 08             	sub    $0x8,%esp
801039e1:	ff 33                	pushl  (%ebx)
801039e3:	ff 73 04             	pushl  0x4(%ebx)
801039e6:	89 c7                	mov    %eax,%edi
801039e8:	e8 f3 48 00 00       	call   801082e0 <copyuvm>
801039ed:	83 c4 10             	add    $0x10,%esp
801039f0:	85 c0                	test   %eax,%eax
801039f2:	89 47 04             	mov    %eax,0x4(%edi)
801039f5:	0f 84 ad 00 00 00    	je     80103aa8 <fork+0xf8>
  np->sz = curproc->sz;
801039fb:	8b 03                	mov    (%ebx),%eax
801039fd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103a00:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103a02:	89 59 14             	mov    %ebx,0x14(%ecx)
80103a05:	89 c8                	mov    %ecx,%eax
  *np->tf = *curproc->tf;
80103a07:	8b 79 18             	mov    0x18(%ecx),%edi
80103a0a:	8b 73 18             	mov    0x18(%ebx),%esi
80103a0d:	b9 13 00 00 00       	mov    $0x13,%ecx
80103a12:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103a14:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103a16:	8b 40 18             	mov    0x18(%eax),%eax
80103a19:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103a20:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103a24:	85 c0                	test   %eax,%eax
80103a26:	74 13                	je     80103a3b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103a28:	83 ec 0c             	sub    $0xc,%esp
80103a2b:	50                   	push   %eax
80103a2c:	e8 bf d3 ff ff       	call   80100df0 <filedup>
80103a31:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103a34:	83 c4 10             	add    $0x10,%esp
80103a37:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103a3b:	83 c6 01             	add    $0x1,%esi
80103a3e:	83 fe 64             	cmp    $0x64,%esi
80103a41:	75 dd                	jne    80103a20 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103a43:	83 ec 0c             	sub    $0xc,%esp
80103a46:	ff b3 b8 01 00 00    	pushl  0x1b8(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a4c:	81 c3 bc 01 00 00    	add    $0x1bc,%ebx
  np->cwd = idup(curproc->cwd);
80103a52:	e8 09 dc ff ff       	call   80101660 <idup>
80103a57:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a5a:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103a5d:	89 87 b8 01 00 00    	mov    %eax,0x1b8(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a63:	8d 87 bc 01 00 00    	lea    0x1bc(%edi),%eax
80103a69:	6a 10                	push   $0x10
80103a6b:	53                   	push   %ebx
80103a6c:	50                   	push   %eax
80103a6d:	e8 7e 11 00 00       	call   80104bf0 <safestrcpy>
  pid = np->pid;
80103a72:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103a75:	c7 04 24 20 38 13 80 	movl   $0x80133820,(%esp)
80103a7c:	e8 7f 0e 00 00       	call   80104900 <acquire>
  np->state = RUNNABLE;
80103a81:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103a88:	c7 04 24 20 38 13 80 	movl   $0x80133820,(%esp)
80103a8f:	e8 2c 0f 00 00       	call   801049c0 <release>
  return pid;
80103a94:	83 c4 10             	add    $0x10,%esp
}
80103a97:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a9a:	89 d8                	mov    %ebx,%eax
80103a9c:	5b                   	pop    %ebx
80103a9d:	5e                   	pop    %esi
80103a9e:	5f                   	pop    %edi
80103a9f:	5d                   	pop    %ebp
80103aa0:	c3                   	ret    
    return -1;
80103aa1:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103aa6:	eb ef                	jmp    80103a97 <fork+0xe7>
    kfree(np->kstack);
80103aa8:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103aab:	83 ec 0c             	sub    $0xc,%esp
    return -1;
80103aae:	83 cb ff             	or     $0xffffffff,%ebx
    kfree(np->kstack);
80103ab1:	ff 77 08             	pushl  0x8(%edi)
80103ab4:	e8 77 e8 ff ff       	call   80102330 <kfree>
    np->kstack = 0;
80103ab9:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103ac0:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103ac7:	83 c4 10             	add    $0x10,%esp
80103aca:	eb cb                	jmp    80103a97 <fork+0xe7>
80103acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103ad0 <scheduler>:
{
80103ad0:	55                   	push   %ebp
80103ad1:	89 e5                	mov    %esp,%ebp
80103ad3:	57                   	push   %edi
80103ad4:	56                   	push   %esi
80103ad5:	53                   	push   %ebx
80103ad6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103ad9:	e8 82 fc ff ff       	call   80103760 <mycpu>
80103ade:	8d 78 04             	lea    0x4(%eax),%edi
80103ae1:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103ae3:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103aea:	00 00 00 
80103aed:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103af0:	fb                   	sti    
    acquire(&ptable.lock);
80103af1:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103af4:	bb 54 38 13 80       	mov    $0x80133854,%ebx
    acquire(&ptable.lock);
80103af9:	68 20 38 13 80       	push   $0x80133820
80103afe:	e8 fd 0d 00 00       	call   80104900 <acquire>
80103b03:	83 c4 10             	add    $0x10,%esp
80103b06:	8d 76 00             	lea    0x0(%esi),%esi
80103b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(p->state != RUNNABLE)
80103b10:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103b14:	75 33                	jne    80103b49 <scheduler+0x79>
      switchuvm(p);
80103b16:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103b19:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103b1f:	53                   	push   %ebx
80103b20:	e8 bb 42 00 00       	call   80107de0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103b25:	58                   	pop    %eax
80103b26:	5a                   	pop    %edx
80103b27:	ff 73 1c             	pushl  0x1c(%ebx)
80103b2a:	57                   	push   %edi
      p->state = RUNNING;
80103b2b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103b32:	e8 14 11 00 00       	call   80104c4b <swtch>
      switchkvm();
80103b37:	e8 84 42 00 00       	call   80107dc0 <switchkvm>
      c->proc = 0;
80103b3c:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103b43:	00 00 00 
80103b46:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b49:	81 c3 d0 01 00 00    	add    $0x1d0,%ebx
80103b4f:	81 fb 54 ac 13 80    	cmp    $0x8013ac54,%ebx
80103b55:	72 b9                	jb     80103b10 <scheduler+0x40>
    release(&ptable.lock);
80103b57:	83 ec 0c             	sub    $0xc,%esp
80103b5a:	68 20 38 13 80       	push   $0x80133820
80103b5f:	e8 5c 0e 00 00       	call   801049c0 <release>
    sti();
80103b64:	83 c4 10             	add    $0x10,%esp
80103b67:	eb 87                	jmp    80103af0 <scheduler+0x20>
80103b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103b70 <scheduler2>:
{
80103b70:	55                   	push   %ebp
80103b71:	89 e5                	mov    %esp,%ebp
80103b73:	57                   	push   %edi
80103b74:	56                   	push   %esi
80103b75:	53                   	push   %ebx
80103b76:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103b79:	e8 e2 fb ff ff       	call   80103760 <mycpu>
80103b7e:	8d 78 04             	lea    0x4(%eax),%edi
80103b81:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103b83:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103b8a:	00 00 00 
80103b8d:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&ptable.lock);
80103b90:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b93:	bb 54 38 13 80       	mov    $0x80133854,%ebx
    acquire(&ptable.lock);
80103b98:	68 20 38 13 80       	push   $0x80133820
80103b9d:	e8 5e 0d 00 00       	call   80104900 <acquire>
80103ba2:	83 c4 10             	add    $0x10,%esp
80103ba5:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->state != RUNNABLE)
80103ba8:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103bac:	75 33                	jne    80103be1 <scheduler2+0x71>
      switchuvm(p);
80103bae:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103bb1:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103bb7:	53                   	push   %ebx
80103bb8:	e8 23 42 00 00       	call   80107de0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103bbd:	58                   	pop    %eax
80103bbe:	5a                   	pop    %edx
80103bbf:	ff 73 1c             	pushl  0x1c(%ebx)
80103bc2:	57                   	push   %edi
      p->state = RUNNING;
80103bc3:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103bca:	e8 7c 10 00 00       	call   80104c4b <swtch>
      switchkvm();
80103bcf:	e8 ec 41 00 00       	call   80107dc0 <switchkvm>
      c->proc = 0;
80103bd4:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103bdb:	00 00 00 
80103bde:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103be1:	81 c3 d0 01 00 00    	add    $0x1d0,%ebx
80103be7:	81 fb 54 ac 13 80    	cmp    $0x8013ac54,%ebx
80103bed:	72 b9                	jb     80103ba8 <scheduler2+0x38>
    release(&ptable.lock);
80103bef:	83 ec 0c             	sub    $0xc,%esp
80103bf2:	68 20 38 13 80       	push   $0x80133820
80103bf7:	e8 c4 0d 00 00       	call   801049c0 <release>
    acquire(&ptable.lock);
80103bfc:	83 c4 10             	add    $0x10,%esp
80103bff:	eb 8f                	jmp    80103b90 <scheduler2+0x20>
80103c01:	eb 0d                	jmp    80103c10 <sched>
80103c03:	90                   	nop
80103c04:	90                   	nop
80103c05:	90                   	nop
80103c06:	90                   	nop
80103c07:	90                   	nop
80103c08:	90                   	nop
80103c09:	90                   	nop
80103c0a:	90                   	nop
80103c0b:	90                   	nop
80103c0c:	90                   	nop
80103c0d:	90                   	nop
80103c0e:	90                   	nop
80103c0f:	90                   	nop

80103c10 <sched>:
{
80103c10:	55                   	push   %ebp
80103c11:	89 e5                	mov    %esp,%ebp
80103c13:	56                   	push   %esi
80103c14:	53                   	push   %ebx
  pushcli();
80103c15:	e8 16 0c 00 00       	call   80104830 <pushcli>
  c = mycpu();
80103c1a:	e8 41 fb ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103c1f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c25:	e8 46 0c 00 00       	call   80104870 <popcli>
  if(!holding(&ptable.lock))
80103c2a:	83 ec 0c             	sub    $0xc,%esp
80103c2d:	68 20 38 13 80       	push   $0x80133820
80103c32:	e8 99 0c 00 00       	call   801048d0 <holding>
80103c37:	83 c4 10             	add    $0x10,%esp
80103c3a:	85 c0                	test   %eax,%eax
80103c3c:	74 4f                	je     80103c8d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103c3e:	e8 1d fb ff ff       	call   80103760 <mycpu>
80103c43:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103c4a:	75 68                	jne    80103cb4 <sched+0xa4>
  if(p->state == RUNNING)
80103c4c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103c50:	74 55                	je     80103ca7 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103c52:	9c                   	pushf  
80103c53:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103c54:	f6 c4 02             	test   $0x2,%ah
80103c57:	75 41                	jne    80103c9a <sched+0x8a>
  intena = mycpu()->intena;
80103c59:	e8 02 fb ff ff       	call   80103760 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103c5e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103c61:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103c67:	e8 f4 fa ff ff       	call   80103760 <mycpu>
80103c6c:	83 ec 08             	sub    $0x8,%esp
80103c6f:	ff 70 04             	pushl  0x4(%eax)
80103c72:	53                   	push   %ebx
80103c73:	e8 d3 0f 00 00       	call   80104c4b <swtch>
  mycpu()->intena = intena;
80103c78:	e8 e3 fa ff ff       	call   80103760 <mycpu>
}
80103c7d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103c80:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103c86:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c89:	5b                   	pop    %ebx
80103c8a:	5e                   	pop    %esi
80103c8b:	5d                   	pop    %ebp
80103c8c:	c3                   	ret    
    panic("sched ptable.lock");
80103c8d:	83 ec 0c             	sub    $0xc,%esp
80103c90:	68 50 8a 10 80       	push   $0x80108a50
80103c95:	e8 f6 c6 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103c9a:	83 ec 0c             	sub    $0xc,%esp
80103c9d:	68 7c 8a 10 80       	push   $0x80108a7c
80103ca2:	e8 e9 c6 ff ff       	call   80100390 <panic>
    panic("sched running");
80103ca7:	83 ec 0c             	sub    $0xc,%esp
80103caa:	68 6e 8a 10 80       	push   $0x80108a6e
80103caf:	e8 dc c6 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103cb4:	83 ec 0c             	sub    $0xc,%esp
80103cb7:	68 62 8a 10 80       	push   $0x80108a62
80103cbc:	e8 cf c6 ff ff       	call   80100390 <panic>
80103cc1:	eb 0d                	jmp    80103cd0 <exit>
80103cc3:	90                   	nop
80103cc4:	90                   	nop
80103cc5:	90                   	nop
80103cc6:	90                   	nop
80103cc7:	90                   	nop
80103cc8:	90                   	nop
80103cc9:	90                   	nop
80103cca:	90                   	nop
80103ccb:	90                   	nop
80103ccc:	90                   	nop
80103ccd:	90                   	nop
80103cce:	90                   	nop
80103ccf:	90                   	nop

80103cd0 <exit>:
{
80103cd0:	55                   	push   %ebp
80103cd1:	89 e5                	mov    %esp,%ebp
80103cd3:	57                   	push   %edi
80103cd4:	56                   	push   %esi
80103cd5:	53                   	push   %ebx
80103cd6:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103cd9:	e8 52 0b 00 00       	call   80104830 <pushcli>
  c = mycpu();
80103cde:	e8 7d fa ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103ce3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103ce9:	e8 82 0b 00 00       	call   80104870 <popcli>
  if(curproc == initproc)
80103cee:	39 35 bc c5 10 80    	cmp    %esi,0x8010c5bc
80103cf4:	8d 5e 28             	lea    0x28(%esi),%ebx
80103cf7:	8d be b8 01 00 00    	lea    0x1b8(%esi),%edi
80103cfd:	0f 84 fe 00 00 00    	je     80103e01 <exit+0x131>
80103d03:	90                   	nop
80103d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd]){
80103d08:	8b 03                	mov    (%ebx),%eax
80103d0a:	85 c0                	test   %eax,%eax
80103d0c:	74 12                	je     80103d20 <exit+0x50>
      fileclose(curproc->ofile[fd]);
80103d0e:	83 ec 0c             	sub    $0xc,%esp
80103d11:	50                   	push   %eax
80103d12:	e8 29 d1 ff ff       	call   80100e40 <fileclose>
      curproc->ofile[fd] = 0;
80103d17:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103d1d:	83 c4 10             	add    $0x10,%esp
80103d20:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80103d23:	39 fb                	cmp    %edi,%ebx
80103d25:	75 e1                	jne    80103d08 <exit+0x38>
  begin_op();
80103d27:	e8 94 ee ff ff       	call   80102bc0 <begin_op>
  iput(curproc->cwd);
80103d2c:	83 ec 0c             	sub    $0xc,%esp
80103d2f:	ff b6 b8 01 00 00    	pushl  0x1b8(%esi)
80103d35:	e8 86 da ff ff       	call   801017c0 <iput>
  end_op();
80103d3a:	e8 f1 ee ff ff       	call   80102c30 <end_op>
  curproc->cwd = 0;
80103d3f:	c7 86 b8 01 00 00 00 	movl   $0x0,0x1b8(%esi)
80103d46:	00 00 00 
  acquire(&ptable.lock);
80103d49:	c7 04 24 20 38 13 80 	movl   $0x80133820,(%esp)
80103d50:	e8 ab 0b 00 00       	call   80104900 <acquire>
  wakeup1(curproc->parent);
80103d55:	8b 56 14             	mov    0x14(%esi),%edx
80103d58:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d5b:	b8 54 38 13 80       	mov    $0x80133854,%eax
80103d60:	eb 12                	jmp    80103d74 <exit+0xa4>
80103d62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103d68:	05 d0 01 00 00       	add    $0x1d0,%eax
80103d6d:	3d 54 ac 13 80       	cmp    $0x8013ac54,%eax
80103d72:	73 1e                	jae    80103d92 <exit+0xc2>
    if(p->state == SLEEPING && p->chan == chan)
80103d74:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103d78:	75 ee                	jne    80103d68 <exit+0x98>
80103d7a:	3b 50 20             	cmp    0x20(%eax),%edx
80103d7d:	75 e9                	jne    80103d68 <exit+0x98>
      p->state = RUNNABLE;
80103d7f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d86:	05 d0 01 00 00       	add    $0x1d0,%eax
80103d8b:	3d 54 ac 13 80       	cmp    $0x8013ac54,%eax
80103d90:	72 e2                	jb     80103d74 <exit+0xa4>
      p->parent = initproc;
80103d92:	8b 0d bc c5 10 80    	mov    0x8010c5bc,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d98:	ba 54 38 13 80       	mov    $0x80133854,%edx
80103d9d:	eb 0f                	jmp    80103dae <exit+0xde>
80103d9f:	90                   	nop
80103da0:	81 c2 d0 01 00 00    	add    $0x1d0,%edx
80103da6:	81 fa 54 ac 13 80    	cmp    $0x8013ac54,%edx
80103dac:	73 3a                	jae    80103de8 <exit+0x118>
    if(p->parent == curproc){
80103dae:	39 72 14             	cmp    %esi,0x14(%edx)
80103db1:	75 ed                	jne    80103da0 <exit+0xd0>
      if(p->state == ZOMBIE)
80103db3:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103db7:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103dba:	75 e4                	jne    80103da0 <exit+0xd0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103dbc:	b8 54 38 13 80       	mov    $0x80133854,%eax
80103dc1:	eb 11                	jmp    80103dd4 <exit+0x104>
80103dc3:	90                   	nop
80103dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103dc8:	05 d0 01 00 00       	add    $0x1d0,%eax
80103dcd:	3d 54 ac 13 80       	cmp    $0x8013ac54,%eax
80103dd2:	73 cc                	jae    80103da0 <exit+0xd0>
    if(p->state == SLEEPING && p->chan == chan)
80103dd4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103dd8:	75 ee                	jne    80103dc8 <exit+0xf8>
80103dda:	3b 48 20             	cmp    0x20(%eax),%ecx
80103ddd:	75 e9                	jne    80103dc8 <exit+0xf8>
      p->state = RUNNABLE;
80103ddf:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103de6:	eb e0                	jmp    80103dc8 <exit+0xf8>
  curproc->state = ZOMBIE;
80103de8:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103def:	e8 1c fe ff ff       	call   80103c10 <sched>
  panic("zombie exit");
80103df4:	83 ec 0c             	sub    $0xc,%esp
80103df7:	68 9d 8a 10 80       	push   $0x80108a9d
80103dfc:	e8 8f c5 ff ff       	call   80100390 <panic>
    panic("init exiting");
80103e01:	83 ec 0c             	sub    $0xc,%esp
80103e04:	68 90 8a 10 80       	push   $0x80108a90
80103e09:	e8 82 c5 ff ff       	call   80100390 <panic>
80103e0e:	66 90                	xchg   %ax,%ax

80103e10 <yield>:
{
80103e10:	55                   	push   %ebp
80103e11:	89 e5                	mov    %esp,%ebp
80103e13:	53                   	push   %ebx
80103e14:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103e17:	68 20 38 13 80       	push   $0x80133820
80103e1c:	e8 df 0a 00 00       	call   80104900 <acquire>
  pushcli();
80103e21:	e8 0a 0a 00 00       	call   80104830 <pushcli>
  c = mycpu();
80103e26:	e8 35 f9 ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103e2b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e31:	e8 3a 0a 00 00       	call   80104870 <popcli>
  myproc()->state = RUNNABLE;
80103e36:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103e3d:	e8 ce fd ff ff       	call   80103c10 <sched>
  release(&ptable.lock);
80103e42:	c7 04 24 20 38 13 80 	movl   $0x80133820,(%esp)
80103e49:	e8 72 0b 00 00       	call   801049c0 <release>
}
80103e4e:	83 c4 10             	add    $0x10,%esp
80103e51:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e54:	c9                   	leave  
80103e55:	c3                   	ret    
80103e56:	8d 76 00             	lea    0x0(%esi),%esi
80103e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e60 <sleep>:
{
80103e60:	55                   	push   %ebp
80103e61:	89 e5                	mov    %esp,%ebp
80103e63:	57                   	push   %edi
80103e64:	56                   	push   %esi
80103e65:	53                   	push   %ebx
80103e66:	83 ec 0c             	sub    $0xc,%esp
80103e69:	8b 7d 08             	mov    0x8(%ebp),%edi
80103e6c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103e6f:	e8 bc 09 00 00       	call   80104830 <pushcli>
  c = mycpu();
80103e74:	e8 e7 f8 ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103e79:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e7f:	e8 ec 09 00 00       	call   80104870 <popcli>
  if(p == 0)
80103e84:	85 db                	test   %ebx,%ebx
80103e86:	0f 84 87 00 00 00    	je     80103f13 <sleep+0xb3>
  if(lk == 0)
80103e8c:	85 f6                	test   %esi,%esi
80103e8e:	74 76                	je     80103f06 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103e90:	81 fe 20 38 13 80    	cmp    $0x80133820,%esi
80103e96:	74 50                	je     80103ee8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103e98:	83 ec 0c             	sub    $0xc,%esp
80103e9b:	68 20 38 13 80       	push   $0x80133820
80103ea0:	e8 5b 0a 00 00       	call   80104900 <acquire>
    release(lk);
80103ea5:	89 34 24             	mov    %esi,(%esp)
80103ea8:	e8 13 0b 00 00       	call   801049c0 <release>
  p->chan = chan;
80103ead:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103eb0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103eb7:	e8 54 fd ff ff       	call   80103c10 <sched>
  p->chan = 0;
80103ebc:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103ec3:	c7 04 24 20 38 13 80 	movl   $0x80133820,(%esp)
80103eca:	e8 f1 0a 00 00       	call   801049c0 <release>
    acquire(lk);
80103ecf:	89 75 08             	mov    %esi,0x8(%ebp)
80103ed2:	83 c4 10             	add    $0x10,%esp
}
80103ed5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ed8:	5b                   	pop    %ebx
80103ed9:	5e                   	pop    %esi
80103eda:	5f                   	pop    %edi
80103edb:	5d                   	pop    %ebp
    acquire(lk);
80103edc:	e9 1f 0a 00 00       	jmp    80104900 <acquire>
80103ee1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80103ee8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103eeb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103ef2:	e8 19 fd ff ff       	call   80103c10 <sched>
  p->chan = 0;
80103ef7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103efe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f01:	5b                   	pop    %ebx
80103f02:	5e                   	pop    %esi
80103f03:	5f                   	pop    %edi
80103f04:	5d                   	pop    %ebp
80103f05:	c3                   	ret    
    panic("sleep without lk");
80103f06:	83 ec 0c             	sub    $0xc,%esp
80103f09:	68 af 8a 10 80       	push   $0x80108aaf
80103f0e:	e8 7d c4 ff ff       	call   80100390 <panic>
    panic("sleep");
80103f13:	83 ec 0c             	sub    $0xc,%esp
80103f16:	68 a9 8a 10 80       	push   $0x80108aa9
80103f1b:	e8 70 c4 ff ff       	call   80100390 <panic>

80103f20 <wait>:
{
80103f20:	55                   	push   %ebp
80103f21:	89 e5                	mov    %esp,%ebp
80103f23:	56                   	push   %esi
80103f24:	53                   	push   %ebx
  pushcli();
80103f25:	e8 06 09 00 00       	call   80104830 <pushcli>
  c = mycpu();
80103f2a:	e8 31 f8 ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103f2f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103f35:	e8 36 09 00 00       	call   80104870 <popcli>
  acquire(&ptable.lock);
80103f3a:	83 ec 0c             	sub    $0xc,%esp
80103f3d:	68 20 38 13 80       	push   $0x80133820
80103f42:	e8 b9 09 00 00       	call   80104900 <acquire>
80103f47:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103f4a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f4c:	bb 54 38 13 80       	mov    $0x80133854,%ebx
80103f51:	eb 13                	jmp    80103f66 <wait+0x46>
80103f53:	90                   	nop
80103f54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f58:	81 c3 d0 01 00 00    	add    $0x1d0,%ebx
80103f5e:	81 fb 54 ac 13 80    	cmp    $0x8013ac54,%ebx
80103f64:	73 1e                	jae    80103f84 <wait+0x64>
      if(p->parent != curproc)
80103f66:	39 73 14             	cmp    %esi,0x14(%ebx)
80103f69:	75 ed                	jne    80103f58 <wait+0x38>
      if(p->state == ZOMBIE){
80103f6b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103f6f:	74 37                	je     80103fa8 <wait+0x88>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f71:	81 c3 d0 01 00 00    	add    $0x1d0,%ebx
      havekids = 1;
80103f77:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f7c:	81 fb 54 ac 13 80    	cmp    $0x8013ac54,%ebx
80103f82:	72 e2                	jb     80103f66 <wait+0x46>
    if(!havekids || curproc->killed){
80103f84:	85 c0                	test   %eax,%eax
80103f86:	74 79                	je     80104001 <wait+0xe1>
80103f88:	8b 46 24             	mov    0x24(%esi),%eax
80103f8b:	85 c0                	test   %eax,%eax
80103f8d:	75 72                	jne    80104001 <wait+0xe1>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103f8f:	83 ec 08             	sub    $0x8,%esp
80103f92:	68 20 38 13 80       	push   $0x80133820
80103f97:	56                   	push   %esi
80103f98:	e8 c3 fe ff ff       	call   80103e60 <sleep>
    havekids = 0;
80103f9d:	83 c4 10             	add    $0x10,%esp
80103fa0:	eb a8                	jmp    80103f4a <wait+0x2a>
80103fa2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
80103fa8:	83 ec 0c             	sub    $0xc,%esp
80103fab:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80103fae:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103fb1:	e8 7a e3 ff ff       	call   80102330 <kfree>
        freevm(p->pgdir);
80103fb6:	5a                   	pop    %edx
80103fb7:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80103fba:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103fc1:	e8 ca 41 00 00       	call   80108190 <freevm>
        release(&ptable.lock);
80103fc6:	c7 04 24 20 38 13 80 	movl   $0x80133820,(%esp)
        p->pid = 0;
80103fcd:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103fd4:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103fdb:	c6 83 bc 01 00 00 00 	movb   $0x0,0x1bc(%ebx)
        p->killed = 0;
80103fe2:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103fe9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103ff0:	e8 cb 09 00 00       	call   801049c0 <release>
        return pid;
80103ff5:	83 c4 10             	add    $0x10,%esp
}
80103ff8:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103ffb:	89 f0                	mov    %esi,%eax
80103ffd:	5b                   	pop    %ebx
80103ffe:	5e                   	pop    %esi
80103fff:	5d                   	pop    %ebp
80104000:	c3                   	ret    
      release(&ptable.lock);
80104001:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104004:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104009:	68 20 38 13 80       	push   $0x80133820
8010400e:	e8 ad 09 00 00       	call   801049c0 <release>
      return -1;
80104013:	83 c4 10             	add    $0x10,%esp
80104016:	eb e0                	jmp    80103ff8 <wait+0xd8>
80104018:	90                   	nop
80104019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104020 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104020:	55                   	push   %ebp
80104021:	89 e5                	mov    %esp,%ebp
80104023:	53                   	push   %ebx
80104024:	83 ec 10             	sub    $0x10,%esp
80104027:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010402a:	68 20 38 13 80       	push   $0x80133820
8010402f:	e8 cc 08 00 00       	call   80104900 <acquire>
80104034:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104037:	b8 54 38 13 80       	mov    $0x80133854,%eax
8010403c:	eb 0e                	jmp    8010404c <wakeup+0x2c>
8010403e:	66 90                	xchg   %ax,%ax
80104040:	05 d0 01 00 00       	add    $0x1d0,%eax
80104045:	3d 54 ac 13 80       	cmp    $0x8013ac54,%eax
8010404a:	73 1e                	jae    8010406a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
8010404c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104050:	75 ee                	jne    80104040 <wakeup+0x20>
80104052:	3b 58 20             	cmp    0x20(%eax),%ebx
80104055:	75 e9                	jne    80104040 <wakeup+0x20>
      p->state = RUNNABLE;
80104057:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010405e:	05 d0 01 00 00       	add    $0x1d0,%eax
80104063:	3d 54 ac 13 80       	cmp    $0x8013ac54,%eax
80104068:	72 e2                	jb     8010404c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
8010406a:	c7 45 08 20 38 13 80 	movl   $0x80133820,0x8(%ebp)
}
80104071:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104074:	c9                   	leave  
  release(&ptable.lock);
80104075:	e9 46 09 00 00       	jmp    801049c0 <release>
8010407a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104080 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104080:	55                   	push   %ebp
80104081:	89 e5                	mov    %esp,%ebp
80104083:	53                   	push   %ebx
80104084:	83 ec 10             	sub    $0x10,%esp
80104087:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010408a:	68 20 38 13 80       	push   $0x80133820
8010408f:	e8 6c 08 00 00       	call   80104900 <acquire>
80104094:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104097:	b8 54 38 13 80       	mov    $0x80133854,%eax
8010409c:	eb 0e                	jmp    801040ac <kill+0x2c>
8010409e:	66 90                	xchg   %ax,%ax
801040a0:	05 d0 01 00 00       	add    $0x1d0,%eax
801040a5:	3d 54 ac 13 80       	cmp    $0x8013ac54,%eax
801040aa:	73 34                	jae    801040e0 <kill+0x60>
    if(p->pid == pid){
801040ac:	39 58 10             	cmp    %ebx,0x10(%eax)
801040af:	75 ef                	jne    801040a0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801040b1:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
801040b5:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
801040bc:	75 07                	jne    801040c5 <kill+0x45>
        p->state = RUNNABLE;
801040be:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801040c5:	83 ec 0c             	sub    $0xc,%esp
801040c8:	68 20 38 13 80       	push   $0x80133820
801040cd:	e8 ee 08 00 00       	call   801049c0 <release>
      return 0;
801040d2:	83 c4 10             	add    $0x10,%esp
801040d5:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
801040d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040da:	c9                   	leave  
801040db:	c3                   	ret    
801040dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801040e0:	83 ec 0c             	sub    $0xc,%esp
801040e3:	68 20 38 13 80       	push   $0x80133820
801040e8:	e8 d3 08 00 00       	call   801049c0 <release>
  return -1;
801040ed:	83 c4 10             	add    $0x10,%esp
801040f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801040f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040f8:	c9                   	leave  
801040f9:	c3                   	ret    
801040fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104100 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104100:	55                   	push   %ebp
80104101:	89 e5                	mov    %esp,%ebp
80104103:	57                   	push   %edi
80104104:	56                   	push   %esi
80104105:	53                   	push   %ebx
80104106:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104109:	bb 54 38 13 80       	mov    $0x80133854,%ebx
{
8010410e:	83 ec 3c             	sub    $0x3c,%esp
80104111:	eb 27                	jmp    8010413a <procdump+0x3a>
80104113:	90                   	nop
80104114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104118:	83 ec 0c             	sub    $0xc,%esp
8010411b:	68 6c 8d 10 80       	push   $0x80108d6c
80104120:	e8 3b c5 ff ff       	call   80100660 <cprintf>
80104125:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104128:	81 c3 d0 01 00 00    	add    $0x1d0,%ebx
8010412e:	81 fb 54 ac 13 80    	cmp    $0x8013ac54,%ebx
80104134:	0f 83 96 00 00 00    	jae    801041d0 <procdump+0xd0>
    if(p->state == UNUSED)
8010413a:	8b 43 0c             	mov    0xc(%ebx),%eax
8010413d:	85 c0                	test   %eax,%eax
8010413f:	74 e7                	je     80104128 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104141:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104144:	ba c0 8a 10 80       	mov    $0x80108ac0,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104149:	77 11                	ja     8010415c <procdump+0x5c>
8010414b:	8b 14 85 48 8b 10 80 	mov    -0x7fef74b8(,%eax,4),%edx
      state = "???";
80104152:	b8 c0 8a 10 80       	mov    $0x80108ac0,%eax
80104157:	85 d2                	test   %edx,%edx
80104159:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010415c:	8d 83 bc 01 00 00    	lea    0x1bc(%ebx),%eax
80104162:	50                   	push   %eax
80104163:	52                   	push   %edx
80104164:	ff 73 10             	pushl  0x10(%ebx)
80104167:	68 c4 8a 10 80       	push   $0x80108ac4
8010416c:	e8 ef c4 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
80104171:	83 c4 10             	add    $0x10,%esp
80104174:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104178:	75 9e                	jne    80104118 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
8010417a:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010417d:	83 ec 08             	sub    $0x8,%esp
80104180:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104183:	50                   	push   %eax
80104184:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104187:	8b 40 0c             	mov    0xc(%eax),%eax
8010418a:	83 c0 08             	add    $0x8,%eax
8010418d:	50                   	push   %eax
8010418e:	e8 4d 06 00 00       	call   801047e0 <getcallerpcs>
80104193:	83 c4 10             	add    $0x10,%esp
80104196:	8d 76 00             	lea    0x0(%esi),%esi
80104199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      for(i=0; i<10 && pc[i] != 0; i++)
801041a0:	8b 17                	mov    (%edi),%edx
801041a2:	85 d2                	test   %edx,%edx
801041a4:	0f 84 6e ff ff ff    	je     80104118 <procdump+0x18>
        cprintf(" %p", pc[i]);
801041aa:	83 ec 08             	sub    $0x8,%esp
801041ad:	83 c7 04             	add    $0x4,%edi
801041b0:	52                   	push   %edx
801041b1:	68 01 85 10 80       	push   $0x80108501
801041b6:	e8 a5 c4 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801041bb:	83 c4 10             	add    $0x10,%esp
801041be:	39 fe                	cmp    %edi,%esi
801041c0:	75 de                	jne    801041a0 <procdump+0xa0>
801041c2:	e9 51 ff ff ff       	jmp    80104118 <procdump+0x18>
801041c7:	89 f6                	mov    %esi,%esi
801041c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }
}
801041d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041d3:	5b                   	pop    %ebx
801041d4:	5e                   	pop    %esi
801041d5:	5f                   	pop    %edi
801041d6:	5d                   	pop    %ebp
801041d7:	c3                   	ret    
801041d8:	90                   	nop
801041d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801041e0 <running_procs>:
/*
///////////////////// MY CODE /////////////////////
*/
void
running_procs(void)
{
801041e0:	55                   	push   %ebp
801041e1:	89 e5                	mov    %esp,%ebp
801041e3:	57                   	push   %edi
801041e4:	56                   	push   %esi
801041e5:	53                   	push   %ebx
801041e6:	83 ec 1c             	sub    $0x1c,%esp
  if (cid_to_ptable!=1){
801041e9:	83 3d b8 c5 10 80 01 	cmpl   $0x1,0x8010c5b8
801041f0:	74 4a                	je     8010423c <running_procs+0x5c>
    // cprintf("Done in ps%s\n");
    acquire(&ptable.lock);
801041f2:	83 ec 0c             	sub    $0xc,%esp
801041f5:	68 20 38 13 80       	push   $0x80133820
801041fa:	e8 01 07 00 00       	call   80104900 <acquire>
801041ff:	b8 20 3a 13 80       	mov    $0x80133a20,%eax
80104204:	83 c4 10             	add    $0x10,%esp
80104207:	89 f6                	mov    %esi,%esi
80104209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      for(int p = 0; p < NPROC; p++)
      {
        struct proc *pr;
        pr = &ptable.proc[p];
        pr->cid = -1;
80104210:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
80104216:	05 d0 01 00 00       	add    $0x1d0,%eax
      for(int p = 0; p < NPROC; p++)
8010421b:	3d 20 ae 13 80       	cmp    $0x8013ae20,%eax
80104220:	75 ee                	jne    80104210 <running_procs+0x30>
      }
    release(&ptable.lock);
80104222:	83 ec 0c             	sub    $0xc,%esp
80104225:	68 20 38 13 80       	push   $0x80133820
8010422a:	e8 91 07 00 00       	call   801049c0 <release>
    cid_to_ptable = 1;
8010422f:	c7 05 b8 c5 10 80 01 	movl   $0x1,0x8010c5b8
80104236:	00 00 00 
80104239:	83 c4 10             	add    $0x10,%esp
  pushcli();
8010423c:	e8 ef 05 00 00       	call   80104830 <pushcli>
  c = mycpu();
80104241:	e8 1a f5 ff ff       	call   80103760 <mycpu>
  p = c->proc;
80104246:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010424c:	e8 1f 06 00 00       	call   80104870 <popcli>
  }
  struct proc *curproc = myproc();
  int cid = curproc->cid;
80104251:	8b 93 cc 01 00 00    	mov    0x1cc(%ebx),%edx
    release(&ptable.lock);
  }
  else{
    // cprintf("Doosre me ghusa%s\n");
    int c = 0;
    for (int i = 0; i < 100; i++) {
80104257:	31 db                	xor    %ebx,%ebx
  if (cid== -1){
80104259:	83 fa ff             	cmp    $0xffffffff,%edx
8010425c:	75 16                	jne    80104274 <running_procs+0x94>
8010425e:	e9 e7 00 00 00       	jmp    8010434a <running_procs+0x16a>
80104263:	90                   	nop
80104264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for (int i = 0; i < 100; i++) {
80104268:	83 c3 01             	add    $0x1,%ebx
8010426b:	83 fb 64             	cmp    $0x64,%ebx
8010426e:	0f 84 cf 00 00 00    	je     80104343 <running_procs+0x163>
      if (container_location[i]==1){
80104274:	83 3c 9d 00 06 13 80 	cmpl   $0x1,-0x7fecfa00(,%ebx,4)
8010427b:	01 
8010427c:	75 ea                	jne    80104268 <running_procs+0x88>
        if(container_array[i].cid==cid){
8010427e:	69 c3 bc 04 00 00    	imul   $0x4bc,%ebx,%eax
80104284:	39 90 e0 2b 11 80    	cmp    %edx,-0x7feed420(%eax)
8010428a:	75 dc                	jne    80104268 <running_procs+0x88>
          c=i;
          break;
        }
      }
    }
    acquire(&ptable.lock);
8010428c:	83 ec 0c             	sub    $0xc,%esp
8010428f:	68 20 38 13 80       	push   $0x80133820
80104294:	e8 67 06 00 00       	call   80104900 <acquire>
    for (int i = 0; i < container_array[c].number_of_process+1; i++) {
80104299:	69 d3 bc 04 00 00    	imul   $0x4bc,%ebx,%edx
8010429f:	83 c4 10             	add    $0x10,%esp
801042a2:	8b 8a e4 2b 11 80    	mov    -0x7feed41c(%edx),%ecx
801042a8:	8d 82 e0 2b 11 80    	lea    -0x7feed420(%edx),%eax
801042ae:	85 c9                	test   %ecx,%ecx
801042b0:	78 7c                	js     8010432e <running_procs+0x14e>
801042b2:	8d ba ec 2b 11 80    	lea    -0x7feed414(%edx),%edi
801042b8:	31 f6                	xor    %esi,%esi
801042ba:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801042bd:	8d 76 00             	lea    0x0(%esi),%esi
801042c0:	bb 60 38 13 80       	mov    $0x80133860,%ebx
801042c5:	eb 17                	jmp    801042de <running_procs+0xfe>
801042c7:	89 f6                	mov    %esi,%esi
801042c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801042d0:	81 c3 d0 01 00 00    	add    $0x1d0,%ebx
      for(int p = 0; p < NPROC; p++)
801042d6:	81 fb 60 ac 13 80    	cmp    $0x8013ac60,%ebx
801042dc:	74 42                	je     80104320 <running_procs+0x140>
      {
        struct proc *pr;
        pr = &ptable.proc[p];
        if(pr->pid==container_array[c].mypid[i] && pr->state != UNUSED)
801042de:	8b 43 04             	mov    0x4(%ebx),%eax
801042e1:	3b 07                	cmp    (%edi),%eax
801042e3:	75 eb                	jne    801042d0 <running_procs+0xf0>
801042e5:	8b 13                	mov    (%ebx),%edx
801042e7:	85 d2                	test   %edx,%edx
801042e9:	74 e5                	je     801042d0 <running_procs+0xf0>
        {
          cprintf("pid:%d name:%s",pr->pid,pr->name);
801042eb:	8d 8b b0 01 00 00    	lea    0x1b0(%ebx),%ecx
801042f1:	83 ec 04             	sub    $0x4,%esp
801042f4:	81 c3 d0 01 00 00    	add    $0x1d0,%ebx
801042fa:	51                   	push   %ecx
801042fb:	50                   	push   %eax
801042fc:	68 cd 8a 10 80       	push   $0x80108acd
80104301:	e8 5a c3 ff ff       	call   80100660 <cprintf>
          cprintf("\n");
80104306:	c7 04 24 6c 8d 10 80 	movl   $0x80108d6c,(%esp)
8010430d:	e8 4e c3 ff ff       	call   80100660 <cprintf>
80104312:	83 c4 10             	add    $0x10,%esp
      for(int p = 0; p < NPROC; p++)
80104315:	81 fb 60 ac 13 80    	cmp    $0x8013ac60,%ebx
8010431b:	75 c1                	jne    801042de <running_procs+0xfe>
8010431d:	8d 76 00             	lea    0x0(%esi),%esi
    for (int i = 0; i < container_array[c].number_of_process+1; i++) {
80104320:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80104323:	83 c6 01             	add    $0x1,%esi
80104326:	83 c7 04             	add    $0x4,%edi
80104329:	39 70 04             	cmp    %esi,0x4(%eax)
8010432c:	7d 92                	jge    801042c0 <running_procs+0xe0>
    release(&ptable.lock);
8010432e:	83 ec 0c             	sub    $0xc,%esp
80104331:	68 20 38 13 80       	push   $0x80133820
80104336:	e8 85 06 00 00       	call   801049c0 <release>
        }
      }
    }
    release(&ptable.lock);
  }
}
8010433b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010433e:	5b                   	pop    %ebx
8010433f:	5e                   	pop    %esi
80104340:	5f                   	pop    %edi
80104341:	5d                   	pop    %ebp
80104342:	c3                   	ret    
    int c = 0;
80104343:	31 db                	xor    %ebx,%ebx
80104345:	e9 42 ff ff ff       	jmp    8010428c <running_procs+0xac>
    acquire(&ptable.lock);
8010434a:	83 ec 0c             	sub    $0xc,%esp
8010434d:	bb 10 3a 13 80       	mov    $0x80133a10,%ebx
80104352:	be 10 ae 13 80       	mov    $0x8013ae10,%esi
80104357:	68 20 38 13 80       	push   $0x80133820
8010435c:	e8 9f 05 00 00       	call   80104900 <acquire>
80104361:	83 c4 10             	add    $0x10,%esp
80104364:	eb 14                	jmp    8010437a <running_procs+0x19a>
80104366:	8d 76 00             	lea    0x0(%esi),%esi
80104369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104370:	81 c3 d0 01 00 00    	add    $0x1d0,%ebx
      for(int p = 0; p < NPROC; p++)
80104376:	39 de                	cmp    %ebx,%esi
80104378:	74 b4                	je     8010432e <running_procs+0x14e>
        if(pr->state != UNUSED)
8010437a:	8b bb 50 fe ff ff    	mov    -0x1b0(%ebx),%edi
80104380:	85 ff                	test   %edi,%edi
80104382:	74 ec                	je     80104370 <running_procs+0x190>
          cprintf("pid:%d name:%s",pr->pid,pr->name);
80104384:	83 ec 04             	sub    $0x4,%esp
80104387:	53                   	push   %ebx
80104388:	ff b3 54 fe ff ff    	pushl  -0x1ac(%ebx)
8010438e:	68 cd 8a 10 80       	push   $0x80108acd
80104393:	e8 c8 c2 ff ff       	call   80100660 <cprintf>
          cprintf("\n");
80104398:	c7 04 24 6c 8d 10 80 	movl   $0x80108d6c,(%esp)
8010439f:	e8 bc c2 ff ff       	call   80100660 <cprintf>
801043a4:	83 c4 10             	add    $0x10,%esp
801043a7:	eb c7                	jmp    80104370 <running_procs+0x190>
801043a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801043b0 <join_cont>:


int
join_cont(int cid){
801043b0:	55                   	push   %ebp
801043b1:	89 e5                	mov    %esp,%ebp
801043b3:	57                   	push   %edi
801043b4:	56                   	push   %esi
801043b5:	53                   	push   %ebx
801043b6:	83 ec 1c             	sub    $0x1c,%esp
  // cprintf("cid_to_ptable is:%d\n",cid_to_ptable);
  if (cid_to_ptable!=1){
801043b9:	83 3d b8 c5 10 80 01 	cmpl   $0x1,0x8010c5b8
join_cont(int cid){
801043c0:	8b 55 08             	mov    0x8(%ebp),%edx
  if (cid_to_ptable!=1){
801043c3:	0f 85 87 00 00 00    	jne    80104450 <join_cont+0xa0>
        pr->cid = -1;
      }
    release(&ptable.lock);
    cid_to_ptable = 1;
  }
  for (int i = 0; i < 100; i++) {
801043c9:	31 db                	xor    %ebx,%ebx
801043cb:	eb 0f                	jmp    801043dc <join_cont+0x2c>
801043cd:	8d 76 00             	lea    0x0(%esi),%esi
801043d0:	83 c3 01             	add    $0x1,%ebx
801043d3:	83 fb 64             	cmp    $0x64,%ebx
801043d6:	0f 84 cb 00 00 00    	je     801044a7 <join_cont+0xf7>
    if (container_location[i]==1) {
801043dc:	8b 34 9d 00 06 13 80 	mov    -0x7fecfa00(,%ebx,4),%esi
801043e3:	83 fe 01             	cmp    $0x1,%esi
801043e6:	75 e8                	jne    801043d0 <join_cont+0x20>
      if(container_array[i].cid==cid){
801043e8:	69 fb bc 04 00 00    	imul   $0x4bc,%ebx,%edi
801043ee:	39 97 e0 2b 11 80    	cmp    %edx,-0x7feed420(%edi)
801043f4:	75 da                	jne    801043d0 <join_cont+0x20>
801043f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
  pushcli();
801043f9:	e8 32 04 00 00       	call   80104830 <pushcli>
  c = mycpu();
801043fe:	e8 5d f3 ff ff       	call   80103760 <mycpu>
  p = c->proc;
80104403:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
        struct proc *curproc = myproc();
        container_array[i].mypid[container_array[i].number_of_process]=curproc->pid;
80104409:	69 db 2f 01 00 00    	imul   $0x12f,%ebx,%ebx
  p = c->proc;
8010440f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  popcli();
80104412:	e8 59 04 00 00       	call   80104870 <popcli>
        container_array[i].mypid[container_array[i].number_of_process]=curproc->pid;
80104417:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010441a:	03 9f e4 2b 11 80    	add    -0x7feed41c(%edi),%ebx
80104420:	81 c7 e0 2b 11 80    	add    $0x80112be0,%edi
        curproc->cid = cid;
80104426:	8b 55 e0             	mov    -0x20(%ebp),%edx
        container_array[i].mypid[container_array[i].number_of_process]=curproc->pid;
80104429:	8b 48 10             	mov    0x10(%eax),%ecx
8010442c:	89 0c 9d ec 2b 11 80 	mov    %ecx,-0x7feed414(,%ebx,4)
        curproc->cid = cid;
80104433:	89 90 cc 01 00 00    	mov    %edx,0x1cc(%eax)
        return 1;
      }
    }
  }
  return -1;
}
80104439:	89 f0                	mov    %esi,%eax
        container_array[i].number_of_process++;
8010443b:	83 47 04 01          	addl   $0x1,0x4(%edi)
}
8010443f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104442:	5b                   	pop    %ebx
80104443:	5e                   	pop    %esi
80104444:	5f                   	pop    %edi
80104445:	5d                   	pop    %ebp
80104446:	c3                   	ret    
80104447:	89 f6                	mov    %esi,%esi
80104449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    acquire(&ptable.lock);
80104450:	83 ec 0c             	sub    $0xc,%esp
80104453:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80104456:	68 20 38 13 80       	push   $0x80133820
8010445b:	e8 a0 04 00 00       	call   80104900 <acquire>
80104460:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104463:	b8 20 3a 13 80       	mov    $0x80133a20,%eax
80104468:	83 c4 10             	add    $0x10,%esp
8010446b:	90                   	nop
8010446c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        pr->cid = -1;
80104470:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
80104476:	05 d0 01 00 00       	add    $0x1d0,%eax
      for(int p = 0; p < NPROC; p++)
8010447b:	3d 20 ae 13 80       	cmp    $0x8013ae20,%eax
80104480:	75 ee                	jne    80104470 <join_cont+0xc0>
    release(&ptable.lock);
80104482:	83 ec 0c             	sub    $0xc,%esp
80104485:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80104488:	68 20 38 13 80       	push   $0x80133820
8010448d:	e8 2e 05 00 00       	call   801049c0 <release>
    cid_to_ptable = 1;
80104492:	c7 05 b8 c5 10 80 01 	movl   $0x1,0x8010c5b8
80104499:	00 00 00 
8010449c:	83 c4 10             	add    $0x10,%esp
8010449f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801044a2:	e9 22 ff ff ff       	jmp    801043c9 <join_cont+0x19>
}
801044a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801044aa:	be ff ff ff ff       	mov    $0xffffffff,%esi
}
801044af:	89 f0                	mov    %esi,%eax
801044b1:	5b                   	pop    %ebx
801044b2:	5e                   	pop    %esi
801044b3:	5f                   	pop    %edi
801044b4:	5d                   	pop    %ebp
801044b5:	c3                   	ret    
801044b6:	8d 76 00             	lea    0x0(%esi),%esi
801044b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801044c0 <TransferMessage>:



void
TransferMessage(int msg_no, char* msg)
{
801044c0:	55                   	push   %ebp
801044c1:	89 e5                	mov    %esp,%ebp
801044c3:	83 ec 0c             	sub    $0xc,%esp
  int len = 8;
  copyFromSystemSpace(msg,messageBuffers[msg_no],len);          // message size is 8
801044c6:	8b 45 08             	mov    0x8(%ebp),%eax
801044c9:	6a 08                	push   $0x8
801044cb:	ff 34 85 e0 d5 10 80 	pushl  -0x7fef2a20(,%eax,4)
801044d2:	ff 75 0c             	pushl  0xc(%ebp)
801044d5:	e8 36 0c 00 00       	call   80105110 <copyFromSystemSpace>
  // freeMessageBuffer(msg_no);
}
801044da:	83 c4 10             	add    $0x10,%esp
801044dd:	c9                   	leave  
801044de:	c3                   	ret    
801044df:	90                   	nop

801044e0 <sys_send>:


// sys call for send message//
int
sys_send(int sender_pid, int rec_pid, void *msg)
{
801044e0:	55                   	push   %ebp
801044e1:	89 e5                	mov    %esp,%ebp
801044e3:	53                   	push   %ebx
801044e4:	83 ec 24             	sub    $0x24,%esp
  if(isTraceOn==1)
801044e7:	83 3d 18 27 11 80 01 	cmpl   $0x1,0x80112718
801044ee:	75 07                	jne    801044f7 <sys_send+0x17>
  {num_calls[SYS_send] ++;}
801044f0:	83 05 b4 2a 11 80 01 	addl   $0x1,0x80112ab4

  argint(0,&sender_pid);
801044f7:	8d 45 08             	lea    0x8(%ebp),%eax
801044fa:	83 ec 08             	sub    $0x8,%esp
801044fd:	50                   	push   %eax
801044fe:	6a 00                	push   $0x0
80104500:	e8 0b 08 00 00       	call   80104d10 <argint>
  argint(1,&rec_pid);
80104505:	5a                   	pop    %edx
80104506:	8d 45 0c             	lea    0xc(%ebp),%eax
80104509:	59                   	pop    %ecx
8010450a:	50                   	push   %eax
8010450b:	6a 01                	push   $0x1
8010450d:	e8 fe 07 00 00       	call   80104d10 <argint>
  char * str;
  argstr(2,&str);
80104512:	5b                   	pop    %ebx
80104513:	58                   	pop    %eax
80104514:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104517:	50                   	push   %eax
80104518:	6a 02                	push   $0x2
8010451a:	e8 a1 08 00 00       	call   80104dc0 <argstr>
  // int len = 8;       //fixed for now
  int msg_no = getMessageBuffer();
8010451f:	e8 1c 0c 00 00       	call   80105140 <getMessageBuffer>
  if(msg_no ==EndOfFreeList)
80104524:	83 c4 10             	add    $0x10,%esp
80104527:	39 05 5c 8c 10 80    	cmp    %eax,0x80108c5c
  int msg_no = getMessageBuffer();
8010452d:	89 c3                	mov    %eax,%ebx
  if(msg_no ==EndOfFreeList)
8010452f:	74 7f                	je     801045b0 <sys_send+0xd0>
  cprintf("message buffers consumed\n");

  messageBuffers[msg_no] = (char *)kalloc();
80104531:	e8 aa df ff ff       	call   801024e0 <kalloc>
  safestrcpy(messageBuffers[msg_no],str,8);
80104536:	83 ec 04             	sub    $0x4,%esp
  messageBuffers[msg_no] = (char *)kalloc();
80104539:	89 04 9d e0 d5 10 80 	mov    %eax,-0x7fef2a20(,%ebx,4)
  safestrcpy(messageBuffers[msg_no],str,8);
80104540:	6a 08                	push   $0x8
80104542:	ff 75 f4             	pushl  -0xc(%ebp)
80104545:	50                   	push   %eax
80104546:	e8 a5 06 00 00       	call   80104bf0 <safestrcpy>

  if( isWaitEmpty(wait_queue[rec_pid]) == 0 )          // some proc is waiting
8010454b:	58                   	pop    %eax
8010454c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010454f:	ff 34 85 20 27 11 80 	pushl  -0x7feed8e0(,%eax,4)
80104556:	e8 25 0a 00 00       	call   80104f80 <isWaitEmpty>
8010455b:	83 c4 10             	add    $0x10,%esp
8010455e:	85 c0                	test   %eax,%eax
80104560:	75 2a                	jne    8010458c <sys_send+0xac>
  {                                                    // amke that process runnable so that scheduler can run it
    int pid = (waitdequeue(wait_queue[rec_pid])).pid;  // and it can recieve.
80104562:	8b 55 0c             	mov    0xc(%ebp),%edx
80104565:	8d 45 e0             	lea    -0x20(%ebp),%eax
80104568:	83 ec 08             	sub    $0x8,%esp
8010456b:	ff 34 95 20 27 11 80 	pushl  -0x7feed8e0(,%edx,4)
80104572:	50                   	push   %eax
80104573:	e8 68 0a 00 00       	call   80104fe0 <waitdequeue>
    ptable.proc[pid].state = RUNNABLE;
80104578:	69 45 e0 d0 01 00 00 	imul   $0x1d0,-0x20(%ebp),%eax
8010457f:	83 c4 0c             	add    $0xc,%esp
80104582:	c7 80 60 38 13 80 03 	movl   $0x3,-0x7fecc7a0(%eax)
80104589:	00 00 00 
  }

  enqueue(int_message_queue[rec_pid],msg_no);
8010458c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010458f:	83 ec 08             	sub    $0x8,%esp
80104592:	53                   	push   %ebx
80104593:	ff 34 85 e0 2a 11 80 	pushl  -0x7feed520(,%eax,4)
8010459a:	e8 c1 0a 00 00       	call   80105060 <enqueue>

  return 1;
}
8010459f:	b8 01 00 00 00       	mov    $0x1,%eax
801045a4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801045a7:	c9                   	leave  
801045a8:	c3                   	ret    
801045a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  cprintf("message buffers consumed\n");
801045b0:	83 ec 0c             	sub    $0xc,%esp
801045b3:	68 dc 8a 10 80       	push   $0x80108adc
801045b8:	e8 a3 c0 ff ff       	call   80100660 <cprintf>
801045bd:	83 c4 10             	add    $0x10,%esp
801045c0:	e9 6c ff ff ff       	jmp    80104531 <sys_send+0x51>
801045c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045d0 <sys_recv>:


int
sys_recv(void *msg)
{
801045d0:	55                   	push   %ebp
801045d1:	89 e5                	mov    %esp,%ebp
801045d3:	53                   	push   %ebx
801045d4:	83 ec 14             	sub    $0x14,%esp

  if(isTraceOn==1)
801045d7:	83 3d 18 27 11 80 01 	cmpl   $0x1,0x80112718
801045de:	75 07                	jne    801045e7 <sys_recv+0x17>
  {num_calls[SYS_recv] ++;}
801045e0:	83 05 b8 2a 11 80 01 	addl   $0x1,0x80112ab8

  char* str;
  argstr(0,&str);
801045e7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801045ea:	83 ec 08             	sub    $0x8,%esp
801045ed:	50                   	push   %eax
801045ee:	6a 00                	push   $0x0
801045f0:	e8 cb 07 00 00       	call   80104dc0 <argstr>
  pushcli();
801045f5:	e8 36 02 00 00       	call   80104830 <pushcli>
  c = mycpu();
801045fa:	e8 61 f1 ff ff       	call   80103760 <mycpu>
  p = c->proc;
801045ff:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104605:	e8 66 02 00 00       	call   80104870 <popcli>
  struct proc *curproc = myproc();
  if(isEmpty(int_message_queue[curproc->pid]) == 1)
8010460a:	58                   	pop    %eax
8010460b:	8b 43 10             	mov    0x10(%ebx),%eax
8010460e:	ff 34 85 e0 2a 11 80 	pushl  -0x7feed520(,%eax,4)
80104615:	e8 26 0a 00 00       	call   80105040 <isEmpty>
8010461a:	83 c4 10             	add    $0x10,%esp
8010461d:	83 f8 01             	cmp    $0x1,%eax
80104620:	74 36                	je     80104658 <sys_recv+0x88>
    item.buffer = str;                            // block the current item
    waitenqueue(wait_queue[curproc->pid],item);   // and put in wait queue.
    sched();                                     // call the scheduler (non-blocking)
  }
  else{
  int msg_no= dequeue(int_message_queue[curproc->pid]);
80104622:	8b 43 10             	mov    0x10(%ebx),%eax
80104625:	83 ec 0c             	sub    $0xc,%esp
80104628:	ff 34 85 e0 2a 11 80 	pushl  -0x7feed520(,%eax,4)
8010462f:	e8 5c 0a 00 00       	call   80105090 <dequeue>
  safestrcpy(str,messageBuffers[msg_no],8);            // if there is message in the message queue then recieve it
80104634:	83 c4 0c             	add    $0xc,%esp
80104637:	6a 08                	push   $0x8
80104639:	ff 34 85 e0 d5 10 80 	pushl  -0x7fef2a20(,%eax,4)
80104640:	ff 75 f4             	pushl  -0xc(%ebp)
80104643:	e8 a8 05 00 00       	call   80104bf0 <safestrcpy>
80104648:	83 c4 10             	add    $0x10,%esp
  }
  return 1;
}
8010464b:	b8 01 00 00 00       	mov    $0x1,%eax
80104650:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104653:	c9                   	leave  
80104654:	c3                   	ret    
80104655:	8d 76 00             	lea    0x0(%esi),%esi
    item.pid = curproc->pid;
80104658:	8b 4b 10             	mov    0x10(%ebx),%ecx
    item.buffer = str;                            // block the current item
8010465b:	8b 55 f4             	mov    -0xc(%ebp),%edx
    waitenqueue(wait_queue[curproc->pid],item);   // and put in wait queue.
8010465e:	83 ec 04             	sub    $0x4,%esp
    curproc->state = SLEEPING;                    // block the current process
80104661:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
    waitenqueue(wait_queue[curproc->pid],item);   // and put in wait queue.
80104668:	52                   	push   %edx
80104669:	51                   	push   %ecx
8010466a:	ff 34 8d 20 27 11 80 	pushl  -0x7feed8e0(,%ecx,4)
80104671:	e8 2a 09 00 00       	call   80104fa0 <waitenqueue>
    sched();                                     // call the scheduler (non-blocking)
80104676:	e8 95 f5 ff ff       	call   80103c10 <sched>
8010467b:	83 c4 10             	add    $0x10,%esp
}
8010467e:	b8 01 00 00 00       	mov    $0x1,%eax
80104683:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104686:	c9                   	leave  
80104687:	c3                   	ret    
80104688:	66 90                	xchg   %ax,%ax
8010468a:	66 90                	xchg   %ax,%ax
8010468c:	66 90                	xchg   %ax,%ax
8010468e:	66 90                	xchg   %ax,%ax

80104690 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104690:	55                   	push   %ebp
80104691:	89 e5                	mov    %esp,%ebp
80104693:	53                   	push   %ebx
80104694:	83 ec 0c             	sub    $0xc,%esp
80104697:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010469a:	68 60 8b 10 80       	push   $0x80108b60
8010469f:	8d 43 04             	lea    0x4(%ebx),%eax
801046a2:	50                   	push   %eax
801046a3:	e8 18 01 00 00       	call   801047c0 <initlock>
  lk->name = name;
801046a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801046ab:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801046b1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801046b4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801046bb:	89 43 38             	mov    %eax,0x38(%ebx)
}
801046be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801046c1:	c9                   	leave  
801046c2:	c3                   	ret    
801046c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801046c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046d0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801046d0:	55                   	push   %ebp
801046d1:	89 e5                	mov    %esp,%ebp
801046d3:	56                   	push   %esi
801046d4:	53                   	push   %ebx
801046d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801046d8:	83 ec 0c             	sub    $0xc,%esp
801046db:	8d 73 04             	lea    0x4(%ebx),%esi
801046de:	56                   	push   %esi
801046df:	e8 1c 02 00 00       	call   80104900 <acquire>
  while (lk->locked) {
801046e4:	8b 13                	mov    (%ebx),%edx
801046e6:	83 c4 10             	add    $0x10,%esp
801046e9:	85 d2                	test   %edx,%edx
801046eb:	74 16                	je     80104703 <acquiresleep+0x33>
801046ed:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801046f0:	83 ec 08             	sub    $0x8,%esp
801046f3:	56                   	push   %esi
801046f4:	53                   	push   %ebx
801046f5:	e8 66 f7 ff ff       	call   80103e60 <sleep>
  while (lk->locked) {
801046fa:	8b 03                	mov    (%ebx),%eax
801046fc:	83 c4 10             	add    $0x10,%esp
801046ff:	85 c0                	test   %eax,%eax
80104701:	75 ed                	jne    801046f0 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104703:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104709:	e8 f2 f0 ff ff       	call   80103800 <myproc>
8010470e:	8b 40 10             	mov    0x10(%eax),%eax
80104711:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104714:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104717:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010471a:	5b                   	pop    %ebx
8010471b:	5e                   	pop    %esi
8010471c:	5d                   	pop    %ebp
  release(&lk->lk);
8010471d:	e9 9e 02 00 00       	jmp    801049c0 <release>
80104722:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104730 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104730:	55                   	push   %ebp
80104731:	89 e5                	mov    %esp,%ebp
80104733:	56                   	push   %esi
80104734:	53                   	push   %ebx
80104735:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104738:	83 ec 0c             	sub    $0xc,%esp
8010473b:	8d 73 04             	lea    0x4(%ebx),%esi
8010473e:	56                   	push   %esi
8010473f:	e8 bc 01 00 00       	call   80104900 <acquire>
  lk->locked = 0;
80104744:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010474a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104751:	89 1c 24             	mov    %ebx,(%esp)
80104754:	e8 c7 f8 ff ff       	call   80104020 <wakeup>
  release(&lk->lk);
80104759:	89 75 08             	mov    %esi,0x8(%ebp)
8010475c:	83 c4 10             	add    $0x10,%esp
}
8010475f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104762:	5b                   	pop    %ebx
80104763:	5e                   	pop    %esi
80104764:	5d                   	pop    %ebp
  release(&lk->lk);
80104765:	e9 56 02 00 00       	jmp    801049c0 <release>
8010476a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104770 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104770:	55                   	push   %ebp
80104771:	89 e5                	mov    %esp,%ebp
80104773:	57                   	push   %edi
80104774:	56                   	push   %esi
80104775:	53                   	push   %ebx
80104776:	31 ff                	xor    %edi,%edi
80104778:	83 ec 18             	sub    $0x18,%esp
8010477b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010477e:	8d 73 04             	lea    0x4(%ebx),%esi
80104781:	56                   	push   %esi
80104782:	e8 79 01 00 00       	call   80104900 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104787:	8b 03                	mov    (%ebx),%eax
80104789:	83 c4 10             	add    $0x10,%esp
8010478c:	85 c0                	test   %eax,%eax
8010478e:	74 13                	je     801047a3 <holdingsleep+0x33>
80104790:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104793:	e8 68 f0 ff ff       	call   80103800 <myproc>
80104798:	39 58 10             	cmp    %ebx,0x10(%eax)
8010479b:	0f 94 c0             	sete   %al
8010479e:	0f b6 c0             	movzbl %al,%eax
801047a1:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
801047a3:	83 ec 0c             	sub    $0xc,%esp
801047a6:	56                   	push   %esi
801047a7:	e8 14 02 00 00       	call   801049c0 <release>
  return r;
}
801047ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
801047af:	89 f8                	mov    %edi,%eax
801047b1:	5b                   	pop    %ebx
801047b2:	5e                   	pop    %esi
801047b3:	5f                   	pop    %edi
801047b4:	5d                   	pop    %ebp
801047b5:	c3                   	ret    
801047b6:	66 90                	xchg   %ax,%ax
801047b8:	66 90                	xchg   %ax,%ax
801047ba:	66 90                	xchg   %ax,%ax
801047bc:	66 90                	xchg   %ax,%ax
801047be:	66 90                	xchg   %ax,%ax

801047c0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801047c0:	55                   	push   %ebp
801047c1:	89 e5                	mov    %esp,%ebp
801047c3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801047c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801047c9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801047cf:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801047d2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801047d9:	5d                   	pop    %ebp
801047da:	c3                   	ret    
801047db:	90                   	nop
801047dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801047e0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801047e0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801047e1:	31 d2                	xor    %edx,%edx
{
801047e3:	89 e5                	mov    %esp,%ebp
801047e5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801047e6:	8b 45 08             	mov    0x8(%ebp),%eax
{
801047e9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
801047ec:	83 e8 08             	sub    $0x8,%eax
801047ef:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801047f0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801047f6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801047fc:	77 1a                	ja     80104818 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
801047fe:	8b 58 04             	mov    0x4(%eax),%ebx
80104801:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104804:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104807:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104809:	83 fa 0a             	cmp    $0xa,%edx
8010480c:	75 e2                	jne    801047f0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010480e:	5b                   	pop    %ebx
8010480f:	5d                   	pop    %ebp
80104810:	c3                   	ret    
80104811:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104818:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010481b:	83 c1 28             	add    $0x28,%ecx
8010481e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104820:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104826:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104829:	39 c1                	cmp    %eax,%ecx
8010482b:	75 f3                	jne    80104820 <getcallerpcs+0x40>
}
8010482d:	5b                   	pop    %ebx
8010482e:	5d                   	pop    %ebp
8010482f:	c3                   	ret    

80104830 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104830:	55                   	push   %ebp
80104831:	89 e5                	mov    %esp,%ebp
80104833:	53                   	push   %ebx
80104834:	83 ec 04             	sub    $0x4,%esp
80104837:	9c                   	pushf  
80104838:	5b                   	pop    %ebx
  asm volatile("cli");
80104839:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010483a:	e8 21 ef ff ff       	call   80103760 <mycpu>
8010483f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104845:	85 c0                	test   %eax,%eax
80104847:	75 11                	jne    8010485a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104849:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010484f:	e8 0c ef ff ff       	call   80103760 <mycpu>
80104854:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010485a:	e8 01 ef ff ff       	call   80103760 <mycpu>
8010485f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104866:	83 c4 04             	add    $0x4,%esp
80104869:	5b                   	pop    %ebx
8010486a:	5d                   	pop    %ebp
8010486b:	c3                   	ret    
8010486c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104870 <popcli>:

void
popcli(void)
{
80104870:	55                   	push   %ebp
80104871:	89 e5                	mov    %esp,%ebp
80104873:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104876:	9c                   	pushf  
80104877:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104878:	f6 c4 02             	test   $0x2,%ah
8010487b:	75 35                	jne    801048b2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010487d:	e8 de ee ff ff       	call   80103760 <mycpu>
80104882:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104889:	78 34                	js     801048bf <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010488b:	e8 d0 ee ff ff       	call   80103760 <mycpu>
80104890:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104896:	85 d2                	test   %edx,%edx
80104898:	74 06                	je     801048a0 <popcli+0x30>
    sti();
}
8010489a:	c9                   	leave  
8010489b:	c3                   	ret    
8010489c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801048a0:	e8 bb ee ff ff       	call   80103760 <mycpu>
801048a5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801048ab:	85 c0                	test   %eax,%eax
801048ad:	74 eb                	je     8010489a <popcli+0x2a>
  asm volatile("sti");
801048af:	fb                   	sti    
}
801048b0:	c9                   	leave  
801048b1:	c3                   	ret    
    panic("popcli - interruptible");
801048b2:	83 ec 0c             	sub    $0xc,%esp
801048b5:	68 6b 8b 10 80       	push   $0x80108b6b
801048ba:	e8 d1 ba ff ff       	call   80100390 <panic>
    panic("popcli");
801048bf:	83 ec 0c             	sub    $0xc,%esp
801048c2:	68 82 8b 10 80       	push   $0x80108b82
801048c7:	e8 c4 ba ff ff       	call   80100390 <panic>
801048cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801048d0 <holding>:
{
801048d0:	55                   	push   %ebp
801048d1:	89 e5                	mov    %esp,%ebp
801048d3:	56                   	push   %esi
801048d4:	53                   	push   %ebx
801048d5:	8b 75 08             	mov    0x8(%ebp),%esi
801048d8:	31 db                	xor    %ebx,%ebx
  pushcli();
801048da:	e8 51 ff ff ff       	call   80104830 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801048df:	8b 06                	mov    (%esi),%eax
801048e1:	85 c0                	test   %eax,%eax
801048e3:	74 10                	je     801048f5 <holding+0x25>
801048e5:	8b 5e 08             	mov    0x8(%esi),%ebx
801048e8:	e8 73 ee ff ff       	call   80103760 <mycpu>
801048ed:	39 c3                	cmp    %eax,%ebx
801048ef:	0f 94 c3             	sete   %bl
801048f2:	0f b6 db             	movzbl %bl,%ebx
  popcli();
801048f5:	e8 76 ff ff ff       	call   80104870 <popcli>
}
801048fa:	89 d8                	mov    %ebx,%eax
801048fc:	5b                   	pop    %ebx
801048fd:	5e                   	pop    %esi
801048fe:	5d                   	pop    %ebp
801048ff:	c3                   	ret    

80104900 <acquire>:
{
80104900:	55                   	push   %ebp
80104901:	89 e5                	mov    %esp,%ebp
80104903:	56                   	push   %esi
80104904:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104905:	e8 26 ff ff ff       	call   80104830 <pushcli>
  if(holding(lk))
8010490a:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010490d:	83 ec 0c             	sub    $0xc,%esp
80104910:	53                   	push   %ebx
80104911:	e8 ba ff ff ff       	call   801048d0 <holding>
80104916:	83 c4 10             	add    $0x10,%esp
80104919:	85 c0                	test   %eax,%eax
8010491b:	0f 85 83 00 00 00    	jne    801049a4 <acquire+0xa4>
80104921:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104923:	ba 01 00 00 00       	mov    $0x1,%edx
80104928:	eb 09                	jmp    80104933 <acquire+0x33>
8010492a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104930:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104933:	89 d0                	mov    %edx,%eax
80104935:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104938:	85 c0                	test   %eax,%eax
8010493a:	75 f4                	jne    80104930 <acquire+0x30>
  __sync_synchronize();
8010493c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104941:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104944:	e8 17 ee ff ff       	call   80103760 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104949:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
8010494c:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
8010494f:	89 e8                	mov    %ebp,%eax
80104951:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104958:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
8010495e:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104964:	77 1a                	ja     80104980 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104966:	8b 48 04             	mov    0x4(%eax),%ecx
80104969:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
8010496c:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
8010496f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104971:	83 fe 0a             	cmp    $0xa,%esi
80104974:	75 e2                	jne    80104958 <acquire+0x58>
}
80104976:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104979:	5b                   	pop    %ebx
8010497a:	5e                   	pop    %esi
8010497b:	5d                   	pop    %ebp
8010497c:	c3                   	ret    
8010497d:	8d 76 00             	lea    0x0(%esi),%esi
80104980:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104983:	83 c2 28             	add    $0x28,%edx
80104986:	8d 76 00             	lea    0x0(%esi),%esi
80104989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104990:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104996:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104999:	39 d0                	cmp    %edx,%eax
8010499b:	75 f3                	jne    80104990 <acquire+0x90>
}
8010499d:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049a0:	5b                   	pop    %ebx
801049a1:	5e                   	pop    %esi
801049a2:	5d                   	pop    %ebp
801049a3:	c3                   	ret    
    panic("acquire");
801049a4:	83 ec 0c             	sub    $0xc,%esp
801049a7:	68 89 8b 10 80       	push   $0x80108b89
801049ac:	e8 df b9 ff ff       	call   80100390 <panic>
801049b1:	eb 0d                	jmp    801049c0 <release>
801049b3:	90                   	nop
801049b4:	90                   	nop
801049b5:	90                   	nop
801049b6:	90                   	nop
801049b7:	90                   	nop
801049b8:	90                   	nop
801049b9:	90                   	nop
801049ba:	90                   	nop
801049bb:	90                   	nop
801049bc:	90                   	nop
801049bd:	90                   	nop
801049be:	90                   	nop
801049bf:	90                   	nop

801049c0 <release>:
{
801049c0:	55                   	push   %ebp
801049c1:	89 e5                	mov    %esp,%ebp
801049c3:	53                   	push   %ebx
801049c4:	83 ec 10             	sub    $0x10,%esp
801049c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
801049ca:	53                   	push   %ebx
801049cb:	e8 00 ff ff ff       	call   801048d0 <holding>
801049d0:	83 c4 10             	add    $0x10,%esp
801049d3:	85 c0                	test   %eax,%eax
801049d5:	74 22                	je     801049f9 <release+0x39>
  lk->pcs[0] = 0;
801049d7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801049de:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
801049e5:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801049ea:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
801049f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049f3:	c9                   	leave  
  popcli();
801049f4:	e9 77 fe ff ff       	jmp    80104870 <popcli>
    panic("release");
801049f9:	83 ec 0c             	sub    $0xc,%esp
801049fc:	68 91 8b 10 80       	push   $0x80108b91
80104a01:	e8 8a b9 ff ff       	call   80100390 <panic>
80104a06:	66 90                	xchg   %ax,%ax
80104a08:	66 90                	xchg   %ax,%ax
80104a0a:	66 90                	xchg   %ax,%ax
80104a0c:	66 90                	xchg   %ax,%ax
80104a0e:	66 90                	xchg   %ax,%ax

80104a10 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104a10:	55                   	push   %ebp
80104a11:	89 e5                	mov    %esp,%ebp
80104a13:	57                   	push   %edi
80104a14:	53                   	push   %ebx
80104a15:	8b 55 08             	mov    0x8(%ebp),%edx
80104a18:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104a1b:	f6 c2 03             	test   $0x3,%dl
80104a1e:	75 05                	jne    80104a25 <memset+0x15>
80104a20:	f6 c1 03             	test   $0x3,%cl
80104a23:	74 13                	je     80104a38 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104a25:	89 d7                	mov    %edx,%edi
80104a27:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a2a:	fc                   	cld    
80104a2b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104a2d:	5b                   	pop    %ebx
80104a2e:	89 d0                	mov    %edx,%eax
80104a30:	5f                   	pop    %edi
80104a31:	5d                   	pop    %ebp
80104a32:	c3                   	ret    
80104a33:	90                   	nop
80104a34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104a38:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104a3c:	c1 e9 02             	shr    $0x2,%ecx
80104a3f:	89 f8                	mov    %edi,%eax
80104a41:	89 fb                	mov    %edi,%ebx
80104a43:	c1 e0 18             	shl    $0x18,%eax
80104a46:	c1 e3 10             	shl    $0x10,%ebx
80104a49:	09 d8                	or     %ebx,%eax
80104a4b:	09 f8                	or     %edi,%eax
80104a4d:	c1 e7 08             	shl    $0x8,%edi
80104a50:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104a52:	89 d7                	mov    %edx,%edi
80104a54:	fc                   	cld    
80104a55:	f3 ab                	rep stos %eax,%es:(%edi)
}
80104a57:	5b                   	pop    %ebx
80104a58:	89 d0                	mov    %edx,%eax
80104a5a:	5f                   	pop    %edi
80104a5b:	5d                   	pop    %ebp
80104a5c:	c3                   	ret    
80104a5d:	8d 76 00             	lea    0x0(%esi),%esi

80104a60 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104a60:	55                   	push   %ebp
80104a61:	89 e5                	mov    %esp,%ebp
80104a63:	57                   	push   %edi
80104a64:	56                   	push   %esi
80104a65:	53                   	push   %ebx
80104a66:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104a69:	8b 75 08             	mov    0x8(%ebp),%esi
80104a6c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104a6f:	85 db                	test   %ebx,%ebx
80104a71:	74 29                	je     80104a9c <memcmp+0x3c>
    if(*s1 != *s2)
80104a73:	0f b6 16             	movzbl (%esi),%edx
80104a76:	0f b6 0f             	movzbl (%edi),%ecx
80104a79:	38 d1                	cmp    %dl,%cl
80104a7b:	75 2b                	jne    80104aa8 <memcmp+0x48>
80104a7d:	b8 01 00 00 00       	mov    $0x1,%eax
80104a82:	eb 14                	jmp    80104a98 <memcmp+0x38>
80104a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a88:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80104a8c:	83 c0 01             	add    $0x1,%eax
80104a8f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104a94:	38 ca                	cmp    %cl,%dl
80104a96:	75 10                	jne    80104aa8 <memcmp+0x48>
  while(n-- > 0){
80104a98:	39 d8                	cmp    %ebx,%eax
80104a9a:	75 ec                	jne    80104a88 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80104a9c:	5b                   	pop    %ebx
  return 0;
80104a9d:	31 c0                	xor    %eax,%eax
}
80104a9f:	5e                   	pop    %esi
80104aa0:	5f                   	pop    %edi
80104aa1:	5d                   	pop    %ebp
80104aa2:	c3                   	ret    
80104aa3:	90                   	nop
80104aa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104aa8:	0f b6 c2             	movzbl %dl,%eax
}
80104aab:	5b                   	pop    %ebx
      return *s1 - *s2;
80104aac:	29 c8                	sub    %ecx,%eax
}
80104aae:	5e                   	pop    %esi
80104aaf:	5f                   	pop    %edi
80104ab0:	5d                   	pop    %ebp
80104ab1:	c3                   	ret    
80104ab2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ac0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104ac0:	55                   	push   %ebp
80104ac1:	89 e5                	mov    %esp,%ebp
80104ac3:	56                   	push   %esi
80104ac4:	53                   	push   %ebx
80104ac5:	8b 45 08             	mov    0x8(%ebp),%eax
80104ac8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104acb:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104ace:	39 c3                	cmp    %eax,%ebx
80104ad0:	73 26                	jae    80104af8 <memmove+0x38>
80104ad2:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104ad5:	39 c8                	cmp    %ecx,%eax
80104ad7:	73 1f                	jae    80104af8 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104ad9:	85 f6                	test   %esi,%esi
80104adb:	8d 56 ff             	lea    -0x1(%esi),%edx
80104ade:	74 0f                	je     80104aef <memmove+0x2f>
      *--d = *--s;
80104ae0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104ae4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104ae7:	83 ea 01             	sub    $0x1,%edx
80104aea:	83 fa ff             	cmp    $0xffffffff,%edx
80104aed:	75 f1                	jne    80104ae0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104aef:	5b                   	pop    %ebx
80104af0:	5e                   	pop    %esi
80104af1:	5d                   	pop    %ebp
80104af2:	c3                   	ret    
80104af3:	90                   	nop
80104af4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104af8:	31 d2                	xor    %edx,%edx
80104afa:	85 f6                	test   %esi,%esi
80104afc:	74 f1                	je     80104aef <memmove+0x2f>
80104afe:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104b00:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104b04:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104b07:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
80104b0a:	39 d6                	cmp    %edx,%esi
80104b0c:	75 f2                	jne    80104b00 <memmove+0x40>
}
80104b0e:	5b                   	pop    %ebx
80104b0f:	5e                   	pop    %esi
80104b10:	5d                   	pop    %ebp
80104b11:	c3                   	ret    
80104b12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b20 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104b20:	55                   	push   %ebp
80104b21:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104b23:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104b24:	eb 9a                	jmp    80104ac0 <memmove>
80104b26:	8d 76 00             	lea    0x0(%esi),%esi
80104b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b30 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104b30:	55                   	push   %ebp
80104b31:	89 e5                	mov    %esp,%ebp
80104b33:	57                   	push   %edi
80104b34:	56                   	push   %esi
80104b35:	8b 7d 10             	mov    0x10(%ebp),%edi
80104b38:	53                   	push   %ebx
80104b39:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104b3c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
80104b3f:	85 ff                	test   %edi,%edi
80104b41:	74 2f                	je     80104b72 <strncmp+0x42>
80104b43:	0f b6 01             	movzbl (%ecx),%eax
80104b46:	0f b6 1e             	movzbl (%esi),%ebx
80104b49:	84 c0                	test   %al,%al
80104b4b:	74 37                	je     80104b84 <strncmp+0x54>
80104b4d:	38 c3                	cmp    %al,%bl
80104b4f:	75 33                	jne    80104b84 <strncmp+0x54>
80104b51:	01 f7                	add    %esi,%edi
80104b53:	eb 13                	jmp    80104b68 <strncmp+0x38>
80104b55:	8d 76 00             	lea    0x0(%esi),%esi
80104b58:	0f b6 01             	movzbl (%ecx),%eax
80104b5b:	84 c0                	test   %al,%al
80104b5d:	74 21                	je     80104b80 <strncmp+0x50>
80104b5f:	0f b6 1a             	movzbl (%edx),%ebx
80104b62:	89 d6                	mov    %edx,%esi
80104b64:	38 d8                	cmp    %bl,%al
80104b66:	75 1c                	jne    80104b84 <strncmp+0x54>
    n--, p++, q++;
80104b68:	8d 56 01             	lea    0x1(%esi),%edx
80104b6b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104b6e:	39 fa                	cmp    %edi,%edx
80104b70:	75 e6                	jne    80104b58 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104b72:	5b                   	pop    %ebx
    return 0;
80104b73:	31 c0                	xor    %eax,%eax
}
80104b75:	5e                   	pop    %esi
80104b76:	5f                   	pop    %edi
80104b77:	5d                   	pop    %ebp
80104b78:	c3                   	ret    
80104b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b80:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104b84:	29 d8                	sub    %ebx,%eax
}
80104b86:	5b                   	pop    %ebx
80104b87:	5e                   	pop    %esi
80104b88:	5f                   	pop    %edi
80104b89:	5d                   	pop    %ebp
80104b8a:	c3                   	ret    
80104b8b:	90                   	nop
80104b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104b90 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104b90:	55                   	push   %ebp
80104b91:	89 e5                	mov    %esp,%ebp
80104b93:	56                   	push   %esi
80104b94:	53                   	push   %ebx
80104b95:	8b 45 08             	mov    0x8(%ebp),%eax
80104b98:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104b9b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104b9e:	89 c2                	mov    %eax,%edx
80104ba0:	eb 19                	jmp    80104bbb <strncpy+0x2b>
80104ba2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ba8:	83 c3 01             	add    $0x1,%ebx
80104bab:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
80104baf:	83 c2 01             	add    $0x1,%edx
80104bb2:	84 c9                	test   %cl,%cl
80104bb4:	88 4a ff             	mov    %cl,-0x1(%edx)
80104bb7:	74 09                	je     80104bc2 <strncpy+0x32>
80104bb9:	89 f1                	mov    %esi,%ecx
80104bbb:	85 c9                	test   %ecx,%ecx
80104bbd:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104bc0:	7f e6                	jg     80104ba8 <strncpy+0x18>
    ;
  while(n-- > 0)
80104bc2:	31 c9                	xor    %ecx,%ecx
80104bc4:	85 f6                	test   %esi,%esi
80104bc6:	7e 17                	jle    80104bdf <strncpy+0x4f>
80104bc8:	90                   	nop
80104bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104bd0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104bd4:	89 f3                	mov    %esi,%ebx
80104bd6:	83 c1 01             	add    $0x1,%ecx
80104bd9:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
80104bdb:	85 db                	test   %ebx,%ebx
80104bdd:	7f f1                	jg     80104bd0 <strncpy+0x40>
  return os;
}
80104bdf:	5b                   	pop    %ebx
80104be0:	5e                   	pop    %esi
80104be1:	5d                   	pop    %ebp
80104be2:	c3                   	ret    
80104be3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104bf0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104bf0:	55                   	push   %ebp
80104bf1:	89 e5                	mov    %esp,%ebp
80104bf3:	56                   	push   %esi
80104bf4:	53                   	push   %ebx
80104bf5:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104bf8:	8b 45 08             	mov    0x8(%ebp),%eax
80104bfb:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80104bfe:	85 c9                	test   %ecx,%ecx
80104c00:	7e 26                	jle    80104c28 <safestrcpy+0x38>
80104c02:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104c06:	89 c1                	mov    %eax,%ecx
80104c08:	eb 17                	jmp    80104c21 <safestrcpy+0x31>
80104c0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104c10:	83 c2 01             	add    $0x1,%edx
80104c13:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104c17:	83 c1 01             	add    $0x1,%ecx
80104c1a:	84 db                	test   %bl,%bl
80104c1c:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104c1f:	74 04                	je     80104c25 <safestrcpy+0x35>
80104c21:	39 f2                	cmp    %esi,%edx
80104c23:	75 eb                	jne    80104c10 <safestrcpy+0x20>
    ;
  *s = 0;
80104c25:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104c28:	5b                   	pop    %ebx
80104c29:	5e                   	pop    %esi
80104c2a:	5d                   	pop    %ebp
80104c2b:	c3                   	ret    
80104c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c30 <strlen>:

int
strlen(const char *s)
{
80104c30:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104c31:	31 c0                	xor    %eax,%eax
{
80104c33:	89 e5                	mov    %esp,%ebp
80104c35:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104c38:	80 3a 00             	cmpb   $0x0,(%edx)
80104c3b:	74 0c                	je     80104c49 <strlen+0x19>
80104c3d:	8d 76 00             	lea    0x0(%esi),%esi
80104c40:	83 c0 01             	add    $0x1,%eax
80104c43:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104c47:	75 f7                	jne    80104c40 <strlen+0x10>
    ;
  return n;
}
80104c49:	5d                   	pop    %ebp
80104c4a:	c3                   	ret    

80104c4b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104c4b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104c4f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104c53:	55                   	push   %ebp
  pushl %ebx
80104c54:	53                   	push   %ebx
  pushl %esi
80104c55:	56                   	push   %esi
  pushl %edi
80104c56:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104c57:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104c59:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104c5b:	5f                   	pop    %edi
  popl %esi
80104c5c:	5e                   	pop    %esi
  popl %ebx
80104c5d:	5b                   	pop    %ebx
  popl %ebp
80104c5e:	5d                   	pop    %ebp
  ret
80104c5f:	c3                   	ret    

80104c60 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104c60:	55                   	push   %ebp
80104c61:	89 e5                	mov    %esp,%ebp
80104c63:	53                   	push   %ebx
80104c64:	83 ec 04             	sub    $0x4,%esp
80104c67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104c6a:	e8 91 eb ff ff       	call   80103800 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104c6f:	8b 00                	mov    (%eax),%eax
80104c71:	39 d8                	cmp    %ebx,%eax
80104c73:	76 1b                	jbe    80104c90 <fetchint+0x30>
80104c75:	8d 53 04             	lea    0x4(%ebx),%edx
80104c78:	39 d0                	cmp    %edx,%eax
80104c7a:	72 14                	jb     80104c90 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104c7c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104c7f:	8b 13                	mov    (%ebx),%edx
80104c81:	89 10                	mov    %edx,(%eax)
  return 0;
80104c83:	31 c0                	xor    %eax,%eax
}
80104c85:	83 c4 04             	add    $0x4,%esp
80104c88:	5b                   	pop    %ebx
80104c89:	5d                   	pop    %ebp
80104c8a:	c3                   	ret    
80104c8b:	90                   	nop
80104c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104c90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c95:	eb ee                	jmp    80104c85 <fetchint+0x25>
80104c97:	89 f6                	mov    %esi,%esi
80104c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ca0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104ca0:	55                   	push   %ebp
80104ca1:	89 e5                	mov    %esp,%ebp
80104ca3:	53                   	push   %ebx
80104ca4:	83 ec 04             	sub    $0x4,%esp
80104ca7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104caa:	e8 51 eb ff ff       	call   80103800 <myproc>

  if(addr >= curproc->sz)
80104caf:	39 18                	cmp    %ebx,(%eax)
80104cb1:	76 29                	jbe    80104cdc <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104cb3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104cb6:	89 da                	mov    %ebx,%edx
80104cb8:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80104cba:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80104cbc:	39 c3                	cmp    %eax,%ebx
80104cbe:	73 1c                	jae    80104cdc <fetchstr+0x3c>
    if(*s == 0)
80104cc0:	80 3b 00             	cmpb   $0x0,(%ebx)
80104cc3:	75 10                	jne    80104cd5 <fetchstr+0x35>
80104cc5:	eb 39                	jmp    80104d00 <fetchstr+0x60>
80104cc7:	89 f6                	mov    %esi,%esi
80104cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104cd0:	80 3a 00             	cmpb   $0x0,(%edx)
80104cd3:	74 1b                	je     80104cf0 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80104cd5:	83 c2 01             	add    $0x1,%edx
80104cd8:	39 d0                	cmp    %edx,%eax
80104cda:	77 f4                	ja     80104cd0 <fetchstr+0x30>
    return -1;
80104cdc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80104ce1:	83 c4 04             	add    $0x4,%esp
80104ce4:	5b                   	pop    %ebx
80104ce5:	5d                   	pop    %ebp
80104ce6:	c3                   	ret    
80104ce7:	89 f6                	mov    %esi,%esi
80104ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104cf0:	83 c4 04             	add    $0x4,%esp
80104cf3:	89 d0                	mov    %edx,%eax
80104cf5:	29 d8                	sub    %ebx,%eax
80104cf7:	5b                   	pop    %ebx
80104cf8:	5d                   	pop    %ebp
80104cf9:	c3                   	ret    
80104cfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80104d00:	31 c0                	xor    %eax,%eax
      return s - *pp;
80104d02:	eb dd                	jmp    80104ce1 <fetchstr+0x41>
80104d04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104d10 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104d10:	55                   	push   %ebp
80104d11:	89 e5                	mov    %esp,%ebp
80104d13:	56                   	push   %esi
80104d14:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d15:	e8 e6 ea ff ff       	call   80103800 <myproc>
80104d1a:	8b 40 18             	mov    0x18(%eax),%eax
80104d1d:	8b 55 08             	mov    0x8(%ebp),%edx
80104d20:	8b 40 44             	mov    0x44(%eax),%eax
80104d23:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104d26:	e8 d5 ea ff ff       	call   80103800 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104d2b:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d2d:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104d30:	39 c6                	cmp    %eax,%esi
80104d32:	73 1c                	jae    80104d50 <argint+0x40>
80104d34:	8d 53 08             	lea    0x8(%ebx),%edx
80104d37:	39 d0                	cmp    %edx,%eax
80104d39:	72 15                	jb     80104d50 <argint+0x40>
  *ip = *(int*)(addr);
80104d3b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d3e:	8b 53 04             	mov    0x4(%ebx),%edx
80104d41:	89 10                	mov    %edx,(%eax)
  return 0;
80104d43:	31 c0                	xor    %eax,%eax
}
80104d45:	5b                   	pop    %ebx
80104d46:	5e                   	pop    %esi
80104d47:	5d                   	pop    %ebp
80104d48:	c3                   	ret    
80104d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104d50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d55:	eb ee                	jmp    80104d45 <argint+0x35>
80104d57:	89 f6                	mov    %esi,%esi
80104d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d60 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104d60:	55                   	push   %ebp
80104d61:	89 e5                	mov    %esp,%ebp
80104d63:	56                   	push   %esi
80104d64:	53                   	push   %ebx
80104d65:	83 ec 10             	sub    $0x10,%esp
80104d68:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104d6b:	e8 90 ea ff ff       	call   80103800 <myproc>
80104d70:	89 c6                	mov    %eax,%esi

  if(argint(n, &i) < 0)
80104d72:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d75:	83 ec 08             	sub    $0x8,%esp
80104d78:	50                   	push   %eax
80104d79:	ff 75 08             	pushl  0x8(%ebp)
80104d7c:	e8 8f ff ff ff       	call   80104d10 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104d81:	83 c4 10             	add    $0x10,%esp
80104d84:	85 c0                	test   %eax,%eax
80104d86:	78 28                	js     80104db0 <argptr+0x50>
80104d88:	85 db                	test   %ebx,%ebx
80104d8a:	78 24                	js     80104db0 <argptr+0x50>
80104d8c:	8b 16                	mov    (%esi),%edx
80104d8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d91:	39 c2                	cmp    %eax,%edx
80104d93:	76 1b                	jbe    80104db0 <argptr+0x50>
80104d95:	01 c3                	add    %eax,%ebx
80104d97:	39 da                	cmp    %ebx,%edx
80104d99:	72 15                	jb     80104db0 <argptr+0x50>
    return -1;
  *pp = (char*)i;
80104d9b:	8b 55 0c             	mov    0xc(%ebp),%edx
80104d9e:	89 02                	mov    %eax,(%edx)
  return 0;
80104da0:	31 c0                	xor    %eax,%eax
}
80104da2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104da5:	5b                   	pop    %ebx
80104da6:	5e                   	pop    %esi
80104da7:	5d                   	pop    %ebp
80104da8:	c3                   	ret    
80104da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104db0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104db5:	eb eb                	jmp    80104da2 <argptr+0x42>
80104db7:	89 f6                	mov    %esi,%esi
80104db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104dc0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104dc0:	55                   	push   %ebp
80104dc1:	89 e5                	mov    %esp,%ebp
80104dc3:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104dc6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104dc9:	50                   	push   %eax
80104dca:	ff 75 08             	pushl  0x8(%ebp)
80104dcd:	e8 3e ff ff ff       	call   80104d10 <argint>
80104dd2:	83 c4 10             	add    $0x10,%esp
80104dd5:	85 c0                	test   %eax,%eax
80104dd7:	78 17                	js     80104df0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104dd9:	83 ec 08             	sub    $0x8,%esp
80104ddc:	ff 75 0c             	pushl  0xc(%ebp)
80104ddf:	ff 75 f4             	pushl  -0xc(%ebp)
80104de2:	e8 b9 fe ff ff       	call   80104ca0 <fetchstr>
80104de7:	83 c4 10             	add    $0x10,%esp
}
80104dea:	c9                   	leave  
80104deb:	c3                   	ret    
80104dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104df0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104df5:	c9                   	leave  
80104df6:	c3                   	ret    
80104df7:	89 f6                	mov    %esi,%esi
80104df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e00 <createIntQueue>:
//     mq->array = kalloc();
//     return mq;
// }

struct intMessageQueue* createIntQueue(unsigned capacity)
{
80104e00:	55                   	push   %ebp
80104e01:	89 e5                	mov    %esp,%ebp
80104e03:	53                   	push   %ebx
80104e04:	83 ec 04             	sub    $0x4,%esp
    struct intMessageQueue* mq = (struct intMessageQueue*) kalloc();
80104e07:	e8 d4 d6 ff ff       	call   801024e0 <kalloc>
80104e0c:	89 c3                	mov    %eax,%ebx
    mq->capacity = capacity;
80104e0e:	8b 45 08             	mov    0x8(%ebp),%eax
    mq->front =0;
80104e11:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
    mq->size = 0;
80104e17:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    mq->last = -1;  // This is important, see the enqueue
80104e1e:	c7 43 04 ff ff ff ff 	movl   $0xffffffff,0x4(%ebx)
    mq->capacity = capacity;
80104e25:	89 43 0c             	mov    %eax,0xc(%ebx)
    mq->arr = (int*) kalloc();
80104e28:	e8 b3 d6 ff ff       	call   801024e0 <kalloc>
80104e2d:	89 43 10             	mov    %eax,0x10(%ebx)
    return mq;
}
80104e30:	83 c4 04             	add    $0x4,%esp
80104e33:	89 d8                	mov    %ebx,%eax
80104e35:	5b                   	pop    %ebx
80104e36:	5d                   	pop    %ebp
80104e37:	c3                   	ret    
80104e38:	90                   	nop
80104e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104e40 <createWaitQueue>:

struct waitQueue* createWaitQueue(unsigned capacity)
{
80104e40:	55                   	push   %ebp
80104e41:	89 e5                	mov    %esp,%ebp
80104e43:	53                   	push   %ebx
80104e44:	83 ec 04             	sub    $0x4,%esp
    struct waitQueue* mq = (struct waitQueue*) kalloc();
80104e47:	e8 94 d6 ff ff       	call   801024e0 <kalloc>
80104e4c:	89 c3                	mov    %eax,%ebx
    mq->capacity = capacity;
80104e4e:	8b 45 08             	mov    0x8(%ebp),%eax
    mq->front = 0;
80104e51:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
    mq->size = 0;
80104e57:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    mq->last = -1;  // This is important, see the enqueue
80104e5e:	c7 43 04 ff ff ff ff 	movl   $0xffffffff,0x4(%ebx)
    mq->capacity = capacity;
80104e65:	89 43 0c             	mov    %eax,0xc(%ebx)
    mq->array = (struct waitQueueItem*) kalloc();
80104e68:	e8 73 d6 ff ff       	call   801024e0 <kalloc>
80104e6d:	89 43 10             	mov    %eax,0x10(%ebx)
    return mq;
}
80104e70:	83 c4 04             	add    $0x4,%esp
80104e73:	89 d8                	mov    %ebx,%eax
80104e75:	5b                   	pop    %ebx
80104e76:	5d                   	pop    %ebp
80104e77:	c3                   	ret    
80104e78:	90                   	nop
80104e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104e80 <init_queues>:


void
init_queues(void)
{
80104e80:	55                   	push   %ebp
80104e81:	89 e5                	mov    %esp,%ebp
80104e83:	53                   	push   %ebx
80104e84:	31 db                	xor    %ebx,%ebx
80104e86:	83 ec 04             	sub    $0x4,%esp
80104e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  unsigned capacity = 50;             // capacity of one message quque
  for(int p = 0; p < NPROC; p++){
    // message_quque[p] = createQueue(capacity);
    int_message_queue[p] = createIntQueue(capacity);
80104e90:	83 ec 0c             	sub    $0xc,%esp
80104e93:	83 c3 04             	add    $0x4,%ebx
80104e96:	6a 32                	push   $0x32
80104e98:	e8 63 ff ff ff       	call   80104e00 <createIntQueue>
    wait_queue[p] = createWaitQueue(capacity);
80104e9d:	c7 04 24 32 00 00 00 	movl   $0x32,(%esp)
    int_message_queue[p] = createIntQueue(capacity);
80104ea4:	89 83 dc 2a 11 80    	mov    %eax,-0x7feed524(%ebx)
    wait_queue[p] = createWaitQueue(capacity);
80104eaa:	e8 91 ff ff ff       	call   80104e40 <createWaitQueue>
80104eaf:	89 83 1c 27 11 80    	mov    %eax,-0x7feed8e4(%ebx)
  for(int p = 0; p < NPROC; p++){
80104eb5:	83 c4 10             	add    $0x10,%esp
80104eb8:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
80104ebe:	75 d0                	jne    80104e90 <init_queues+0x10>
  }
}
80104ec0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ec3:	c9                   	leave  
80104ec4:	c3                   	ret    
80104ec5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ed0 <syscall>:
{
80104ed0:	55                   	push   %ebp
80104ed1:	89 e5                	mov    %esp,%ebp
80104ed3:	53                   	push   %ebx
80104ed4:	83 ec 04             	sub    $0x4,%esp
  if(syscallhappened==0){
80104ed7:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
80104edc:	85 c0                	test   %eax,%eax
80104ede:	74 60                	je     80104f40 <syscall+0x70>
  struct proc *curproc = myproc();
80104ee0:	e8 1b e9 ff ff       	call   80103800 <myproc>
80104ee5:	89 c3                	mov    %eax,%ebx
  num = curproc->tf->eax;
80104ee7:	8b 40 18             	mov    0x18(%eax),%eax
80104eea:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104eed:	8d 50 ff             	lea    -0x1(%eax),%edx
80104ef0:	83 fa 1d             	cmp    $0x1d,%edx
80104ef3:	77 1b                	ja     80104f10 <syscall+0x40>
80104ef5:	8b 14 85 e0 8b 10 80 	mov    -0x7fef7420(,%eax,4),%edx
80104efc:	85 d2                	test   %edx,%edx
80104efe:	74 10                	je     80104f10 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104f00:	ff d2                	call   *%edx
80104f02:	8b 53 18             	mov    0x18(%ebx),%edx
80104f05:	89 42 1c             	mov    %eax,0x1c(%edx)
}
80104f08:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104f0b:	c9                   	leave  
80104f0c:	c3                   	ret    
80104f0d:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104f10:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104f11:	8d 83 bc 01 00 00    	lea    0x1bc(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104f17:	50                   	push   %eax
80104f18:	ff 73 10             	pushl  0x10(%ebx)
80104f1b:	68 99 8b 10 80       	push   $0x80108b99
80104f20:	e8 3b b7 ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
80104f25:	8b 43 18             	mov    0x18(%ebx),%eax
80104f28:	83 c4 10             	add    $0x10,%esp
80104f2b:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104f32:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104f35:	c9                   	leave  
80104f36:	c3                   	ret    
80104f37:	89 f6                	mov    %esi,%esi
80104f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  	init_queues();
80104f40:	e8 3b ff ff ff       	call   80104e80 <init_queues>
  	syscallhappened=1;
80104f45:	c7 05 c0 c5 10 80 01 	movl   $0x1,0x8010c5c0
80104f4c:	00 00 00 
80104f4f:	eb 8f                	jmp    80104ee0 <syscall+0x10>
80104f51:	eb 0d                	jmp    80104f60 <isWaitFull>
80104f53:	90                   	nop
80104f54:	90                   	nop
80104f55:	90                   	nop
80104f56:	90                   	nop
80104f57:	90                   	nop
80104f58:	90                   	nop
80104f59:	90                   	nop
80104f5a:	90                   	nop
80104f5b:	90                   	nop
80104f5c:	90                   	nop
80104f5d:	90                   	nop
80104f5e:	90                   	nop
80104f5f:	90                   	nop

80104f60 <isWaitFull>:
//     return item;
// }


int isWaitFull(struct waitQueue* mq)
{
80104f60:	55                   	push   %ebp
80104f61:	89 e5                	mov    %esp,%ebp
80104f63:	8b 45 08             	mov    0x8(%ebp),%eax
	if(mq->size == mq->capacity)
	return 1;
	else return 0;
}
80104f66:	5d                   	pop    %ebp
	if(mq->size == mq->capacity)
80104f67:	8b 50 0c             	mov    0xc(%eax),%edx
80104f6a:	39 50 08             	cmp    %edx,0x8(%eax)
80104f6d:	0f 94 c0             	sete   %al
80104f70:	0f b6 c0             	movzbl %al,%eax
}
80104f73:	c3                   	ret    
80104f74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104f80 <isWaitEmpty>:


int isWaitEmpty(struct waitQueue* mq)
{
80104f80:	55                   	push   %ebp
80104f81:	89 e5                	mov    %esp,%ebp
	if(mq->size == 0)
80104f83:	8b 45 08             	mov    0x8(%ebp),%eax
	return 1;
	else return 0;
}
80104f86:	5d                   	pop    %ebp
	if(mq->size == 0)
80104f87:	8b 40 08             	mov    0x8(%eax),%eax
80104f8a:	85 c0                	test   %eax,%eax
80104f8c:	0f 94 c0             	sete   %al
80104f8f:	0f b6 c0             	movzbl %al,%eax
}
80104f92:	c3                   	ret    
80104f93:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104fa0 <waitenqueue>:


void waitenqueue(struct waitQueue* mq, struct waitQueueItem item)
{
80104fa0:	55                   	push   %ebp
80104fa1:	89 e5                	mov    %esp,%ebp
80104fa3:	56                   	push   %esi
80104fa4:	53                   	push   %ebx
80104fa5:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(mq->size == mq->capacity)
80104fa8:	8b 41 0c             	mov    0xc(%ecx),%eax
80104fab:	39 41 08             	cmp    %eax,0x8(%ecx)
80104fae:	74 1d                	je     80104fcd <waitenqueue+0x2d>
    if (isWaitFull(mq))
        return;
    mq->last = mq->last + 1;
80104fb0:	8b 41 04             	mov    0x4(%ecx),%eax
    mq->array[mq->last] = item;
80104fb3:	8b 71 10             	mov    0x10(%ecx),%esi
80104fb6:	8b 55 10             	mov    0x10(%ebp),%edx
    mq->last = mq->last + 1;
80104fb9:	8d 58 01             	lea    0x1(%eax),%ebx
    mq->array[mq->last] = item;
80104fbc:	8b 45 0c             	mov    0xc(%ebp),%eax
    mq->last = mq->last + 1;
80104fbf:	89 59 04             	mov    %ebx,0x4(%ecx)
    mq->array[mq->last] = item;
80104fc2:	89 54 de 04          	mov    %edx,0x4(%esi,%ebx,8)
80104fc6:	89 04 de             	mov    %eax,(%esi,%ebx,8)
    mq->size = mq->size + 1;
80104fc9:	83 41 08 01          	addl   $0x1,0x8(%ecx)
    // printf("%d enqueued to queue\n", item);
}
80104fcd:	5b                   	pop    %ebx
80104fce:	5e                   	pop    %esi
80104fcf:	5d                   	pop    %ebp
80104fd0:	c3                   	ret    
80104fd1:	eb 0d                	jmp    80104fe0 <waitdequeue>
80104fd3:	90                   	nop
80104fd4:	90                   	nop
80104fd5:	90                   	nop
80104fd6:	90                   	nop
80104fd7:	90                   	nop
80104fd8:	90                   	nop
80104fd9:	90                   	nop
80104fda:	90                   	nop
80104fdb:	90                   	nop
80104fdc:	90                   	nop
80104fdd:	90                   	nop
80104fde:	90                   	nop
80104fdf:	90                   	nop

80104fe0 <waitdequeue>:

struct waitQueueItem waitdequeue(struct waitQueue* mq)                // ALWAYS CHECK IF EMPTY BEFORE USING DEQUEUE
{
80104fe0:	55                   	push   %ebp
80104fe1:	89 e5                	mov    %esp,%ebp
80104fe3:	56                   	push   %esi
80104fe4:	53                   	push   %ebx
80104fe5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104fe8:	8b 5d 08             	mov    0x8(%ebp),%ebx

    // if (isEmpty(mq))
    //     return;
    struct waitQueueItem item = mq->array[mq->front];
80104feb:	8b 01                	mov    (%ecx),%eax
80104fed:	8b 51 10             	mov    0x10(%ecx),%edx
80104ff0:	8d 14 c2             	lea    (%edx,%eax,8),%edx
    mq->front = (mq->front + 1)%mq->capacity;
80104ff3:	83 c0 01             	add    $0x1,%eax
    struct waitQueueItem item = mq->array[mq->front];
80104ff6:	8b 32                	mov    (%edx),%esi
80104ff8:	89 33                	mov    %esi,(%ebx)
80104ffa:	8b 72 04             	mov    0x4(%edx),%esi
    mq->front = (mq->front + 1)%mq->capacity;
80104ffd:	31 d2                	xor    %edx,%edx
80104fff:	f7 71 0c             	divl   0xc(%ecx)
    mq->size = mq->size - 1;
80105002:	83 69 08 01          	subl   $0x1,0x8(%ecx)
    return item;
}
80105006:	89 d8                	mov    %ebx,%eax
    struct waitQueueItem item = mq->array[mq->front];
80105008:	89 73 04             	mov    %esi,0x4(%ebx)
    mq->front = (mq->front + 1)%mq->capacity;
8010500b:	89 11                	mov    %edx,(%ecx)
}
8010500d:	5b                   	pop    %ebx
8010500e:	5e                   	pop    %esi
8010500f:	5d                   	pop    %ebp
80105010:	c2 04 00             	ret    $0x4
80105013:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105020 <isFull>:


/////////////////////////////////////////////////////////

int isFull(struct intMessageQueue* mq)
{  if(mq->size == mq->capacity)
80105020:	55                   	push   %ebp
80105021:	89 e5                	mov    %esp,%ebp
80105023:	8b 45 08             	mov    0x8(%ebp),%eax
	return 1;
	else return 0;
}
80105026:	5d                   	pop    %ebp
{  if(mq->size == mq->capacity)
80105027:	8b 50 0c             	mov    0xc(%eax),%edx
8010502a:	39 50 08             	cmp    %edx,0x8(%eax)
8010502d:	0f 94 c0             	sete   %al
80105030:	0f b6 c0             	movzbl %al,%eax
}
80105033:	c3                   	ret    
80105034:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010503a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105040 <isEmpty>:


int isEmpty(struct intMessageQueue* mq)
{
80105040:	55                   	push   %ebp
80105041:	89 e5                	mov    %esp,%ebp
	if(mq->size == 0)
80105043:	8b 45 08             	mov    0x8(%ebp),%eax
	return 1;
	else return 0;
}
80105046:	5d                   	pop    %ebp
	if(mq->size == 0)
80105047:	8b 40 08             	mov    0x8(%eax),%eax
8010504a:	85 c0                	test   %eax,%eax
8010504c:	0f 94 c0             	sete   %al
8010504f:	0f b6 c0             	movzbl %al,%eax
}
80105052:	c3                   	ret    
80105053:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105060 <enqueue>:


void enqueue(struct intMessageQueue* mq, int item)
{
80105060:	55                   	push   %ebp
80105061:	89 e5                	mov    %esp,%ebp
80105063:	53                   	push   %ebx
80105064:	8b 4d 08             	mov    0x8(%ebp),%ecx
{  if(mq->size == mq->capacity)
80105067:	8b 59 0c             	mov    0xc(%ecx),%ebx
8010506a:	39 59 08             	cmp    %ebx,0x8(%ecx)
8010506d:	74 1a                	je     80105089 <enqueue+0x29>
    if (isFull(mq))
        return;
    mq->last = (mq->last + 1)%mq->capacity;
8010506f:	8b 41 04             	mov    0x4(%ecx),%eax
80105072:	31 d2                	xor    %edx,%edx
80105074:	83 c0 01             	add    $0x1,%eax
80105077:	f7 f3                	div    %ebx
    mq->arr[mq->last] = item;
80105079:	8b 41 10             	mov    0x10(%ecx),%eax
8010507c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    mq->last = (mq->last + 1)%mq->capacity;
8010507f:	89 51 04             	mov    %edx,0x4(%ecx)
    mq->arr[mq->last] = item;
80105082:	89 1c 90             	mov    %ebx,(%eax,%edx,4)
    mq->size = mq->size + 1;
80105085:	83 41 08 01          	addl   $0x1,0x8(%ecx)
    // printf("%d enqueued to queue\n", item);
}
80105089:	5b                   	pop    %ebx
8010508a:	5d                   	pop    %ebp
8010508b:	c3                   	ret    
8010508c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105090 <dequeue>:

int dequeue(struct intMessageQueue* mq)                // ALWAYS CHECK IF EMPTY BEFORE USING DEQUEUE
{
80105090:	55                   	push   %ebp
80105091:	89 e5                	mov    %esp,%ebp
80105093:	56                   	push   %esi
80105094:	53                   	push   %ebx
80105095:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(mq->size == 0)
80105098:	8b 59 08             	mov    0x8(%ecx),%ebx
8010509b:	85 db                	test   %ebx,%ebx
8010509d:	74 21                	je     801050c0 <dequeue+0x30>

    if (isEmpty(mq))
        {cprintf("dequeue from EMPTY\n");return -3;}
    int item = mq->arr[mq->front];
8010509f:	8b 01                	mov    (%ecx),%eax
801050a1:	8b 51 10             	mov    0x10(%ecx),%edx
    mq->front = (mq->front + 1)%mq->capacity;
    mq->size = mq->size - 1;
801050a4:	83 eb 01             	sub    $0x1,%ebx
    int item = mq->arr[mq->front];
801050a7:	8b 34 82             	mov    (%edx,%eax,4),%esi
    mq->front = (mq->front + 1)%mq->capacity;
801050aa:	83 c0 01             	add    $0x1,%eax
801050ad:	31 d2                	xor    %edx,%edx
801050af:	f7 71 0c             	divl   0xc(%ecx)
    mq->size = mq->size - 1;
801050b2:	89 59 08             	mov    %ebx,0x8(%ecx)
    mq->front = (mq->front + 1)%mq->capacity;
801050b5:	89 11                	mov    %edx,(%ecx)
    return item;
}
801050b7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801050ba:	89 f0                	mov    %esi,%eax
801050bc:	5b                   	pop    %ebx
801050bd:	5e                   	pop    %esi
801050be:	5d                   	pop    %ebp
801050bf:	c3                   	ret    
        {cprintf("dequeue from EMPTY\n");return -3;}
801050c0:	83 ec 0c             	sub    $0xc,%esp
801050c3:	be fd ff ff ff       	mov    $0xfffffffd,%esi
801050c8:	68 b5 8b 10 80       	push   $0x80108bb5
801050cd:	e8 8e b5 ff ff       	call   80100660 <cprintf>
801050d2:	83 c4 10             	add    $0x10,%esp
801050d5:	eb e0                	jmp    801050b7 <dequeue+0x27>
801050d7:	89 f6                	mov    %esi,%esi
801050d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801050e0 <copyToSystemSpace>:
/////////// COPY TO SYSTEM SPACE AND COPY FROM SYSTEM SPACE///////
*/

void
copyToSystemSpace(char *from,char *to, int len)
{
801050e0:	55                   	push   %ebp
801050e1:	89 e5                	mov    %esp,%ebp
801050e3:	56                   	push   %esi
801050e4:	53                   	push   %ebx
801050e5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801050e8:	8b 5d 08             	mov    0x8(%ebp),%ebx
801050eb:	8b 75 0c             	mov    0xc(%ebp),%esi
	// from = P2V(from);
	while(len-->0){
801050ee:	85 c9                	test   %ecx,%ecx
801050f0:	7e 14                	jle    80105106 <copyToSystemSpace+0x26>
801050f2:	31 c0                	xor    %eax,%eax
801050f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		*to++= *from++;
801050f8:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
801050fc:	88 14 06             	mov    %dl,(%esi,%eax,1)
801050ff:	83 c0 01             	add    $0x1,%eax
	while(len-->0){
80105102:	39 c1                	cmp    %eax,%ecx
80105104:	75 f2                	jne    801050f8 <copyToSystemSpace+0x18>
		// to++;
		// from++;
	}
}
80105106:	5b                   	pop    %ebx
80105107:	5e                   	pop    %esi
80105108:	5d                   	pop    %ebp
80105109:	c3                   	ret    
8010510a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105110 <copyFromSystemSpace>:

void
copyFromSystemSpace(char *to,char *from, int len)
{
80105110:	55                   	push   %ebp
80105111:	89 e5                	mov    %esp,%ebp
80105113:	56                   	push   %esi
80105114:	53                   	push   %ebx
80105115:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105118:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010511b:	8b 75 0c             	mov    0xc(%ebp),%esi
	// to = P2V(to);
	while(len-->0){
8010511e:	85 c9                	test   %ecx,%ecx
80105120:	7e 14                	jle    80105136 <copyFromSystemSpace+0x26>
80105122:	31 c0                	xor    %eax,%eax
80105124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		*to++= *from++;
80105128:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
8010512c:	88 14 03             	mov    %dl,(%ebx,%eax,1)
8010512f:	83 c0 01             	add    $0x1,%eax
	while(len-->0){
80105132:	39 c1                	cmp    %eax,%ecx
80105134:	75 f2                	jne    80105128 <copyFromSystemSpace+0x18>
		// to++;
		// from++;
	}
}
80105136:	5b                   	pop    %ebx
80105137:	5e                   	pop    %esi
80105138:	5d                   	pop    %ebp
80105139:	c3                   	ret    
8010513a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105140 <getMessageBuffer>:
	// if(msg_no != EndOfFreeList){
	// 	free_message_buffer = messageBuffers[msg_no][0];
	// }
	// return msg_no;

	lastBufferUsed++;
80105140:	a1 c4 c5 10 80       	mov    0x8010c5c4,%eax
{
80105145:	55                   	push   %ebp
80105146:	89 e5                	mov    %esp,%ebp
	int m = lastBufferUsed;
	lastBufferUsed++;
80105148:	8d 50 02             	lea    0x2(%eax),%edx
	lastBufferUsed++;
8010514b:	83 c0 01             	add    $0x1,%eax

	return m;

}
8010514e:	5d                   	pop    %ebp
	lastBufferUsed++;
8010514f:	89 15 c4 c5 10 80    	mov    %edx,0x8010c5c4
}
80105155:	c3                   	ret    
80105156:	8d 76 00             	lea    0x0(%esi),%esi
80105159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105160 <freeMessageBuffer>:

void
freeMessageBuffer(int msg_no)
{
80105160:	55                   	push   %ebp
	messageBuffers[msg_no][0]= free_message_buffer;
80105161:	8b 0d 20 2a 11 80    	mov    0x80112a20,%ecx
{
80105167:	89 e5                	mov    %esp,%ebp
80105169:	8b 45 08             	mov    0x8(%ebp),%eax
	messageBuffers[msg_no][0]= free_message_buffer;
8010516c:	8b 14 85 e0 d5 10 80 	mov    -0x7fef2a20(,%eax,4),%edx
80105173:	88 0a                	mov    %cl,(%edx)
	free_message_buffer = msg_no;
80105175:	a3 20 2a 11 80       	mov    %eax,0x80112a20
}
8010517a:	5d                   	pop    %ebp
8010517b:	c3                   	ret    
8010517c:	66 90                	xchg   %ax,%ax
8010517e:	66 90                	xchg   %ax,%ax

80105180 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105180:	55                   	push   %ebp
80105181:	89 e5                	mov    %esp,%ebp
80105183:	57                   	push   %edi
80105184:	56                   	push   %esi
80105185:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105186:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80105189:	83 ec 44             	sub    $0x44,%esp
8010518c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
8010518f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105192:	56                   	push   %esi
80105193:	50                   	push   %eax
{
80105194:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80105197:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010519a:	e8 81 cd ff ff       	call   80101f20 <nameiparent>
8010519f:	83 c4 10             	add    $0x10,%esp
801051a2:	85 c0                	test   %eax,%eax
801051a4:	0f 84 46 01 00 00    	je     801052f0 <create+0x170>
    return 0;
  ilock(dp);
801051aa:	83 ec 0c             	sub    $0xc,%esp
801051ad:	89 c3                	mov    %eax,%ebx
801051af:	50                   	push   %eax
801051b0:	e8 db c4 ff ff       	call   80101690 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
801051b5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801051b8:	83 c4 0c             	add    $0xc,%esp
801051bb:	50                   	push   %eax
801051bc:	56                   	push   %esi
801051bd:	53                   	push   %ebx
801051be:	e8 fd c9 ff ff       	call   80101bc0 <dirlookup>
801051c3:	83 c4 10             	add    $0x10,%esp
801051c6:	85 c0                	test   %eax,%eax
801051c8:	89 c7                	mov    %eax,%edi
801051ca:	74 34                	je     80105200 <create+0x80>
    iunlockput(dp);
801051cc:	83 ec 0c             	sub    $0xc,%esp
801051cf:	53                   	push   %ebx
801051d0:	e8 4b c7 ff ff       	call   80101920 <iunlockput>
    ilock(ip);
801051d5:	89 3c 24             	mov    %edi,(%esp)
801051d8:	e8 b3 c4 ff ff       	call   80101690 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801051dd:	83 c4 10             	add    $0x10,%esp
801051e0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
801051e5:	0f 85 95 00 00 00    	jne    80105280 <create+0x100>
801051eb:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
801051f0:	0f 85 8a 00 00 00    	jne    80105280 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801051f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051f9:	89 f8                	mov    %edi,%eax
801051fb:	5b                   	pop    %ebx
801051fc:	5e                   	pop    %esi
801051fd:	5f                   	pop    %edi
801051fe:	5d                   	pop    %ebp
801051ff:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80105200:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80105204:	83 ec 08             	sub    $0x8,%esp
80105207:	50                   	push   %eax
80105208:	ff 33                	pushl  (%ebx)
8010520a:	e8 11 c3 ff ff       	call   80101520 <ialloc>
8010520f:	83 c4 10             	add    $0x10,%esp
80105212:	85 c0                	test   %eax,%eax
80105214:	89 c7                	mov    %eax,%edi
80105216:	0f 84 e8 00 00 00    	je     80105304 <create+0x184>
  ilock(ip);
8010521c:	83 ec 0c             	sub    $0xc,%esp
8010521f:	50                   	push   %eax
80105220:	e8 6b c4 ff ff       	call   80101690 <ilock>
  ip->major = major;
80105225:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80105229:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
8010522d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80105231:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80105235:	b8 01 00 00 00       	mov    $0x1,%eax
8010523a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
8010523e:	89 3c 24             	mov    %edi,(%esp)
80105241:	e8 9a c3 ff ff       	call   801015e0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105246:	83 c4 10             	add    $0x10,%esp
80105249:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
8010524e:	74 50                	je     801052a0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80105250:	83 ec 04             	sub    $0x4,%esp
80105253:	ff 77 04             	pushl  0x4(%edi)
80105256:	56                   	push   %esi
80105257:	53                   	push   %ebx
80105258:	e8 e3 cb ff ff       	call   80101e40 <dirlink>
8010525d:	83 c4 10             	add    $0x10,%esp
80105260:	85 c0                	test   %eax,%eax
80105262:	0f 88 8f 00 00 00    	js     801052f7 <create+0x177>
  iunlockput(dp);
80105268:	83 ec 0c             	sub    $0xc,%esp
8010526b:	53                   	push   %ebx
8010526c:	e8 af c6 ff ff       	call   80101920 <iunlockput>
  return ip;
80105271:	83 c4 10             	add    $0x10,%esp
}
80105274:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105277:	89 f8                	mov    %edi,%eax
80105279:	5b                   	pop    %ebx
8010527a:	5e                   	pop    %esi
8010527b:	5f                   	pop    %edi
8010527c:	5d                   	pop    %ebp
8010527d:	c3                   	ret    
8010527e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105280:	83 ec 0c             	sub    $0xc,%esp
80105283:	57                   	push   %edi
    return 0;
80105284:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80105286:	e8 95 c6 ff ff       	call   80101920 <iunlockput>
    return 0;
8010528b:	83 c4 10             	add    $0x10,%esp
}
8010528e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105291:	89 f8                	mov    %edi,%eax
80105293:	5b                   	pop    %ebx
80105294:	5e                   	pop    %esi
80105295:	5f                   	pop    %edi
80105296:	5d                   	pop    %ebp
80105297:	c3                   	ret    
80105298:	90                   	nop
80105299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
801052a0:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
801052a5:	83 ec 0c             	sub    $0xc,%esp
801052a8:	53                   	push   %ebx
801052a9:	e8 32 c3 ff ff       	call   801015e0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801052ae:	83 c4 0c             	add    $0xc,%esp
801052b1:	ff 77 04             	pushl  0x4(%edi)
801052b4:	68 7c 8c 10 80       	push   $0x80108c7c
801052b9:	57                   	push   %edi
801052ba:	e8 81 cb ff ff       	call   80101e40 <dirlink>
801052bf:	83 c4 10             	add    $0x10,%esp
801052c2:	85 c0                	test   %eax,%eax
801052c4:	78 1c                	js     801052e2 <create+0x162>
801052c6:	83 ec 04             	sub    $0x4,%esp
801052c9:	ff 73 04             	pushl  0x4(%ebx)
801052cc:	68 7b 8c 10 80       	push   $0x80108c7b
801052d1:	57                   	push   %edi
801052d2:	e8 69 cb ff ff       	call   80101e40 <dirlink>
801052d7:	83 c4 10             	add    $0x10,%esp
801052da:	85 c0                	test   %eax,%eax
801052dc:	0f 89 6e ff ff ff    	jns    80105250 <create+0xd0>
      panic("create dots");
801052e2:	83 ec 0c             	sub    $0xc,%esp
801052e5:	68 6f 8c 10 80       	push   $0x80108c6f
801052ea:	e8 a1 b0 ff ff       	call   80100390 <panic>
801052ef:	90                   	nop
    return 0;
801052f0:	31 ff                	xor    %edi,%edi
801052f2:	e9 ff fe ff ff       	jmp    801051f6 <create+0x76>
    panic("create: dirlink");
801052f7:	83 ec 0c             	sub    $0xc,%esp
801052fa:	68 7e 8c 10 80       	push   $0x80108c7e
801052ff:	e8 8c b0 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80105304:	83 ec 0c             	sub    $0xc,%esp
80105307:	68 60 8c 10 80       	push   $0x80108c60
8010530c:	e8 7f b0 ff ff       	call   80100390 <panic>
80105311:	eb 0d                	jmp    80105320 <argfd.constprop.0>
80105313:	90                   	nop
80105314:	90                   	nop
80105315:	90                   	nop
80105316:	90                   	nop
80105317:	90                   	nop
80105318:	90                   	nop
80105319:	90                   	nop
8010531a:	90                   	nop
8010531b:	90                   	nop
8010531c:	90                   	nop
8010531d:	90                   	nop
8010531e:	90                   	nop
8010531f:	90                   	nop

80105320 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	56                   	push   %esi
80105324:	53                   	push   %ebx
80105325:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80105327:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
8010532a:	89 d6                	mov    %edx,%esi
8010532c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010532f:	50                   	push   %eax
80105330:	6a 00                	push   $0x0
80105332:	e8 d9 f9 ff ff       	call   80104d10 <argint>
80105337:	83 c4 10             	add    $0x10,%esp
8010533a:	85 c0                	test   %eax,%eax
8010533c:	78 2a                	js     80105368 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010533e:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
80105342:	77 24                	ja     80105368 <argfd.constprop.0+0x48>
80105344:	e8 b7 e4 ff ff       	call   80103800 <myproc>
80105349:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010534c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80105350:	85 c0                	test   %eax,%eax
80105352:	74 14                	je     80105368 <argfd.constprop.0+0x48>
  if(pfd)
80105354:	85 db                	test   %ebx,%ebx
80105356:	74 02                	je     8010535a <argfd.constprop.0+0x3a>
    *pfd = fd;
80105358:	89 13                	mov    %edx,(%ebx)
    *pf = f;
8010535a:	89 06                	mov    %eax,(%esi)
  return 0;
8010535c:	31 c0                	xor    %eax,%eax
}
8010535e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105361:	5b                   	pop    %ebx
80105362:	5e                   	pop    %esi
80105363:	5d                   	pop    %ebp
80105364:	c3                   	ret    
80105365:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105368:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010536d:	eb ef                	jmp    8010535e <argfd.constprop.0+0x3e>
8010536f:	90                   	nop

80105370 <sys_dup>:
{ if(isTraceOn==1)
80105370:	55                   	push   %ebp
80105371:	89 e5                	mov    %esp,%ebp
80105373:	56                   	push   %esi
80105374:	53                   	push   %ebx
80105375:	83 ec 10             	sub    $0x10,%esp
80105378:	83 3d 18 27 11 80 01 	cmpl   $0x1,0x80112718
8010537f:	75 07                	jne    80105388 <sys_dup+0x18>
  {num_calls[SYS_dup] ++;}
80105381:	83 05 68 2a 11 80 01 	addl   $0x1,0x80112a68
  if(argfd(0, 0, &f) < 0)
80105388:	8d 55 f4             	lea    -0xc(%ebp),%edx
8010538b:	31 c0                	xor    %eax,%eax
8010538d:	e8 8e ff ff ff       	call   80105320 <argfd.constprop.0>
80105392:	85 c0                	test   %eax,%eax
80105394:	78 42                	js     801053d8 <sys_dup+0x68>
  if((fd=fdalloc(f)) < 0)
80105396:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105399:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010539b:	e8 60 e4 ff ff       	call   80103800 <myproc>
801053a0:	eb 0e                	jmp    801053b0 <sys_dup+0x40>
801053a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
801053a8:	83 c3 01             	add    $0x1,%ebx
801053ab:	83 fb 64             	cmp    $0x64,%ebx
801053ae:	74 28                	je     801053d8 <sys_dup+0x68>
    if(curproc->ofile[fd] == 0){
801053b0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801053b4:	85 d2                	test   %edx,%edx
801053b6:	75 f0                	jne    801053a8 <sys_dup+0x38>
      curproc->ofile[fd] = f;
801053b8:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
801053bc:	83 ec 0c             	sub    $0xc,%esp
801053bf:	ff 75 f4             	pushl  -0xc(%ebp)
801053c2:	e8 29 ba ff ff       	call   80100df0 <filedup>
  return fd;
801053c7:	83 c4 10             	add    $0x10,%esp
}
801053ca:	8d 65 f8             	lea    -0x8(%ebp),%esp
801053cd:	89 d8                	mov    %ebx,%eax
801053cf:	5b                   	pop    %ebx
801053d0:	5e                   	pop    %esi
801053d1:	5d                   	pop    %ebp
801053d2:	c3                   	ret    
801053d3:	90                   	nop
801053d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801053d8:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
801053db:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
801053e0:	89 d8                	mov    %ebx,%eax
801053e2:	5b                   	pop    %ebx
801053e3:	5e                   	pop    %esi
801053e4:	5d                   	pop    %ebp
801053e5:	c3                   	ret    
801053e6:	8d 76 00             	lea    0x0(%esi),%esi
801053e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801053f0 <sys_read>:
{ if(isTraceOn==1)
801053f0:	55                   	push   %ebp
801053f1:	89 e5                	mov    %esp,%ebp
801053f3:	83 ec 18             	sub    $0x18,%esp
801053f6:	83 3d 18 27 11 80 01 	cmpl   $0x1,0x80112718
801053fd:	75 07                	jne    80105406 <sys_read+0x16>
  {num_calls[SYS_read] ++;}
801053ff:	83 05 54 2a 11 80 01 	addl   $0x1,0x80112a54
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105406:	8d 55 ec             	lea    -0x14(%ebp),%edx
80105409:	31 c0                	xor    %eax,%eax
8010540b:	e8 10 ff ff ff       	call   80105320 <argfd.constprop.0>
80105410:	85 c0                	test   %eax,%eax
80105412:	78 4c                	js     80105460 <sys_read+0x70>
80105414:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105417:	83 ec 08             	sub    $0x8,%esp
8010541a:	50                   	push   %eax
8010541b:	6a 02                	push   $0x2
8010541d:	e8 ee f8 ff ff       	call   80104d10 <argint>
80105422:	83 c4 10             	add    $0x10,%esp
80105425:	85 c0                	test   %eax,%eax
80105427:	78 37                	js     80105460 <sys_read+0x70>
80105429:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010542c:	83 ec 04             	sub    $0x4,%esp
8010542f:	ff 75 f0             	pushl  -0x10(%ebp)
80105432:	50                   	push   %eax
80105433:	6a 01                	push   $0x1
80105435:	e8 26 f9 ff ff       	call   80104d60 <argptr>
8010543a:	83 c4 10             	add    $0x10,%esp
8010543d:	85 c0                	test   %eax,%eax
8010543f:	78 1f                	js     80105460 <sys_read+0x70>
  return fileread(f, p, n);
80105441:	83 ec 04             	sub    $0x4,%esp
80105444:	ff 75 f0             	pushl  -0x10(%ebp)
80105447:	ff 75 f4             	pushl  -0xc(%ebp)
8010544a:	ff 75 ec             	pushl  -0x14(%ebp)
8010544d:	e8 0e bb ff ff       	call   80100f60 <fileread>
80105452:	83 c4 10             	add    $0x10,%esp
}
80105455:	c9                   	leave  
80105456:	c3                   	ret    
80105457:	89 f6                	mov    %esi,%esi
80105459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105460:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105465:	c9                   	leave  
80105466:	c3                   	ret    
80105467:	89 f6                	mov    %esi,%esi
80105469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105470 <sys_write>:
{ if(isTraceOn==1)
80105470:	55                   	push   %ebp
80105471:	89 e5                	mov    %esp,%ebp
80105473:	83 ec 18             	sub    $0x18,%esp
80105476:	83 3d 18 27 11 80 01 	cmpl   $0x1,0x80112718
8010547d:	75 07                	jne    80105486 <sys_write+0x16>
  {num_calls[SYS_write] ++;}
8010547f:	83 05 80 2a 11 80 01 	addl   $0x1,0x80112a80
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105486:	8d 55 ec             	lea    -0x14(%ebp),%edx
80105489:	31 c0                	xor    %eax,%eax
8010548b:	e8 90 fe ff ff       	call   80105320 <argfd.constprop.0>
80105490:	85 c0                	test   %eax,%eax
80105492:	78 4c                	js     801054e0 <sys_write+0x70>
80105494:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105497:	83 ec 08             	sub    $0x8,%esp
8010549a:	50                   	push   %eax
8010549b:	6a 02                	push   $0x2
8010549d:	e8 6e f8 ff ff       	call   80104d10 <argint>
801054a2:	83 c4 10             	add    $0x10,%esp
801054a5:	85 c0                	test   %eax,%eax
801054a7:	78 37                	js     801054e0 <sys_write+0x70>
801054a9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054ac:	83 ec 04             	sub    $0x4,%esp
801054af:	ff 75 f0             	pushl  -0x10(%ebp)
801054b2:	50                   	push   %eax
801054b3:	6a 01                	push   $0x1
801054b5:	e8 a6 f8 ff ff       	call   80104d60 <argptr>
801054ba:	83 c4 10             	add    $0x10,%esp
801054bd:	85 c0                	test   %eax,%eax
801054bf:	78 1f                	js     801054e0 <sys_write+0x70>
  return filewrite(f, p, n);
801054c1:	83 ec 04             	sub    $0x4,%esp
801054c4:	ff 75 f0             	pushl  -0x10(%ebp)
801054c7:	ff 75 f4             	pushl  -0xc(%ebp)
801054ca:	ff 75 ec             	pushl  -0x14(%ebp)
801054cd:	e8 1e bb ff ff       	call   80100ff0 <filewrite>
801054d2:	83 c4 10             	add    $0x10,%esp
}
801054d5:	c9                   	leave  
801054d6:	c3                   	ret    
801054d7:	89 f6                	mov    %esi,%esi
801054d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801054e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054e5:	c9                   	leave  
801054e6:	c3                   	ret    
801054e7:	89 f6                	mov    %esi,%esi
801054e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801054f0 <sys_close>:
{ if(isTraceOn==1)
801054f0:	55                   	push   %ebp
801054f1:	89 e5                	mov    %esp,%ebp
801054f3:	83 ec 18             	sub    $0x18,%esp
801054f6:	83 3d 18 27 11 80 01 	cmpl   $0x1,0x80112718
801054fd:	75 07                	jne    80105506 <sys_close+0x16>
  {num_calls[SYS_close] ++;}
801054ff:	83 05 94 2a 11 80 01 	addl   $0x1,0x80112a94
  if(argfd(0, &fd, &f) < 0)
80105506:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105509:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010550c:	e8 0f fe ff ff       	call   80105320 <argfd.constprop.0>
80105511:	85 c0                	test   %eax,%eax
80105513:	78 2b                	js     80105540 <sys_close+0x50>
  myproc()->ofile[fd] = 0;
80105515:	e8 e6 e2 ff ff       	call   80103800 <myproc>
8010551a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
8010551d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105520:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80105527:	00 
  fileclose(f);
80105528:	ff 75 f4             	pushl  -0xc(%ebp)
8010552b:	e8 10 b9 ff ff       	call   80100e40 <fileclose>
  return 0;
80105530:	83 c4 10             	add    $0x10,%esp
80105533:	31 c0                	xor    %eax,%eax
}
80105535:	c9                   	leave  
80105536:	c3                   	ret    
80105537:	89 f6                	mov    %esi,%esi
80105539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105540:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105545:	c9                   	leave  
80105546:	c3                   	ret    
80105547:	89 f6                	mov    %esi,%esi
80105549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105550 <sys_fstat>:
{ if(isTraceOn==1)
80105550:	55                   	push   %ebp
80105551:	89 e5                	mov    %esp,%ebp
80105553:	83 ec 18             	sub    $0x18,%esp
80105556:	83 3d 18 27 11 80 01 	cmpl   $0x1,0x80112718
8010555d:	75 07                	jne    80105566 <sys_fstat+0x16>
  {num_calls[SYS_fstat] ++;}
8010555f:	83 05 60 2a 11 80 01 	addl   $0x1,0x80112a60
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105566:	8d 55 f0             	lea    -0x10(%ebp),%edx
80105569:	31 c0                	xor    %eax,%eax
8010556b:	e8 b0 fd ff ff       	call   80105320 <argfd.constprop.0>
80105570:	85 c0                	test   %eax,%eax
80105572:	78 2c                	js     801055a0 <sys_fstat+0x50>
80105574:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105577:	83 ec 04             	sub    $0x4,%esp
8010557a:	6a 14                	push   $0x14
8010557c:	50                   	push   %eax
8010557d:	6a 01                	push   $0x1
8010557f:	e8 dc f7 ff ff       	call   80104d60 <argptr>
80105584:	83 c4 10             	add    $0x10,%esp
80105587:	85 c0                	test   %eax,%eax
80105589:	78 15                	js     801055a0 <sys_fstat+0x50>
  return filestat(f, st);
8010558b:	83 ec 08             	sub    $0x8,%esp
8010558e:	ff 75 f4             	pushl  -0xc(%ebp)
80105591:	ff 75 f0             	pushl  -0x10(%ebp)
80105594:	e8 77 b9 ff ff       	call   80100f10 <filestat>
80105599:	83 c4 10             	add    $0x10,%esp
}
8010559c:	c9                   	leave  
8010559d:	c3                   	ret    
8010559e:	66 90                	xchg   %ax,%ax
    return -1;
801055a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055a5:	c9                   	leave  
801055a6:	c3                   	ret    
801055a7:	89 f6                	mov    %esi,%esi
801055a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055b0 <sys_link>:
{
801055b0:	55                   	push   %ebp
801055b1:	89 e5                	mov    %esp,%ebp
801055b3:	57                   	push   %edi
801055b4:	56                   	push   %esi
801055b5:	53                   	push   %ebx
801055b6:	83 ec 2c             	sub    $0x2c,%esp
  if(isTraceOn==1)
801055b9:	83 3d 18 27 11 80 01 	cmpl   $0x1,0x80112718
801055c0:	75 07                	jne    801055c9 <sys_link+0x19>
  {num_calls[SYS_link] ++;}
801055c2:	83 05 8c 2a 11 80 01 	addl   $0x1,0x80112a8c
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801055c9:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801055cc:	83 ec 08             	sub    $0x8,%esp
801055cf:	50                   	push   %eax
801055d0:	6a 00                	push   $0x0
801055d2:	e8 e9 f7 ff ff       	call   80104dc0 <argstr>
801055d7:	83 c4 10             	add    $0x10,%esp
801055da:	85 c0                	test   %eax,%eax
801055dc:	0f 88 f8 00 00 00    	js     801056da <sys_link+0x12a>
801055e2:	8d 45 d0             	lea    -0x30(%ebp),%eax
801055e5:	83 ec 08             	sub    $0x8,%esp
801055e8:	50                   	push   %eax
801055e9:	6a 01                	push   $0x1
801055eb:	e8 d0 f7 ff ff       	call   80104dc0 <argstr>
801055f0:	83 c4 10             	add    $0x10,%esp
801055f3:	85 c0                	test   %eax,%eax
801055f5:	0f 88 df 00 00 00    	js     801056da <sys_link+0x12a>
  begin_op();
801055fb:	e8 c0 d5 ff ff       	call   80102bc0 <begin_op>
  if((ip = namei(old)) == 0){
80105600:	83 ec 0c             	sub    $0xc,%esp
80105603:	ff 75 d4             	pushl  -0x2c(%ebp)
80105606:	e8 f5 c8 ff ff       	call   80101f00 <namei>
8010560b:	83 c4 10             	add    $0x10,%esp
8010560e:	85 c0                	test   %eax,%eax
80105610:	89 c3                	mov    %eax,%ebx
80105612:	0f 84 e7 00 00 00    	je     801056ff <sys_link+0x14f>
  ilock(ip);
80105618:	83 ec 0c             	sub    $0xc,%esp
8010561b:	50                   	push   %eax
8010561c:	e8 6f c0 ff ff       	call   80101690 <ilock>
  if(ip->type == T_DIR){
80105621:	83 c4 10             	add    $0x10,%esp
80105624:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105629:	0f 84 b8 00 00 00    	je     801056e7 <sys_link+0x137>
  ip->nlink++;
8010562f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105634:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80105637:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
8010563a:	53                   	push   %ebx
8010563b:	e8 a0 bf ff ff       	call   801015e0 <iupdate>
  iunlock(ip);
80105640:	89 1c 24             	mov    %ebx,(%esp)
80105643:	e8 28 c1 ff ff       	call   80101770 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105648:	58                   	pop    %eax
80105649:	5a                   	pop    %edx
8010564a:	57                   	push   %edi
8010564b:	ff 75 d0             	pushl  -0x30(%ebp)
8010564e:	e8 cd c8 ff ff       	call   80101f20 <nameiparent>
80105653:	83 c4 10             	add    $0x10,%esp
80105656:	85 c0                	test   %eax,%eax
80105658:	89 c6                	mov    %eax,%esi
8010565a:	74 58                	je     801056b4 <sys_link+0x104>
  ilock(dp);
8010565c:	83 ec 0c             	sub    $0xc,%esp
8010565f:	50                   	push   %eax
80105660:	e8 2b c0 ff ff       	call   80101690 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105665:	83 c4 10             	add    $0x10,%esp
80105668:	8b 03                	mov    (%ebx),%eax
8010566a:	39 06                	cmp    %eax,(%esi)
8010566c:	75 3a                	jne    801056a8 <sys_link+0xf8>
8010566e:	83 ec 04             	sub    $0x4,%esp
80105671:	ff 73 04             	pushl  0x4(%ebx)
80105674:	57                   	push   %edi
80105675:	56                   	push   %esi
80105676:	e8 c5 c7 ff ff       	call   80101e40 <dirlink>
8010567b:	83 c4 10             	add    $0x10,%esp
8010567e:	85 c0                	test   %eax,%eax
80105680:	78 26                	js     801056a8 <sys_link+0xf8>
  iunlockput(dp);
80105682:	83 ec 0c             	sub    $0xc,%esp
80105685:	56                   	push   %esi
80105686:	e8 95 c2 ff ff       	call   80101920 <iunlockput>
  iput(ip);
8010568b:	89 1c 24             	mov    %ebx,(%esp)
8010568e:	e8 2d c1 ff ff       	call   801017c0 <iput>
  end_op();
80105693:	e8 98 d5 ff ff       	call   80102c30 <end_op>
  return 0;
80105698:	83 c4 10             	add    $0x10,%esp
8010569b:	31 c0                	xor    %eax,%eax
}
8010569d:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056a0:	5b                   	pop    %ebx
801056a1:	5e                   	pop    %esi
801056a2:	5f                   	pop    %edi
801056a3:	5d                   	pop    %ebp
801056a4:	c3                   	ret    
801056a5:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(dp);
801056a8:	83 ec 0c             	sub    $0xc,%esp
801056ab:	56                   	push   %esi
801056ac:	e8 6f c2 ff ff       	call   80101920 <iunlockput>
    goto bad;
801056b1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801056b4:	83 ec 0c             	sub    $0xc,%esp
801056b7:	53                   	push   %ebx
801056b8:	e8 d3 bf ff ff       	call   80101690 <ilock>
  ip->nlink--;
801056bd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801056c2:	89 1c 24             	mov    %ebx,(%esp)
801056c5:	e8 16 bf ff ff       	call   801015e0 <iupdate>
  iunlockput(ip);
801056ca:	89 1c 24             	mov    %ebx,(%esp)
801056cd:	e8 4e c2 ff ff       	call   80101920 <iunlockput>
  end_op();
801056d2:	e8 59 d5 ff ff       	call   80102c30 <end_op>
  return -1;
801056d7:	83 c4 10             	add    $0x10,%esp
}
801056da:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801056dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801056e2:	5b                   	pop    %ebx
801056e3:	5e                   	pop    %esi
801056e4:	5f                   	pop    %edi
801056e5:	5d                   	pop    %ebp
801056e6:	c3                   	ret    
    iunlockput(ip);
801056e7:	83 ec 0c             	sub    $0xc,%esp
801056ea:	53                   	push   %ebx
801056eb:	e8 30 c2 ff ff       	call   80101920 <iunlockput>
    end_op();
801056f0:	e8 3b d5 ff ff       	call   80102c30 <end_op>
    return -1;
801056f5:	83 c4 10             	add    $0x10,%esp
801056f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056fd:	eb 9e                	jmp    8010569d <sys_link+0xed>
    end_op();
801056ff:	e8 2c d5 ff ff       	call   80102c30 <end_op>
    return -1;
80105704:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105709:	eb 92                	jmp    8010569d <sys_link+0xed>
8010570b:	90                   	nop
8010570c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105710 <sys_unlink>:
{ if(isTraceOn==1)
80105710:	55                   	push   %ebp
80105711:	89 e5                	mov    %esp,%ebp
80105713:	57                   	push   %edi
80105714:	56                   	push   %esi
80105715:	53                   	push   %ebx
80105716:	83 ec 3c             	sub    $0x3c,%esp
80105719:	83 3d 18 27 11 80 01 	cmpl   $0x1,0x80112718
80105720:	75 07                	jne    80105729 <sys_unlink+0x19>
  {num_calls[SYS_unlink] ++;}
80105722:	83 05 88 2a 11 80 01 	addl   $0x1,0x80112a88
  if(argstr(0, &path) < 0)
80105729:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010572c:	83 ec 08             	sub    $0x8,%esp
8010572f:	50                   	push   %eax
80105730:	6a 00                	push   $0x0
80105732:	e8 89 f6 ff ff       	call   80104dc0 <argstr>
80105737:	83 c4 10             	add    $0x10,%esp
8010573a:	85 c0                	test   %eax,%eax
8010573c:	0f 88 74 01 00 00    	js     801058b6 <sys_unlink+0x1a6>
  if((dp = nameiparent(path, name)) == 0){
80105742:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80105745:	e8 76 d4 ff ff       	call   80102bc0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
8010574a:	83 ec 08             	sub    $0x8,%esp
8010574d:	53                   	push   %ebx
8010574e:	ff 75 c0             	pushl  -0x40(%ebp)
80105751:	e8 ca c7 ff ff       	call   80101f20 <nameiparent>
80105756:	83 c4 10             	add    $0x10,%esp
80105759:	85 c0                	test   %eax,%eax
8010575b:	89 c6                	mov    %eax,%esi
8010575d:	0f 84 5d 01 00 00    	je     801058c0 <sys_unlink+0x1b0>
  ilock(dp);
80105763:	83 ec 0c             	sub    $0xc,%esp
80105766:	50                   	push   %eax
80105767:	e8 24 bf ff ff       	call   80101690 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010576c:	58                   	pop    %eax
8010576d:	5a                   	pop    %edx
8010576e:	68 7c 8c 10 80       	push   $0x80108c7c
80105773:	53                   	push   %ebx
80105774:	e8 27 c4 ff ff       	call   80101ba0 <namecmp>
80105779:	83 c4 10             	add    $0x10,%esp
8010577c:	85 c0                	test   %eax,%eax
8010577e:	0f 84 00 01 00 00    	je     80105884 <sys_unlink+0x174>
80105784:	83 ec 08             	sub    $0x8,%esp
80105787:	68 7b 8c 10 80       	push   $0x80108c7b
8010578c:	53                   	push   %ebx
8010578d:	e8 0e c4 ff ff       	call   80101ba0 <namecmp>
80105792:	83 c4 10             	add    $0x10,%esp
80105795:	85 c0                	test   %eax,%eax
80105797:	0f 84 e7 00 00 00    	je     80105884 <sys_unlink+0x174>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010579d:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801057a0:	83 ec 04             	sub    $0x4,%esp
801057a3:	50                   	push   %eax
801057a4:	53                   	push   %ebx
801057a5:	56                   	push   %esi
801057a6:	e8 15 c4 ff ff       	call   80101bc0 <dirlookup>
801057ab:	83 c4 10             	add    $0x10,%esp
801057ae:	85 c0                	test   %eax,%eax
801057b0:	89 c3                	mov    %eax,%ebx
801057b2:	0f 84 cc 00 00 00    	je     80105884 <sys_unlink+0x174>
  ilock(ip);
801057b8:	83 ec 0c             	sub    $0xc,%esp
801057bb:	50                   	push   %eax
801057bc:	e8 cf be ff ff       	call   80101690 <ilock>
  if(ip->nlink < 1)
801057c1:	83 c4 10             	add    $0x10,%esp
801057c4:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801057c9:	0f 8e 0d 01 00 00    	jle    801058dc <sys_unlink+0x1cc>
  if(ip->type == T_DIR && !isdirempty(ip)){
801057cf:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801057d4:	74 6a                	je     80105840 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
801057d6:	8d 45 d8             	lea    -0x28(%ebp),%eax
801057d9:	83 ec 04             	sub    $0x4,%esp
801057dc:	6a 10                	push   $0x10
801057de:	6a 00                	push   $0x0
801057e0:	50                   	push   %eax
801057e1:	e8 2a f2 ff ff       	call   80104a10 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801057e6:	8d 45 d8             	lea    -0x28(%ebp),%eax
801057e9:	6a 10                	push   $0x10
801057eb:	ff 75 c4             	pushl  -0x3c(%ebp)
801057ee:	50                   	push   %eax
801057ef:	56                   	push   %esi
801057f0:	e8 7b c2 ff ff       	call   80101a70 <writei>
801057f5:	83 c4 20             	add    $0x20,%esp
801057f8:	83 f8 10             	cmp    $0x10,%eax
801057fb:	0f 85 e8 00 00 00    	jne    801058e9 <sys_unlink+0x1d9>
  if(ip->type == T_DIR){
80105801:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105806:	0f 84 94 00 00 00    	je     801058a0 <sys_unlink+0x190>
  iunlockput(dp);
8010580c:	83 ec 0c             	sub    $0xc,%esp
8010580f:	56                   	push   %esi
80105810:	e8 0b c1 ff ff       	call   80101920 <iunlockput>
  ip->nlink--;
80105815:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010581a:	89 1c 24             	mov    %ebx,(%esp)
8010581d:	e8 be bd ff ff       	call   801015e0 <iupdate>
  iunlockput(ip);
80105822:	89 1c 24             	mov    %ebx,(%esp)
80105825:	e8 f6 c0 ff ff       	call   80101920 <iunlockput>
  end_op();
8010582a:	e8 01 d4 ff ff       	call   80102c30 <end_op>
  return 0;
8010582f:	83 c4 10             	add    $0x10,%esp
80105832:	31 c0                	xor    %eax,%eax
}
80105834:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105837:	5b                   	pop    %ebx
80105838:	5e                   	pop    %esi
80105839:	5f                   	pop    %edi
8010583a:	5d                   	pop    %ebp
8010583b:	c3                   	ret    
8010583c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105840:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105844:	76 90                	jbe    801057d6 <sys_unlink+0xc6>
80105846:	bf 20 00 00 00       	mov    $0x20,%edi
8010584b:	eb 0f                	jmp    8010585c <sys_unlink+0x14c>
8010584d:	8d 76 00             	lea    0x0(%esi),%esi
80105850:	83 c7 10             	add    $0x10,%edi
80105853:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105856:	0f 83 7a ff ff ff    	jae    801057d6 <sys_unlink+0xc6>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010585c:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010585f:	6a 10                	push   $0x10
80105861:	57                   	push   %edi
80105862:	50                   	push   %eax
80105863:	53                   	push   %ebx
80105864:	e8 07 c1 ff ff       	call   80101970 <readi>
80105869:	83 c4 10             	add    $0x10,%esp
8010586c:	83 f8 10             	cmp    $0x10,%eax
8010586f:	75 5e                	jne    801058cf <sys_unlink+0x1bf>
    if(de.inum != 0)
80105871:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105876:	74 d8                	je     80105850 <sys_unlink+0x140>
    iunlockput(ip);
80105878:	83 ec 0c             	sub    $0xc,%esp
8010587b:	53                   	push   %ebx
8010587c:	e8 9f c0 ff ff       	call   80101920 <iunlockput>
    goto bad;
80105881:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80105884:	83 ec 0c             	sub    $0xc,%esp
80105887:	56                   	push   %esi
80105888:	e8 93 c0 ff ff       	call   80101920 <iunlockput>
  end_op();
8010588d:	e8 9e d3 ff ff       	call   80102c30 <end_op>
  return -1;
80105892:	83 c4 10             	add    $0x10,%esp
80105895:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010589a:	eb 98                	jmp    80105834 <sys_unlink+0x124>
8010589c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
801058a0:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
801058a5:	83 ec 0c             	sub    $0xc,%esp
801058a8:	56                   	push   %esi
801058a9:	e8 32 bd ff ff       	call   801015e0 <iupdate>
801058ae:	83 c4 10             	add    $0x10,%esp
801058b1:	e9 56 ff ff ff       	jmp    8010580c <sys_unlink+0xfc>
    return -1;
801058b6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058bb:	e9 74 ff ff ff       	jmp    80105834 <sys_unlink+0x124>
    end_op();
801058c0:	e8 6b d3 ff ff       	call   80102c30 <end_op>
    return -1;
801058c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058ca:	e9 65 ff ff ff       	jmp    80105834 <sys_unlink+0x124>
      panic("isdirempty: readi");
801058cf:	83 ec 0c             	sub    $0xc,%esp
801058d2:	68 a0 8c 10 80       	push   $0x80108ca0
801058d7:	e8 b4 aa ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
801058dc:	83 ec 0c             	sub    $0xc,%esp
801058df:	68 8e 8c 10 80       	push   $0x80108c8e
801058e4:	e8 a7 aa ff ff       	call   80100390 <panic>
    panic("unlink: writei");
801058e9:	83 ec 0c             	sub    $0xc,%esp
801058ec:	68 b2 8c 10 80       	push   $0x80108cb2
801058f1:	e8 9a aa ff ff       	call   80100390 <panic>
801058f6:	8d 76 00             	lea    0x0(%esi),%esi
801058f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105900 <sys_mkdir>:
// end  new code


int
sys_mkdir(void)
{ if(isTraceOn==1)
80105900:	55                   	push   %ebp
80105901:	89 e5                	mov    %esp,%ebp
80105903:	83 ec 18             	sub    $0x18,%esp
80105906:	83 3d 18 27 11 80 01 	cmpl   $0x1,0x80112718
8010590d:	75 07                	jne    80105916 <sys_mkdir+0x16>
  {num_calls[SYS_mkdir] ++;}
8010590f:	83 05 90 2a 11 80 01 	addl   $0x1,0x80112a90
  char *path;
  struct inode *ip;

  begin_op();
80105916:	e8 a5 d2 ff ff       	call   80102bc0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010591b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010591e:	83 ec 08             	sub    $0x8,%esp
80105921:	50                   	push   %eax
80105922:	6a 00                	push   $0x0
80105924:	e8 97 f4 ff ff       	call   80104dc0 <argstr>
80105929:	83 c4 10             	add    $0x10,%esp
8010592c:	85 c0                	test   %eax,%eax
8010592e:	78 30                	js     80105960 <sys_mkdir+0x60>
80105930:	83 ec 0c             	sub    $0xc,%esp
80105933:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105936:	31 c9                	xor    %ecx,%ecx
80105938:	6a 00                	push   $0x0
8010593a:	ba 01 00 00 00       	mov    $0x1,%edx
8010593f:	e8 3c f8 ff ff       	call   80105180 <create>
80105944:	83 c4 10             	add    $0x10,%esp
80105947:	85 c0                	test   %eax,%eax
80105949:	74 15                	je     80105960 <sys_mkdir+0x60>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010594b:	83 ec 0c             	sub    $0xc,%esp
8010594e:	50                   	push   %eax
8010594f:	e8 cc bf ff ff       	call   80101920 <iunlockput>
  end_op();
80105954:	e8 d7 d2 ff ff       	call   80102c30 <end_op>
  return 0;
80105959:	83 c4 10             	add    $0x10,%esp
8010595c:	31 c0                	xor    %eax,%eax
}
8010595e:	c9                   	leave  
8010595f:	c3                   	ret    
    end_op();
80105960:	e8 cb d2 ff ff       	call   80102c30 <end_op>
    return -1;
80105965:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010596a:	c9                   	leave  
8010596b:	c3                   	ret    
8010596c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105970 <sys_mknod>:

int
sys_mknod(void)
{ if(isTraceOn==1)
80105970:	55                   	push   %ebp
80105971:	89 e5                	mov    %esp,%ebp
80105973:	83 ec 18             	sub    $0x18,%esp
80105976:	83 3d 18 27 11 80 01 	cmpl   $0x1,0x80112718
8010597d:	75 07                	jne    80105986 <sys_mknod+0x16>
  {num_calls[SYS_mknod] ++;}
8010597f:	83 05 84 2a 11 80 01 	addl   $0x1,0x80112a84
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105986:	e8 35 d2 ff ff       	call   80102bc0 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010598b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010598e:	83 ec 08             	sub    $0x8,%esp
80105991:	50                   	push   %eax
80105992:	6a 00                	push   $0x0
80105994:	e8 27 f4 ff ff       	call   80104dc0 <argstr>
80105999:	83 c4 10             	add    $0x10,%esp
8010599c:	85 c0                	test   %eax,%eax
8010599e:	78 60                	js     80105a00 <sys_mknod+0x90>
     argint(1, &major) < 0 ||
801059a0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801059a3:	83 ec 08             	sub    $0x8,%esp
801059a6:	50                   	push   %eax
801059a7:	6a 01                	push   $0x1
801059a9:	e8 62 f3 ff ff       	call   80104d10 <argint>
  if((argstr(0, &path)) < 0 ||
801059ae:	83 c4 10             	add    $0x10,%esp
801059b1:	85 c0                	test   %eax,%eax
801059b3:	78 4b                	js     80105a00 <sys_mknod+0x90>
     argint(2, &minor) < 0 ||
801059b5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801059b8:	83 ec 08             	sub    $0x8,%esp
801059bb:	50                   	push   %eax
801059bc:	6a 02                	push   $0x2
801059be:	e8 4d f3 ff ff       	call   80104d10 <argint>
     argint(1, &major) < 0 ||
801059c3:	83 c4 10             	add    $0x10,%esp
801059c6:	85 c0                	test   %eax,%eax
801059c8:	78 36                	js     80105a00 <sys_mknod+0x90>
     (ip = create(path, T_DEV, major, minor)) == 0){
801059ca:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
801059ce:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
801059d1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
801059d5:	ba 03 00 00 00       	mov    $0x3,%edx
801059da:	50                   	push   %eax
801059db:	8b 45 ec             	mov    -0x14(%ebp),%eax
801059de:	e8 9d f7 ff ff       	call   80105180 <create>
801059e3:	83 c4 10             	add    $0x10,%esp
801059e6:	85 c0                	test   %eax,%eax
801059e8:	74 16                	je     80105a00 <sys_mknod+0x90>
    end_op();
    return -1;
  }
  iunlockput(ip);
801059ea:	83 ec 0c             	sub    $0xc,%esp
801059ed:	50                   	push   %eax
801059ee:	e8 2d bf ff ff       	call   80101920 <iunlockput>
  end_op();
801059f3:	e8 38 d2 ff ff       	call   80102c30 <end_op>
  return 0;
801059f8:	83 c4 10             	add    $0x10,%esp
801059fb:	31 c0                	xor    %eax,%eax
}
801059fd:	c9                   	leave  
801059fe:	c3                   	ret    
801059ff:	90                   	nop
    end_op();
80105a00:	e8 2b d2 ff ff       	call   80102c30 <end_op>
    return -1;
80105a05:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a0a:	c9                   	leave  
80105a0b:	c3                   	ret    
80105a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105a10 <sys_chdir>:

int
sys_chdir(void)
{ if(isTraceOn==1)
80105a10:	55                   	push   %ebp
80105a11:	89 e5                	mov    %esp,%ebp
80105a13:	56                   	push   %esi
80105a14:	53                   	push   %ebx
80105a15:	83 ec 10             	sub    $0x10,%esp
80105a18:	83 3d 18 27 11 80 01 	cmpl   $0x1,0x80112718
80105a1f:	75 07                	jne    80105a28 <sys_chdir+0x18>
  {num_calls[SYS_chdir] ++;}
80105a21:	83 05 64 2a 11 80 01 	addl   $0x1,0x80112a64
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105a28:	e8 d3 dd ff ff       	call   80103800 <myproc>
80105a2d:	89 c6                	mov    %eax,%esi

  begin_op();
80105a2f:	e8 8c d1 ff ff       	call   80102bc0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105a34:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a37:	83 ec 08             	sub    $0x8,%esp
80105a3a:	50                   	push   %eax
80105a3b:	6a 00                	push   $0x0
80105a3d:	e8 7e f3 ff ff       	call   80104dc0 <argstr>
80105a42:	83 c4 10             	add    $0x10,%esp
80105a45:	85 c0                	test   %eax,%eax
80105a47:	78 77                	js     80105ac0 <sys_chdir+0xb0>
80105a49:	83 ec 0c             	sub    $0xc,%esp
80105a4c:	ff 75 f4             	pushl  -0xc(%ebp)
80105a4f:	e8 ac c4 ff ff       	call   80101f00 <namei>
80105a54:	83 c4 10             	add    $0x10,%esp
80105a57:	85 c0                	test   %eax,%eax
80105a59:	89 c3                	mov    %eax,%ebx
80105a5b:	74 63                	je     80105ac0 <sys_chdir+0xb0>
    end_op();
    return -1;
  }
  ilock(ip);
80105a5d:	83 ec 0c             	sub    $0xc,%esp
80105a60:	50                   	push   %eax
80105a61:	e8 2a bc ff ff       	call   80101690 <ilock>
  if(ip->type != T_DIR){
80105a66:	83 c4 10             	add    $0x10,%esp
80105a69:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105a6e:	75 30                	jne    80105aa0 <sys_chdir+0x90>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105a70:	83 ec 0c             	sub    $0xc,%esp
80105a73:	53                   	push   %ebx
80105a74:	e8 f7 bc ff ff       	call   80101770 <iunlock>
  iput(curproc->cwd);
80105a79:	58                   	pop    %eax
80105a7a:	ff b6 b8 01 00 00    	pushl  0x1b8(%esi)
80105a80:	e8 3b bd ff ff       	call   801017c0 <iput>
  end_op();
80105a85:	e8 a6 d1 ff ff       	call   80102c30 <end_op>
  curproc->cwd = ip;
80105a8a:	89 9e b8 01 00 00    	mov    %ebx,0x1b8(%esi)
  return 0;
80105a90:	83 c4 10             	add    $0x10,%esp
80105a93:	31 c0                	xor    %eax,%eax
}
80105a95:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105a98:	5b                   	pop    %ebx
80105a99:	5e                   	pop    %esi
80105a9a:	5d                   	pop    %ebp
80105a9b:	c3                   	ret    
80105a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
80105aa0:	83 ec 0c             	sub    $0xc,%esp
80105aa3:	53                   	push   %ebx
80105aa4:	e8 77 be ff ff       	call   80101920 <iunlockput>
    end_op();
80105aa9:	e8 82 d1 ff ff       	call   80102c30 <end_op>
    return -1;
80105aae:	83 c4 10             	add    $0x10,%esp
80105ab1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ab6:	eb dd                	jmp    80105a95 <sys_chdir+0x85>
80105ab8:	90                   	nop
80105ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105ac0:	e8 6b d1 ff ff       	call   80102c30 <end_op>
    return -1;
80105ac5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105aca:	eb c9                	jmp    80105a95 <sys_chdir+0x85>
80105acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ad0 <sys_exec>:

int
sys_exec(void)
{ if(isTraceOn==1)
80105ad0:	55                   	push   %ebp
80105ad1:	89 e5                	mov    %esp,%ebp
80105ad3:	57                   	push   %edi
80105ad4:	56                   	push   %esi
80105ad5:	53                   	push   %ebx
80105ad6:	81 ec 9c 00 00 00    	sub    $0x9c,%esp
80105adc:	83 3d 18 27 11 80 01 	cmpl   $0x1,0x80112718
80105ae3:	75 07                	jne    80105aec <sys_exec+0x1c>
  {num_calls[SYS_exec] ++;}
80105ae5:	83 05 5c 2a 11 80 01 	addl   $0x1,0x80112a5c
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105aec:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80105af2:	83 ec 08             	sub    $0x8,%esp
80105af5:	50                   	push   %eax
80105af6:	6a 00                	push   $0x0
80105af8:	e8 c3 f2 ff ff       	call   80104dc0 <argstr>
80105afd:	83 c4 10             	add    $0x10,%esp
80105b00:	85 c0                	test   %eax,%eax
80105b02:	0f 88 8c 00 00 00    	js     80105b94 <sys_exec+0xc4>
80105b08:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105b0e:	83 ec 08             	sub    $0x8,%esp
80105b11:	50                   	push   %eax
80105b12:	6a 01                	push   $0x1
80105b14:	e8 f7 f1 ff ff       	call   80104d10 <argint>
80105b19:	83 c4 10             	add    $0x10,%esp
80105b1c:	85 c0                	test   %eax,%eax
80105b1e:	78 74                	js     80105b94 <sys_exec+0xc4>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105b20:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105b26:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105b29:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105b2b:	68 80 00 00 00       	push   $0x80
80105b30:	6a 00                	push   $0x0
80105b32:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105b38:	50                   	push   %eax
80105b39:	e8 d2 ee ff ff       	call   80104a10 <memset>
80105b3e:	83 c4 10             	add    $0x10,%esp
80105b41:	eb 31                	jmp    80105b74 <sys_exec+0xa4>
80105b43:	90                   	nop
80105b44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80105b48:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105b4e:	85 c0                	test   %eax,%eax
80105b50:	74 56                	je     80105ba8 <sys_exec+0xd8>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105b52:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105b58:	83 ec 08             	sub    $0x8,%esp
80105b5b:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105b5e:	52                   	push   %edx
80105b5f:	50                   	push   %eax
80105b60:	e8 3b f1 ff ff       	call   80104ca0 <fetchstr>
80105b65:	83 c4 10             	add    $0x10,%esp
80105b68:	85 c0                	test   %eax,%eax
80105b6a:	78 28                	js     80105b94 <sys_exec+0xc4>
  for(i=0;; i++){
80105b6c:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105b6f:	83 fb 20             	cmp    $0x20,%ebx
80105b72:	74 20                	je     80105b94 <sys_exec+0xc4>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105b74:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105b7a:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105b81:	83 ec 08             	sub    $0x8,%esp
80105b84:	57                   	push   %edi
80105b85:	01 f0                	add    %esi,%eax
80105b87:	50                   	push   %eax
80105b88:	e8 d3 f0 ff ff       	call   80104c60 <fetchint>
80105b8d:	83 c4 10             	add    $0x10,%esp
80105b90:	85 c0                	test   %eax,%eax
80105b92:	79 b4                	jns    80105b48 <sys_exec+0x78>
      return -1;
  }
  return exec(path, argv);
}
80105b94:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105b97:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b9c:	5b                   	pop    %ebx
80105b9d:	5e                   	pop    %esi
80105b9e:	5f                   	pop    %edi
80105b9f:	5d                   	pop    %ebp
80105ba0:	c3                   	ret    
80105ba1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105ba8:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105bae:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105bb1:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105bb8:	00 00 00 00 
  return exec(path, argv);
80105bbc:	50                   	push   %eax
80105bbd:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105bc3:	e8 48 ae ff ff       	call   80100a10 <exec>
80105bc8:	83 c4 10             	add    $0x10,%esp
}
80105bcb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bce:	5b                   	pop    %ebx
80105bcf:	5e                   	pop    %esi
80105bd0:	5f                   	pop    %edi
80105bd1:	5d                   	pop    %ebp
80105bd2:	c3                   	ret    
80105bd3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105be0 <sys_pipe>:

int
sys_pipe(void)
{ if(isTraceOn==1)
80105be0:	55                   	push   %ebp
80105be1:	89 e5                	mov    %esp,%ebp
80105be3:	57                   	push   %edi
80105be4:	56                   	push   %esi
80105be5:	53                   	push   %ebx
80105be6:	83 ec 1c             	sub    $0x1c,%esp
80105be9:	83 3d 18 27 11 80 01 	cmpl   $0x1,0x80112718
80105bf0:	75 07                	jne    80105bf9 <sys_pipe+0x19>
  {num_calls[SYS_pipe] ++;}
80105bf2:	83 05 50 2a 11 80 01 	addl   $0x1,0x80112a50
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105bf9:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105bfc:	83 ec 04             	sub    $0x4,%esp
80105bff:	6a 08                	push   $0x8
80105c01:	50                   	push   %eax
80105c02:	6a 00                	push   $0x0
80105c04:	e8 57 f1 ff ff       	call   80104d60 <argptr>
80105c09:	83 c4 10             	add    $0x10,%esp
80105c0c:	85 c0                	test   %eax,%eax
80105c0e:	0f 88 a3 00 00 00    	js     80105cb7 <sys_pipe+0xd7>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105c14:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105c17:	83 ec 08             	sub    $0x8,%esp
80105c1a:	50                   	push   %eax
80105c1b:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105c1e:	50                   	push   %eax
80105c1f:	e8 3c d6 ff ff       	call   80103260 <pipealloc>
80105c24:	83 c4 10             	add    $0x10,%esp
80105c27:	85 c0                	test   %eax,%eax
80105c29:	0f 88 88 00 00 00    	js     80105cb7 <sys_pipe+0xd7>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105c2f:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105c32:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105c34:	e8 c7 db ff ff       	call   80103800 <myproc>
80105c39:	eb 0d                	jmp    80105c48 <sys_pipe+0x68>
80105c3b:	90                   	nop
80105c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105c40:	83 c3 01             	add    $0x1,%ebx
80105c43:	83 fb 64             	cmp    $0x64,%ebx
80105c46:	74 58                	je     80105ca0 <sys_pipe+0xc0>
    if(curproc->ofile[fd] == 0){
80105c48:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105c4c:	85 f6                	test   %esi,%esi
80105c4e:	75 f0                	jne    80105c40 <sys_pipe+0x60>
      curproc->ofile[fd] = f;
80105c50:	8d 73 08             	lea    0x8(%ebx),%esi
80105c53:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105c57:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105c5a:	e8 a1 db ff ff       	call   80103800 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105c5f:	31 d2                	xor    %edx,%edx
80105c61:	eb 0d                	jmp    80105c70 <sys_pipe+0x90>
80105c63:	90                   	nop
80105c64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c68:	83 c2 01             	add    $0x1,%edx
80105c6b:	83 fa 64             	cmp    $0x64,%edx
80105c6e:	74 21                	je     80105c91 <sys_pipe+0xb1>
    if(curproc->ofile[fd] == 0){
80105c70:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105c74:	85 c9                	test   %ecx,%ecx
80105c76:	75 f0                	jne    80105c68 <sys_pipe+0x88>
      curproc->ofile[fd] = f;
80105c78:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105c7c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105c7f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105c81:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105c84:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105c87:	31 c0                	xor    %eax,%eax
}
80105c89:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c8c:	5b                   	pop    %ebx
80105c8d:	5e                   	pop    %esi
80105c8e:	5f                   	pop    %edi
80105c8f:	5d                   	pop    %ebp
80105c90:	c3                   	ret    
      myproc()->ofile[fd0] = 0;
80105c91:	e8 6a db ff ff       	call   80103800 <myproc>
80105c96:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105c9d:	00 
80105c9e:	66 90                	xchg   %ax,%ax
    fileclose(rf);
80105ca0:	83 ec 0c             	sub    $0xc,%esp
80105ca3:	ff 75 e0             	pushl  -0x20(%ebp)
80105ca6:	e8 95 b1 ff ff       	call   80100e40 <fileclose>
    fileclose(wf);
80105cab:	58                   	pop    %eax
80105cac:	ff 75 e4             	pushl  -0x1c(%ebp)
80105caf:	e8 8c b1 ff ff       	call   80100e40 <fileclose>
    return -1;
80105cb4:	83 c4 10             	add    $0x10,%esp
80105cb7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cbc:	eb cb                	jmp    80105c89 <sys_pipe+0xa9>
80105cbe:	66 90                	xchg   %ax,%ax

80105cc0 <my_itoa>:

char* my_itoa(int i, char* b){
80105cc0:	55                   	push   %ebp
    char const digit[] = "0123456789";
80105cc1:	b8 38 39 00 00       	mov    $0x3938,%eax
char* my_itoa(int i, char* b){
80105cc6:	89 e5                	mov    %esp,%ebp
80105cc8:	57                   	push   %edi
80105cc9:	56                   	push   %esi
80105cca:	53                   	push   %ebx
80105ccb:	83 ec 10             	sub    $0x10,%esp
80105cce:	8b 4d 08             	mov    0x8(%ebp),%ecx
    char const digit[] = "0123456789";
80105cd1:	c7 45 e9 30 31 32 33 	movl   $0x33323130,-0x17(%ebp)
80105cd8:	c7 45 ed 34 35 36 37 	movl   $0x37363534,-0x13(%ebp)
80105cdf:	66 89 45 f1          	mov    %ax,-0xf(%ebp)
80105ce3:	c6 45 f3 00          	movb   $0x0,-0xd(%ebp)
    char const sig[] = "_";
    char* p = b;
80105ce7:	8b 75 0c             	mov    0xc(%ebp),%esi
    // if(i<0){
    //     *p++ = '-';
    //     i *= -1;
    // }
    int n = i;
80105cea:	89 cb                	mov    %ecx,%ebx
80105cec:	eb 04                	jmp    80105cf2 <my_itoa+0x32>
80105cee:	66 90                	xchg   %ax,%ax
    do{
        ++p;
80105cf0:	89 fe                	mov    %edi,%esi
        n = n/10;
80105cf2:	b8 67 66 66 66       	mov    $0x66666667,%eax
        ++p;
80105cf7:	8d 7e 01             	lea    0x1(%esi),%edi
        n = n/10;
80105cfa:	f7 eb                	imul   %ebx
80105cfc:	c1 fb 1f             	sar    $0x1f,%ebx
80105cff:	c1 fa 02             	sar    $0x2,%edx
    }while(n);
80105d02:	29 da                	sub    %ebx,%edx
80105d04:	89 d3                	mov    %edx,%ebx
80105d06:	75 e8                	jne    80105cf0 <my_itoa+0x30>
    p++;
80105d08:	83 c6 02             	add    $0x2,%esi
    *p = '\0';
80105d0b:	c6 47 01 00          	movb   $0x0,0x1(%edi)
    do{
        *--p = digit[i%10];
80105d0f:	bb 67 66 66 66       	mov    $0x66666667,%ebx
80105d14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d18:	89 c8                	mov    %ecx,%eax
80105d1a:	83 ee 01             	sub    $0x1,%esi
80105d1d:	f7 eb                	imul   %ebx
80105d1f:	89 c8                	mov    %ecx,%eax
80105d21:	c1 f8 1f             	sar    $0x1f,%eax
80105d24:	c1 fa 02             	sar    $0x2,%edx
80105d27:	29 c2                	sub    %eax,%edx
80105d29:	8d 04 92             	lea    (%edx,%edx,4),%eax
80105d2c:	01 c0                	add    %eax,%eax
80105d2e:	29 c1                	sub    %eax,%ecx
        i = i/10;
    }while(i);
80105d30:	85 d2                	test   %edx,%edx
        *--p = digit[i%10];
80105d32:	0f b6 44 0d e9       	movzbl -0x17(%ebp,%ecx,1),%eax
        i = i/10;
80105d37:	89 d1                	mov    %edx,%ecx
        *--p = digit[i%10];
80105d39:	88 06                	mov    %al,(%esi)
    }while(i);
80105d3b:	75 db                	jne    80105d18 <my_itoa+0x58>
    // p--;
    *--p = sig[0];
80105d3d:	c6 46 ff 5f          	movb   $0x5f,-0x1(%esi)

    return b;
}
80105d41:	8b 45 0c             	mov    0xc(%ebp),%eax
80105d44:	83 c4 10             	add    $0x10,%esp
80105d47:	5b                   	pop    %ebx
80105d48:	5e                   	pop    %esi
80105d49:	5f                   	pop    %edi
80105d4a:	5d                   	pop    %ebp
80105d4b:	c3                   	ret    
80105d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d50 <strcat>:

char* strcat(char* s1,const char* s2)
{
80105d50:	55                   	push   %ebp
80105d51:	89 e5                	mov    %esp,%ebp
80105d53:	56                   	push   %esi
80105d54:	53                   	push   %ebx
80105d55:	8b 75 08             	mov    0x8(%ebp),%esi
80105d58:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char* b = (char*)kalloc();
80105d5b:	e8 80 c7 ff ff       	call   801024e0 <kalloc>
80105d60:	89 c2                	mov    %eax,%edx
  char* c= b;

  while (*s1)  *b++=*s1++;
80105d62:	0f b6 0e             	movzbl (%esi),%ecx
80105d65:	84 c9                	test   %cl,%cl
80105d67:	74 2f                	je     80105d98 <strcat+0x48>
80105d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d70:	83 c6 01             	add    $0x1,%esi
80105d73:	83 c2 01             	add    $0x1,%edx
80105d76:	88 4a ff             	mov    %cl,-0x1(%edx)
80105d79:	0f b6 0e             	movzbl (%esi),%ecx
80105d7c:	84 c9                	test   %cl,%cl
80105d7e:	75 f0                	jne    80105d70 <strcat+0x20>
  while (*s2) {
80105d80:	0f b6 0b             	movzbl (%ebx),%ecx
80105d83:	84 c9                	test   %cl,%cl
80105d85:	74 18                	je     80105d9f <strcat+0x4f>
80105d87:	89 f6                	mov    %esi,%esi
80105d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    *b=*s2;
80105d90:	88 0a                	mov    %cl,(%edx)
    b++;
    s2++;}
80105d92:	83 c3 01             	add    $0x1,%ebx
    b++;
80105d95:	83 c2 01             	add    $0x1,%edx
  while (*s2) {
80105d98:	0f b6 0b             	movzbl (%ebx),%ecx
80105d9b:	84 c9                	test   %cl,%cl
80105d9d:	75 f1                	jne    80105d90 <strcat+0x40>
  *b = 0;
80105d9f:	c6 02 00             	movb   $0x0,(%edx)

  return c;
}
80105da2:	5b                   	pop    %ebx
80105da3:	5e                   	pop    %esi
80105da4:	5d                   	pop    %ebp
80105da5:	c3                   	ret    
80105da6:	8d 76 00             	lea    0x0(%esi),%esi
80105da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105db0 <mystrcmp>:
int
mystrcmp (char *s1, char *s2)
{
80105db0:	55                   	push   %ebp
80105db1:	89 e5                	mov    %esp,%ebp
80105db3:	56                   	push   %esi
80105db4:	53                   	push   %ebx
80105db5:	8b 4d 08             	mov    0x8(%ebp),%ecx
    int a =0,b=0;
80105db8:	31 db                	xor    %ebx,%ebx
{
80105dba:	8b 55 0c             	mov    0xc(%ebp),%edx
    while(*s1){a++;s1++;}
80105dbd:	80 39 00             	cmpb   $0x0,(%ecx)
80105dc0:	0f b6 02             	movzbl (%edx),%eax
80105dc3:	74 33                	je     80105df8 <mystrcmp+0x48>
80105dc5:	8d 76 00             	lea    0x0(%esi),%esi
80105dc8:	83 c1 01             	add    $0x1,%ecx
80105dcb:	83 c3 01             	add    $0x1,%ebx
80105dce:	80 39 00             	cmpb   $0x0,(%ecx)
80105dd1:	75 f5                	jne    80105dc8 <mystrcmp+0x18>
    while(*s2){b++;s2++;}
80105dd3:	84 c0                	test   %al,%al
80105dd5:	74 51                	je     80105e28 <mystrcmp+0x78>
    int a =0,b=0;
80105dd7:	31 f6                	xor    %esi,%esi
80105dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(*s2){b++;s2++;}
80105de0:	83 c2 01             	add    $0x1,%edx
80105de3:	83 c6 01             	add    $0x1,%esi
80105de6:	80 3a 00             	cmpb   $0x0,(%edx)
80105de9:	75 f5                	jne    80105de0 <mystrcmp+0x30>

    if(a!=b)return 0;
80105deb:	31 c0                	xor    %eax,%eax
80105ded:	39 de                	cmp    %ebx,%esi
80105def:	74 0f                	je     80105e00 <mystrcmp+0x50>
    // printf("here");
    while(a--){
        if(*s1++ != *s2++)return 0;
    }
    return 1;
}
80105df1:	5b                   	pop    %ebx
80105df2:	5e                   	pop    %esi
80105df3:	5d                   	pop    %ebp
80105df4:	c3                   	ret    
80105df5:	8d 76 00             	lea    0x0(%esi),%esi
    while(*s2){b++;s2++;}
80105df8:	84 c0                	test   %al,%al
80105dfa:	75 db                	jne    80105dd7 <mystrcmp+0x27>
80105dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e00:	01 d3                	add    %edx,%ebx
80105e02:	eb 13                	jmp    80105e17 <mystrcmp+0x67>
80105e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(*s1++ != *s2++)return 0;
80105e08:	83 c2 01             	add    $0x1,%edx
80105e0b:	83 c1 01             	add    $0x1,%ecx
80105e0e:	0f b6 42 ff          	movzbl -0x1(%edx),%eax
80105e12:	38 41 ff             	cmp    %al,-0x1(%ecx)
80105e15:	75 11                	jne    80105e28 <mystrcmp+0x78>
    while(a--){
80105e17:	39 d3                	cmp    %edx,%ebx
80105e19:	75 ed                	jne    80105e08 <mystrcmp+0x58>
}
80105e1b:	5b                   	pop    %ebx
    return 1;
80105e1c:	b8 01 00 00 00       	mov    $0x1,%eax
}
80105e21:	5e                   	pop    %esi
80105e22:	5d                   	pop    %ebp
80105e23:	c3                   	ret    
80105e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e28:	5b                   	pop    %ebx
    if(a!=b)return 0;
80105e29:	31 c0                	xor    %eax,%eax
}
80105e2b:	5e                   	pop    %esi
80105e2c:	5d                   	pop    %ebp
80105e2d:	c3                   	ret    
80105e2e:	66 90                	xchg   %ax,%ax

80105e30 <sys_open>:
// char buf[4];


int
sys_open(void)
{
80105e30:	55                   	push   %ebp
80105e31:	89 e5                	mov    %esp,%ebp
80105e33:	57                   	push   %edi
80105e34:	56                   	push   %esi
80105e35:	53                   	push   %ebx
80105e36:	83 ec 4c             	sub    $0x4c,%esp
  int create_in_container = 0;
  struct proc *curproc = myproc();
80105e39:	e8 c2 d9 ff ff       	call   80103800 <myproc>
  int cid = curproc->cid;



  if(isTraceOn==1)
80105e3e:	83 3d 18 27 11 80 01 	cmpl   $0x1,0x80112718
  struct proc *curproc = myproc();
80105e45:	89 45 bc             	mov    %eax,-0x44(%ebp)
  int cid = curproc->cid;
80105e48:	8b 80 cc 01 00 00    	mov    0x1cc(%eax),%eax
80105e4e:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(isTraceOn==1)
80105e51:	75 07                	jne    80105e5a <sys_open+0x2a>
  {num_calls[SYS_open] ++;}
80105e53:	83 05 7c 2a 11 80 01 	addl   $0x1,0x80112a7c
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105e5a:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80105e5d:	83 ec 08             	sub    $0x8,%esp
80105e60:	50                   	push   %eax
80105e61:	6a 00                	push   $0x0
80105e63:	e8 58 ef ff ff       	call   80104dc0 <argstr>
80105e68:	83 c4 10             	add    $0x10,%esp
80105e6b:	85 c0                	test   %eax,%eax
80105e6d:	0f 88 a2 08 00 00    	js     80106715 <sys_open+0x8e5>
80105e73:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105e76:	83 ec 08             	sub    $0x8,%esp
80105e79:	50                   	push   %eax
80105e7a:	6a 01                	push   $0x1
80105e7c:	e8 8f ee ff ff       	call   80104d10 <argint>
80105e81:	83 c4 10             	add    $0x10,%esp
80105e84:	85 c0                	test   %eax,%eax
80105e86:	0f 88 89 08 00 00    	js     80106715 <sys_open+0x8e5>



  int pehle_se_hai_conatiner_me = 0;

  for (int i = 0; i < 100; i++) {
80105e8c:	31 db                	xor    %ebx,%ebx
80105e8e:	8b 55 c0             	mov    -0x40(%ebp),%edx
80105e91:	eb 11                	jmp    80105ea4 <sys_open+0x74>
80105e93:	90                   	nop
80105e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e98:	83 c3 01             	add    $0x1,%ebx
80105e9b:	83 fb 64             	cmp    $0x64,%ebx
80105e9e:	0f 84 4c 01 00 00    	je     80105ff0 <sys_open+0x1c0>
    if (container_location[i]==1){
80105ea4:	8b 3c 9d 00 06 13 80 	mov    -0x7fecfa00(,%ebx,4),%edi
80105eab:	83 ff 01             	cmp    $0x1,%edi
80105eae:	75 e8                	jne    80105e98 <sys_open+0x68>
80105eb0:	69 c3 bc 04 00 00    	imul   $0x4bc,%ebx,%eax
      if(container_array[i].cid==cid){
80105eb6:	39 90 e0 2b 11 80    	cmp    %edx,-0x7feed420(%eax)
80105ebc:	75 da                	jne    80105e98 <sys_open+0x68>
80105ebe:	89 45 ac             	mov    %eax,-0x54(%ebp)
        int ind = curproc->cid;
80105ec1:	8b 45 bc             	mov    -0x44(%ebp),%eax
80105ec4:	8b b0 cc 01 00 00    	mov    0x1cc(%eax),%esi
        // int ind = 67;
        char *sind = (char *)kalloc();
80105eca:	e8 11 c6 ff ff       	call   801024e0 <kalloc>
        // strncpy(sind,my_itoa(ind,sind),);
        char *ipath = path;
80105ecf:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    char const digit[] = "0123456789";
80105ed2:	ba 38 39 00 00       	mov    $0x3938,%edx
        char *sind = (char *)kalloc();
80105ed7:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80105eda:	89 75 b0             	mov    %esi,-0x50(%ebp)
    char const digit[] = "0123456789";
80105edd:	c7 45 dd 30 31 32 33 	movl   $0x33323130,-0x23(%ebp)
80105ee4:	c7 45 e1 34 35 36 37 	movl   $0x37363534,-0x1f(%ebp)
80105eeb:	66 89 55 e5          	mov    %dx,-0x1b(%ebp)
        char *ipath = path;
80105eef:	89 4d b8             	mov    %ecx,-0x48(%ebp)
    char const digit[] = "0123456789";
80105ef2:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
    int n = i;
80105ef6:	89 f1                	mov    %esi,%ecx
80105ef8:	89 7d b4             	mov    %edi,-0x4c(%ebp)
80105efb:	89 c6                	mov    %eax,%esi
80105efd:	eb 03                	jmp    80105f02 <sys_open+0xd2>
80105eff:	90                   	nop
        ++p;
80105f00:	89 fe                	mov    %edi,%esi
        n = n/10;
80105f02:	b8 67 66 66 66       	mov    $0x66666667,%eax
        ++p;
80105f07:	8d 7e 01             	lea    0x1(%esi),%edi
        n = n/10;
80105f0a:	f7 e9                	imul   %ecx
80105f0c:	c1 f9 1f             	sar    $0x1f,%ecx
80105f0f:	c1 fa 02             	sar    $0x2,%edx
    }while(n);
80105f12:	29 ca                	sub    %ecx,%edx
80105f14:	89 d1                	mov    %edx,%ecx
80105f16:	75 e8                	jne    80105f00 <sys_open+0xd0>
80105f18:	89 f0                	mov    %esi,%eax
80105f1a:	89 fa                	mov    %edi,%edx
80105f1c:	8b 75 b0             	mov    -0x50(%ebp),%esi
80105f1f:	8b 7d b4             	mov    -0x4c(%ebp),%edi
    p++;
80105f22:	83 c0 02             	add    $0x2,%eax
    *p = '\0';
80105f25:	c6 42 01 00          	movb   $0x0,0x1(%edx)
    p++;
80105f29:	89 c1                	mov    %eax,%ecx
80105f2b:	90                   	nop
80105f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        *--p = digit[i%10];
80105f30:	b8 67 66 66 66       	mov    $0x66666667,%eax
80105f35:	83 e9 01             	sub    $0x1,%ecx
80105f38:	f7 ee                	imul   %esi
80105f3a:	89 f0                	mov    %esi,%eax
80105f3c:	c1 f8 1f             	sar    $0x1f,%eax
80105f3f:	c1 fa 02             	sar    $0x2,%edx
80105f42:	29 c2                	sub    %eax,%edx
80105f44:	8d 04 92             	lea    (%edx,%edx,4),%eax
80105f47:	01 c0                	add    %eax,%eax
80105f49:	29 c6                	sub    %eax,%esi
    }while(i);
80105f4b:	85 d2                	test   %edx,%edx
        *--p = digit[i%10];
80105f4d:	0f b6 44 35 dd       	movzbl -0x23(%ebp,%esi,1),%eax
        i = i/10;
80105f52:	89 d6                	mov    %edx,%esi
        *--p = digit[i%10];
80105f54:	88 01                	mov    %al,(%ecx)
    }while(i);
80105f56:	75 d8                	jne    80105f30 <sys_open+0x100>
        sind = my_itoa(ind,sind);
        char *path4 = strcat(ipath,sind);
        // cprintf("path is:%s\n",path4);
          for (int j = 0; j < container_array[i].number_of_files; j++) {
80105f58:	69 db bc 04 00 00    	imul   $0x4bc,%ebx,%ebx
        char *path4 = strcat(ipath,sind);
80105f5e:	83 ec 08             	sub    $0x8,%esp
    *--p = sig[0];
80105f61:	c6 41 ff 5f          	movb   $0x5f,-0x1(%ecx)
        char *path4 = strcat(ipath,sind);
80105f65:	ff 75 c4             	pushl  -0x3c(%ebp)
80105f68:	ff 75 b8             	pushl  -0x48(%ebp)
          for (int j = 0; j < container_array[i].number_of_files; j++) {
80105f6b:	81 c3 e0 2b 11 80    	add    $0x80112be0,%ebx
        char *path4 = strcat(ipath,sind);
80105f71:	e8 da fd ff ff       	call   80105d50 <strcat>
          for (int j = 0; j < container_array[i].number_of_files; j++) {
80105f76:	8b 4b 08             	mov    0x8(%ebx),%ecx
80105f79:	83 c4 10             	add    $0x10,%esp
        char *path4 = strcat(ipath,sind);
80105f7c:	89 45 c4             	mov    %eax,-0x3c(%ebp)
          for (int j = 0; j < container_array[i].number_of_files; j++) {
80105f7f:	85 c9                	test   %ecx,%ecx
80105f81:	7e 6d                	jle    80105ff0 <sys_open+0x1c0>
80105f83:	89 d8                	mov    %ebx,%eax
80105f85:	89 7d b8             	mov    %edi,-0x48(%ebp)
80105f88:	89 f3                	mov    %esi,%ebx
80105f8a:	8b 7d ac             	mov    -0x54(%ebp),%edi
80105f8d:	89 c6                	mov    %eax,%esi
80105f8f:	eb 0f                	jmp    80105fa0 <sys_open+0x170>
80105f91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f98:	83 c3 01             	add    $0x1,%ebx
80105f9b:	39 5e 08             	cmp    %ebx,0x8(%esi)
80105f9e:	7e 50                	jle    80105ff0 <sys_open+0x1c0>
            cprintf("path is: %s\n",container_array[i].container_files[j]);
80105fa0:	83 ec 08             	sub    $0x8,%esp
80105fa3:	ff b4 9f 7c 2d 11 80 	pushl  -0x7feed284(%edi,%ebx,4)
80105faa:	68 dc 8c 10 80       	push   $0x80108cdc
80105faf:	e8 ac a6 ff ff       	call   80100660 <cprintf>
            if (mystrcmp(container_array[i].container_files[j],path4)){
80105fb4:	58                   	pop    %eax
80105fb5:	5a                   	pop    %edx
80105fb6:	ff 75 c4             	pushl  -0x3c(%ebp)
80105fb9:	ff b4 9f 7c 2d 11 80 	pushl  -0x7feed284(%edi,%ebx,4)
80105fc0:	e8 eb fd ff ff       	call   80105db0 <mystrcmp>
80105fc5:	83 c4 10             	add    $0x10,%esp
80105fc8:	85 c0                	test   %eax,%eax
80105fca:	74 cc                	je     80105f98 <sys_open+0x168>
              cprintf("yahan aya\n");
80105fcc:	83 ec 0c             	sub    $0xc,%esp
80105fcf:	8b 7d b8             	mov    -0x48(%ebp),%edi
80105fd2:	68 e9 8c 10 80       	push   $0x80108ce9
80105fd7:	e8 84 a6 ff ff       	call   80100660 <cprintf>
              pehle_se_hai_conatiner_me = 1;
              path = path4;
80105fdc:	8b 45 c4             	mov    -0x3c(%ebp),%eax
              break;
80105fdf:	83 c4 10             	add    $0x10,%esp
              path = path4;
80105fe2:	89 45 d4             	mov    %eax,-0x2c(%ebp)
              break;
80105fe5:	eb 0b                	jmp    80105ff2 <sys_open+0x1c2>
80105fe7:	89 f6                	mov    %esi,%esi
80105fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int pehle_se_hai_conatiner_me = 0;
80105ff0:	31 ff                	xor    %edi,%edi
          break;
      }
    }
  }

  begin_op();
80105ff2:	e8 c9 cb ff ff       	call   80102bc0 <begin_op>

  if(omode & O_CREATE){
80105ff7:	8b 45 d8             	mov    -0x28(%ebp),%eax
80105ffa:	25 00 02 00 00       	and    $0x200,%eax
80105fff:	89 45 b8             	mov    %eax,-0x48(%ebp)
80106002:	0f 84 e8 02 00 00    	je     801062f0 <sys_open+0x4c0>
    // cprintf("yahan nahi aana chahiye 1\n");
    if (cid==-1 || create_container_called == 0){
80106008:	83 7d c0 ff          	cmpl   $0xffffffff,-0x40(%ebp)
8010600c:	74 0e                	je     8010601c <sys_open+0x1ec>
8010600e:	8b 0d c8 c5 10 80    	mov    0x8010c5c8,%ecx
80106014:	85 c9                	test   %ecx,%ecx
80106016:	0f 85 34 03 00 00    	jne    80106350 <sys_open+0x520>
    ip = create(path, T_FILE, 0, 0);
8010601c:	83 ec 0c             	sub    $0xc,%esp
8010601f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80106022:	31 c9                	xor    %ecx,%ecx
80106024:	6a 00                	push   $0x0
80106026:	ba 02 00 00 00       	mov    $0x2,%edx
8010602b:	e8 50 f1 ff ff       	call   80105180 <create>
80106030:	83 c4 10             	add    $0x10,%esp
80106033:	89 c3                	mov    %eax,%ebx
  int create_in_container = 0;
80106035:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
      char *ipath2 = path;
      char *path5 = strcat(ipath2,sind);
      cprintf("path is:%s\n",path5 );
      ip = create(path5, T_FILE, 0, 0);
    }
    if(ip == 0){
8010603c:	85 db                	test   %ebx,%ebx
8010603e:	0f 84 24 07 00 00    	je     80106768 <sys_open+0x938>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80106044:	e8 37 ad ff ff       	call   80100d80 <filealloc>
80106049:	85 c0                	test   %eax,%eax
8010604b:	89 45 c4             	mov    %eax,-0x3c(%ebp)
8010604e:	0f 84 db 06 00 00    	je     8010672f <sys_open+0x8ff>
  struct proc *curproc = myproc();
80106054:	e8 a7 d7 ff ff       	call   80103800 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106059:	31 f6                	xor    %esi,%esi
8010605b:	eb 0f                	jmp    8010606c <sys_open+0x23c>
8010605d:	8d 76 00             	lea    0x0(%esi),%esi
80106060:	83 c6 01             	add    $0x1,%esi
80106063:	83 fe 64             	cmp    $0x64,%esi
80106066:	0f 84 75 06 00 00    	je     801066e1 <sys_open+0x8b1>
    if(curproc->ofile[fd] == 0){
8010606c:	8b 54 b0 28          	mov    0x28(%eax,%esi,4),%edx
80106070:	85 d2                	test   %edx,%edx
80106072:	75 ec                	jne    80106060 <sys_open+0x230>
      curproc->ofile[fd] = f;
80106074:	8d 4e 08             	lea    0x8(%esi),%ecx
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80106077:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
8010607a:	89 ca                	mov    %ecx,%edx
8010607c:	89 4d b4             	mov    %ecx,-0x4c(%ebp)
8010607f:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
80106082:	89 4c 90 08          	mov    %ecx,0x8(%eax,%edx,4)
  iunlock(ip);
80106086:	53                   	push   %ebx
80106087:	e8 e4 b6 ff ff       	call   80101770 <iunlock>
  end_op();
8010608c:	e8 9f cb ff ff       	call   80102c30 <end_op>

  f->type = FD_INODE;
80106091:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106094:	83 c4 10             	add    $0x10,%esp
  f->type = FD_INODE;
80106097:	c7 01 02 00 00 00    	movl   $0x2,(%ecx)
  f->readable = !(omode & O_WRONLY);
8010609d:	8b 55 d8             	mov    -0x28(%ebp),%edx
  f->ip = ip;
801060a0:	89 59 10             	mov    %ebx,0x10(%ecx)
  f->off = 0;
801060a3:	c7 41 14 00 00 00 00 	movl   $0x0,0x14(%ecx)
  f->path = path;
  f->cid = -1;
801060aa:	c7 41 18 ff ff ff ff 	movl   $0xffffffff,0x18(%ecx)
  f->readable = !(omode & O_WRONLY);
801060b1:	89 d0                	mov    %edx,%eax
801060b3:	f7 d0                	not    %eax
801060b5:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801060b8:	83 e2 03             	and    $0x3,%edx
801060bb:	0f 95 41 09          	setne  0x9(%ecx)

  if (cid==-1 || create_container_called == 0){ return fd;}
801060bf:	83 7d c0 ff          	cmpl   $0xffffffff,-0x40(%ebp)
  f->readable = !(omode & O_WRONLY);
801060c3:	88 41 08             	mov    %al,0x8(%ecx)
  f->path = path;
801060c6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801060c9:	89 41 1c             	mov    %eax,0x1c(%ecx)
  if (cid==-1 || create_container_called == 0){ return fd;}
801060cc:	0f 84 14 02 00 00    	je     801062e6 <sys_open+0x4b6>
801060d2:	a1 c8 c5 10 80       	mov    0x8010c5c8,%eax
801060d7:	85 c0                	test   %eax,%eax
801060d9:	0f 84 07 02 00 00    	je     801062e6 <sys_open+0x4b6>
  if (pehle_se_hai_conatiner_me == 1){
801060df:	83 ff 01             	cmp    $0x1,%edi
801060e2:	0f 84 e4 05 00 00    	je     801066cc <sys_open+0x89c>
    cprintf("pehle_se_hai_conatiner_me\n");
    return fd;
  }
  if (create_in_container == 1) {
801060e8:	83 7d b8 01          	cmpl   $0x1,-0x48(%ebp)
801060ec:	8b 45 bc             	mov    -0x44(%ebp),%eax
801060ef:	8b 98 cc 01 00 00    	mov    0x1cc(%eax),%ebx
801060f5:	0f 84 29 03 00 00    	je     80106424 <sys_open+0x5f4>
    char const digit[] = "0123456789";
801060fb:	be 38 39 00 00       	mov    $0x3938,%esi
  // struct proc *curproc = myproc();
  struct file *f2;
  int fd2;
  int ind = curproc->cid;
  // int ind = 67;
  char *sind = (char *)kalloc();
80106100:	e8 db c3 ff ff       	call   801024e0 <kalloc>
    char const digit[] = "0123456789";
80106105:	66 89 75 e5          	mov    %si,-0x1b(%ebp)
  char *sind = (char *)kalloc();
80106109:	89 45 bc             	mov    %eax,-0x44(%ebp)
    int n = i;
8010610c:	89 d9                	mov    %ebx,%ecx
    char const digit[] = "0123456789";
8010610e:	c7 45 dd 30 31 32 33 	movl   $0x33323130,-0x23(%ebp)
80106115:	c7 45 e1 34 35 36 37 	movl   $0x37363534,-0x1f(%ebp)
    char* p = b;
8010611c:	89 c6                	mov    %eax,%esi
    char const digit[] = "0123456789";
8010611e:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
80106122:	eb 06                	jmp    8010612a <sys_open+0x2fa>
80106124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        ++p;
80106128:	89 fe                	mov    %edi,%esi
        n = n/10;
8010612a:	b8 67 66 66 66       	mov    $0x66666667,%eax
        ++p;
8010612f:	8d 7e 01             	lea    0x1(%esi),%edi
        n = n/10;
80106132:	f7 e9                	imul   %ecx
80106134:	c1 f9 1f             	sar    $0x1f,%ecx
80106137:	c1 fa 02             	sar    $0x2,%edx
    }while(n);
8010613a:	29 ca                	sub    %ecx,%edx
8010613c:	89 d1                	mov    %edx,%ecx
8010613e:	75 e8                	jne    80106128 <sys_open+0x2f8>
    p++;
80106140:	83 c6 02             	add    $0x2,%esi
    *p = '\0';
80106143:	c6 47 01 00          	movb   $0x0,0x1(%edi)
        *--p = digit[i%10];
80106147:	b9 67 66 66 66       	mov    $0x66666667,%ecx
8010614c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106150:	89 d8                	mov    %ebx,%eax
80106152:	83 ee 01             	sub    $0x1,%esi
80106155:	f7 e9                	imul   %ecx
80106157:	89 d8                	mov    %ebx,%eax
80106159:	c1 f8 1f             	sar    $0x1f,%eax
8010615c:	c1 fa 02             	sar    $0x2,%edx
8010615f:	29 c2                	sub    %eax,%edx
80106161:	8d 04 92             	lea    (%edx,%edx,4),%eax
80106164:	01 c0                	add    %eax,%eax
80106166:	29 c3                	sub    %eax,%ebx
    }while(i);
80106168:	85 d2                	test   %edx,%edx
        *--p = digit[i%10];
8010616a:	0f b6 44 1d dd       	movzbl -0x23(%ebp,%ebx,1),%eax
        i = i/10;
8010616f:	89 d3                	mov    %edx,%ebx
        *--p = digit[i%10];
80106171:	88 06                	mov    %al,(%esi)
    }while(i);
80106173:	75 db                	jne    80106150 <sys_open+0x320>
  // strncpy(sind,my_itoa(ind,sind));
  sind = my_itoa(ind,sind);
  char *ipath4 = path;
  char *path2 = strcat(ipath4,sind);
80106175:	83 ec 08             	sub    $0x8,%esp
    *--p = sig[0];
80106178:	c6 46 ff 5f          	movb   $0x5f,-0x1(%esi)
  char *path2 = strcat(ipath4,sind);
8010617c:	ff 75 bc             	pushl  -0x44(%ebp)
8010617f:	ff 75 d4             	pushl  -0x2c(%ebp)
80106182:	e8 c9 fb ff ff       	call   80105d50 <strcat>
80106187:	89 c7                	mov    %eax,%edi
80106189:	89 45 bc             	mov    %eax,-0x44(%ebp)
  // cprintf("path 2 is %s\n",path2);
  struct inode *ip2;

  begin_op();
8010618c:	e8 2f ca ff ff       	call   80102bc0 <begin_op>
  ip2 = create(path2, T_FILE, 0, 0);
80106191:	31 c9                	xor    %ecx,%ecx
80106193:	ba 02 00 00 00       	mov    $0x2,%edx
80106198:	89 f8                	mov    %edi,%eax
8010619a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801061a1:	e8 da ef ff ff       	call   80105180 <create>
  if(ip2 == 0){
801061a6:	83 c4 10             	add    $0x10,%esp
801061a9:	85 c0                	test   %eax,%eax
  ip2 = create(path2, T_FILE, 0, 0);
801061ab:	89 c6                	mov    %eax,%esi
  if(ip2 == 0){
801061ad:	0f 84 c4 05 00 00    	je     80106777 <sys_open+0x947>
    return -1;
    cprintf("ip2 0 \n");
  }


  cprintf("file 2 is created\n");
801061b3:	83 ec 0c             	sub    $0xc,%esp
801061b6:	68 51 8d 10 80       	push   $0x80108d51
801061bb:	e8 a0 a4 ff ff       	call   80100660 <cprintf>
  if((f2 = filealloc()) == 0 || (fd2 = fdalloc(f2)) < 0){
801061c0:	e8 bb ab ff ff       	call   80100d80 <filealloc>
801061c5:	83 c4 10             	add    $0x10,%esp
801061c8:	85 c0                	test   %eax,%eax
801061ca:	89 c7                	mov    %eax,%edi
801061cc:	0f 84 7b 05 00 00    	je     8010674d <sys_open+0x91d>
  struct proc *curproc = myproc();
801061d2:	e8 29 d6 ff ff       	call   80103800 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801061d7:	31 d2                	xor    %edx,%edx
801061d9:	eb 11                	jmp    801061ec <sys_open+0x3bc>
801061db:	90                   	nop
801061dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801061e0:	83 c2 01             	add    $0x1,%edx
801061e3:	83 fa 64             	cmp    $0x64,%edx
801061e6:	0f 84 55 05 00 00    	je     80106741 <sys_open+0x911>
    if(curproc->ofile[fd] == 0){
801061ec:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801061f0:	85 c9                	test   %ecx,%ecx
801061f2:	75 ec                	jne    801061e0 <sys_open+0x3b0>
      curproc->ofile[fd] = f;
801061f4:	8d 4a 08             	lea    0x8(%edx),%ecx
      fileclose(f2);
    iunlockput(ip2);
    end_op();
    return -1;
  }
  cprintf("yahan 1 \n");
801061f7:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801061fa:	89 7c 88 08          	mov    %edi,0x8(%eax,%ecx,4)
  cprintf("yahan 1 \n");
801061fe:	68 64 8d 10 80       	push   $0x80108d64
      curproc->ofile[fd] = f;
80106203:	89 4d b8             	mov    %ecx,-0x48(%ebp)
  cprintf("yahan 1 \n");
80106206:	e8 55 a4 ff ff       	call   80100660 <cprintf>


  iunlock(ip2);
8010620b:	89 34 24             	mov    %esi,(%esp)
8010620e:	e8 5d b5 ff ff       	call   80101770 <iunlock>
  end_op();
80106213:	e8 18 ca ff ff       	call   80102c30 <end_op>

  f2->type = FD_INODE;
80106218:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f2->ip = ip2;
  f2->off = 0;
  f2->readable = !(omode & O_WRONLY);
8010621e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  f2->ip = ip2;
80106221:	89 77 10             	mov    %esi,0x10(%edi)
  f2->off = 0;
80106224:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
8010622b:	8d 75 dd             	lea    -0x23(%ebp),%esi
  // f2->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  f2->writable =1;
8010622e:	c6 47 09 01          	movb   $0x1,0x9(%edi)
  f2->readable = !(omode & O_WRONLY);
80106232:	f7 d0                	not    %eax
80106234:	83 e0 01             	and    $0x1,%eax
80106237:	88 47 08             	mov    %al,0x8(%edi)
  f2->path = path2;
8010623a:	8b 45 bc             	mov    -0x44(%ebp),%eax
8010623d:	89 47 1c             	mov    %eax,0x1c(%edi)
  f2->cid = cid;
80106240:	8b 45 c0             	mov    -0x40(%ebp),%eax
80106243:	89 47 18             	mov    %eax,0x18(%edi)


  cprintf("yahan 2 \n");
80106246:	c7 04 24 6e 8d 10 80 	movl   $0x80108d6e,(%esp)
8010624d:	e8 0e a4 ff ff       	call   80100660 <cprintf>
80106252:	83 c4 10             	add    $0x10,%esp
80106255:	8d 76 00             	lea    0x0(%esi),%esi

  // return fd;
  while(1){
    int n1;
    char c[1];
    n1 = fileread(f, c, sizeof(c)) ;
80106258:	83 ec 04             	sub    $0x4,%esp
8010625b:	6a 01                	push   $0x1
8010625d:	56                   	push   %esi
8010625e:	ff 75 c4             	pushl  -0x3c(%ebp)
80106261:	e8 fa ac ff ff       	call   80100f60 <fileread>
    if(n1<=0)break;
80106266:	83 c4 10             	add    $0x10,%esp
80106269:	85 c0                	test   %eax,%eax
8010626b:	0f 8e ca 02 00 00    	jle    8010653b <sys_open+0x70b>
    n1 = filewrite(f2,c,sizeof(c));
80106271:	83 ec 04             	sub    $0x4,%esp
80106274:	6a 01                	push   $0x1
80106276:	56                   	push   %esi
80106277:	57                   	push   %edi
80106278:	e8 73 ad ff ff       	call   80100ff0 <filewrite>
    // cprintf("reading  %s \n",c);
    if(n1<0)
8010627d:	83 c4 10             	add    $0x10,%esp
80106280:	85 c0                	test   %eax,%eax
80106282:	79 d4                	jns    80106258 <sys_open+0x428>
      cprintf("error in writing in newopen \n");
80106284:	83 ec 0c             	sub    $0xc,%esp
80106287:	68 78 8d 10 80       	push   $0x80108d78
8010628c:	e8 cf a3 ff ff       	call   80100660 <cprintf>
80106291:	83 c4 10             	add    $0x10,%esp
  while(1){
80106294:	eb c2                	jmp    80106258 <sys_open+0x428>
      return -1;
    }
  }

  else {
    if((ip3 = namei(path3)) == 0){
80106296:	83 ec 0c             	sub    $0xc,%esp
80106299:	ff 75 bc             	pushl  -0x44(%ebp)
8010629c:	e8 5f bc ff ff       	call   80101f00 <namei>
801062a1:	83 c4 10             	add    $0x10,%esp
801062a4:	85 c0                	test   %eax,%eax
801062a6:	89 c7                	mov    %eax,%edi
801062a8:	0f 84 ba 04 00 00    	je     80106768 <sys_open+0x938>
      end_op();
      return -1;
    }
    ilock(ip3);
801062ae:	83 ec 0c             	sub    $0xc,%esp
801062b1:	50                   	push   %eax
801062b2:	e8 d9 b3 ff ff       	call   80101690 <ilock>
    if(ip3->type == T_DIR && omode != O_RDONLY){
801062b7:	83 c4 10             	add    $0x10,%esp
801062ba:	66 83 7f 50 01       	cmpw   $0x1,0x50(%edi)
801062bf:	0f 85 09 03 00 00    	jne    801065ce <sys_open+0x79e>
801062c5:	8b 75 d8             	mov    -0x28(%ebp),%esi
801062c8:	85 f6                	test   %esi,%esi
801062ca:	0f 84 fe 02 00 00    	je     801065ce <sys_open+0x79e>
  }

  if((f3 = filealloc()) == 0 || (fd3 = fdalloc(f3)) < 0){
    if(f3)
      fileclose(f3);
    iunlockput(ip3);
801062d0:	83 ec 0c             	sub    $0xc,%esp
    end_op();
    return -1;
801062d3:	be ff ff ff ff       	mov    $0xffffffff,%esi
    iunlockput(ip3);
801062d8:	57                   	push   %edi
801062d9:	e8 42 b6 ff ff       	call   80101920 <iunlockput>
    end_op();
801062de:	e8 4d c9 ff ff       	call   80102c30 <end_op>
    return -1;
801062e3:	83 c4 10             	add    $0x10,%esp
      }
    }
  }
  cprintf("yahan fd3 is %d \n",fd3);
  return fd3;
}
801062e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801062e9:	89 f0                	mov    %esi,%eax
801062eb:	5b                   	pop    %ebx
801062ec:	5e                   	pop    %esi
801062ed:	5f                   	pop    %edi
801062ee:	5d                   	pop    %ebp
801062ef:	c3                   	ret    
    if((ip = namei(path)) == 0){
801062f0:	83 ec 0c             	sub    $0xc,%esp
801062f3:	ff 75 d4             	pushl  -0x2c(%ebp)
801062f6:	e8 05 bc ff ff       	call   80101f00 <namei>
801062fb:	83 c4 10             	add    $0x10,%esp
801062fe:	85 c0                	test   %eax,%eax
80106300:	89 c3                	mov    %eax,%ebx
80106302:	0f 84 60 04 00 00    	je     80106768 <sys_open+0x938>
    ilock(ip);
80106308:	83 ec 0c             	sub    $0xc,%esp
8010630b:	50                   	push   %eax
8010630c:	e8 7f b3 ff ff       	call   80101690 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80106311:	83 c4 10             	add    $0x10,%esp
80106314:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106319:	0f 85 25 fd ff ff    	jne    80106044 <sys_open+0x214>
8010631f:	8b 45 d8             	mov    -0x28(%ebp),%eax
80106322:	85 c0                	test   %eax,%eax
80106324:	89 45 b8             	mov    %eax,-0x48(%ebp)
80106327:	0f 84 17 fd ff ff    	je     80106044 <sys_open+0x214>
    cprintf("yahan nahi aana chahiye 3\n");
8010632d:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80106330:	83 ce ff             	or     $0xffffffff,%esi
    cprintf("yahan nahi aana chahiye 3\n");
80106333:	68 00 8d 10 80       	push   $0x80108d00
80106338:	e8 23 a3 ff ff       	call   80100660 <cprintf>
      iunlockput(ip);
8010633d:	89 1c 24             	mov    %ebx,(%esp)
80106340:	e8 db b5 ff ff       	call   80101920 <iunlockput>
      end_op();
80106345:	e8 e6 c8 ff ff       	call   80102c30 <end_op>
      return -1;
8010634a:	83 c4 10             	add    $0x10,%esp
8010634d:	eb 97                	jmp    801062e6 <sys_open+0x4b6>
8010634f:	90                   	nop
      int ind = curproc->cid;
80106350:	8b 45 bc             	mov    -0x44(%ebp),%eax
80106353:	8b 98 cc 01 00 00    	mov    0x1cc(%eax),%ebx
      char *sind = (char *)kalloc();
80106359:	e8 82 c1 ff ff       	call   801024e0 <kalloc>
    char const digit[] = "0123456789";
8010635e:	ba 38 39 00 00       	mov    $0x3938,%edx
      char *sind = (char *)kalloc();
80106363:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    char const digit[] = "0123456789";
80106366:	c7 45 dd 30 31 32 33 	movl   $0x33323130,-0x23(%ebp)
8010636d:	c7 45 e1 34 35 36 37 	movl   $0x37363534,-0x1f(%ebp)
80106374:	66 89 55 e5          	mov    %dx,-0x1b(%ebp)
    int n = i;
80106378:	89 d9                	mov    %ebx,%ecx
    char const digit[] = "0123456789";
8010637a:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
    char* p = b;
8010637e:	89 c6                	mov    %eax,%esi
80106380:	89 7d b8             	mov    %edi,-0x48(%ebp)
80106383:	eb 05                	jmp    8010638a <sys_open+0x55a>
80106385:	8d 76 00             	lea    0x0(%esi),%esi
        ++p;
80106388:	89 fe                	mov    %edi,%esi
        n = n/10;
8010638a:	b8 67 66 66 66       	mov    $0x66666667,%eax
        ++p;
8010638f:	8d 7e 01             	lea    0x1(%esi),%edi
        n = n/10;
80106392:	f7 e9                	imul   %ecx
80106394:	c1 f9 1f             	sar    $0x1f,%ecx
80106397:	c1 fa 02             	sar    $0x2,%edx
    }while(n);
8010639a:	29 ca                	sub    %ecx,%edx
8010639c:	89 d1                	mov    %edx,%ecx
8010639e:	75 e8                	jne    80106388 <sys_open+0x558>
801063a0:	89 f8                	mov    %edi,%eax
801063a2:	8b 7d b8             	mov    -0x48(%ebp),%edi
    p++;
801063a5:	8d 4e 02             	lea    0x2(%esi),%ecx
    *p = '\0';
801063a8:	c6 40 01 00          	movb   $0x0,0x1(%eax)
        *--p = digit[i%10];
801063ac:	be 67 66 66 66       	mov    $0x66666667,%esi
801063b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801063b8:	89 d8                	mov    %ebx,%eax
801063ba:	83 e9 01             	sub    $0x1,%ecx
801063bd:	f7 ee                	imul   %esi
801063bf:	89 d8                	mov    %ebx,%eax
801063c1:	c1 f8 1f             	sar    $0x1f,%eax
801063c4:	c1 fa 02             	sar    $0x2,%edx
801063c7:	29 c2                	sub    %eax,%edx
801063c9:	8d 04 92             	lea    (%edx,%edx,4),%eax
801063cc:	01 c0                	add    %eax,%eax
801063ce:	29 c3                	sub    %eax,%ebx
    }while(i);
801063d0:	85 d2                	test   %edx,%edx
        *--p = digit[i%10];
801063d2:	0f b6 44 1d dd       	movzbl -0x23(%ebp,%ebx,1),%eax
        i = i/10;
801063d7:	89 d3                	mov    %edx,%ebx
        *--p = digit[i%10];
801063d9:	88 01                	mov    %al,(%ecx)
    }while(i);
801063db:	75 db                	jne    801063b8 <sys_open+0x588>
      char *path5 = strcat(ipath2,sind);
801063dd:	83 ec 08             	sub    $0x8,%esp
    *--p = sig[0];
801063e0:	c6 41 ff 5f          	movb   $0x5f,-0x1(%ecx)
      char *path5 = strcat(ipath2,sind);
801063e4:	ff 75 c4             	pushl  -0x3c(%ebp)
801063e7:	ff 75 d4             	pushl  -0x2c(%ebp)
801063ea:	e8 61 f9 ff ff       	call   80105d50 <strcat>
      cprintf("path is:%s\n",path5 );
801063ef:	59                   	pop    %ecx
801063f0:	5e                   	pop    %esi
801063f1:	50                   	push   %eax
801063f2:	68 f4 8c 10 80       	push   $0x80108cf4
      char *path5 = strcat(ipath2,sind);
801063f7:	89 c3                	mov    %eax,%ebx
      cprintf("path is:%s\n",path5 );
801063f9:	e8 62 a2 ff ff       	call   80100660 <cprintf>
      ip = create(path5, T_FILE, 0, 0);
801063fe:	89 d8                	mov    %ebx,%eax
80106400:	31 c9                	xor    %ecx,%ecx
80106402:	ba 02 00 00 00       	mov    $0x2,%edx
80106407:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010640e:	e8 6d ed ff ff       	call   80105180 <create>
80106413:	83 c4 10             	add    $0x10,%esp
80106416:	89 c3                	mov    %eax,%ebx
      create_in_container = 1;
80106418:	c7 45 b8 01 00 00 00 	movl   $0x1,-0x48(%ebp)
8010641f:	e9 18 fc ff ff       	jmp    8010603c <sys_open+0x20c>
    char const digit[] = "0123456789";
80106424:	bf 38 39 00 00       	mov    $0x3938,%edi
    char *sind = (char *)kalloc();
80106429:	e8 b2 c0 ff ff       	call   801024e0 <kalloc>
    char const digit[] = "0123456789";
8010642e:	66 89 7d e5          	mov    %di,-0x1b(%ebp)
    char *sind = (char *)kalloc();
80106432:	89 45 bc             	mov    %eax,-0x44(%ebp)
    int n = i;
80106435:	89 d9                	mov    %ebx,%ecx
    char const digit[] = "0123456789";
80106437:	c7 45 dd 30 31 32 33 	movl   $0x33323130,-0x23(%ebp)
8010643e:	c7 45 e1 34 35 36 37 	movl   $0x37363534,-0x1f(%ebp)
    char* p = b;
80106445:	89 c7                	mov    %eax,%edi
    char const digit[] = "0123456789";
80106447:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
8010644b:	89 5d b8             	mov    %ebx,-0x48(%ebp)
8010644e:	eb 02                	jmp    80106452 <sys_open+0x622>
        ++p;
80106450:	89 df                	mov    %ebx,%edi
        n = n/10;
80106452:	b8 67 66 66 66       	mov    $0x66666667,%eax
        ++p;
80106457:	8d 5f 01             	lea    0x1(%edi),%ebx
        n = n/10;
8010645a:	f7 e9                	imul   %ecx
8010645c:	c1 f9 1f             	sar    $0x1f,%ecx
8010645f:	c1 fa 02             	sar    $0x2,%edx
    }while(n);
80106462:	29 ca                	sub    %ecx,%edx
80106464:	89 d1                	mov    %edx,%ecx
80106466:	75 e8                	jne    80106450 <sys_open+0x620>
80106468:	89 d8                	mov    %ebx,%eax
8010646a:	8b 5d b8             	mov    -0x48(%ebp),%ebx
    p++;
8010646d:	8d 4f 02             	lea    0x2(%edi),%ecx
    *p = '\0';
80106470:	c6 40 01 00          	movb   $0x0,0x1(%eax)
        *--p = digit[i%10];
80106474:	bf 67 66 66 66       	mov    $0x66666667,%edi
80106479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106480:	89 d8                	mov    %ebx,%eax
80106482:	83 e9 01             	sub    $0x1,%ecx
80106485:	f7 ef                	imul   %edi
80106487:	89 d8                	mov    %ebx,%eax
80106489:	c1 f8 1f             	sar    $0x1f,%eax
8010648c:	c1 fa 02             	sar    $0x2,%edx
8010648f:	29 c2                	sub    %eax,%edx
80106491:	8d 04 92             	lea    (%edx,%edx,4),%eax
80106494:	01 c0                	add    %eax,%eax
80106496:	29 c3                	sub    %eax,%ebx
    }while(i);
80106498:	85 d2                	test   %edx,%edx
        *--p = digit[i%10];
8010649a:	0f b6 44 1d dd       	movzbl -0x23(%ebp,%ebx,1),%eax
        i = i/10;
8010649f:	89 d3                	mov    %edx,%ebx
        *--p = digit[i%10];
801064a1:	88 01                	mov    %al,(%ecx)
    }while(i);
801064a3:	75 db                	jne    80106480 <sys_open+0x650>
    char *path6 = strcat(ipath3,sind);
801064a5:	83 ec 08             	sub    $0x8,%esp
    *--p = sig[0];
801064a8:	c6 41 ff 5f          	movb   $0x5f,-0x1(%ecx)
    char *path6 = strcat(ipath3,sind);
801064ac:	ff 75 bc             	pushl  -0x44(%ebp)
801064af:	ff 75 d4             	pushl  -0x2c(%ebp)
801064b2:	e8 99 f8 ff ff       	call   80105d50 <strcat>
801064b7:	ba e8 2b 11 80       	mov    $0x80112be8,%edx
801064bc:	83 c4 10             	add    $0x10,%esp
801064bf:	8b 7d c0             	mov    -0x40(%ebp),%edi
801064c2:	89 75 bc             	mov    %esi,-0x44(%ebp)
801064c5:	eb 17                	jmp    801064de <sys_open+0x6ae>
801064c7:	89 f6                	mov    %esi,%esi
801064c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    for (int i = 0; i < 100; i++) {
801064d0:	83 c3 01             	add    $0x1,%ebx
801064d3:	81 c2 bc 04 00 00    	add    $0x4bc,%edx
801064d9:	83 fb 64             	cmp    $0x64,%ebx
801064dc:	74 42                	je     80106520 <sys_open+0x6f0>
      if (container_location[i]==1){
801064de:	83 3c 9d 00 06 13 80 	cmpl   $0x1,-0x7fecfa00(,%ebx,4)
801064e5:	01 
801064e6:	75 e8                	jne    801064d0 <sys_open+0x6a0>
        if(container_array[i].cid==cid){
801064e8:	39 7a f8             	cmp    %edi,-0x8(%edx)
801064eb:	75 e3                	jne    801064d0 <sys_open+0x6a0>
            container_array[i].container_files[container_array[i].number_of_files] = path6;
801064ed:	8b 0a                	mov    (%edx),%ecx
801064ef:	81 c2 bc 04 00 00    	add    $0x4bc,%edx
801064f5:	69 f3 2f 01 00 00    	imul   $0x12f,%ebx,%esi
    for (int i = 0; i < 100; i++) {
801064fb:	83 c3 01             	add    $0x1,%ebx
            container_array[i].container_files[container_array[i].number_of_files] = path6;
801064fe:	01 ce                	add    %ecx,%esi
            container_array[i].number_of_files++;
80106500:	83 c1 01             	add    $0x1,%ecx
            container_array[i].container_files[container_array[i].number_of_files] = path6;
80106503:	89 04 b5 7c 2d 11 80 	mov    %eax,-0x7feed284(,%esi,4)
            container_array[i].copied_or_not[container_array[i].number_of_files] = 0;
8010650a:	c7 04 b5 0c 2f 11 80 	movl   $0x0,-0x7feed0f4(,%esi,4)
80106511:	00 00 00 00 
            container_array[i].number_of_files++;
80106515:	89 8a 44 fb ff ff    	mov    %ecx,-0x4bc(%edx)
    for (int i = 0; i < 100; i++) {
8010651b:	83 fb 64             	cmp    $0x64,%ebx
8010651e:	75 be                	jne    801064de <sys_open+0x6ae>
    f->path = path6;
80106520:	8b 7d c4             	mov    -0x3c(%ebp),%edi
80106523:	8b 75 bc             	mov    -0x44(%ebp),%esi
80106526:	89 47 1c             	mov    %eax,0x1c(%edi)
    f->cid = cid;
80106529:	89 f8                	mov    %edi,%eax
8010652b:	8b 7d c0             	mov    -0x40(%ebp),%edi
8010652e:	89 78 18             	mov    %edi,0x18(%eax)
}
80106531:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106534:	89 f0                	mov    %esi,%eax
80106536:	5b                   	pop    %ebx
80106537:	5e                   	pop    %esi
80106538:	5f                   	pop    %edi
80106539:	5d                   	pop    %ebp
8010653a:	c3                   	ret    
  f->off = 0;
8010653b:	8b 75 c4             	mov    -0x3c(%ebp),%esi
  cprintf("yahan 2 fd2 ka offset %d\n", f2->off);
8010653e:	83 ec 08             	sub    $0x8,%esp
  f2->off = 0;
80106541:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->off = 0;
80106548:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  cprintf("yahan 2 fd2 ka offset %d\n", f2->off);
8010654f:	ff 77 14             	pushl  0x14(%edi)
80106552:	68 96 8d 10 80       	push   $0x80108d96
80106557:	e8 04 a1 ff ff       	call   80100660 <cprintf>
  myproc()->ofile[fd] = 0;
8010655c:	e8 9f d2 ff ff       	call   80103800 <myproc>
80106561:	8b 4d b4             	mov    -0x4c(%ebp),%ecx
80106564:	c7 44 88 08 00 00 00 	movl   $0x0,0x8(%eax,%ecx,4)
8010656b:	00 
  fileclose(f);
8010656c:	89 34 24             	mov    %esi,(%esp)
8010656f:	e8 cc a8 ff ff       	call   80100e40 <fileclose>
  myproc()->ofile[fd2] = 0;
80106574:	e8 87 d2 ff ff       	call   80103800 <myproc>
80106579:	8b 4d b8             	mov    -0x48(%ebp),%ecx
8010657c:	c7 44 88 08 00 00 00 	movl   $0x0,0x8(%eax,%ecx,4)
80106583:	00 
  fileclose(f2);
80106584:	89 3c 24             	mov    %edi,(%esp)
80106587:	e8 b4 a8 ff ff       	call   80100e40 <fileclose>
  begin_op();
8010658c:	e8 2f c6 ff ff       	call   80102bc0 <begin_op>
  if(omode & O_CREATE){
80106591:	83 c4 10             	add    $0x10,%esp
80106594:	f6 45 d9 02          	testb  $0x2,-0x27(%ebp)
80106598:	0f 84 f8 fc ff ff    	je     80106296 <sys_open+0x466>
    cprintf("yahan nahi aana chahiye 6\n");
8010659e:	83 ec 0c             	sub    $0xc,%esp
801065a1:	68 b0 8d 10 80       	push   $0x80108db0
801065a6:	e8 b5 a0 ff ff       	call   80100660 <cprintf>
    ip3 = create(path3, T_FILE, 0, 0);
801065ab:	8b 45 bc             	mov    -0x44(%ebp),%eax
801065ae:	31 c9                	xor    %ecx,%ecx
801065b0:	ba 02 00 00 00       	mov    $0x2,%edx
801065b5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801065bc:	e8 bf eb ff ff       	call   80105180 <create>
    if(ip3 == 0){
801065c1:	83 c4 10             	add    $0x10,%esp
801065c4:	85 c0                	test   %eax,%eax
    ip3 = create(path3, T_FILE, 0, 0);
801065c6:	89 c7                	mov    %eax,%edi
    if(ip3 == 0){
801065c8:	0f 84 9a 01 00 00    	je     80106768 <sys_open+0x938>
  if((f3 = filealloc()) == 0 || (fd3 = fdalloc(f3)) < 0){
801065ce:	e8 ad a7 ff ff       	call   80100d80 <filealloc>
801065d3:	85 c0                	test   %eax,%eax
801065d5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801065d8:	0f 84 f2 fc ff ff    	je     801062d0 <sys_open+0x4a0>
  struct proc *curproc = myproc();
801065de:	e8 1d d2 ff ff       	call   80103800 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801065e3:	31 f6                	xor    %esi,%esi
801065e5:	8b 55 c4             	mov    -0x3c(%ebp),%edx
801065e8:	eb 12                	jmp    801065fc <sys_open+0x7cc>
801065ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801065f0:	83 c6 01             	add    $0x1,%esi
801065f3:	83 fe 64             	cmp    $0x64,%esi
801065f6:	0f 84 9a 01 00 00    	je     80106796 <sys_open+0x966>
    if(curproc->ofile[fd] == 0){
801065fc:	8b 4c b0 28          	mov    0x28(%eax,%esi,4),%ecx
80106600:	85 c9                	test   %ecx,%ecx
80106602:	75 ec                	jne    801065f0 <sys_open+0x7c0>
  iunlock(ip3);
80106604:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80106607:	89 54 b0 28          	mov    %edx,0x28(%eax,%esi,4)
8010660b:	89 55 c4             	mov    %edx,-0x3c(%ebp)
  iunlock(ip3);
8010660e:	57                   	push   %edi
8010660f:	e8 5c b1 ff ff       	call   80101770 <iunlock>
  end_op();
80106614:	e8 17 c6 ff ff       	call   80102c30 <end_op>
  f3->type = FD_INODE;
80106619:	8b 55 c4             	mov    -0x3c(%ebp),%edx
  f3->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010661c:	83 c4 10             	add    $0x10,%esp
8010661f:	89 75 c4             	mov    %esi,-0x3c(%ebp)
  f3->type = FD_INODE;
80106622:	c7 02 02 00 00 00    	movl   $0x2,(%edx)
  f3->readable = !(omode & O_WRONLY);
80106628:	8b 4d d8             	mov    -0x28(%ebp),%ecx
  f3->ip = ip3;
8010662b:	89 7a 10             	mov    %edi,0x10(%edx)
  f3->path = path3;
8010662e:	8b 7d bc             	mov    -0x44(%ebp),%edi
  f3->off = 0;
80106631:	c7 42 14 00 00 00 00 	movl   $0x0,0x14(%edx)
  f3->readable = !(omode & O_WRONLY);
80106638:	89 c8                	mov    %ecx,%eax
8010663a:	f7 d0                	not    %eax
  f3->path = path3;
8010663c:	89 7a 1c             	mov    %edi,0x1c(%edx)
  f3->readable = !(omode & O_WRONLY);
8010663f:	83 e0 01             	and    $0x1,%eax
  f3->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106642:	83 e1 03             	and    $0x3,%ecx
  f3->cid = cid;
80106645:	8b 4d c0             	mov    -0x40(%ebp),%ecx
  f3->readable = !(omode & O_WRONLY);
80106648:	88 42 08             	mov    %al,0x8(%edx)
  f3->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010664b:	0f 95 42 09          	setne  0x9(%edx)
8010664f:	b8 e8 2b 11 80       	mov    $0x80112be8,%eax
  f3->cid = cid;
80106654:	89 4a 18             	mov    %ecx,0x18(%edx)
80106657:	89 ce                	mov    %ecx,%esi
80106659:	eb 12                	jmp    8010666d <sys_open+0x83d>
8010665b:	90                   	nop
8010665c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for (int i = 0; i < 100; i++) {
80106660:	83 c3 01             	add    $0x1,%ebx
80106663:	05 bc 04 00 00       	add    $0x4bc,%eax
80106668:	83 fb 64             	cmp    $0x64,%ebx
8010666b:	74 41                	je     801066ae <sys_open+0x87e>
    if (container_location[i]==1){
8010666d:	83 3c 9d 00 06 13 80 	cmpl   $0x1,-0x7fecfa00(,%ebx,4)
80106674:	01 
80106675:	75 e9                	jne    80106660 <sys_open+0x830>
      if(container_array[i].cid==cid){
80106677:	39 70 f8             	cmp    %esi,-0x8(%eax)
8010667a:	75 e4                	jne    80106660 <sys_open+0x830>
          container_array[i].container_files[container_array[i].number_of_files] = path3;
8010667c:	8b 10                	mov    (%eax),%edx
8010667e:	05 bc 04 00 00       	add    $0x4bc,%eax
80106683:	69 cb 2f 01 00 00    	imul   $0x12f,%ebx,%ecx
  for (int i = 0; i < 100; i++) {
80106689:	83 c3 01             	add    $0x1,%ebx
          container_array[i].container_files[container_array[i].number_of_files] = path3;
8010668c:	01 d1                	add    %edx,%ecx
          container_array[i].number_of_files++;
8010668e:	83 c2 01             	add    $0x1,%edx
          container_array[i].container_files[container_array[i].number_of_files] = path3;
80106691:	89 3c 8d 7c 2d 11 80 	mov    %edi,-0x7feed284(,%ecx,4)
          container_array[i].copied_or_not[container_array[i].number_of_files] = 1;
80106698:	c7 04 8d 0c 2f 11 80 	movl   $0x1,-0x7feed0f4(,%ecx,4)
8010669f:	01 00 00 00 
          container_array[i].number_of_files++;
801066a3:	89 90 44 fb ff ff    	mov    %edx,-0x4bc(%eax)
  for (int i = 0; i < 100; i++) {
801066a9:	83 fb 64             	cmp    $0x64,%ebx
801066ac:	75 bf                	jne    8010666d <sys_open+0x83d>
801066ae:	8b 75 c4             	mov    -0x3c(%ebp),%esi
  cprintf("yahan fd3 is %d \n",fd3);
801066b1:	83 ec 08             	sub    $0x8,%esp
801066b4:	56                   	push   %esi
801066b5:	68 cb 8d 10 80       	push   $0x80108dcb
801066ba:	e8 a1 9f ff ff       	call   80100660 <cprintf>
  return fd3;
801066bf:	83 c4 10             	add    $0x10,%esp
}
801066c2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801066c5:	89 f0                	mov    %esi,%eax
801066c7:	5b                   	pop    %ebx
801066c8:	5e                   	pop    %esi
801066c9:	5f                   	pop    %edi
801066ca:	5d                   	pop    %ebp
801066cb:	c3                   	ret    
    cprintf("pehle_se_hai_conatiner_me\n");
801066cc:	83 ec 0c             	sub    $0xc,%esp
801066cf:	68 1b 8d 10 80       	push   $0x80108d1b
801066d4:	e8 87 9f ff ff       	call   80100660 <cprintf>
    return fd;
801066d9:	83 c4 10             	add    $0x10,%esp
801066dc:	e9 05 fc ff ff       	jmp    801062e6 <sys_open+0x4b6>
    cprintf("yahan nahi aana chahiye 4\n");
801066e1:	83 ec 0c             	sub    $0xc,%esp
801066e4:	68 dd 8d 10 80       	push   $0x80108ddd
801066e9:	e8 72 9f ff ff       	call   80100660 <cprintf>
      fileclose(f);
801066ee:	58                   	pop    %eax
801066ef:	ff 75 c4             	pushl  -0x3c(%ebp)
801066f2:	e8 49 a7 ff ff       	call   80100e40 <fileclose>
801066f7:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801066fa:	83 ec 0c             	sub    $0xc,%esp
    return -1;
801066fd:	be ff ff ff ff       	mov    $0xffffffff,%esi
    iunlockput(ip);
80106702:	53                   	push   %ebx
80106703:	e8 18 b2 ff ff       	call   80101920 <iunlockput>
    end_op();
80106708:	e8 23 c5 ff ff       	call   80102c30 <end_op>
    return -1;
8010670d:	83 c4 10             	add    $0x10,%esp
80106710:	e9 d1 fb ff ff       	jmp    801062e6 <sys_open+0x4b6>
    {cprintf("yahan nahi aana chahiye 0\n");
80106715:	83 ec 0c             	sub    $0xc,%esp
    return -1;}
80106718:	be ff ff ff ff       	mov    $0xffffffff,%esi
    {cprintf("yahan nahi aana chahiye 0\n");
8010671d:	68 c1 8c 10 80       	push   $0x80108cc1
80106722:	e8 39 9f ff ff       	call   80100660 <cprintf>
    return -1;}
80106727:	83 c4 10             	add    $0x10,%esp
8010672a:	e9 b7 fb ff ff       	jmp    801062e6 <sys_open+0x4b6>
    cprintf("yahan nahi aana chahiye 4\n");
8010672f:	83 ec 0c             	sub    $0xc,%esp
80106732:	68 dd 8d 10 80       	push   $0x80108ddd
80106737:	e8 24 9f ff ff       	call   80100660 <cprintf>
8010673c:	83 c4 10             	add    $0x10,%esp
8010673f:	eb b9                	jmp    801066fa <sys_open+0x8ca>
      fileclose(f2);
80106741:	83 ec 0c             	sub    $0xc,%esp
80106744:	57                   	push   %edi
80106745:	e8 f6 a6 ff ff       	call   80100e40 <fileclose>
8010674a:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip2);
8010674d:	83 ec 0c             	sub    $0xc,%esp
80106750:	56                   	push   %esi
    return -1;
80106751:	be ff ff ff ff       	mov    $0xffffffff,%esi
    iunlockput(ip2);
80106756:	e8 c5 b1 ff ff       	call   80101920 <iunlockput>
    end_op();
8010675b:	e8 d0 c4 ff ff       	call   80102c30 <end_op>
    return -1;
80106760:	83 c4 10             	add    $0x10,%esp
80106763:	e9 7e fb ff ff       	jmp    801062e6 <sys_open+0x4b6>
      end_op();
80106768:	e8 c3 c4 ff ff       	call   80102c30 <end_op>
      return -1;
8010676d:	be ff ff ff ff       	mov    $0xffffffff,%esi
80106772:	e9 6f fb ff ff       	jmp    801062e6 <sys_open+0x4b6>
    cprintf("yahan nahi aana chahiye 5\n");
80106777:	83 ec 0c             	sub    $0xc,%esp
    return -1;
8010677a:	be ff ff ff ff       	mov    $0xffffffff,%esi
    cprintf("yahan nahi aana chahiye 5\n");
8010677f:	68 36 8d 10 80       	push   $0x80108d36
80106784:	e8 d7 9e ff ff       	call   80100660 <cprintf>
    end_op();
80106789:	e8 a2 c4 ff ff       	call   80102c30 <end_op>
    return -1;
8010678e:	83 c4 10             	add    $0x10,%esp
80106791:	e9 50 fb ff ff       	jmp    801062e6 <sys_open+0x4b6>
      fileclose(f3);
80106796:	83 ec 0c             	sub    $0xc,%esp
80106799:	52                   	push   %edx
8010679a:	e8 a1 a6 ff ff       	call   80100e40 <fileclose>
8010679f:	83 c4 10             	add    $0x10,%esp
801067a2:	e9 29 fb ff ff       	jmp    801062d0 <sys_open+0x4a0>
801067a7:	89 f6                	mov    %esi,%esi
801067a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801067b0 <sys_create_container>:

int
sys_create_container(int cid){
801067b0:	55                   	push   %ebp
801067b1:	89 e5                	mov    %esp,%ebp
801067b3:	53                   	push   %ebx
  // cprintf("Create container call hua%s\n");
  create_container_called = 1;
  argint(0,&cid);
801067b4:	8d 45 08             	lea    0x8(%ebp),%eax
sys_create_container(int cid){
801067b7:	83 ec 0c             	sub    $0xc,%esp
  create_container_called = 1;
801067ba:	c7 05 c8 c5 10 80 01 	movl   $0x1,0x8010c5c8
801067c1:	00 00 00 
  argint(0,&cid);
801067c4:	50                   	push   %eax
801067c5:	6a 00                	push   $0x0
801067c7:	e8 44 e5 ff ff       	call   80104d10 <argint>
  for (int i = 0; i < 100; i++) {
    if (container_location[i]==1){
      if(container_array[i].cid==cid){return -1;}
801067cc:	8b 45 08             	mov    0x8(%ebp),%eax
801067cf:	83 c4 10             	add    $0x10,%esp
  for (int i = 0; i < 100; i++) {
801067d2:	31 d2                	xor    %edx,%edx
801067d4:	eb 12                	jmp    801067e8 <sys_create_container+0x38>
801067d6:	8d 76 00             	lea    0x0(%esi),%esi
801067d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801067e0:	83 c2 01             	add    $0x1,%edx
801067e3:	83 fa 64             	cmp    $0x64,%edx
801067e6:	74 28                	je     80106810 <sys_create_container+0x60>
    if (container_location[i]==1){
801067e8:	83 3c 95 00 06 13 80 	cmpl   $0x1,-0x7fecfa00(,%edx,4)
801067ef:	01 
801067f0:	75 ee                	jne    801067e0 <sys_create_container+0x30>
      if(container_array[i].cid==cid){return -1;}
801067f2:	69 ca bc 04 00 00    	imul   $0x4bc,%edx,%ecx
801067f8:	39 81 e0 2b 11 80    	cmp    %eax,-0x7feed420(%ecx)
801067fe:	75 e0                	jne    801067e0 <sys_create_container+0x30>
80106800:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      container_array[i].number_of_files=0;
      break;
    }
  }
  return cid;
}
80106805:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106808:	c9                   	leave  
80106809:	c3                   	ret    
8010680a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for ( int i=0; i<100 ; i++) {
80106810:	31 d2                	xor    %edx,%edx
80106812:	eb 0c                	jmp    80106820 <sys_create_container+0x70>
80106814:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106818:	83 c2 01             	add    $0x1,%edx
8010681b:	83 fa 64             	cmp    $0x64,%edx
8010681e:	74 e5                	je     80106805 <sys_create_container+0x55>
    if (container_location[i]!=1){
80106820:	83 3c 95 00 06 13 80 	cmpl   $0x1,-0x7fecfa00(,%edx,4)
80106827:	01 
80106828:	74 ee                	je     80106818 <sys_create_container+0x68>
      container_array[i]=new_container;
8010682a:	69 da bc 04 00 00    	imul   $0x4bc,%edx,%ebx
      container_location[i]=1;
80106830:	c7 04 95 00 06 13 80 	movl   $0x1,-0x7fecfa00(,%edx,4)
80106837:	01 00 00 00 
      container_array[i]=new_container;
8010683b:	89 83 e0 2b 11 80    	mov    %eax,-0x7feed420(%ebx)
      container_array[i].number_of_process=0;
80106841:	c7 83 e4 2b 11 80 00 	movl   $0x0,-0x7feed41c(%ebx)
80106848:	00 00 00 
      container_array[i].number_of_files=0;
8010684b:	c7 83 e8 2b 11 80 00 	movl   $0x0,-0x7feed418(%ebx)
80106852:	00 00 00 
}
80106855:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106858:	c9                   	leave  
80106859:	c3                   	ret    
8010685a:	66 90                	xchg   %ax,%ax
8010685c:	66 90                	xchg   %ax,%ax
8010685e:	66 90                	xchg   %ax,%ax

80106860 <sys_fork>:

// #include "queues.h"

int
sys_fork(void)
{ if(isTraceOn==1)
80106860:	83 3d 18 27 11 80 01 	cmpl   $0x1,0x80112718
80106867:	55                   	push   %ebp
80106868:	89 e5                	mov    %esp,%ebp
8010686a:	75 07                	jne    80106873 <sys_fork+0x13>
  {num_calls[SYS_fork] ++;}
8010686c:	83 05 44 2a 11 80 01 	addl   $0x1,0x80112a44
  return fork();
}
80106873:	5d                   	pop    %ebp
  return fork();
80106874:	e9 37 d1 ff ff       	jmp    801039b0 <fork>
80106879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106880 <sys_exit>:

int
sys_exit(void)
{ if(isTraceOn==1)
80106880:	55                   	push   %ebp
80106881:	89 e5                	mov    %esp,%ebp
80106883:	83 ec 08             	sub    $0x8,%esp
80106886:	83 3d 18 27 11 80 01 	cmpl   $0x1,0x80112718
8010688d:	75 07                	jne    80106896 <sys_exit+0x16>
  {num_calls[SYS_exit] ++;}
8010688f:	83 05 48 2a 11 80 01 	addl   $0x1,0x80112a48
  exit();
80106896:	e8 35 d4 ff ff       	call   80103cd0 <exit>
  return 0;  // not reached
}
8010689b:	31 c0                	xor    %eax,%eax
8010689d:	c9                   	leave  
8010689e:	c3                   	ret    
8010689f:	90                   	nop

801068a0 <sys_wait>:

int
sys_wait(void)
{ if(isTraceOn==1)
801068a0:	83 3d 18 27 11 80 01 	cmpl   $0x1,0x80112718
801068a7:	55                   	push   %ebp
801068a8:	89 e5                	mov    %esp,%ebp
801068aa:	75 07                	jne    801068b3 <sys_wait+0x13>
  {num_calls[SYS_wait] ++;}
801068ac:	83 05 4c 2a 11 80 01 	addl   $0x1,0x80112a4c
  return wait();
}
801068b3:	5d                   	pop    %ebp
  return wait();
801068b4:	e9 67 d6 ff ff       	jmp    80103f20 <wait>
801068b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801068c0 <sys_kill>:

int
sys_kill(void)
{ if(isTraceOn==1)
801068c0:	55                   	push   %ebp
801068c1:	89 e5                	mov    %esp,%ebp
801068c3:	83 ec 18             	sub    $0x18,%esp
801068c6:	83 3d 18 27 11 80 01 	cmpl   $0x1,0x80112718
801068cd:	75 07                	jne    801068d6 <sys_kill+0x16>
  {num_calls[SYS_kill] ++;}
801068cf:	83 05 58 2a 11 80 01 	addl   $0x1,0x80112a58
  int pid;

  if(argint(0, &pid) < 0)
801068d6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801068d9:	83 ec 08             	sub    $0x8,%esp
801068dc:	50                   	push   %eax
801068dd:	6a 00                	push   $0x0
801068df:	e8 2c e4 ff ff       	call   80104d10 <argint>
801068e4:	83 c4 10             	add    $0x10,%esp
801068e7:	85 c0                	test   %eax,%eax
801068e9:	78 15                	js     80106900 <sys_kill+0x40>
    return -1;
  return kill(pid);
801068eb:	83 ec 0c             	sub    $0xc,%esp
801068ee:	ff 75 f4             	pushl  -0xc(%ebp)
801068f1:	e8 8a d7 ff ff       	call   80104080 <kill>
801068f6:	83 c4 10             	add    $0x10,%esp
}
801068f9:	c9                   	leave  
801068fa:	c3                   	ret    
801068fb:	90                   	nop
801068fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106900:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106905:	c9                   	leave  
80106906:	c3                   	ret    
80106907:	89 f6                	mov    %esi,%esi
80106909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106910 <sys_getpid>:

int
sys_getpid(void)
{ if(isTraceOn==1)
80106910:	55                   	push   %ebp
80106911:	89 e5                	mov    %esp,%ebp
80106913:	83 ec 08             	sub    $0x8,%esp
80106916:	83 3d 18 27 11 80 01 	cmpl   $0x1,0x80112718
8010691d:	75 07                	jne    80106926 <sys_getpid+0x16>
  {num_calls[SYS_getpid] ++;}
8010691f:	83 05 6c 2a 11 80 01 	addl   $0x1,0x80112a6c
  return myproc()->pid;
80106926:	e8 d5 ce ff ff       	call   80103800 <myproc>
8010692b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010692e:	c9                   	leave  
8010692f:	c3                   	ret    

80106930 <sys_sbrk>:

int
sys_sbrk(void)
{ if(isTraceOn==1)
80106930:	55                   	push   %ebp
80106931:	89 e5                	mov    %esp,%ebp
80106933:	53                   	push   %ebx
80106934:	83 ec 14             	sub    $0x14,%esp
80106937:	83 3d 18 27 11 80 01 	cmpl   $0x1,0x80112718
8010693e:	75 07                	jne    80106947 <sys_sbrk+0x17>
  {num_calls[SYS_sbrk] ++;}
80106940:	83 05 70 2a 11 80 01 	addl   $0x1,0x80112a70
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106947:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010694a:	83 ec 08             	sub    $0x8,%esp
8010694d:	50                   	push   %eax
8010694e:	6a 00                	push   $0x0
80106950:	e8 bb e3 ff ff       	call   80104d10 <argint>
80106955:	83 c4 10             	add    $0x10,%esp
80106958:	85 c0                	test   %eax,%eax
8010695a:	78 24                	js     80106980 <sys_sbrk+0x50>
    return -1;
  addr = myproc()->sz;
8010695c:	e8 9f ce ff ff       	call   80103800 <myproc>
  if(growproc(n) < 0)
80106961:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80106964:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106966:	ff 75 f4             	pushl  -0xc(%ebp)
80106969:	e8 c2 cf ff ff       	call   80103930 <growproc>
8010696e:	83 c4 10             	add    $0x10,%esp
80106971:	85 c0                	test   %eax,%eax
80106973:	78 0b                	js     80106980 <sys_sbrk+0x50>
    return -1;
  return addr;
}
80106975:	89 d8                	mov    %ebx,%eax
80106977:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010697a:	c9                   	leave  
8010697b:	c3                   	ret    
8010697c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106980:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106985:	eb ee                	jmp    80106975 <sys_sbrk+0x45>
80106987:	89 f6                	mov    %esi,%esi
80106989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106990 <sys_sleep>:

int
sys_sleep(void)
{ if(isTraceOn==1)
80106990:	55                   	push   %ebp
80106991:	89 e5                	mov    %esp,%ebp
80106993:	53                   	push   %ebx
80106994:	83 ec 14             	sub    $0x14,%esp
80106997:	83 3d 18 27 11 80 01 	cmpl   $0x1,0x80112718
8010699e:	75 07                	jne    801069a7 <sys_sleep+0x17>
  {num_calls[SYS_sleep] ++;}
801069a0:	83 05 74 2a 11 80 01 	addl   $0x1,0x80112a74
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801069a7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801069aa:	83 ec 08             	sub    $0x8,%esp
801069ad:	50                   	push   %eax
801069ae:	6a 00                	push   $0x0
801069b0:	e8 5b e3 ff ff       	call   80104d10 <argint>
801069b5:	83 c4 10             	add    $0x10,%esp
801069b8:	85 c0                	test   %eax,%eax
801069ba:	0f 88 87 00 00 00    	js     80106a47 <sys_sleep+0xb7>
    return -1;
  acquire(&tickslock);
801069c0:	83 ec 0c             	sub    $0xc,%esp
801069c3:	68 60 ac 13 80       	push   $0x8013ac60
801069c8:	e8 33 df ff ff       	call   80104900 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801069cd:	8b 55 f4             	mov    -0xc(%ebp),%edx
801069d0:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
801069d3:	8b 1d a0 b4 13 80    	mov    0x8013b4a0,%ebx
  while(ticks - ticks0 < n){
801069d9:	85 d2                	test   %edx,%edx
801069db:	75 24                	jne    80106a01 <sys_sleep+0x71>
801069dd:	eb 51                	jmp    80106a30 <sys_sleep+0xa0>
801069df:	90                   	nop
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801069e0:	83 ec 08             	sub    $0x8,%esp
801069e3:	68 60 ac 13 80       	push   $0x8013ac60
801069e8:	68 a0 b4 13 80       	push   $0x8013b4a0
801069ed:	e8 6e d4 ff ff       	call   80103e60 <sleep>
  while(ticks - ticks0 < n){
801069f2:	a1 a0 b4 13 80       	mov    0x8013b4a0,%eax
801069f7:	83 c4 10             	add    $0x10,%esp
801069fa:	29 d8                	sub    %ebx,%eax
801069fc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801069ff:	73 2f                	jae    80106a30 <sys_sleep+0xa0>
    if(myproc()->killed){
80106a01:	e8 fa cd ff ff       	call   80103800 <myproc>
80106a06:	8b 40 24             	mov    0x24(%eax),%eax
80106a09:	85 c0                	test   %eax,%eax
80106a0b:	74 d3                	je     801069e0 <sys_sleep+0x50>
      release(&tickslock);
80106a0d:	83 ec 0c             	sub    $0xc,%esp
80106a10:	68 60 ac 13 80       	push   $0x8013ac60
80106a15:	e8 a6 df ff ff       	call   801049c0 <release>
      return -1;
80106a1a:	83 c4 10             	add    $0x10,%esp
80106a1d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80106a22:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106a25:	c9                   	leave  
80106a26:	c3                   	ret    
80106a27:	89 f6                	mov    %esi,%esi
80106a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80106a30:	83 ec 0c             	sub    $0xc,%esp
80106a33:	68 60 ac 13 80       	push   $0x8013ac60
80106a38:	e8 83 df ff ff       	call   801049c0 <release>
  return 0;
80106a3d:	83 c4 10             	add    $0x10,%esp
80106a40:	31 c0                	xor    %eax,%eax
}
80106a42:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106a45:	c9                   	leave  
80106a46:	c3                   	ret    
    return -1;
80106a47:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a4c:	eb f4                	jmp    80106a42 <sys_sleep+0xb2>
80106a4e:	66 90                	xchg   %ax,%ax

80106a50 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{ if(isTraceOn==1)
80106a50:	55                   	push   %ebp
80106a51:	89 e5                	mov    %esp,%ebp
80106a53:	53                   	push   %ebx
80106a54:	83 ec 04             	sub    $0x4,%esp
80106a57:	83 3d 18 27 11 80 01 	cmpl   $0x1,0x80112718
80106a5e:	75 07                	jne    80106a67 <sys_uptime+0x17>
  {num_calls[SYS_uptime] ++;}
80106a60:	83 05 78 2a 11 80 01 	addl   $0x1,0x80112a78
  uint xticks;

  acquire(&tickslock);
80106a67:	83 ec 0c             	sub    $0xc,%esp
80106a6a:	68 60 ac 13 80       	push   $0x8013ac60
80106a6f:	e8 8c de ff ff       	call   80104900 <acquire>
  xticks = ticks;
80106a74:	8b 1d a0 b4 13 80    	mov    0x8013b4a0,%ebx
  release(&tickslock);
80106a7a:	c7 04 24 60 ac 13 80 	movl   $0x8013ac60,(%esp)
80106a81:	e8 3a df ff ff       	call   801049c0 <release>
  return xticks;
}
80106a86:	89 d8                	mov    %ebx,%eax
80106a88:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106a8b:	c9                   	leave  
80106a8c:	c3                   	ret    
80106a8d:	8d 76 00             	lea    0x0(%esi),%esi

80106a90 <sys_halt>:

int
sys_halt(void)
{ if(isTraceOn==1)
80106a90:	83 3d 18 27 11 80 01 	cmpl   $0x1,0x80112718
80106a97:	55                   	push   %ebp
80106a98:	89 e5                	mov    %esp,%ebp
80106a9a:	75 07                	jne    80106aa3 <sys_halt+0x13>
  {num_calls[SYS_halt] ++;}
80106a9c:	83 05 98 2a 11 80 01 	addl   $0x1,0x80112a98
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106aa3:	31 c0                	xor    %eax,%eax
80106aa5:	ba f4 00 00 00       	mov    $0xf4,%edx
80106aaa:	ee                   	out    %al,(%dx)
  outb(0xf4, 0x00);
  return 0;
}
80106aab:	31 c0                	xor    %eax,%eax
80106aad:	5d                   	pop    %ebp
80106aae:	c3                   	ret    
80106aaf:	90                   	nop

80106ab0 <sys_toggle>:

int
sys_toggle(void)
{
  if(isTraceOn==0)
80106ab0:	a1 18 27 11 80       	mov    0x80112718,%eax
{
80106ab5:	55                   	push   %ebp
80106ab6:	89 e5                	mov    %esp,%ebp
  if(isTraceOn==0)
80106ab8:	85 c0                	test   %eax,%eax
80106aba:	75 2c                	jne    80106ae8 <sys_toggle+0x38>
    {
      isTraceOn=1;
80106abc:	c7 05 18 27 11 80 01 	movl   $0x1,0x80112718
80106ac3:	00 00 00 
80106ac6:	b8 40 2a 11 80       	mov    $0x80112a40,%eax
80106acb:	90                   	nop
80106acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(int i =0;i<NELEM(num_calls);i++){num_calls[i]=0;}
80106ad0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80106ad6:	83 c0 04             	add    $0x4,%eax
80106ad9:	3d e0 2a 11 80       	cmp    $0x80112ae0,%eax
80106ade:	75 f0                	jne    80106ad0 <sys_toggle+0x20>
  {
    isTraceOn=0;
    return 0;
  }
  return 0;
}
80106ae0:	31 c0                	xor    %eax,%eax
80106ae2:	5d                   	pop    %ebp
80106ae3:	c3                   	ret    
80106ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(isTraceOn==1)
80106ae8:	83 f8 01             	cmp    $0x1,%eax
80106aeb:	75 f3                	jne    80106ae0 <sys_toggle+0x30>
}
80106aed:	31 c0                	xor    %eax,%eax
    isTraceOn=0;
80106aef:	c7 05 18 27 11 80 00 	movl   $0x0,0x80112718
80106af6:	00 00 00 
}
80106af9:	5d                   	pop    %ebp
80106afa:	c3                   	ret    
80106afb:	90                   	nop
80106afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106b00 <sys_ps>:



int
sys_ps(void)
{
80106b00:	55                   	push   %ebp
80106b01:	89 e5                	mov    %esp,%ebp
80106b03:	83 ec 08             	sub    $0x8,%esp
  // cprintf("ps call hua%s\n");
  if(isTraceOn==1){num_calls[SYS_ps] ++;}
80106b06:	83 3d 18 27 11 80 01 	cmpl   $0x1,0x80112718
80106b0d:	75 07                	jne    80106b16 <sys_ps+0x16>
80106b0f:	83 05 a0 2a 11 80 01 	addl   $0x1,0x80112aa0
  running_procs();
80106b16:	e8 c5 d6 ff ff       	call   801041e0 <running_procs>
return 0;
}
80106b1b:	31 c0                	xor    %eax,%eax
80106b1d:	c9                   	leave  
80106b1e:	c3                   	ret    
80106b1f:	90                   	nop

80106b20 <sys_destroy_container>:


int
sys_destroy_container(int cid){
80106b20:	55                   	push   %ebp
80106b21:	89 e5                	mov    %esp,%ebp
80106b23:	53                   	push   %ebx
  argint(0,&cid);
80106b24:	8d 45 08             	lea    0x8(%ebp),%eax
sys_destroy_container(int cid){
80106b27:	83 ec 0c             	sub    $0xc,%esp
  argint(0,&cid);
80106b2a:	50                   	push   %eax
80106b2b:	6a 00                	push   $0x0
80106b2d:	e8 de e1 ff ff       	call   80104d10 <argint>
  for (int i = 0; i < 100; i++) {
    if (container_location[i]==1){
      if(container_array[i].cid==cid){
80106b32:	8b 5d 08             	mov    0x8(%ebp),%ebx
80106b35:	83 c4 10             	add    $0x10,%esp
  for (int i = 0; i < 100; i++) {
80106b38:	31 d2                	xor    %edx,%edx
80106b3a:	eb 0c                	jmp    80106b48 <sys_destroy_container+0x28>
80106b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106b40:	83 c2 01             	add    $0x1,%edx
80106b43:	83 fa 64             	cmp    $0x64,%edx
80106b46:	74 30                	je     80106b78 <sys_destroy_container+0x58>
    if (container_location[i]==1){
80106b48:	8b 04 95 00 06 13 80 	mov    -0x7fecfa00(,%edx,4),%eax
80106b4f:	83 f8 01             	cmp    $0x1,%eax
80106b52:	75 ec                	jne    80106b40 <sys_destroy_container+0x20>
      if(container_array[i].cid==cid){
80106b54:	69 ca bc 04 00 00    	imul   $0x4bc,%edx,%ecx
80106b5a:	39 99 e0 2b 11 80    	cmp    %ebx,-0x7feed420(%ecx)
80106b60:	75 de                	jne    80106b40 <sys_destroy_container+0x20>
        // container_array[i]=null;
        container_location[i]=0;
80106b62:	c7 04 95 00 06 13 80 	movl   $0x0,-0x7fecfa00(,%edx,4)
80106b69:	00 00 00 00 
        return 1;
        }
    }
  }
  return -1;
}
80106b6d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106b70:	c9                   	leave  
80106b71:	c3                   	ret    
80106b72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80106b78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106b7d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106b80:	c9                   	leave  
80106b81:	c3                   	ret    
80106b82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b90 <sys_join_container>:

int
sys_join_container(int cid){
80106b90:	55                   	push   %ebp
80106b91:	89 e5                	mov    %esp,%ebp
80106b93:	83 ec 10             	sub    $0x10,%esp
  // cprintf("Join container call hua%s\n");
  argint(0,&cid);
80106b96:	8d 45 08             	lea    0x8(%ebp),%eax
80106b99:	50                   	push   %eax
80106b9a:	6a 00                	push   $0x0
80106b9c:	e8 6f e1 ff ff       	call   80104d10 <argint>
  int r = join_cont(cid);
80106ba1:	58                   	pop    %eax
80106ba2:	ff 75 08             	pushl  0x8(%ebp)
80106ba5:	e8 06 d8 ff ff       	call   801043b0 <join_cont>
  return r;
}
80106baa:	c9                   	leave  
80106bab:	c3                   	ret    
80106bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106bb0 <sys_leave_container>:

int
sys_leave_container(void){
80106bb0:	55                   	push   %ebp
80106bb1:	89 e5                	mov    %esp,%ebp
80106bb3:	56                   	push   %esi
80106bb4:	53                   	push   %ebx
  struct proc *curproc = myproc();
80106bb5:	e8 46 cc ff ff       	call   80103800 <myproc>
  int cid = curproc->cid;
  for (int i = 0; i < 100; i++) {
80106bba:	31 d2                	xor    %edx,%edx
  int cid = curproc->cid;
80106bbc:	8b b0 cc 01 00 00    	mov    0x1cc(%eax),%esi
80106bc2:	eb 0c                	jmp    80106bd0 <sys_leave_container+0x20>
80106bc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for (int i = 0; i < 100; i++) {
80106bc8:	83 c2 01             	add    $0x1,%edx
80106bcb:	83 fa 64             	cmp    $0x64,%edx
80106bce:	74 50                	je     80106c20 <sys_leave_container+0x70>
    if (container_location[i]==1){
80106bd0:	8b 0c 95 00 06 13 80 	mov    -0x7fecfa00(,%edx,4),%ecx
80106bd7:	83 f9 01             	cmp    $0x1,%ecx
80106bda:	75 ec                	jne    80106bc8 <sys_leave_container+0x18>
      if(container_array[i].cid==cid){
80106bdc:	69 da bc 04 00 00    	imul   $0x4bc,%edx,%ebx
80106be2:	39 b3 e0 2b 11 80    	cmp    %esi,-0x7feed420(%ebx)
80106be8:	75 de                	jne    80106bc8 <sys_leave_container+0x18>
        curproc->cid = 0;
80106bea:	c7 80 cc 01 00 00 00 	movl   $0x0,0x1cc(%eax)
80106bf1:	00 00 00 
        container_array[i].mypid[container_array[i].number_of_process] = -1;
80106bf4:	8b 83 e4 2b 11 80    	mov    -0x7feed41c(%ebx),%eax
80106bfa:	69 d2 2f 01 00 00    	imul   $0x12f,%edx,%edx
80106c00:	01 c2                	add    %eax,%edx
        container_array[i].number_of_process--;
80106c02:	83 e8 01             	sub    $0x1,%eax
80106c05:	89 83 e4 2b 11 80    	mov    %eax,-0x7feed41c(%ebx)
        container_array[i].mypid[container_array[i].number_of_process] = -1;
80106c0b:	c7 04 95 ec 2b 11 80 	movl   $0xffffffff,-0x7feed414(,%edx,4)
80106c12:	ff ff ff ff 
        return 1;
      }
    }
  }
  return -1;
}
80106c16:	89 c8                	mov    %ecx,%eax
80106c18:	5b                   	pop    %ebx
80106c19:	5e                   	pop    %esi
80106c1a:	5d                   	pop    %ebp
80106c1b:	c3                   	ret    
80106c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return -1;
80106c20:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
}
80106c25:	5b                   	pop    %ebx
80106c26:	89 c8                	mov    %ecx,%eax
80106c28:	5e                   	pop    %esi
80106c29:	5d                   	pop    %ebp
80106c2a:	c3                   	ret    

80106c2b <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106c2b:	1e                   	push   %ds
  pushl %es
80106c2c:	06                   	push   %es
  pushl %fs
80106c2d:	0f a0                	push   %fs
  pushl %gs
80106c2f:	0f a8                	push   %gs
  pushal
80106c31:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106c32:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106c36:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106c38:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106c3a:	54                   	push   %esp
  call trap
80106c3b:	e8 c0 00 00 00       	call   80106d00 <trap>
  addl $4, %esp
80106c40:	83 c4 04             	add    $0x4,%esp

80106c43 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106c43:	61                   	popa   
  popl %gs
80106c44:	0f a9                	pop    %gs
  popl %fs
80106c46:	0f a1                	pop    %fs
  popl %es
80106c48:	07                   	pop    %es
  popl %ds
80106c49:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106c4a:	83 c4 08             	add    $0x8,%esp
  iret
80106c4d:	cf                   	iret   
80106c4e:	66 90                	xchg   %ax,%ax

80106c50 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106c50:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106c51:	31 c0                	xor    %eax,%eax
{
80106c53:	89 e5                	mov    %esp,%ebp
80106c55:	83 ec 08             	sub    $0x8,%esp
80106c58:	90                   	nop
80106c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106c60:	8b 14 85 08 c0 10 80 	mov    -0x7fef3ff8(,%eax,4),%edx
80106c67:	c7 04 c5 a2 ac 13 80 	movl   $0x8e000008,-0x7fec535e(,%eax,8)
80106c6e:	08 00 00 8e 
80106c72:	66 89 14 c5 a0 ac 13 	mov    %dx,-0x7fec5360(,%eax,8)
80106c79:	80 
80106c7a:	c1 ea 10             	shr    $0x10,%edx
80106c7d:	66 89 14 c5 a6 ac 13 	mov    %dx,-0x7fec535a(,%eax,8)
80106c84:	80 
  for(i = 0; i < 256; i++)
80106c85:	83 c0 01             	add    $0x1,%eax
80106c88:	3d 00 01 00 00       	cmp    $0x100,%eax
80106c8d:	75 d1                	jne    80106c60 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106c8f:	a1 08 c1 10 80       	mov    0x8010c108,%eax

  initlock(&tickslock, "time");
80106c94:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106c97:	c7 05 a2 ae 13 80 08 	movl   $0xef000008,0x8013aea2
80106c9e:	00 00 ef 
  initlock(&tickslock, "time");
80106ca1:	68 f8 8d 10 80       	push   $0x80108df8
80106ca6:	68 60 ac 13 80       	push   $0x8013ac60
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106cab:	66 a3 a0 ae 13 80    	mov    %ax,0x8013aea0
80106cb1:	c1 e8 10             	shr    $0x10,%eax
80106cb4:	66 a3 a6 ae 13 80    	mov    %ax,0x8013aea6
  initlock(&tickslock, "time");
80106cba:	e8 01 db ff ff       	call   801047c0 <initlock>
}
80106cbf:	83 c4 10             	add    $0x10,%esp
80106cc2:	c9                   	leave  
80106cc3:	c3                   	ret    
80106cc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106cca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106cd0 <idtinit>:

void
idtinit(void)
{
80106cd0:	55                   	push   %ebp
  pd[0] = size-1;
80106cd1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106cd6:	89 e5                	mov    %esp,%ebp
80106cd8:	83 ec 10             	sub    $0x10,%esp
80106cdb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106cdf:	b8 a0 ac 13 80       	mov    $0x8013aca0,%eax
80106ce4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106ce8:	c1 e8 10             	shr    $0x10,%eax
80106ceb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80106cef:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106cf2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106cf5:	c9                   	leave  
80106cf6:	c3                   	ret    
80106cf7:	89 f6                	mov    %esi,%esi
80106cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d00 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106d00:	55                   	push   %ebp
80106d01:	89 e5                	mov    %esp,%ebp
80106d03:	57                   	push   %edi
80106d04:	56                   	push   %esi
80106d05:	53                   	push   %ebx
80106d06:	83 ec 1c             	sub    $0x1c,%esp
80106d09:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
80106d0c:	8b 47 30             	mov    0x30(%edi),%eax
80106d0f:	83 f8 40             	cmp    $0x40,%eax
80106d12:	0f 84 f0 00 00 00    	je     80106e08 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80106d18:	83 e8 20             	sub    $0x20,%eax
80106d1b:	83 f8 1f             	cmp    $0x1f,%eax
80106d1e:	77 10                	ja     80106d30 <trap+0x30>
80106d20:	ff 24 85 a0 8e 10 80 	jmp    *-0x7fef7160(,%eax,4)
80106d27:	89 f6                	mov    %esi,%esi
80106d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80106d30:	e8 cb ca ff ff       	call   80103800 <myproc>
80106d35:	85 c0                	test   %eax,%eax
80106d37:	8b 5f 38             	mov    0x38(%edi),%ebx
80106d3a:	0f 84 14 02 00 00    	je     80106f54 <trap+0x254>
80106d40:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80106d44:	0f 84 0a 02 00 00    	je     80106f54 <trap+0x254>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106d4a:	0f 20 d1             	mov    %cr2,%ecx
80106d4d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106d50:	e8 8b ca ff ff       	call   801037e0 <cpuid>
80106d55:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106d58:	8b 47 34             	mov    0x34(%edi),%eax
80106d5b:	8b 77 30             	mov    0x30(%edi),%esi
80106d5e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106d61:	e8 9a ca ff ff       	call   80103800 <myproc>
80106d66:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106d69:	e8 92 ca ff ff       	call   80103800 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106d6e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106d71:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106d74:	51                   	push   %ecx
80106d75:	53                   	push   %ebx
80106d76:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80106d77:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106d7a:	ff 75 e4             	pushl  -0x1c(%ebp)
80106d7d:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80106d7e:	81 c2 bc 01 00 00    	add    $0x1bc,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106d84:	52                   	push   %edx
80106d85:	ff 70 10             	pushl  0x10(%eax)
80106d88:	68 5c 8e 10 80       	push   $0x80108e5c
80106d8d:	e8 ce 98 ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80106d92:	83 c4 20             	add    $0x20,%esp
80106d95:	e8 66 ca ff ff       	call   80103800 <myproc>
80106d9a:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106da1:	e8 5a ca ff ff       	call   80103800 <myproc>
80106da6:	85 c0                	test   %eax,%eax
80106da8:	74 1d                	je     80106dc7 <trap+0xc7>
80106daa:	e8 51 ca ff ff       	call   80103800 <myproc>
80106daf:	8b 50 24             	mov    0x24(%eax),%edx
80106db2:	85 d2                	test   %edx,%edx
80106db4:	74 11                	je     80106dc7 <trap+0xc7>
80106db6:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80106dba:	83 e0 03             	and    $0x3,%eax
80106dbd:	66 83 f8 03          	cmp    $0x3,%ax
80106dc1:	0f 84 49 01 00 00    	je     80106f10 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106dc7:	e8 34 ca ff ff       	call   80103800 <myproc>
80106dcc:	85 c0                	test   %eax,%eax
80106dce:	74 0b                	je     80106ddb <trap+0xdb>
80106dd0:	e8 2b ca ff ff       	call   80103800 <myproc>
80106dd5:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106dd9:	74 65                	je     80106e40 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106ddb:	e8 20 ca ff ff       	call   80103800 <myproc>
80106de0:	85 c0                	test   %eax,%eax
80106de2:	74 19                	je     80106dfd <trap+0xfd>
80106de4:	e8 17 ca ff ff       	call   80103800 <myproc>
80106de9:	8b 40 24             	mov    0x24(%eax),%eax
80106dec:	85 c0                	test   %eax,%eax
80106dee:	74 0d                	je     80106dfd <trap+0xfd>
80106df0:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80106df4:	83 e0 03             	and    $0x3,%eax
80106df7:	66 83 f8 03          	cmp    $0x3,%ax
80106dfb:	74 34                	je     80106e31 <trap+0x131>
    exit();
}
80106dfd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e00:	5b                   	pop    %ebx
80106e01:	5e                   	pop    %esi
80106e02:	5f                   	pop    %edi
80106e03:	5d                   	pop    %ebp
80106e04:	c3                   	ret    
80106e05:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc()->killed)
80106e08:	e8 f3 c9 ff ff       	call   80103800 <myproc>
80106e0d:	8b 58 24             	mov    0x24(%eax),%ebx
80106e10:	85 db                	test   %ebx,%ebx
80106e12:	0f 85 e8 00 00 00    	jne    80106f00 <trap+0x200>
    myproc()->tf = tf;
80106e18:	e8 e3 c9 ff ff       	call   80103800 <myproc>
80106e1d:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80106e20:	e8 ab e0 ff ff       	call   80104ed0 <syscall>
    if(myproc()->killed)
80106e25:	e8 d6 c9 ff ff       	call   80103800 <myproc>
80106e2a:	8b 48 24             	mov    0x24(%eax),%ecx
80106e2d:	85 c9                	test   %ecx,%ecx
80106e2f:	74 cc                	je     80106dfd <trap+0xfd>
}
80106e31:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e34:	5b                   	pop    %ebx
80106e35:	5e                   	pop    %esi
80106e36:	5f                   	pop    %edi
80106e37:	5d                   	pop    %ebp
      exit();
80106e38:	e9 93 ce ff ff       	jmp    80103cd0 <exit>
80106e3d:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80106e40:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80106e44:	75 95                	jne    80106ddb <trap+0xdb>
    yield();
80106e46:	e8 c5 cf ff ff       	call   80103e10 <yield>
80106e4b:	eb 8e                	jmp    80106ddb <trap+0xdb>
80106e4d:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80106e50:	e8 8b c9 ff ff       	call   801037e0 <cpuid>
80106e55:	85 c0                	test   %eax,%eax
80106e57:	0f 84 c3 00 00 00    	je     80106f20 <trap+0x220>
    lapiceoi();
80106e5d:	e8 0e b9 ff ff       	call   80102770 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106e62:	e8 99 c9 ff ff       	call   80103800 <myproc>
80106e67:	85 c0                	test   %eax,%eax
80106e69:	0f 85 3b ff ff ff    	jne    80106daa <trap+0xaa>
80106e6f:	e9 53 ff ff ff       	jmp    80106dc7 <trap+0xc7>
80106e74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106e78:	e8 b3 b7 ff ff       	call   80102630 <kbdintr>
    lapiceoi();
80106e7d:	e8 ee b8 ff ff       	call   80102770 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106e82:	e8 79 c9 ff ff       	call   80103800 <myproc>
80106e87:	85 c0                	test   %eax,%eax
80106e89:	0f 85 1b ff ff ff    	jne    80106daa <trap+0xaa>
80106e8f:	e9 33 ff ff ff       	jmp    80106dc7 <trap+0xc7>
80106e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106e98:	e8 53 02 00 00       	call   801070f0 <uartintr>
    lapiceoi();
80106e9d:	e8 ce b8 ff ff       	call   80102770 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106ea2:	e8 59 c9 ff ff       	call   80103800 <myproc>
80106ea7:	85 c0                	test   %eax,%eax
80106ea9:	0f 85 fb fe ff ff    	jne    80106daa <trap+0xaa>
80106eaf:	e9 13 ff ff ff       	jmp    80106dc7 <trap+0xc7>
80106eb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106eb8:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80106ebc:	8b 77 38             	mov    0x38(%edi),%esi
80106ebf:	e8 1c c9 ff ff       	call   801037e0 <cpuid>
80106ec4:	56                   	push   %esi
80106ec5:	53                   	push   %ebx
80106ec6:	50                   	push   %eax
80106ec7:	68 04 8e 10 80       	push   $0x80108e04
80106ecc:	e8 8f 97 ff ff       	call   80100660 <cprintf>
    lapiceoi();
80106ed1:	e8 9a b8 ff ff       	call   80102770 <lapiceoi>
    break;
80106ed6:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106ed9:	e8 22 c9 ff ff       	call   80103800 <myproc>
80106ede:	85 c0                	test   %eax,%eax
80106ee0:	0f 85 c4 fe ff ff    	jne    80106daa <trap+0xaa>
80106ee6:	e9 dc fe ff ff       	jmp    80106dc7 <trap+0xc7>
80106eeb:	90                   	nop
80106eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80106ef0:	e8 ab b1 ff ff       	call   801020a0 <ideintr>
80106ef5:	e9 63 ff ff ff       	jmp    80106e5d <trap+0x15d>
80106efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106f00:	e8 cb cd ff ff       	call   80103cd0 <exit>
80106f05:	e9 0e ff ff ff       	jmp    80106e18 <trap+0x118>
80106f0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
80106f10:	e8 bb cd ff ff       	call   80103cd0 <exit>
80106f15:	e9 ad fe ff ff       	jmp    80106dc7 <trap+0xc7>
80106f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80106f20:	83 ec 0c             	sub    $0xc,%esp
80106f23:	68 60 ac 13 80       	push   $0x8013ac60
80106f28:	e8 d3 d9 ff ff       	call   80104900 <acquire>
      wakeup(&ticks);
80106f2d:	c7 04 24 a0 b4 13 80 	movl   $0x8013b4a0,(%esp)
      ticks++;
80106f34:	83 05 a0 b4 13 80 01 	addl   $0x1,0x8013b4a0
      wakeup(&ticks);
80106f3b:	e8 e0 d0 ff ff       	call   80104020 <wakeup>
      release(&tickslock);
80106f40:	c7 04 24 60 ac 13 80 	movl   $0x8013ac60,(%esp)
80106f47:	e8 74 da ff ff       	call   801049c0 <release>
80106f4c:	83 c4 10             	add    $0x10,%esp
80106f4f:	e9 09 ff ff ff       	jmp    80106e5d <trap+0x15d>
80106f54:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106f57:	e8 84 c8 ff ff       	call   801037e0 <cpuid>
80106f5c:	83 ec 0c             	sub    $0xc,%esp
80106f5f:	56                   	push   %esi
80106f60:	53                   	push   %ebx
80106f61:	50                   	push   %eax
80106f62:	ff 77 30             	pushl  0x30(%edi)
80106f65:	68 28 8e 10 80       	push   $0x80108e28
80106f6a:	e8 f1 96 ff ff       	call   80100660 <cprintf>
      panic("trap");
80106f6f:	83 c4 14             	add    $0x14,%esp
80106f72:	68 fd 8d 10 80       	push   $0x80108dfd
80106f77:	e8 14 94 ff ff       	call   80100390 <panic>
80106f7c:	66 90                	xchg   %ax,%ax
80106f7e:	66 90                	xchg   %ax,%ax

80106f80 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106f80:	a1 cc c5 10 80       	mov    0x8010c5cc,%eax
{
80106f85:	55                   	push   %ebp
80106f86:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106f88:	85 c0                	test   %eax,%eax
80106f8a:	74 1c                	je     80106fa8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106f8c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106f91:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106f92:	a8 01                	test   $0x1,%al
80106f94:	74 12                	je     80106fa8 <uartgetc+0x28>
80106f96:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106f9b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106f9c:	0f b6 c0             	movzbl %al,%eax
}
80106f9f:	5d                   	pop    %ebp
80106fa0:	c3                   	ret    
80106fa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106fa8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106fad:	5d                   	pop    %ebp
80106fae:	c3                   	ret    
80106faf:	90                   	nop

80106fb0 <uartputc.part.0>:
uartputc(int c)
80106fb0:	55                   	push   %ebp
80106fb1:	89 e5                	mov    %esp,%ebp
80106fb3:	57                   	push   %edi
80106fb4:	56                   	push   %esi
80106fb5:	53                   	push   %ebx
80106fb6:	89 c7                	mov    %eax,%edi
80106fb8:	bb 80 00 00 00       	mov    $0x80,%ebx
80106fbd:	be fd 03 00 00       	mov    $0x3fd,%esi
80106fc2:	83 ec 0c             	sub    $0xc,%esp
80106fc5:	eb 1b                	jmp    80106fe2 <uartputc.part.0+0x32>
80106fc7:	89 f6                	mov    %esi,%esi
80106fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80106fd0:	83 ec 0c             	sub    $0xc,%esp
80106fd3:	6a 0a                	push   $0xa
80106fd5:	e8 b6 b7 ff ff       	call   80102790 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106fda:	83 c4 10             	add    $0x10,%esp
80106fdd:	83 eb 01             	sub    $0x1,%ebx
80106fe0:	74 07                	je     80106fe9 <uartputc.part.0+0x39>
80106fe2:	89 f2                	mov    %esi,%edx
80106fe4:	ec                   	in     (%dx),%al
80106fe5:	a8 20                	test   $0x20,%al
80106fe7:	74 e7                	je     80106fd0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106fe9:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106fee:	89 f8                	mov    %edi,%eax
80106ff0:	ee                   	out    %al,(%dx)
}
80106ff1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ff4:	5b                   	pop    %ebx
80106ff5:	5e                   	pop    %esi
80106ff6:	5f                   	pop    %edi
80106ff7:	5d                   	pop    %ebp
80106ff8:	c3                   	ret    
80106ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107000 <uartinit>:
{
80107000:	55                   	push   %ebp
80107001:	31 c9                	xor    %ecx,%ecx
80107003:	89 c8                	mov    %ecx,%eax
80107005:	89 e5                	mov    %esp,%ebp
80107007:	57                   	push   %edi
80107008:	56                   	push   %esi
80107009:	53                   	push   %ebx
8010700a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010700f:	89 da                	mov    %ebx,%edx
80107011:	83 ec 0c             	sub    $0xc,%esp
80107014:	ee                   	out    %al,(%dx)
80107015:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010701a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010701f:	89 fa                	mov    %edi,%edx
80107021:	ee                   	out    %al,(%dx)
80107022:	b8 0c 00 00 00       	mov    $0xc,%eax
80107027:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010702c:	ee                   	out    %al,(%dx)
8010702d:	be f9 03 00 00       	mov    $0x3f9,%esi
80107032:	89 c8                	mov    %ecx,%eax
80107034:	89 f2                	mov    %esi,%edx
80107036:	ee                   	out    %al,(%dx)
80107037:	b8 03 00 00 00       	mov    $0x3,%eax
8010703c:	89 fa                	mov    %edi,%edx
8010703e:	ee                   	out    %al,(%dx)
8010703f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80107044:	89 c8                	mov    %ecx,%eax
80107046:	ee                   	out    %al,(%dx)
80107047:	b8 01 00 00 00       	mov    $0x1,%eax
8010704c:	89 f2                	mov    %esi,%edx
8010704e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010704f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80107054:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80107055:	3c ff                	cmp    $0xff,%al
80107057:	74 5a                	je     801070b3 <uartinit+0xb3>
  uart = 1;
80107059:	c7 05 cc c5 10 80 01 	movl   $0x1,0x8010c5cc
80107060:	00 00 00 
80107063:	89 da                	mov    %ebx,%edx
80107065:	ec                   	in     (%dx),%al
80107066:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010706b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
8010706c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
8010706f:	bb 20 8f 10 80       	mov    $0x80108f20,%ebx
  ioapicenable(IRQ_COM1, 0);
80107074:	6a 00                	push   $0x0
80107076:	6a 04                	push   $0x4
80107078:	e8 73 b2 ff ff       	call   801022f0 <ioapicenable>
8010707d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80107080:	b8 78 00 00 00       	mov    $0x78,%eax
80107085:	eb 13                	jmp    8010709a <uartinit+0x9a>
80107087:	89 f6                	mov    %esi,%esi
80107089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107090:	83 c3 01             	add    $0x1,%ebx
80107093:	0f be 03             	movsbl (%ebx),%eax
80107096:	84 c0                	test   %al,%al
80107098:	74 19                	je     801070b3 <uartinit+0xb3>
  if(!uart)
8010709a:	8b 15 cc c5 10 80    	mov    0x8010c5cc,%edx
801070a0:	85 d2                	test   %edx,%edx
801070a2:	74 ec                	je     80107090 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
801070a4:	83 c3 01             	add    $0x1,%ebx
801070a7:	e8 04 ff ff ff       	call   80106fb0 <uartputc.part.0>
801070ac:	0f be 03             	movsbl (%ebx),%eax
801070af:	84 c0                	test   %al,%al
801070b1:	75 e7                	jne    8010709a <uartinit+0x9a>
}
801070b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070b6:	5b                   	pop    %ebx
801070b7:	5e                   	pop    %esi
801070b8:	5f                   	pop    %edi
801070b9:	5d                   	pop    %ebp
801070ba:	c3                   	ret    
801070bb:	90                   	nop
801070bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801070c0 <uartputc>:
  if(!uart)
801070c0:	8b 15 cc c5 10 80    	mov    0x8010c5cc,%edx
{
801070c6:	55                   	push   %ebp
801070c7:	89 e5                	mov    %esp,%ebp
  if(!uart)
801070c9:	85 d2                	test   %edx,%edx
{
801070cb:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
801070ce:	74 10                	je     801070e0 <uartputc+0x20>
}
801070d0:	5d                   	pop    %ebp
801070d1:	e9 da fe ff ff       	jmp    80106fb0 <uartputc.part.0>
801070d6:	8d 76 00             	lea    0x0(%esi),%esi
801070d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801070e0:	5d                   	pop    %ebp
801070e1:	c3                   	ret    
801070e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801070f0 <uartintr>:

void
uartintr(void)
{
801070f0:	55                   	push   %ebp
801070f1:	89 e5                	mov    %esp,%ebp
801070f3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801070f6:	68 80 6f 10 80       	push   $0x80106f80
801070fb:	e8 10 97 ff ff       	call   80100810 <consoleintr>
}
80107100:	83 c4 10             	add    $0x10,%esp
80107103:	c9                   	leave  
80107104:	c3                   	ret    

80107105 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80107105:	6a 00                	push   $0x0
  pushl $0
80107107:	6a 00                	push   $0x0
  jmp alltraps
80107109:	e9 1d fb ff ff       	jmp    80106c2b <alltraps>

8010710e <vector1>:
.globl vector1
vector1:
  pushl $0
8010710e:	6a 00                	push   $0x0
  pushl $1
80107110:	6a 01                	push   $0x1
  jmp alltraps
80107112:	e9 14 fb ff ff       	jmp    80106c2b <alltraps>

80107117 <vector2>:
.globl vector2
vector2:
  pushl $0
80107117:	6a 00                	push   $0x0
  pushl $2
80107119:	6a 02                	push   $0x2
  jmp alltraps
8010711b:	e9 0b fb ff ff       	jmp    80106c2b <alltraps>

80107120 <vector3>:
.globl vector3
vector3:
  pushl $0
80107120:	6a 00                	push   $0x0
  pushl $3
80107122:	6a 03                	push   $0x3
  jmp alltraps
80107124:	e9 02 fb ff ff       	jmp    80106c2b <alltraps>

80107129 <vector4>:
.globl vector4
vector4:
  pushl $0
80107129:	6a 00                	push   $0x0
  pushl $4
8010712b:	6a 04                	push   $0x4
  jmp alltraps
8010712d:	e9 f9 fa ff ff       	jmp    80106c2b <alltraps>

80107132 <vector5>:
.globl vector5
vector5:
  pushl $0
80107132:	6a 00                	push   $0x0
  pushl $5
80107134:	6a 05                	push   $0x5
  jmp alltraps
80107136:	e9 f0 fa ff ff       	jmp    80106c2b <alltraps>

8010713b <vector6>:
.globl vector6
vector6:
  pushl $0
8010713b:	6a 00                	push   $0x0
  pushl $6
8010713d:	6a 06                	push   $0x6
  jmp alltraps
8010713f:	e9 e7 fa ff ff       	jmp    80106c2b <alltraps>

80107144 <vector7>:
.globl vector7
vector7:
  pushl $0
80107144:	6a 00                	push   $0x0
  pushl $7
80107146:	6a 07                	push   $0x7
  jmp alltraps
80107148:	e9 de fa ff ff       	jmp    80106c2b <alltraps>

8010714d <vector8>:
.globl vector8
vector8:
  pushl $8
8010714d:	6a 08                	push   $0x8
  jmp alltraps
8010714f:	e9 d7 fa ff ff       	jmp    80106c2b <alltraps>

80107154 <vector9>:
.globl vector9
vector9:
  pushl $0
80107154:	6a 00                	push   $0x0
  pushl $9
80107156:	6a 09                	push   $0x9
  jmp alltraps
80107158:	e9 ce fa ff ff       	jmp    80106c2b <alltraps>

8010715d <vector10>:
.globl vector10
vector10:
  pushl $10
8010715d:	6a 0a                	push   $0xa
  jmp alltraps
8010715f:	e9 c7 fa ff ff       	jmp    80106c2b <alltraps>

80107164 <vector11>:
.globl vector11
vector11:
  pushl $11
80107164:	6a 0b                	push   $0xb
  jmp alltraps
80107166:	e9 c0 fa ff ff       	jmp    80106c2b <alltraps>

8010716b <vector12>:
.globl vector12
vector12:
  pushl $12
8010716b:	6a 0c                	push   $0xc
  jmp alltraps
8010716d:	e9 b9 fa ff ff       	jmp    80106c2b <alltraps>

80107172 <vector13>:
.globl vector13
vector13:
  pushl $13
80107172:	6a 0d                	push   $0xd
  jmp alltraps
80107174:	e9 b2 fa ff ff       	jmp    80106c2b <alltraps>

80107179 <vector14>:
.globl vector14
vector14:
  pushl $14
80107179:	6a 0e                	push   $0xe
  jmp alltraps
8010717b:	e9 ab fa ff ff       	jmp    80106c2b <alltraps>

80107180 <vector15>:
.globl vector15
vector15:
  pushl $0
80107180:	6a 00                	push   $0x0
  pushl $15
80107182:	6a 0f                	push   $0xf
  jmp alltraps
80107184:	e9 a2 fa ff ff       	jmp    80106c2b <alltraps>

80107189 <vector16>:
.globl vector16
vector16:
  pushl $0
80107189:	6a 00                	push   $0x0
  pushl $16
8010718b:	6a 10                	push   $0x10
  jmp alltraps
8010718d:	e9 99 fa ff ff       	jmp    80106c2b <alltraps>

80107192 <vector17>:
.globl vector17
vector17:
  pushl $17
80107192:	6a 11                	push   $0x11
  jmp alltraps
80107194:	e9 92 fa ff ff       	jmp    80106c2b <alltraps>

80107199 <vector18>:
.globl vector18
vector18:
  pushl $0
80107199:	6a 00                	push   $0x0
  pushl $18
8010719b:	6a 12                	push   $0x12
  jmp alltraps
8010719d:	e9 89 fa ff ff       	jmp    80106c2b <alltraps>

801071a2 <vector19>:
.globl vector19
vector19:
  pushl $0
801071a2:	6a 00                	push   $0x0
  pushl $19
801071a4:	6a 13                	push   $0x13
  jmp alltraps
801071a6:	e9 80 fa ff ff       	jmp    80106c2b <alltraps>

801071ab <vector20>:
.globl vector20
vector20:
  pushl $0
801071ab:	6a 00                	push   $0x0
  pushl $20
801071ad:	6a 14                	push   $0x14
  jmp alltraps
801071af:	e9 77 fa ff ff       	jmp    80106c2b <alltraps>

801071b4 <vector21>:
.globl vector21
vector21:
  pushl $0
801071b4:	6a 00                	push   $0x0
  pushl $21
801071b6:	6a 15                	push   $0x15
  jmp alltraps
801071b8:	e9 6e fa ff ff       	jmp    80106c2b <alltraps>

801071bd <vector22>:
.globl vector22
vector22:
  pushl $0
801071bd:	6a 00                	push   $0x0
  pushl $22
801071bf:	6a 16                	push   $0x16
  jmp alltraps
801071c1:	e9 65 fa ff ff       	jmp    80106c2b <alltraps>

801071c6 <vector23>:
.globl vector23
vector23:
  pushl $0
801071c6:	6a 00                	push   $0x0
  pushl $23
801071c8:	6a 17                	push   $0x17
  jmp alltraps
801071ca:	e9 5c fa ff ff       	jmp    80106c2b <alltraps>

801071cf <vector24>:
.globl vector24
vector24:
  pushl $0
801071cf:	6a 00                	push   $0x0
  pushl $24
801071d1:	6a 18                	push   $0x18
  jmp alltraps
801071d3:	e9 53 fa ff ff       	jmp    80106c2b <alltraps>

801071d8 <vector25>:
.globl vector25
vector25:
  pushl $0
801071d8:	6a 00                	push   $0x0
  pushl $25
801071da:	6a 19                	push   $0x19
  jmp alltraps
801071dc:	e9 4a fa ff ff       	jmp    80106c2b <alltraps>

801071e1 <vector26>:
.globl vector26
vector26:
  pushl $0
801071e1:	6a 00                	push   $0x0
  pushl $26
801071e3:	6a 1a                	push   $0x1a
  jmp alltraps
801071e5:	e9 41 fa ff ff       	jmp    80106c2b <alltraps>

801071ea <vector27>:
.globl vector27
vector27:
  pushl $0
801071ea:	6a 00                	push   $0x0
  pushl $27
801071ec:	6a 1b                	push   $0x1b
  jmp alltraps
801071ee:	e9 38 fa ff ff       	jmp    80106c2b <alltraps>

801071f3 <vector28>:
.globl vector28
vector28:
  pushl $0
801071f3:	6a 00                	push   $0x0
  pushl $28
801071f5:	6a 1c                	push   $0x1c
  jmp alltraps
801071f7:	e9 2f fa ff ff       	jmp    80106c2b <alltraps>

801071fc <vector29>:
.globl vector29
vector29:
  pushl $0
801071fc:	6a 00                	push   $0x0
  pushl $29
801071fe:	6a 1d                	push   $0x1d
  jmp alltraps
80107200:	e9 26 fa ff ff       	jmp    80106c2b <alltraps>

80107205 <vector30>:
.globl vector30
vector30:
  pushl $0
80107205:	6a 00                	push   $0x0
  pushl $30
80107207:	6a 1e                	push   $0x1e
  jmp alltraps
80107209:	e9 1d fa ff ff       	jmp    80106c2b <alltraps>

8010720e <vector31>:
.globl vector31
vector31:
  pushl $0
8010720e:	6a 00                	push   $0x0
  pushl $31
80107210:	6a 1f                	push   $0x1f
  jmp alltraps
80107212:	e9 14 fa ff ff       	jmp    80106c2b <alltraps>

80107217 <vector32>:
.globl vector32
vector32:
  pushl $0
80107217:	6a 00                	push   $0x0
  pushl $32
80107219:	6a 20                	push   $0x20
  jmp alltraps
8010721b:	e9 0b fa ff ff       	jmp    80106c2b <alltraps>

80107220 <vector33>:
.globl vector33
vector33:
  pushl $0
80107220:	6a 00                	push   $0x0
  pushl $33
80107222:	6a 21                	push   $0x21
  jmp alltraps
80107224:	e9 02 fa ff ff       	jmp    80106c2b <alltraps>

80107229 <vector34>:
.globl vector34
vector34:
  pushl $0
80107229:	6a 00                	push   $0x0
  pushl $34
8010722b:	6a 22                	push   $0x22
  jmp alltraps
8010722d:	e9 f9 f9 ff ff       	jmp    80106c2b <alltraps>

80107232 <vector35>:
.globl vector35
vector35:
  pushl $0
80107232:	6a 00                	push   $0x0
  pushl $35
80107234:	6a 23                	push   $0x23
  jmp alltraps
80107236:	e9 f0 f9 ff ff       	jmp    80106c2b <alltraps>

8010723b <vector36>:
.globl vector36
vector36:
  pushl $0
8010723b:	6a 00                	push   $0x0
  pushl $36
8010723d:	6a 24                	push   $0x24
  jmp alltraps
8010723f:	e9 e7 f9 ff ff       	jmp    80106c2b <alltraps>

80107244 <vector37>:
.globl vector37
vector37:
  pushl $0
80107244:	6a 00                	push   $0x0
  pushl $37
80107246:	6a 25                	push   $0x25
  jmp alltraps
80107248:	e9 de f9 ff ff       	jmp    80106c2b <alltraps>

8010724d <vector38>:
.globl vector38
vector38:
  pushl $0
8010724d:	6a 00                	push   $0x0
  pushl $38
8010724f:	6a 26                	push   $0x26
  jmp alltraps
80107251:	e9 d5 f9 ff ff       	jmp    80106c2b <alltraps>

80107256 <vector39>:
.globl vector39
vector39:
  pushl $0
80107256:	6a 00                	push   $0x0
  pushl $39
80107258:	6a 27                	push   $0x27
  jmp alltraps
8010725a:	e9 cc f9 ff ff       	jmp    80106c2b <alltraps>

8010725f <vector40>:
.globl vector40
vector40:
  pushl $0
8010725f:	6a 00                	push   $0x0
  pushl $40
80107261:	6a 28                	push   $0x28
  jmp alltraps
80107263:	e9 c3 f9 ff ff       	jmp    80106c2b <alltraps>

80107268 <vector41>:
.globl vector41
vector41:
  pushl $0
80107268:	6a 00                	push   $0x0
  pushl $41
8010726a:	6a 29                	push   $0x29
  jmp alltraps
8010726c:	e9 ba f9 ff ff       	jmp    80106c2b <alltraps>

80107271 <vector42>:
.globl vector42
vector42:
  pushl $0
80107271:	6a 00                	push   $0x0
  pushl $42
80107273:	6a 2a                	push   $0x2a
  jmp alltraps
80107275:	e9 b1 f9 ff ff       	jmp    80106c2b <alltraps>

8010727a <vector43>:
.globl vector43
vector43:
  pushl $0
8010727a:	6a 00                	push   $0x0
  pushl $43
8010727c:	6a 2b                	push   $0x2b
  jmp alltraps
8010727e:	e9 a8 f9 ff ff       	jmp    80106c2b <alltraps>

80107283 <vector44>:
.globl vector44
vector44:
  pushl $0
80107283:	6a 00                	push   $0x0
  pushl $44
80107285:	6a 2c                	push   $0x2c
  jmp alltraps
80107287:	e9 9f f9 ff ff       	jmp    80106c2b <alltraps>

8010728c <vector45>:
.globl vector45
vector45:
  pushl $0
8010728c:	6a 00                	push   $0x0
  pushl $45
8010728e:	6a 2d                	push   $0x2d
  jmp alltraps
80107290:	e9 96 f9 ff ff       	jmp    80106c2b <alltraps>

80107295 <vector46>:
.globl vector46
vector46:
  pushl $0
80107295:	6a 00                	push   $0x0
  pushl $46
80107297:	6a 2e                	push   $0x2e
  jmp alltraps
80107299:	e9 8d f9 ff ff       	jmp    80106c2b <alltraps>

8010729e <vector47>:
.globl vector47
vector47:
  pushl $0
8010729e:	6a 00                	push   $0x0
  pushl $47
801072a0:	6a 2f                	push   $0x2f
  jmp alltraps
801072a2:	e9 84 f9 ff ff       	jmp    80106c2b <alltraps>

801072a7 <vector48>:
.globl vector48
vector48:
  pushl $0
801072a7:	6a 00                	push   $0x0
  pushl $48
801072a9:	6a 30                	push   $0x30
  jmp alltraps
801072ab:	e9 7b f9 ff ff       	jmp    80106c2b <alltraps>

801072b0 <vector49>:
.globl vector49
vector49:
  pushl $0
801072b0:	6a 00                	push   $0x0
  pushl $49
801072b2:	6a 31                	push   $0x31
  jmp alltraps
801072b4:	e9 72 f9 ff ff       	jmp    80106c2b <alltraps>

801072b9 <vector50>:
.globl vector50
vector50:
  pushl $0
801072b9:	6a 00                	push   $0x0
  pushl $50
801072bb:	6a 32                	push   $0x32
  jmp alltraps
801072bd:	e9 69 f9 ff ff       	jmp    80106c2b <alltraps>

801072c2 <vector51>:
.globl vector51
vector51:
  pushl $0
801072c2:	6a 00                	push   $0x0
  pushl $51
801072c4:	6a 33                	push   $0x33
  jmp alltraps
801072c6:	e9 60 f9 ff ff       	jmp    80106c2b <alltraps>

801072cb <vector52>:
.globl vector52
vector52:
  pushl $0
801072cb:	6a 00                	push   $0x0
  pushl $52
801072cd:	6a 34                	push   $0x34
  jmp alltraps
801072cf:	e9 57 f9 ff ff       	jmp    80106c2b <alltraps>

801072d4 <vector53>:
.globl vector53
vector53:
  pushl $0
801072d4:	6a 00                	push   $0x0
  pushl $53
801072d6:	6a 35                	push   $0x35
  jmp alltraps
801072d8:	e9 4e f9 ff ff       	jmp    80106c2b <alltraps>

801072dd <vector54>:
.globl vector54
vector54:
  pushl $0
801072dd:	6a 00                	push   $0x0
  pushl $54
801072df:	6a 36                	push   $0x36
  jmp alltraps
801072e1:	e9 45 f9 ff ff       	jmp    80106c2b <alltraps>

801072e6 <vector55>:
.globl vector55
vector55:
  pushl $0
801072e6:	6a 00                	push   $0x0
  pushl $55
801072e8:	6a 37                	push   $0x37
  jmp alltraps
801072ea:	e9 3c f9 ff ff       	jmp    80106c2b <alltraps>

801072ef <vector56>:
.globl vector56
vector56:
  pushl $0
801072ef:	6a 00                	push   $0x0
  pushl $56
801072f1:	6a 38                	push   $0x38
  jmp alltraps
801072f3:	e9 33 f9 ff ff       	jmp    80106c2b <alltraps>

801072f8 <vector57>:
.globl vector57
vector57:
  pushl $0
801072f8:	6a 00                	push   $0x0
  pushl $57
801072fa:	6a 39                	push   $0x39
  jmp alltraps
801072fc:	e9 2a f9 ff ff       	jmp    80106c2b <alltraps>

80107301 <vector58>:
.globl vector58
vector58:
  pushl $0
80107301:	6a 00                	push   $0x0
  pushl $58
80107303:	6a 3a                	push   $0x3a
  jmp alltraps
80107305:	e9 21 f9 ff ff       	jmp    80106c2b <alltraps>

8010730a <vector59>:
.globl vector59
vector59:
  pushl $0
8010730a:	6a 00                	push   $0x0
  pushl $59
8010730c:	6a 3b                	push   $0x3b
  jmp alltraps
8010730e:	e9 18 f9 ff ff       	jmp    80106c2b <alltraps>

80107313 <vector60>:
.globl vector60
vector60:
  pushl $0
80107313:	6a 00                	push   $0x0
  pushl $60
80107315:	6a 3c                	push   $0x3c
  jmp alltraps
80107317:	e9 0f f9 ff ff       	jmp    80106c2b <alltraps>

8010731c <vector61>:
.globl vector61
vector61:
  pushl $0
8010731c:	6a 00                	push   $0x0
  pushl $61
8010731e:	6a 3d                	push   $0x3d
  jmp alltraps
80107320:	e9 06 f9 ff ff       	jmp    80106c2b <alltraps>

80107325 <vector62>:
.globl vector62
vector62:
  pushl $0
80107325:	6a 00                	push   $0x0
  pushl $62
80107327:	6a 3e                	push   $0x3e
  jmp alltraps
80107329:	e9 fd f8 ff ff       	jmp    80106c2b <alltraps>

8010732e <vector63>:
.globl vector63
vector63:
  pushl $0
8010732e:	6a 00                	push   $0x0
  pushl $63
80107330:	6a 3f                	push   $0x3f
  jmp alltraps
80107332:	e9 f4 f8 ff ff       	jmp    80106c2b <alltraps>

80107337 <vector64>:
.globl vector64
vector64:
  pushl $0
80107337:	6a 00                	push   $0x0
  pushl $64
80107339:	6a 40                	push   $0x40
  jmp alltraps
8010733b:	e9 eb f8 ff ff       	jmp    80106c2b <alltraps>

80107340 <vector65>:
.globl vector65
vector65:
  pushl $0
80107340:	6a 00                	push   $0x0
  pushl $65
80107342:	6a 41                	push   $0x41
  jmp alltraps
80107344:	e9 e2 f8 ff ff       	jmp    80106c2b <alltraps>

80107349 <vector66>:
.globl vector66
vector66:
  pushl $0
80107349:	6a 00                	push   $0x0
  pushl $66
8010734b:	6a 42                	push   $0x42
  jmp alltraps
8010734d:	e9 d9 f8 ff ff       	jmp    80106c2b <alltraps>

80107352 <vector67>:
.globl vector67
vector67:
  pushl $0
80107352:	6a 00                	push   $0x0
  pushl $67
80107354:	6a 43                	push   $0x43
  jmp alltraps
80107356:	e9 d0 f8 ff ff       	jmp    80106c2b <alltraps>

8010735b <vector68>:
.globl vector68
vector68:
  pushl $0
8010735b:	6a 00                	push   $0x0
  pushl $68
8010735d:	6a 44                	push   $0x44
  jmp alltraps
8010735f:	e9 c7 f8 ff ff       	jmp    80106c2b <alltraps>

80107364 <vector69>:
.globl vector69
vector69:
  pushl $0
80107364:	6a 00                	push   $0x0
  pushl $69
80107366:	6a 45                	push   $0x45
  jmp alltraps
80107368:	e9 be f8 ff ff       	jmp    80106c2b <alltraps>

8010736d <vector70>:
.globl vector70
vector70:
  pushl $0
8010736d:	6a 00                	push   $0x0
  pushl $70
8010736f:	6a 46                	push   $0x46
  jmp alltraps
80107371:	e9 b5 f8 ff ff       	jmp    80106c2b <alltraps>

80107376 <vector71>:
.globl vector71
vector71:
  pushl $0
80107376:	6a 00                	push   $0x0
  pushl $71
80107378:	6a 47                	push   $0x47
  jmp alltraps
8010737a:	e9 ac f8 ff ff       	jmp    80106c2b <alltraps>

8010737f <vector72>:
.globl vector72
vector72:
  pushl $0
8010737f:	6a 00                	push   $0x0
  pushl $72
80107381:	6a 48                	push   $0x48
  jmp alltraps
80107383:	e9 a3 f8 ff ff       	jmp    80106c2b <alltraps>

80107388 <vector73>:
.globl vector73
vector73:
  pushl $0
80107388:	6a 00                	push   $0x0
  pushl $73
8010738a:	6a 49                	push   $0x49
  jmp alltraps
8010738c:	e9 9a f8 ff ff       	jmp    80106c2b <alltraps>

80107391 <vector74>:
.globl vector74
vector74:
  pushl $0
80107391:	6a 00                	push   $0x0
  pushl $74
80107393:	6a 4a                	push   $0x4a
  jmp alltraps
80107395:	e9 91 f8 ff ff       	jmp    80106c2b <alltraps>

8010739a <vector75>:
.globl vector75
vector75:
  pushl $0
8010739a:	6a 00                	push   $0x0
  pushl $75
8010739c:	6a 4b                	push   $0x4b
  jmp alltraps
8010739e:	e9 88 f8 ff ff       	jmp    80106c2b <alltraps>

801073a3 <vector76>:
.globl vector76
vector76:
  pushl $0
801073a3:	6a 00                	push   $0x0
  pushl $76
801073a5:	6a 4c                	push   $0x4c
  jmp alltraps
801073a7:	e9 7f f8 ff ff       	jmp    80106c2b <alltraps>

801073ac <vector77>:
.globl vector77
vector77:
  pushl $0
801073ac:	6a 00                	push   $0x0
  pushl $77
801073ae:	6a 4d                	push   $0x4d
  jmp alltraps
801073b0:	e9 76 f8 ff ff       	jmp    80106c2b <alltraps>

801073b5 <vector78>:
.globl vector78
vector78:
  pushl $0
801073b5:	6a 00                	push   $0x0
  pushl $78
801073b7:	6a 4e                	push   $0x4e
  jmp alltraps
801073b9:	e9 6d f8 ff ff       	jmp    80106c2b <alltraps>

801073be <vector79>:
.globl vector79
vector79:
  pushl $0
801073be:	6a 00                	push   $0x0
  pushl $79
801073c0:	6a 4f                	push   $0x4f
  jmp alltraps
801073c2:	e9 64 f8 ff ff       	jmp    80106c2b <alltraps>

801073c7 <vector80>:
.globl vector80
vector80:
  pushl $0
801073c7:	6a 00                	push   $0x0
  pushl $80
801073c9:	6a 50                	push   $0x50
  jmp alltraps
801073cb:	e9 5b f8 ff ff       	jmp    80106c2b <alltraps>

801073d0 <vector81>:
.globl vector81
vector81:
  pushl $0
801073d0:	6a 00                	push   $0x0
  pushl $81
801073d2:	6a 51                	push   $0x51
  jmp alltraps
801073d4:	e9 52 f8 ff ff       	jmp    80106c2b <alltraps>

801073d9 <vector82>:
.globl vector82
vector82:
  pushl $0
801073d9:	6a 00                	push   $0x0
  pushl $82
801073db:	6a 52                	push   $0x52
  jmp alltraps
801073dd:	e9 49 f8 ff ff       	jmp    80106c2b <alltraps>

801073e2 <vector83>:
.globl vector83
vector83:
  pushl $0
801073e2:	6a 00                	push   $0x0
  pushl $83
801073e4:	6a 53                	push   $0x53
  jmp alltraps
801073e6:	e9 40 f8 ff ff       	jmp    80106c2b <alltraps>

801073eb <vector84>:
.globl vector84
vector84:
  pushl $0
801073eb:	6a 00                	push   $0x0
  pushl $84
801073ed:	6a 54                	push   $0x54
  jmp alltraps
801073ef:	e9 37 f8 ff ff       	jmp    80106c2b <alltraps>

801073f4 <vector85>:
.globl vector85
vector85:
  pushl $0
801073f4:	6a 00                	push   $0x0
  pushl $85
801073f6:	6a 55                	push   $0x55
  jmp alltraps
801073f8:	e9 2e f8 ff ff       	jmp    80106c2b <alltraps>

801073fd <vector86>:
.globl vector86
vector86:
  pushl $0
801073fd:	6a 00                	push   $0x0
  pushl $86
801073ff:	6a 56                	push   $0x56
  jmp alltraps
80107401:	e9 25 f8 ff ff       	jmp    80106c2b <alltraps>

80107406 <vector87>:
.globl vector87
vector87:
  pushl $0
80107406:	6a 00                	push   $0x0
  pushl $87
80107408:	6a 57                	push   $0x57
  jmp alltraps
8010740a:	e9 1c f8 ff ff       	jmp    80106c2b <alltraps>

8010740f <vector88>:
.globl vector88
vector88:
  pushl $0
8010740f:	6a 00                	push   $0x0
  pushl $88
80107411:	6a 58                	push   $0x58
  jmp alltraps
80107413:	e9 13 f8 ff ff       	jmp    80106c2b <alltraps>

80107418 <vector89>:
.globl vector89
vector89:
  pushl $0
80107418:	6a 00                	push   $0x0
  pushl $89
8010741a:	6a 59                	push   $0x59
  jmp alltraps
8010741c:	e9 0a f8 ff ff       	jmp    80106c2b <alltraps>

80107421 <vector90>:
.globl vector90
vector90:
  pushl $0
80107421:	6a 00                	push   $0x0
  pushl $90
80107423:	6a 5a                	push   $0x5a
  jmp alltraps
80107425:	e9 01 f8 ff ff       	jmp    80106c2b <alltraps>

8010742a <vector91>:
.globl vector91
vector91:
  pushl $0
8010742a:	6a 00                	push   $0x0
  pushl $91
8010742c:	6a 5b                	push   $0x5b
  jmp alltraps
8010742e:	e9 f8 f7 ff ff       	jmp    80106c2b <alltraps>

80107433 <vector92>:
.globl vector92
vector92:
  pushl $0
80107433:	6a 00                	push   $0x0
  pushl $92
80107435:	6a 5c                	push   $0x5c
  jmp alltraps
80107437:	e9 ef f7 ff ff       	jmp    80106c2b <alltraps>

8010743c <vector93>:
.globl vector93
vector93:
  pushl $0
8010743c:	6a 00                	push   $0x0
  pushl $93
8010743e:	6a 5d                	push   $0x5d
  jmp alltraps
80107440:	e9 e6 f7 ff ff       	jmp    80106c2b <alltraps>

80107445 <vector94>:
.globl vector94
vector94:
  pushl $0
80107445:	6a 00                	push   $0x0
  pushl $94
80107447:	6a 5e                	push   $0x5e
  jmp alltraps
80107449:	e9 dd f7 ff ff       	jmp    80106c2b <alltraps>

8010744e <vector95>:
.globl vector95
vector95:
  pushl $0
8010744e:	6a 00                	push   $0x0
  pushl $95
80107450:	6a 5f                	push   $0x5f
  jmp alltraps
80107452:	e9 d4 f7 ff ff       	jmp    80106c2b <alltraps>

80107457 <vector96>:
.globl vector96
vector96:
  pushl $0
80107457:	6a 00                	push   $0x0
  pushl $96
80107459:	6a 60                	push   $0x60
  jmp alltraps
8010745b:	e9 cb f7 ff ff       	jmp    80106c2b <alltraps>

80107460 <vector97>:
.globl vector97
vector97:
  pushl $0
80107460:	6a 00                	push   $0x0
  pushl $97
80107462:	6a 61                	push   $0x61
  jmp alltraps
80107464:	e9 c2 f7 ff ff       	jmp    80106c2b <alltraps>

80107469 <vector98>:
.globl vector98
vector98:
  pushl $0
80107469:	6a 00                	push   $0x0
  pushl $98
8010746b:	6a 62                	push   $0x62
  jmp alltraps
8010746d:	e9 b9 f7 ff ff       	jmp    80106c2b <alltraps>

80107472 <vector99>:
.globl vector99
vector99:
  pushl $0
80107472:	6a 00                	push   $0x0
  pushl $99
80107474:	6a 63                	push   $0x63
  jmp alltraps
80107476:	e9 b0 f7 ff ff       	jmp    80106c2b <alltraps>

8010747b <vector100>:
.globl vector100
vector100:
  pushl $0
8010747b:	6a 00                	push   $0x0
  pushl $100
8010747d:	6a 64                	push   $0x64
  jmp alltraps
8010747f:	e9 a7 f7 ff ff       	jmp    80106c2b <alltraps>

80107484 <vector101>:
.globl vector101
vector101:
  pushl $0
80107484:	6a 00                	push   $0x0
  pushl $101
80107486:	6a 65                	push   $0x65
  jmp alltraps
80107488:	e9 9e f7 ff ff       	jmp    80106c2b <alltraps>

8010748d <vector102>:
.globl vector102
vector102:
  pushl $0
8010748d:	6a 00                	push   $0x0
  pushl $102
8010748f:	6a 66                	push   $0x66
  jmp alltraps
80107491:	e9 95 f7 ff ff       	jmp    80106c2b <alltraps>

80107496 <vector103>:
.globl vector103
vector103:
  pushl $0
80107496:	6a 00                	push   $0x0
  pushl $103
80107498:	6a 67                	push   $0x67
  jmp alltraps
8010749a:	e9 8c f7 ff ff       	jmp    80106c2b <alltraps>

8010749f <vector104>:
.globl vector104
vector104:
  pushl $0
8010749f:	6a 00                	push   $0x0
  pushl $104
801074a1:	6a 68                	push   $0x68
  jmp alltraps
801074a3:	e9 83 f7 ff ff       	jmp    80106c2b <alltraps>

801074a8 <vector105>:
.globl vector105
vector105:
  pushl $0
801074a8:	6a 00                	push   $0x0
  pushl $105
801074aa:	6a 69                	push   $0x69
  jmp alltraps
801074ac:	e9 7a f7 ff ff       	jmp    80106c2b <alltraps>

801074b1 <vector106>:
.globl vector106
vector106:
  pushl $0
801074b1:	6a 00                	push   $0x0
  pushl $106
801074b3:	6a 6a                	push   $0x6a
  jmp alltraps
801074b5:	e9 71 f7 ff ff       	jmp    80106c2b <alltraps>

801074ba <vector107>:
.globl vector107
vector107:
  pushl $0
801074ba:	6a 00                	push   $0x0
  pushl $107
801074bc:	6a 6b                	push   $0x6b
  jmp alltraps
801074be:	e9 68 f7 ff ff       	jmp    80106c2b <alltraps>

801074c3 <vector108>:
.globl vector108
vector108:
  pushl $0
801074c3:	6a 00                	push   $0x0
  pushl $108
801074c5:	6a 6c                	push   $0x6c
  jmp alltraps
801074c7:	e9 5f f7 ff ff       	jmp    80106c2b <alltraps>

801074cc <vector109>:
.globl vector109
vector109:
  pushl $0
801074cc:	6a 00                	push   $0x0
  pushl $109
801074ce:	6a 6d                	push   $0x6d
  jmp alltraps
801074d0:	e9 56 f7 ff ff       	jmp    80106c2b <alltraps>

801074d5 <vector110>:
.globl vector110
vector110:
  pushl $0
801074d5:	6a 00                	push   $0x0
  pushl $110
801074d7:	6a 6e                	push   $0x6e
  jmp alltraps
801074d9:	e9 4d f7 ff ff       	jmp    80106c2b <alltraps>

801074de <vector111>:
.globl vector111
vector111:
  pushl $0
801074de:	6a 00                	push   $0x0
  pushl $111
801074e0:	6a 6f                	push   $0x6f
  jmp alltraps
801074e2:	e9 44 f7 ff ff       	jmp    80106c2b <alltraps>

801074e7 <vector112>:
.globl vector112
vector112:
  pushl $0
801074e7:	6a 00                	push   $0x0
  pushl $112
801074e9:	6a 70                	push   $0x70
  jmp alltraps
801074eb:	e9 3b f7 ff ff       	jmp    80106c2b <alltraps>

801074f0 <vector113>:
.globl vector113
vector113:
  pushl $0
801074f0:	6a 00                	push   $0x0
  pushl $113
801074f2:	6a 71                	push   $0x71
  jmp alltraps
801074f4:	e9 32 f7 ff ff       	jmp    80106c2b <alltraps>

801074f9 <vector114>:
.globl vector114
vector114:
  pushl $0
801074f9:	6a 00                	push   $0x0
  pushl $114
801074fb:	6a 72                	push   $0x72
  jmp alltraps
801074fd:	e9 29 f7 ff ff       	jmp    80106c2b <alltraps>

80107502 <vector115>:
.globl vector115
vector115:
  pushl $0
80107502:	6a 00                	push   $0x0
  pushl $115
80107504:	6a 73                	push   $0x73
  jmp alltraps
80107506:	e9 20 f7 ff ff       	jmp    80106c2b <alltraps>

8010750b <vector116>:
.globl vector116
vector116:
  pushl $0
8010750b:	6a 00                	push   $0x0
  pushl $116
8010750d:	6a 74                	push   $0x74
  jmp alltraps
8010750f:	e9 17 f7 ff ff       	jmp    80106c2b <alltraps>

80107514 <vector117>:
.globl vector117
vector117:
  pushl $0
80107514:	6a 00                	push   $0x0
  pushl $117
80107516:	6a 75                	push   $0x75
  jmp alltraps
80107518:	e9 0e f7 ff ff       	jmp    80106c2b <alltraps>

8010751d <vector118>:
.globl vector118
vector118:
  pushl $0
8010751d:	6a 00                	push   $0x0
  pushl $118
8010751f:	6a 76                	push   $0x76
  jmp alltraps
80107521:	e9 05 f7 ff ff       	jmp    80106c2b <alltraps>

80107526 <vector119>:
.globl vector119
vector119:
  pushl $0
80107526:	6a 00                	push   $0x0
  pushl $119
80107528:	6a 77                	push   $0x77
  jmp alltraps
8010752a:	e9 fc f6 ff ff       	jmp    80106c2b <alltraps>

8010752f <vector120>:
.globl vector120
vector120:
  pushl $0
8010752f:	6a 00                	push   $0x0
  pushl $120
80107531:	6a 78                	push   $0x78
  jmp alltraps
80107533:	e9 f3 f6 ff ff       	jmp    80106c2b <alltraps>

80107538 <vector121>:
.globl vector121
vector121:
  pushl $0
80107538:	6a 00                	push   $0x0
  pushl $121
8010753a:	6a 79                	push   $0x79
  jmp alltraps
8010753c:	e9 ea f6 ff ff       	jmp    80106c2b <alltraps>

80107541 <vector122>:
.globl vector122
vector122:
  pushl $0
80107541:	6a 00                	push   $0x0
  pushl $122
80107543:	6a 7a                	push   $0x7a
  jmp alltraps
80107545:	e9 e1 f6 ff ff       	jmp    80106c2b <alltraps>

8010754a <vector123>:
.globl vector123
vector123:
  pushl $0
8010754a:	6a 00                	push   $0x0
  pushl $123
8010754c:	6a 7b                	push   $0x7b
  jmp alltraps
8010754e:	e9 d8 f6 ff ff       	jmp    80106c2b <alltraps>

80107553 <vector124>:
.globl vector124
vector124:
  pushl $0
80107553:	6a 00                	push   $0x0
  pushl $124
80107555:	6a 7c                	push   $0x7c
  jmp alltraps
80107557:	e9 cf f6 ff ff       	jmp    80106c2b <alltraps>

8010755c <vector125>:
.globl vector125
vector125:
  pushl $0
8010755c:	6a 00                	push   $0x0
  pushl $125
8010755e:	6a 7d                	push   $0x7d
  jmp alltraps
80107560:	e9 c6 f6 ff ff       	jmp    80106c2b <alltraps>

80107565 <vector126>:
.globl vector126
vector126:
  pushl $0
80107565:	6a 00                	push   $0x0
  pushl $126
80107567:	6a 7e                	push   $0x7e
  jmp alltraps
80107569:	e9 bd f6 ff ff       	jmp    80106c2b <alltraps>

8010756e <vector127>:
.globl vector127
vector127:
  pushl $0
8010756e:	6a 00                	push   $0x0
  pushl $127
80107570:	6a 7f                	push   $0x7f
  jmp alltraps
80107572:	e9 b4 f6 ff ff       	jmp    80106c2b <alltraps>

80107577 <vector128>:
.globl vector128
vector128:
  pushl $0
80107577:	6a 00                	push   $0x0
  pushl $128
80107579:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010757e:	e9 a8 f6 ff ff       	jmp    80106c2b <alltraps>

80107583 <vector129>:
.globl vector129
vector129:
  pushl $0
80107583:	6a 00                	push   $0x0
  pushl $129
80107585:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010758a:	e9 9c f6 ff ff       	jmp    80106c2b <alltraps>

8010758f <vector130>:
.globl vector130
vector130:
  pushl $0
8010758f:	6a 00                	push   $0x0
  pushl $130
80107591:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80107596:	e9 90 f6 ff ff       	jmp    80106c2b <alltraps>

8010759b <vector131>:
.globl vector131
vector131:
  pushl $0
8010759b:	6a 00                	push   $0x0
  pushl $131
8010759d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801075a2:	e9 84 f6 ff ff       	jmp    80106c2b <alltraps>

801075a7 <vector132>:
.globl vector132
vector132:
  pushl $0
801075a7:	6a 00                	push   $0x0
  pushl $132
801075a9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801075ae:	e9 78 f6 ff ff       	jmp    80106c2b <alltraps>

801075b3 <vector133>:
.globl vector133
vector133:
  pushl $0
801075b3:	6a 00                	push   $0x0
  pushl $133
801075b5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801075ba:	e9 6c f6 ff ff       	jmp    80106c2b <alltraps>

801075bf <vector134>:
.globl vector134
vector134:
  pushl $0
801075bf:	6a 00                	push   $0x0
  pushl $134
801075c1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801075c6:	e9 60 f6 ff ff       	jmp    80106c2b <alltraps>

801075cb <vector135>:
.globl vector135
vector135:
  pushl $0
801075cb:	6a 00                	push   $0x0
  pushl $135
801075cd:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801075d2:	e9 54 f6 ff ff       	jmp    80106c2b <alltraps>

801075d7 <vector136>:
.globl vector136
vector136:
  pushl $0
801075d7:	6a 00                	push   $0x0
  pushl $136
801075d9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801075de:	e9 48 f6 ff ff       	jmp    80106c2b <alltraps>

801075e3 <vector137>:
.globl vector137
vector137:
  pushl $0
801075e3:	6a 00                	push   $0x0
  pushl $137
801075e5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801075ea:	e9 3c f6 ff ff       	jmp    80106c2b <alltraps>

801075ef <vector138>:
.globl vector138
vector138:
  pushl $0
801075ef:	6a 00                	push   $0x0
  pushl $138
801075f1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801075f6:	e9 30 f6 ff ff       	jmp    80106c2b <alltraps>

801075fb <vector139>:
.globl vector139
vector139:
  pushl $0
801075fb:	6a 00                	push   $0x0
  pushl $139
801075fd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80107602:	e9 24 f6 ff ff       	jmp    80106c2b <alltraps>

80107607 <vector140>:
.globl vector140
vector140:
  pushl $0
80107607:	6a 00                	push   $0x0
  pushl $140
80107609:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010760e:	e9 18 f6 ff ff       	jmp    80106c2b <alltraps>

80107613 <vector141>:
.globl vector141
vector141:
  pushl $0
80107613:	6a 00                	push   $0x0
  pushl $141
80107615:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010761a:	e9 0c f6 ff ff       	jmp    80106c2b <alltraps>

8010761f <vector142>:
.globl vector142
vector142:
  pushl $0
8010761f:	6a 00                	push   $0x0
  pushl $142
80107621:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80107626:	e9 00 f6 ff ff       	jmp    80106c2b <alltraps>

8010762b <vector143>:
.globl vector143
vector143:
  pushl $0
8010762b:	6a 00                	push   $0x0
  pushl $143
8010762d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80107632:	e9 f4 f5 ff ff       	jmp    80106c2b <alltraps>

80107637 <vector144>:
.globl vector144
vector144:
  pushl $0
80107637:	6a 00                	push   $0x0
  pushl $144
80107639:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010763e:	e9 e8 f5 ff ff       	jmp    80106c2b <alltraps>

80107643 <vector145>:
.globl vector145
vector145:
  pushl $0
80107643:	6a 00                	push   $0x0
  pushl $145
80107645:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010764a:	e9 dc f5 ff ff       	jmp    80106c2b <alltraps>

8010764f <vector146>:
.globl vector146
vector146:
  pushl $0
8010764f:	6a 00                	push   $0x0
  pushl $146
80107651:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107656:	e9 d0 f5 ff ff       	jmp    80106c2b <alltraps>

8010765b <vector147>:
.globl vector147
vector147:
  pushl $0
8010765b:	6a 00                	push   $0x0
  pushl $147
8010765d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107662:	e9 c4 f5 ff ff       	jmp    80106c2b <alltraps>

80107667 <vector148>:
.globl vector148
vector148:
  pushl $0
80107667:	6a 00                	push   $0x0
  pushl $148
80107669:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010766e:	e9 b8 f5 ff ff       	jmp    80106c2b <alltraps>

80107673 <vector149>:
.globl vector149
vector149:
  pushl $0
80107673:	6a 00                	push   $0x0
  pushl $149
80107675:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010767a:	e9 ac f5 ff ff       	jmp    80106c2b <alltraps>

8010767f <vector150>:
.globl vector150
vector150:
  pushl $0
8010767f:	6a 00                	push   $0x0
  pushl $150
80107681:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107686:	e9 a0 f5 ff ff       	jmp    80106c2b <alltraps>

8010768b <vector151>:
.globl vector151
vector151:
  pushl $0
8010768b:	6a 00                	push   $0x0
  pushl $151
8010768d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80107692:	e9 94 f5 ff ff       	jmp    80106c2b <alltraps>

80107697 <vector152>:
.globl vector152
vector152:
  pushl $0
80107697:	6a 00                	push   $0x0
  pushl $152
80107699:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010769e:	e9 88 f5 ff ff       	jmp    80106c2b <alltraps>

801076a3 <vector153>:
.globl vector153
vector153:
  pushl $0
801076a3:	6a 00                	push   $0x0
  pushl $153
801076a5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801076aa:	e9 7c f5 ff ff       	jmp    80106c2b <alltraps>

801076af <vector154>:
.globl vector154
vector154:
  pushl $0
801076af:	6a 00                	push   $0x0
  pushl $154
801076b1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801076b6:	e9 70 f5 ff ff       	jmp    80106c2b <alltraps>

801076bb <vector155>:
.globl vector155
vector155:
  pushl $0
801076bb:	6a 00                	push   $0x0
  pushl $155
801076bd:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801076c2:	e9 64 f5 ff ff       	jmp    80106c2b <alltraps>

801076c7 <vector156>:
.globl vector156
vector156:
  pushl $0
801076c7:	6a 00                	push   $0x0
  pushl $156
801076c9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801076ce:	e9 58 f5 ff ff       	jmp    80106c2b <alltraps>

801076d3 <vector157>:
.globl vector157
vector157:
  pushl $0
801076d3:	6a 00                	push   $0x0
  pushl $157
801076d5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801076da:	e9 4c f5 ff ff       	jmp    80106c2b <alltraps>

801076df <vector158>:
.globl vector158
vector158:
  pushl $0
801076df:	6a 00                	push   $0x0
  pushl $158
801076e1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801076e6:	e9 40 f5 ff ff       	jmp    80106c2b <alltraps>

801076eb <vector159>:
.globl vector159
vector159:
  pushl $0
801076eb:	6a 00                	push   $0x0
  pushl $159
801076ed:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801076f2:	e9 34 f5 ff ff       	jmp    80106c2b <alltraps>

801076f7 <vector160>:
.globl vector160
vector160:
  pushl $0
801076f7:	6a 00                	push   $0x0
  pushl $160
801076f9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801076fe:	e9 28 f5 ff ff       	jmp    80106c2b <alltraps>

80107703 <vector161>:
.globl vector161
vector161:
  pushl $0
80107703:	6a 00                	push   $0x0
  pushl $161
80107705:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010770a:	e9 1c f5 ff ff       	jmp    80106c2b <alltraps>

8010770f <vector162>:
.globl vector162
vector162:
  pushl $0
8010770f:	6a 00                	push   $0x0
  pushl $162
80107711:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80107716:	e9 10 f5 ff ff       	jmp    80106c2b <alltraps>

8010771b <vector163>:
.globl vector163
vector163:
  pushl $0
8010771b:	6a 00                	push   $0x0
  pushl $163
8010771d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80107722:	e9 04 f5 ff ff       	jmp    80106c2b <alltraps>

80107727 <vector164>:
.globl vector164
vector164:
  pushl $0
80107727:	6a 00                	push   $0x0
  pushl $164
80107729:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010772e:	e9 f8 f4 ff ff       	jmp    80106c2b <alltraps>

80107733 <vector165>:
.globl vector165
vector165:
  pushl $0
80107733:	6a 00                	push   $0x0
  pushl $165
80107735:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010773a:	e9 ec f4 ff ff       	jmp    80106c2b <alltraps>

8010773f <vector166>:
.globl vector166
vector166:
  pushl $0
8010773f:	6a 00                	push   $0x0
  pushl $166
80107741:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107746:	e9 e0 f4 ff ff       	jmp    80106c2b <alltraps>

8010774b <vector167>:
.globl vector167
vector167:
  pushl $0
8010774b:	6a 00                	push   $0x0
  pushl $167
8010774d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107752:	e9 d4 f4 ff ff       	jmp    80106c2b <alltraps>

80107757 <vector168>:
.globl vector168
vector168:
  pushl $0
80107757:	6a 00                	push   $0x0
  pushl $168
80107759:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010775e:	e9 c8 f4 ff ff       	jmp    80106c2b <alltraps>

80107763 <vector169>:
.globl vector169
vector169:
  pushl $0
80107763:	6a 00                	push   $0x0
  pushl $169
80107765:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010776a:	e9 bc f4 ff ff       	jmp    80106c2b <alltraps>

8010776f <vector170>:
.globl vector170
vector170:
  pushl $0
8010776f:	6a 00                	push   $0x0
  pushl $170
80107771:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107776:	e9 b0 f4 ff ff       	jmp    80106c2b <alltraps>

8010777b <vector171>:
.globl vector171
vector171:
  pushl $0
8010777b:	6a 00                	push   $0x0
  pushl $171
8010777d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107782:	e9 a4 f4 ff ff       	jmp    80106c2b <alltraps>

80107787 <vector172>:
.globl vector172
vector172:
  pushl $0
80107787:	6a 00                	push   $0x0
  pushl $172
80107789:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010778e:	e9 98 f4 ff ff       	jmp    80106c2b <alltraps>

80107793 <vector173>:
.globl vector173
vector173:
  pushl $0
80107793:	6a 00                	push   $0x0
  pushl $173
80107795:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010779a:	e9 8c f4 ff ff       	jmp    80106c2b <alltraps>

8010779f <vector174>:
.globl vector174
vector174:
  pushl $0
8010779f:	6a 00                	push   $0x0
  pushl $174
801077a1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801077a6:	e9 80 f4 ff ff       	jmp    80106c2b <alltraps>

801077ab <vector175>:
.globl vector175
vector175:
  pushl $0
801077ab:	6a 00                	push   $0x0
  pushl $175
801077ad:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801077b2:	e9 74 f4 ff ff       	jmp    80106c2b <alltraps>

801077b7 <vector176>:
.globl vector176
vector176:
  pushl $0
801077b7:	6a 00                	push   $0x0
  pushl $176
801077b9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801077be:	e9 68 f4 ff ff       	jmp    80106c2b <alltraps>

801077c3 <vector177>:
.globl vector177
vector177:
  pushl $0
801077c3:	6a 00                	push   $0x0
  pushl $177
801077c5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801077ca:	e9 5c f4 ff ff       	jmp    80106c2b <alltraps>

801077cf <vector178>:
.globl vector178
vector178:
  pushl $0
801077cf:	6a 00                	push   $0x0
  pushl $178
801077d1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801077d6:	e9 50 f4 ff ff       	jmp    80106c2b <alltraps>

801077db <vector179>:
.globl vector179
vector179:
  pushl $0
801077db:	6a 00                	push   $0x0
  pushl $179
801077dd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801077e2:	e9 44 f4 ff ff       	jmp    80106c2b <alltraps>

801077e7 <vector180>:
.globl vector180
vector180:
  pushl $0
801077e7:	6a 00                	push   $0x0
  pushl $180
801077e9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801077ee:	e9 38 f4 ff ff       	jmp    80106c2b <alltraps>

801077f3 <vector181>:
.globl vector181
vector181:
  pushl $0
801077f3:	6a 00                	push   $0x0
  pushl $181
801077f5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801077fa:	e9 2c f4 ff ff       	jmp    80106c2b <alltraps>

801077ff <vector182>:
.globl vector182
vector182:
  pushl $0
801077ff:	6a 00                	push   $0x0
  pushl $182
80107801:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107806:	e9 20 f4 ff ff       	jmp    80106c2b <alltraps>

8010780b <vector183>:
.globl vector183
vector183:
  pushl $0
8010780b:	6a 00                	push   $0x0
  pushl $183
8010780d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107812:	e9 14 f4 ff ff       	jmp    80106c2b <alltraps>

80107817 <vector184>:
.globl vector184
vector184:
  pushl $0
80107817:	6a 00                	push   $0x0
  pushl $184
80107819:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010781e:	e9 08 f4 ff ff       	jmp    80106c2b <alltraps>

80107823 <vector185>:
.globl vector185
vector185:
  pushl $0
80107823:	6a 00                	push   $0x0
  pushl $185
80107825:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010782a:	e9 fc f3 ff ff       	jmp    80106c2b <alltraps>

8010782f <vector186>:
.globl vector186
vector186:
  pushl $0
8010782f:	6a 00                	push   $0x0
  pushl $186
80107831:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107836:	e9 f0 f3 ff ff       	jmp    80106c2b <alltraps>

8010783b <vector187>:
.globl vector187
vector187:
  pushl $0
8010783b:	6a 00                	push   $0x0
  pushl $187
8010783d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107842:	e9 e4 f3 ff ff       	jmp    80106c2b <alltraps>

80107847 <vector188>:
.globl vector188
vector188:
  pushl $0
80107847:	6a 00                	push   $0x0
  pushl $188
80107849:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010784e:	e9 d8 f3 ff ff       	jmp    80106c2b <alltraps>

80107853 <vector189>:
.globl vector189
vector189:
  pushl $0
80107853:	6a 00                	push   $0x0
  pushl $189
80107855:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010785a:	e9 cc f3 ff ff       	jmp    80106c2b <alltraps>

8010785f <vector190>:
.globl vector190
vector190:
  pushl $0
8010785f:	6a 00                	push   $0x0
  pushl $190
80107861:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107866:	e9 c0 f3 ff ff       	jmp    80106c2b <alltraps>

8010786b <vector191>:
.globl vector191
vector191:
  pushl $0
8010786b:	6a 00                	push   $0x0
  pushl $191
8010786d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107872:	e9 b4 f3 ff ff       	jmp    80106c2b <alltraps>

80107877 <vector192>:
.globl vector192
vector192:
  pushl $0
80107877:	6a 00                	push   $0x0
  pushl $192
80107879:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010787e:	e9 a8 f3 ff ff       	jmp    80106c2b <alltraps>

80107883 <vector193>:
.globl vector193
vector193:
  pushl $0
80107883:	6a 00                	push   $0x0
  pushl $193
80107885:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010788a:	e9 9c f3 ff ff       	jmp    80106c2b <alltraps>

8010788f <vector194>:
.globl vector194
vector194:
  pushl $0
8010788f:	6a 00                	push   $0x0
  pushl $194
80107891:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107896:	e9 90 f3 ff ff       	jmp    80106c2b <alltraps>

8010789b <vector195>:
.globl vector195
vector195:
  pushl $0
8010789b:	6a 00                	push   $0x0
  pushl $195
8010789d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801078a2:	e9 84 f3 ff ff       	jmp    80106c2b <alltraps>

801078a7 <vector196>:
.globl vector196
vector196:
  pushl $0
801078a7:	6a 00                	push   $0x0
  pushl $196
801078a9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801078ae:	e9 78 f3 ff ff       	jmp    80106c2b <alltraps>

801078b3 <vector197>:
.globl vector197
vector197:
  pushl $0
801078b3:	6a 00                	push   $0x0
  pushl $197
801078b5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801078ba:	e9 6c f3 ff ff       	jmp    80106c2b <alltraps>

801078bf <vector198>:
.globl vector198
vector198:
  pushl $0
801078bf:	6a 00                	push   $0x0
  pushl $198
801078c1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801078c6:	e9 60 f3 ff ff       	jmp    80106c2b <alltraps>

801078cb <vector199>:
.globl vector199
vector199:
  pushl $0
801078cb:	6a 00                	push   $0x0
  pushl $199
801078cd:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801078d2:	e9 54 f3 ff ff       	jmp    80106c2b <alltraps>

801078d7 <vector200>:
.globl vector200
vector200:
  pushl $0
801078d7:	6a 00                	push   $0x0
  pushl $200
801078d9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801078de:	e9 48 f3 ff ff       	jmp    80106c2b <alltraps>

801078e3 <vector201>:
.globl vector201
vector201:
  pushl $0
801078e3:	6a 00                	push   $0x0
  pushl $201
801078e5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801078ea:	e9 3c f3 ff ff       	jmp    80106c2b <alltraps>

801078ef <vector202>:
.globl vector202
vector202:
  pushl $0
801078ef:	6a 00                	push   $0x0
  pushl $202
801078f1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801078f6:	e9 30 f3 ff ff       	jmp    80106c2b <alltraps>

801078fb <vector203>:
.globl vector203
vector203:
  pushl $0
801078fb:	6a 00                	push   $0x0
  pushl $203
801078fd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107902:	e9 24 f3 ff ff       	jmp    80106c2b <alltraps>

80107907 <vector204>:
.globl vector204
vector204:
  pushl $0
80107907:	6a 00                	push   $0x0
  pushl $204
80107909:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010790e:	e9 18 f3 ff ff       	jmp    80106c2b <alltraps>

80107913 <vector205>:
.globl vector205
vector205:
  pushl $0
80107913:	6a 00                	push   $0x0
  pushl $205
80107915:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010791a:	e9 0c f3 ff ff       	jmp    80106c2b <alltraps>

8010791f <vector206>:
.globl vector206
vector206:
  pushl $0
8010791f:	6a 00                	push   $0x0
  pushl $206
80107921:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107926:	e9 00 f3 ff ff       	jmp    80106c2b <alltraps>

8010792b <vector207>:
.globl vector207
vector207:
  pushl $0
8010792b:	6a 00                	push   $0x0
  pushl $207
8010792d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107932:	e9 f4 f2 ff ff       	jmp    80106c2b <alltraps>

80107937 <vector208>:
.globl vector208
vector208:
  pushl $0
80107937:	6a 00                	push   $0x0
  pushl $208
80107939:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010793e:	e9 e8 f2 ff ff       	jmp    80106c2b <alltraps>

80107943 <vector209>:
.globl vector209
vector209:
  pushl $0
80107943:	6a 00                	push   $0x0
  pushl $209
80107945:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010794a:	e9 dc f2 ff ff       	jmp    80106c2b <alltraps>

8010794f <vector210>:
.globl vector210
vector210:
  pushl $0
8010794f:	6a 00                	push   $0x0
  pushl $210
80107951:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107956:	e9 d0 f2 ff ff       	jmp    80106c2b <alltraps>

8010795b <vector211>:
.globl vector211
vector211:
  pushl $0
8010795b:	6a 00                	push   $0x0
  pushl $211
8010795d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107962:	e9 c4 f2 ff ff       	jmp    80106c2b <alltraps>

80107967 <vector212>:
.globl vector212
vector212:
  pushl $0
80107967:	6a 00                	push   $0x0
  pushl $212
80107969:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010796e:	e9 b8 f2 ff ff       	jmp    80106c2b <alltraps>

80107973 <vector213>:
.globl vector213
vector213:
  pushl $0
80107973:	6a 00                	push   $0x0
  pushl $213
80107975:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010797a:	e9 ac f2 ff ff       	jmp    80106c2b <alltraps>

8010797f <vector214>:
.globl vector214
vector214:
  pushl $0
8010797f:	6a 00                	push   $0x0
  pushl $214
80107981:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107986:	e9 a0 f2 ff ff       	jmp    80106c2b <alltraps>

8010798b <vector215>:
.globl vector215
vector215:
  pushl $0
8010798b:	6a 00                	push   $0x0
  pushl $215
8010798d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107992:	e9 94 f2 ff ff       	jmp    80106c2b <alltraps>

80107997 <vector216>:
.globl vector216
vector216:
  pushl $0
80107997:	6a 00                	push   $0x0
  pushl $216
80107999:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010799e:	e9 88 f2 ff ff       	jmp    80106c2b <alltraps>

801079a3 <vector217>:
.globl vector217
vector217:
  pushl $0
801079a3:	6a 00                	push   $0x0
  pushl $217
801079a5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801079aa:	e9 7c f2 ff ff       	jmp    80106c2b <alltraps>

801079af <vector218>:
.globl vector218
vector218:
  pushl $0
801079af:	6a 00                	push   $0x0
  pushl $218
801079b1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801079b6:	e9 70 f2 ff ff       	jmp    80106c2b <alltraps>

801079bb <vector219>:
.globl vector219
vector219:
  pushl $0
801079bb:	6a 00                	push   $0x0
  pushl $219
801079bd:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801079c2:	e9 64 f2 ff ff       	jmp    80106c2b <alltraps>

801079c7 <vector220>:
.globl vector220
vector220:
  pushl $0
801079c7:	6a 00                	push   $0x0
  pushl $220
801079c9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801079ce:	e9 58 f2 ff ff       	jmp    80106c2b <alltraps>

801079d3 <vector221>:
.globl vector221
vector221:
  pushl $0
801079d3:	6a 00                	push   $0x0
  pushl $221
801079d5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801079da:	e9 4c f2 ff ff       	jmp    80106c2b <alltraps>

801079df <vector222>:
.globl vector222
vector222:
  pushl $0
801079df:	6a 00                	push   $0x0
  pushl $222
801079e1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801079e6:	e9 40 f2 ff ff       	jmp    80106c2b <alltraps>

801079eb <vector223>:
.globl vector223
vector223:
  pushl $0
801079eb:	6a 00                	push   $0x0
  pushl $223
801079ed:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801079f2:	e9 34 f2 ff ff       	jmp    80106c2b <alltraps>

801079f7 <vector224>:
.globl vector224
vector224:
  pushl $0
801079f7:	6a 00                	push   $0x0
  pushl $224
801079f9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801079fe:	e9 28 f2 ff ff       	jmp    80106c2b <alltraps>

80107a03 <vector225>:
.globl vector225
vector225:
  pushl $0
80107a03:	6a 00                	push   $0x0
  pushl $225
80107a05:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107a0a:	e9 1c f2 ff ff       	jmp    80106c2b <alltraps>

80107a0f <vector226>:
.globl vector226
vector226:
  pushl $0
80107a0f:	6a 00                	push   $0x0
  pushl $226
80107a11:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107a16:	e9 10 f2 ff ff       	jmp    80106c2b <alltraps>

80107a1b <vector227>:
.globl vector227
vector227:
  pushl $0
80107a1b:	6a 00                	push   $0x0
  pushl $227
80107a1d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107a22:	e9 04 f2 ff ff       	jmp    80106c2b <alltraps>

80107a27 <vector228>:
.globl vector228
vector228:
  pushl $0
80107a27:	6a 00                	push   $0x0
  pushl $228
80107a29:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80107a2e:	e9 f8 f1 ff ff       	jmp    80106c2b <alltraps>

80107a33 <vector229>:
.globl vector229
vector229:
  pushl $0
80107a33:	6a 00                	push   $0x0
  pushl $229
80107a35:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80107a3a:	e9 ec f1 ff ff       	jmp    80106c2b <alltraps>

80107a3f <vector230>:
.globl vector230
vector230:
  pushl $0
80107a3f:	6a 00                	push   $0x0
  pushl $230
80107a41:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107a46:	e9 e0 f1 ff ff       	jmp    80106c2b <alltraps>

80107a4b <vector231>:
.globl vector231
vector231:
  pushl $0
80107a4b:	6a 00                	push   $0x0
  pushl $231
80107a4d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107a52:	e9 d4 f1 ff ff       	jmp    80106c2b <alltraps>

80107a57 <vector232>:
.globl vector232
vector232:
  pushl $0
80107a57:	6a 00                	push   $0x0
  pushl $232
80107a59:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107a5e:	e9 c8 f1 ff ff       	jmp    80106c2b <alltraps>

80107a63 <vector233>:
.globl vector233
vector233:
  pushl $0
80107a63:	6a 00                	push   $0x0
  pushl $233
80107a65:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107a6a:	e9 bc f1 ff ff       	jmp    80106c2b <alltraps>

80107a6f <vector234>:
.globl vector234
vector234:
  pushl $0
80107a6f:	6a 00                	push   $0x0
  pushl $234
80107a71:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107a76:	e9 b0 f1 ff ff       	jmp    80106c2b <alltraps>

80107a7b <vector235>:
.globl vector235
vector235:
  pushl $0
80107a7b:	6a 00                	push   $0x0
  pushl $235
80107a7d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107a82:	e9 a4 f1 ff ff       	jmp    80106c2b <alltraps>

80107a87 <vector236>:
.globl vector236
vector236:
  pushl $0
80107a87:	6a 00                	push   $0x0
  pushl $236
80107a89:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107a8e:	e9 98 f1 ff ff       	jmp    80106c2b <alltraps>

80107a93 <vector237>:
.globl vector237
vector237:
  pushl $0
80107a93:	6a 00                	push   $0x0
  pushl $237
80107a95:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107a9a:	e9 8c f1 ff ff       	jmp    80106c2b <alltraps>

80107a9f <vector238>:
.globl vector238
vector238:
  pushl $0
80107a9f:	6a 00                	push   $0x0
  pushl $238
80107aa1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107aa6:	e9 80 f1 ff ff       	jmp    80106c2b <alltraps>

80107aab <vector239>:
.globl vector239
vector239:
  pushl $0
80107aab:	6a 00                	push   $0x0
  pushl $239
80107aad:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107ab2:	e9 74 f1 ff ff       	jmp    80106c2b <alltraps>

80107ab7 <vector240>:
.globl vector240
vector240:
  pushl $0
80107ab7:	6a 00                	push   $0x0
  pushl $240
80107ab9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107abe:	e9 68 f1 ff ff       	jmp    80106c2b <alltraps>

80107ac3 <vector241>:
.globl vector241
vector241:
  pushl $0
80107ac3:	6a 00                	push   $0x0
  pushl $241
80107ac5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107aca:	e9 5c f1 ff ff       	jmp    80106c2b <alltraps>

80107acf <vector242>:
.globl vector242
vector242:
  pushl $0
80107acf:	6a 00                	push   $0x0
  pushl $242
80107ad1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107ad6:	e9 50 f1 ff ff       	jmp    80106c2b <alltraps>

80107adb <vector243>:
.globl vector243
vector243:
  pushl $0
80107adb:	6a 00                	push   $0x0
  pushl $243
80107add:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107ae2:	e9 44 f1 ff ff       	jmp    80106c2b <alltraps>

80107ae7 <vector244>:
.globl vector244
vector244:
  pushl $0
80107ae7:	6a 00                	push   $0x0
  pushl $244
80107ae9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107aee:	e9 38 f1 ff ff       	jmp    80106c2b <alltraps>

80107af3 <vector245>:
.globl vector245
vector245:
  pushl $0
80107af3:	6a 00                	push   $0x0
  pushl $245
80107af5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107afa:	e9 2c f1 ff ff       	jmp    80106c2b <alltraps>

80107aff <vector246>:
.globl vector246
vector246:
  pushl $0
80107aff:	6a 00                	push   $0x0
  pushl $246
80107b01:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107b06:	e9 20 f1 ff ff       	jmp    80106c2b <alltraps>

80107b0b <vector247>:
.globl vector247
vector247:
  pushl $0
80107b0b:	6a 00                	push   $0x0
  pushl $247
80107b0d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107b12:	e9 14 f1 ff ff       	jmp    80106c2b <alltraps>

80107b17 <vector248>:
.globl vector248
vector248:
  pushl $0
80107b17:	6a 00                	push   $0x0
  pushl $248
80107b19:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107b1e:	e9 08 f1 ff ff       	jmp    80106c2b <alltraps>

80107b23 <vector249>:
.globl vector249
vector249:
  pushl $0
80107b23:	6a 00                	push   $0x0
  pushl $249
80107b25:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107b2a:	e9 fc f0 ff ff       	jmp    80106c2b <alltraps>

80107b2f <vector250>:
.globl vector250
vector250:
  pushl $0
80107b2f:	6a 00                	push   $0x0
  pushl $250
80107b31:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107b36:	e9 f0 f0 ff ff       	jmp    80106c2b <alltraps>

80107b3b <vector251>:
.globl vector251
vector251:
  pushl $0
80107b3b:	6a 00                	push   $0x0
  pushl $251
80107b3d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107b42:	e9 e4 f0 ff ff       	jmp    80106c2b <alltraps>

80107b47 <vector252>:
.globl vector252
vector252:
  pushl $0
80107b47:	6a 00                	push   $0x0
  pushl $252
80107b49:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107b4e:	e9 d8 f0 ff ff       	jmp    80106c2b <alltraps>

80107b53 <vector253>:
.globl vector253
vector253:
  pushl $0
80107b53:	6a 00                	push   $0x0
  pushl $253
80107b55:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107b5a:	e9 cc f0 ff ff       	jmp    80106c2b <alltraps>

80107b5f <vector254>:
.globl vector254
vector254:
  pushl $0
80107b5f:	6a 00                	push   $0x0
  pushl $254
80107b61:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107b66:	e9 c0 f0 ff ff       	jmp    80106c2b <alltraps>

80107b6b <vector255>:
.globl vector255
vector255:
  pushl $0
80107b6b:	6a 00                	push   $0x0
  pushl $255
80107b6d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107b72:	e9 b4 f0 ff ff       	jmp    80106c2b <alltraps>
80107b77:	66 90                	xchg   %ax,%ax
80107b79:	66 90                	xchg   %ax,%ax
80107b7b:	66 90                	xchg   %ax,%ax
80107b7d:	66 90                	xchg   %ax,%ax
80107b7f:	90                   	nop

80107b80 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107b80:	55                   	push   %ebp
80107b81:	89 e5                	mov    %esp,%ebp
80107b83:	57                   	push   %edi
80107b84:	56                   	push   %esi
80107b85:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107b86:	89 d3                	mov    %edx,%ebx
{
80107b88:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
80107b8a:	c1 eb 16             	shr    $0x16,%ebx
80107b8d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80107b90:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80107b93:	8b 06                	mov    (%esi),%eax
80107b95:	a8 01                	test   $0x1,%al
80107b97:	74 27                	je     80107bc0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107b99:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107b9e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107ba4:	c1 ef 0a             	shr    $0xa,%edi
}
80107ba7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80107baa:	89 fa                	mov    %edi,%edx
80107bac:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107bb2:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80107bb5:	5b                   	pop    %ebx
80107bb6:	5e                   	pop    %esi
80107bb7:	5f                   	pop    %edi
80107bb8:	5d                   	pop    %ebp
80107bb9:	c3                   	ret    
80107bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107bc0:	85 c9                	test   %ecx,%ecx
80107bc2:	74 2c                	je     80107bf0 <walkpgdir+0x70>
80107bc4:	e8 17 a9 ff ff       	call   801024e0 <kalloc>
80107bc9:	85 c0                	test   %eax,%eax
80107bcb:	89 c3                	mov    %eax,%ebx
80107bcd:	74 21                	je     80107bf0 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
80107bcf:	83 ec 04             	sub    $0x4,%esp
80107bd2:	68 00 10 00 00       	push   $0x1000
80107bd7:	6a 00                	push   $0x0
80107bd9:	50                   	push   %eax
80107bda:	e8 31 ce ff ff       	call   80104a10 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107bdf:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107be5:	83 c4 10             	add    $0x10,%esp
80107be8:	83 c8 07             	or     $0x7,%eax
80107beb:	89 06                	mov    %eax,(%esi)
80107bed:	eb b5                	jmp    80107ba4 <walkpgdir+0x24>
80107bef:	90                   	nop
}
80107bf0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80107bf3:	31 c0                	xor    %eax,%eax
}
80107bf5:	5b                   	pop    %ebx
80107bf6:	5e                   	pop    %esi
80107bf7:	5f                   	pop    %edi
80107bf8:	5d                   	pop    %ebp
80107bf9:	c3                   	ret    
80107bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107c00 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107c00:	55                   	push   %ebp
80107c01:	89 e5                	mov    %esp,%ebp
80107c03:	57                   	push   %edi
80107c04:	56                   	push   %esi
80107c05:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107c06:	89 d3                	mov    %edx,%ebx
80107c08:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80107c0e:	83 ec 1c             	sub    $0x1c,%esp
80107c11:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107c14:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107c18:	8b 7d 08             	mov    0x8(%ebp),%edi
80107c1b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107c20:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80107c23:	8b 45 0c             	mov    0xc(%ebp),%eax
80107c26:	29 df                	sub    %ebx,%edi
80107c28:	83 c8 01             	or     $0x1,%eax
80107c2b:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107c2e:	eb 15                	jmp    80107c45 <mappages+0x45>
    if(*pte & PTE_P)
80107c30:	f6 00 01             	testb  $0x1,(%eax)
80107c33:	75 45                	jne    80107c7a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80107c35:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80107c38:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
80107c3b:	89 30                	mov    %esi,(%eax)
    if(a == last)
80107c3d:	74 31                	je     80107c70 <mappages+0x70>
      break;
    a += PGSIZE;
80107c3f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107c45:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107c48:	b9 01 00 00 00       	mov    $0x1,%ecx
80107c4d:	89 da                	mov    %ebx,%edx
80107c4f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80107c52:	e8 29 ff ff ff       	call   80107b80 <walkpgdir>
80107c57:	85 c0                	test   %eax,%eax
80107c59:	75 d5                	jne    80107c30 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80107c5b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107c5e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107c63:	5b                   	pop    %ebx
80107c64:	5e                   	pop    %esi
80107c65:	5f                   	pop    %edi
80107c66:	5d                   	pop    %ebp
80107c67:	c3                   	ret    
80107c68:	90                   	nop
80107c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c70:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107c73:	31 c0                	xor    %eax,%eax
}
80107c75:	5b                   	pop    %ebx
80107c76:	5e                   	pop    %esi
80107c77:	5f                   	pop    %edi
80107c78:	5d                   	pop    %ebp
80107c79:	c3                   	ret    
      panic("remap");
80107c7a:	83 ec 0c             	sub    $0xc,%esp
80107c7d:	68 28 8f 10 80       	push   $0x80108f28
80107c82:	e8 09 87 ff ff       	call   80100390 <panic>
80107c87:	89 f6                	mov    %esi,%esi
80107c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107c90 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107c90:	55                   	push   %ebp
80107c91:	89 e5                	mov    %esp,%ebp
80107c93:	57                   	push   %edi
80107c94:	56                   	push   %esi
80107c95:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107c96:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107c9c:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
80107c9e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107ca4:	83 ec 1c             	sub    $0x1c,%esp
80107ca7:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107caa:	39 d3                	cmp    %edx,%ebx
80107cac:	73 66                	jae    80107d14 <deallocuvm.part.0+0x84>
80107cae:	89 d6                	mov    %edx,%esi
80107cb0:	eb 3d                	jmp    80107cef <deallocuvm.part.0+0x5f>
80107cb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80107cb8:	8b 10                	mov    (%eax),%edx
80107cba:	f6 c2 01             	test   $0x1,%dl
80107cbd:	74 26                	je     80107ce5 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80107cbf:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107cc5:	74 58                	je     80107d1f <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80107cc7:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80107cca:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80107cd0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80107cd3:	52                   	push   %edx
80107cd4:	e8 57 a6 ff ff       	call   80102330 <kfree>
      *pte = 0;
80107cd9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107cdc:	83 c4 10             	add    $0x10,%esp
80107cdf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80107ce5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107ceb:	39 f3                	cmp    %esi,%ebx
80107ced:	73 25                	jae    80107d14 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
80107cef:	31 c9                	xor    %ecx,%ecx
80107cf1:	89 da                	mov    %ebx,%edx
80107cf3:	89 f8                	mov    %edi,%eax
80107cf5:	e8 86 fe ff ff       	call   80107b80 <walkpgdir>
    if(!pte)
80107cfa:	85 c0                	test   %eax,%eax
80107cfc:	75 ba                	jne    80107cb8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107cfe:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80107d04:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107d0a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107d10:	39 f3                	cmp    %esi,%ebx
80107d12:	72 db                	jb     80107cef <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
80107d14:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107d17:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107d1a:	5b                   	pop    %ebx
80107d1b:	5e                   	pop    %esi
80107d1c:	5f                   	pop    %edi
80107d1d:	5d                   	pop    %ebp
80107d1e:	c3                   	ret    
        panic("kfree");
80107d1f:	83 ec 0c             	sub    $0xc,%esp
80107d22:	68 26 87 10 80       	push   $0x80108726
80107d27:	e8 64 86 ff ff       	call   80100390 <panic>
80107d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107d30 <seginit>:
{
80107d30:	55                   	push   %ebp
80107d31:	89 e5                	mov    %esp,%ebp
80107d33:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107d36:	e8 a5 ba ff ff       	call   801037e0 <cpuid>
80107d3b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80107d41:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107d46:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107d4a:	c7 80 f8 32 13 80 ff 	movl   $0xffff,-0x7feccd08(%eax)
80107d51:	ff 00 00 
80107d54:	c7 80 fc 32 13 80 00 	movl   $0xcf9a00,-0x7feccd04(%eax)
80107d5b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107d5e:	c7 80 00 33 13 80 ff 	movl   $0xffff,-0x7feccd00(%eax)
80107d65:	ff 00 00 
80107d68:	c7 80 04 33 13 80 00 	movl   $0xcf9200,-0x7fecccfc(%eax)
80107d6f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107d72:	c7 80 08 33 13 80 ff 	movl   $0xffff,-0x7fecccf8(%eax)
80107d79:	ff 00 00 
80107d7c:	c7 80 0c 33 13 80 00 	movl   $0xcffa00,-0x7fecccf4(%eax)
80107d83:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107d86:	c7 80 10 33 13 80 ff 	movl   $0xffff,-0x7fecccf0(%eax)
80107d8d:	ff 00 00 
80107d90:	c7 80 14 33 13 80 00 	movl   $0xcff200,-0x7fecccec(%eax)
80107d97:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80107d9a:	05 f0 32 13 80       	add    $0x801332f0,%eax
  pd[1] = (uint)p;
80107d9f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107da3:	c1 e8 10             	shr    $0x10,%eax
80107da6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80107daa:	8d 45 f2             	lea    -0xe(%ebp),%eax
80107dad:	0f 01 10             	lgdtl  (%eax)
}
80107db0:	c9                   	leave  
80107db1:	c3                   	ret    
80107db2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107dc0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107dc0:	a1 a4 b4 13 80       	mov    0x8013b4a4,%eax
{
80107dc5:	55                   	push   %ebp
80107dc6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107dc8:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107dcd:	0f 22 d8             	mov    %eax,%cr3
}
80107dd0:	5d                   	pop    %ebp
80107dd1:	c3                   	ret    
80107dd2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107de0 <switchuvm>:
{
80107de0:	55                   	push   %ebp
80107de1:	89 e5                	mov    %esp,%ebp
80107de3:	57                   	push   %edi
80107de4:	56                   	push   %esi
80107de5:	53                   	push   %ebx
80107de6:	83 ec 1c             	sub    $0x1c,%esp
80107de9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
80107dec:	85 db                	test   %ebx,%ebx
80107dee:	0f 84 cb 00 00 00    	je     80107ebf <switchuvm+0xdf>
  if(p->kstack == 0)
80107df4:	8b 43 08             	mov    0x8(%ebx),%eax
80107df7:	85 c0                	test   %eax,%eax
80107df9:	0f 84 da 00 00 00    	je     80107ed9 <switchuvm+0xf9>
  if(p->pgdir == 0)
80107dff:	8b 43 04             	mov    0x4(%ebx),%eax
80107e02:	85 c0                	test   %eax,%eax
80107e04:	0f 84 c2 00 00 00    	je     80107ecc <switchuvm+0xec>
  pushcli();
80107e0a:	e8 21 ca ff ff       	call   80104830 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107e0f:	e8 4c b9 ff ff       	call   80103760 <mycpu>
80107e14:	89 c6                	mov    %eax,%esi
80107e16:	e8 45 b9 ff ff       	call   80103760 <mycpu>
80107e1b:	89 c7                	mov    %eax,%edi
80107e1d:	e8 3e b9 ff ff       	call   80103760 <mycpu>
80107e22:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107e25:	83 c7 08             	add    $0x8,%edi
80107e28:	e8 33 b9 ff ff       	call   80103760 <mycpu>
80107e2d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107e30:	83 c0 08             	add    $0x8,%eax
80107e33:	ba 67 00 00 00       	mov    $0x67,%edx
80107e38:	c1 e8 18             	shr    $0x18,%eax
80107e3b:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80107e42:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80107e49:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107e4f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107e54:	83 c1 08             	add    $0x8,%ecx
80107e57:	c1 e9 10             	shr    $0x10,%ecx
80107e5a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80107e60:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107e65:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107e6c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80107e71:	e8 ea b8 ff ff       	call   80103760 <mycpu>
80107e76:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107e7d:	e8 de b8 ff ff       	call   80103760 <mycpu>
80107e82:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107e86:	8b 73 08             	mov    0x8(%ebx),%esi
80107e89:	e8 d2 b8 ff ff       	call   80103760 <mycpu>
80107e8e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107e94:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107e97:	e8 c4 b8 ff ff       	call   80103760 <mycpu>
80107e9c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107ea0:	b8 28 00 00 00       	mov    $0x28,%eax
80107ea5:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107ea8:	8b 43 04             	mov    0x4(%ebx),%eax
80107eab:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107eb0:	0f 22 d8             	mov    %eax,%cr3
}
80107eb3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107eb6:	5b                   	pop    %ebx
80107eb7:	5e                   	pop    %esi
80107eb8:	5f                   	pop    %edi
80107eb9:	5d                   	pop    %ebp
  popcli();
80107eba:	e9 b1 c9 ff ff       	jmp    80104870 <popcli>
    panic("switchuvm: no process");
80107ebf:	83 ec 0c             	sub    $0xc,%esp
80107ec2:	68 2e 8f 10 80       	push   $0x80108f2e
80107ec7:	e8 c4 84 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
80107ecc:	83 ec 0c             	sub    $0xc,%esp
80107ecf:	68 59 8f 10 80       	push   $0x80108f59
80107ed4:	e8 b7 84 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80107ed9:	83 ec 0c             	sub    $0xc,%esp
80107edc:	68 44 8f 10 80       	push   $0x80108f44
80107ee1:	e8 aa 84 ff ff       	call   80100390 <panic>
80107ee6:	8d 76 00             	lea    0x0(%esi),%esi
80107ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107ef0 <inituvm>:
{
80107ef0:	55                   	push   %ebp
80107ef1:	89 e5                	mov    %esp,%ebp
80107ef3:	57                   	push   %edi
80107ef4:	56                   	push   %esi
80107ef5:	53                   	push   %ebx
80107ef6:	83 ec 1c             	sub    $0x1c,%esp
80107ef9:	8b 75 10             	mov    0x10(%ebp),%esi
80107efc:	8b 45 08             	mov    0x8(%ebp),%eax
80107eff:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80107f02:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80107f08:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107f0b:	77 49                	ja     80107f56 <inituvm+0x66>
  mem = kalloc();
80107f0d:	e8 ce a5 ff ff       	call   801024e0 <kalloc>
  memset(mem, 0, PGSIZE);
80107f12:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80107f15:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107f17:	68 00 10 00 00       	push   $0x1000
80107f1c:	6a 00                	push   $0x0
80107f1e:	50                   	push   %eax
80107f1f:	e8 ec ca ff ff       	call   80104a10 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107f24:	58                   	pop    %eax
80107f25:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107f2b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107f30:	5a                   	pop    %edx
80107f31:	6a 06                	push   $0x6
80107f33:	50                   	push   %eax
80107f34:	31 d2                	xor    %edx,%edx
80107f36:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107f39:	e8 c2 fc ff ff       	call   80107c00 <mappages>
  memmove(mem, init, sz);
80107f3e:	89 75 10             	mov    %esi,0x10(%ebp)
80107f41:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107f44:	83 c4 10             	add    $0x10,%esp
80107f47:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80107f4a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107f4d:	5b                   	pop    %ebx
80107f4e:	5e                   	pop    %esi
80107f4f:	5f                   	pop    %edi
80107f50:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107f51:	e9 6a cb ff ff       	jmp    80104ac0 <memmove>
    panic("inituvm: more than a page");
80107f56:	83 ec 0c             	sub    $0xc,%esp
80107f59:	68 6d 8f 10 80       	push   $0x80108f6d
80107f5e:	e8 2d 84 ff ff       	call   80100390 <panic>
80107f63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107f70 <loaduvm>:
{
80107f70:	55                   	push   %ebp
80107f71:	89 e5                	mov    %esp,%ebp
80107f73:	57                   	push   %edi
80107f74:	56                   	push   %esi
80107f75:	53                   	push   %ebx
80107f76:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80107f79:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107f80:	0f 85 91 00 00 00    	jne    80108017 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80107f86:	8b 75 18             	mov    0x18(%ebp),%esi
80107f89:	31 db                	xor    %ebx,%ebx
80107f8b:	85 f6                	test   %esi,%esi
80107f8d:	75 1a                	jne    80107fa9 <loaduvm+0x39>
80107f8f:	eb 6f                	jmp    80108000 <loaduvm+0x90>
80107f91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107f98:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107f9e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80107fa4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80107fa7:	76 57                	jbe    80108000 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107fa9:	8b 55 0c             	mov    0xc(%ebp),%edx
80107fac:	8b 45 08             	mov    0x8(%ebp),%eax
80107faf:	31 c9                	xor    %ecx,%ecx
80107fb1:	01 da                	add    %ebx,%edx
80107fb3:	e8 c8 fb ff ff       	call   80107b80 <walkpgdir>
80107fb8:	85 c0                	test   %eax,%eax
80107fba:	74 4e                	je     8010800a <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80107fbc:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107fbe:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80107fc1:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107fc6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80107fcb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80107fd1:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107fd4:	01 d9                	add    %ebx,%ecx
80107fd6:	05 00 00 00 80       	add    $0x80000000,%eax
80107fdb:	57                   	push   %edi
80107fdc:	51                   	push   %ecx
80107fdd:	50                   	push   %eax
80107fde:	ff 75 10             	pushl  0x10(%ebp)
80107fe1:	e8 8a 99 ff ff       	call   80101970 <readi>
80107fe6:	83 c4 10             	add    $0x10,%esp
80107fe9:	39 f8                	cmp    %edi,%eax
80107feb:	74 ab                	je     80107f98 <loaduvm+0x28>
}
80107fed:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107ff0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107ff5:	5b                   	pop    %ebx
80107ff6:	5e                   	pop    %esi
80107ff7:	5f                   	pop    %edi
80107ff8:	5d                   	pop    %ebp
80107ff9:	c3                   	ret    
80107ffa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80108000:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80108003:	31 c0                	xor    %eax,%eax
}
80108005:	5b                   	pop    %ebx
80108006:	5e                   	pop    %esi
80108007:	5f                   	pop    %edi
80108008:	5d                   	pop    %ebp
80108009:	c3                   	ret    
      panic("loaduvm: address should exist");
8010800a:	83 ec 0c             	sub    $0xc,%esp
8010800d:	68 87 8f 10 80       	push   $0x80108f87
80108012:	e8 79 83 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80108017:	83 ec 0c             	sub    $0xc,%esp
8010801a:	68 28 90 10 80       	push   $0x80109028
8010801f:	e8 6c 83 ff ff       	call   80100390 <panic>
80108024:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010802a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80108030 <allocuvm>:
{
80108030:	55                   	push   %ebp
80108031:	89 e5                	mov    %esp,%ebp
80108033:	57                   	push   %edi
80108034:	56                   	push   %esi
80108035:	53                   	push   %ebx
80108036:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80108039:	8b 7d 10             	mov    0x10(%ebp),%edi
8010803c:	85 ff                	test   %edi,%edi
8010803e:	0f 88 8e 00 00 00    	js     801080d2 <allocuvm+0xa2>
  if(newsz < oldsz)
80108044:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80108047:	0f 82 93 00 00 00    	jb     801080e0 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
8010804d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108050:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80108056:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010805c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010805f:	0f 86 7e 00 00 00    	jbe    801080e3 <allocuvm+0xb3>
80108065:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80108068:	8b 7d 08             	mov    0x8(%ebp),%edi
8010806b:	eb 42                	jmp    801080af <allocuvm+0x7f>
8010806d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80108070:	83 ec 04             	sub    $0x4,%esp
80108073:	68 00 10 00 00       	push   $0x1000
80108078:	6a 00                	push   $0x0
8010807a:	50                   	push   %eax
8010807b:	e8 90 c9 ff ff       	call   80104a10 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80108080:	58                   	pop    %eax
80108081:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80108087:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010808c:	5a                   	pop    %edx
8010808d:	6a 06                	push   $0x6
8010808f:	50                   	push   %eax
80108090:	89 da                	mov    %ebx,%edx
80108092:	89 f8                	mov    %edi,%eax
80108094:	e8 67 fb ff ff       	call   80107c00 <mappages>
80108099:	83 c4 10             	add    $0x10,%esp
8010809c:	85 c0                	test   %eax,%eax
8010809e:	78 50                	js     801080f0 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
801080a0:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801080a6:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801080a9:	0f 86 81 00 00 00    	jbe    80108130 <allocuvm+0x100>
    mem = kalloc();
801080af:	e8 2c a4 ff ff       	call   801024e0 <kalloc>
    if(mem == 0){
801080b4:	85 c0                	test   %eax,%eax
    mem = kalloc();
801080b6:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801080b8:	75 b6                	jne    80108070 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
801080ba:	83 ec 0c             	sub    $0xc,%esp
801080bd:	68 a5 8f 10 80       	push   $0x80108fa5
801080c2:	e8 99 85 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
801080c7:	83 c4 10             	add    $0x10,%esp
801080ca:	8b 45 0c             	mov    0xc(%ebp),%eax
801080cd:	39 45 10             	cmp    %eax,0x10(%ebp)
801080d0:	77 6e                	ja     80108140 <allocuvm+0x110>
}
801080d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801080d5:	31 ff                	xor    %edi,%edi
}
801080d7:	89 f8                	mov    %edi,%eax
801080d9:	5b                   	pop    %ebx
801080da:	5e                   	pop    %esi
801080db:	5f                   	pop    %edi
801080dc:	5d                   	pop    %ebp
801080dd:	c3                   	ret    
801080de:	66 90                	xchg   %ax,%ax
    return oldsz;
801080e0:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
801080e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801080e6:	89 f8                	mov    %edi,%eax
801080e8:	5b                   	pop    %ebx
801080e9:	5e                   	pop    %esi
801080ea:	5f                   	pop    %edi
801080eb:	5d                   	pop    %ebp
801080ec:	c3                   	ret    
801080ed:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
801080f0:	83 ec 0c             	sub    $0xc,%esp
801080f3:	68 bd 8f 10 80       	push   $0x80108fbd
801080f8:	e8 63 85 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
801080fd:	83 c4 10             	add    $0x10,%esp
80108100:	8b 45 0c             	mov    0xc(%ebp),%eax
80108103:	39 45 10             	cmp    %eax,0x10(%ebp)
80108106:	76 0d                	jbe    80108115 <allocuvm+0xe5>
80108108:	89 c1                	mov    %eax,%ecx
8010810a:	8b 55 10             	mov    0x10(%ebp),%edx
8010810d:	8b 45 08             	mov    0x8(%ebp),%eax
80108110:	e8 7b fb ff ff       	call   80107c90 <deallocuvm.part.0>
      kfree(mem);
80108115:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80108118:	31 ff                	xor    %edi,%edi
      kfree(mem);
8010811a:	56                   	push   %esi
8010811b:	e8 10 a2 ff ff       	call   80102330 <kfree>
      return 0;
80108120:	83 c4 10             	add    $0x10,%esp
}
80108123:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108126:	89 f8                	mov    %edi,%eax
80108128:	5b                   	pop    %ebx
80108129:	5e                   	pop    %esi
8010812a:	5f                   	pop    %edi
8010812b:	5d                   	pop    %ebp
8010812c:	c3                   	ret    
8010812d:	8d 76 00             	lea    0x0(%esi),%esi
80108130:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80108133:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108136:	5b                   	pop    %ebx
80108137:	89 f8                	mov    %edi,%eax
80108139:	5e                   	pop    %esi
8010813a:	5f                   	pop    %edi
8010813b:	5d                   	pop    %ebp
8010813c:	c3                   	ret    
8010813d:	8d 76 00             	lea    0x0(%esi),%esi
80108140:	89 c1                	mov    %eax,%ecx
80108142:	8b 55 10             	mov    0x10(%ebp),%edx
80108145:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80108148:	31 ff                	xor    %edi,%edi
8010814a:	e8 41 fb ff ff       	call   80107c90 <deallocuvm.part.0>
8010814f:	eb 92                	jmp    801080e3 <allocuvm+0xb3>
80108151:	eb 0d                	jmp    80108160 <deallocuvm>
80108153:	90                   	nop
80108154:	90                   	nop
80108155:	90                   	nop
80108156:	90                   	nop
80108157:	90                   	nop
80108158:	90                   	nop
80108159:	90                   	nop
8010815a:	90                   	nop
8010815b:	90                   	nop
8010815c:	90                   	nop
8010815d:	90                   	nop
8010815e:	90                   	nop
8010815f:	90                   	nop

80108160 <deallocuvm>:
{
80108160:	55                   	push   %ebp
80108161:	89 e5                	mov    %esp,%ebp
80108163:	8b 55 0c             	mov    0xc(%ebp),%edx
80108166:	8b 4d 10             	mov    0x10(%ebp),%ecx
80108169:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010816c:	39 d1                	cmp    %edx,%ecx
8010816e:	73 10                	jae    80108180 <deallocuvm+0x20>
}
80108170:	5d                   	pop    %ebp
80108171:	e9 1a fb ff ff       	jmp    80107c90 <deallocuvm.part.0>
80108176:	8d 76 00             	lea    0x0(%esi),%esi
80108179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80108180:	89 d0                	mov    %edx,%eax
80108182:	5d                   	pop    %ebp
80108183:	c3                   	ret    
80108184:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010818a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80108190 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80108190:	55                   	push   %ebp
80108191:	89 e5                	mov    %esp,%ebp
80108193:	57                   	push   %edi
80108194:	56                   	push   %esi
80108195:	53                   	push   %ebx
80108196:	83 ec 0c             	sub    $0xc,%esp
80108199:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010819c:	85 f6                	test   %esi,%esi
8010819e:	74 59                	je     801081f9 <freevm+0x69>
801081a0:	31 c9                	xor    %ecx,%ecx
801081a2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801081a7:	89 f0                	mov    %esi,%eax
801081a9:	e8 e2 fa ff ff       	call   80107c90 <deallocuvm.part.0>
801081ae:	89 f3                	mov    %esi,%ebx
801081b0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801081b6:	eb 0f                	jmp    801081c7 <freevm+0x37>
801081b8:	90                   	nop
801081b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801081c0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801081c3:	39 fb                	cmp    %edi,%ebx
801081c5:	74 23                	je     801081ea <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801081c7:	8b 03                	mov    (%ebx),%eax
801081c9:	a8 01                	test   $0x1,%al
801081cb:	74 f3                	je     801081c0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801081cd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
801081d2:	83 ec 0c             	sub    $0xc,%esp
801081d5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
801081d8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801081dd:	50                   	push   %eax
801081de:	e8 4d a1 ff ff       	call   80102330 <kfree>
801081e3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801081e6:	39 fb                	cmp    %edi,%ebx
801081e8:	75 dd                	jne    801081c7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
801081ea:	89 75 08             	mov    %esi,0x8(%ebp)
}
801081ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801081f0:	5b                   	pop    %ebx
801081f1:	5e                   	pop    %esi
801081f2:	5f                   	pop    %edi
801081f3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801081f4:	e9 37 a1 ff ff       	jmp    80102330 <kfree>
    panic("freevm: no pgdir");
801081f9:	83 ec 0c             	sub    $0xc,%esp
801081fc:	68 d9 8f 10 80       	push   $0x80108fd9
80108201:	e8 8a 81 ff ff       	call   80100390 <panic>
80108206:	8d 76 00             	lea    0x0(%esi),%esi
80108209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108210 <setupkvm>:
{
80108210:	55                   	push   %ebp
80108211:	89 e5                	mov    %esp,%ebp
80108213:	56                   	push   %esi
80108214:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80108215:	e8 c6 a2 ff ff       	call   801024e0 <kalloc>
8010821a:	85 c0                	test   %eax,%eax
8010821c:	89 c6                	mov    %eax,%esi
8010821e:	74 42                	je     80108262 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80108220:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108223:	bb 20 c4 10 80       	mov    $0x8010c420,%ebx
  memset(pgdir, 0, PGSIZE);
80108228:	68 00 10 00 00       	push   $0x1000
8010822d:	6a 00                	push   $0x0
8010822f:	50                   	push   %eax
80108230:	e8 db c7 ff ff       	call   80104a10 <memset>
80108235:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80108238:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010823b:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010823e:	83 ec 08             	sub    $0x8,%esp
80108241:	8b 13                	mov    (%ebx),%edx
80108243:	ff 73 0c             	pushl  0xc(%ebx)
80108246:	50                   	push   %eax
80108247:	29 c1                	sub    %eax,%ecx
80108249:	89 f0                	mov    %esi,%eax
8010824b:	e8 b0 f9 ff ff       	call   80107c00 <mappages>
80108250:	83 c4 10             	add    $0x10,%esp
80108253:	85 c0                	test   %eax,%eax
80108255:	78 19                	js     80108270 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108257:	83 c3 10             	add    $0x10,%ebx
8010825a:	81 fb 60 c4 10 80    	cmp    $0x8010c460,%ebx
80108260:	75 d6                	jne    80108238 <setupkvm+0x28>
}
80108262:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108265:	89 f0                	mov    %esi,%eax
80108267:	5b                   	pop    %ebx
80108268:	5e                   	pop    %esi
80108269:	5d                   	pop    %ebp
8010826a:	c3                   	ret    
8010826b:	90                   	nop
8010826c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80108270:	83 ec 0c             	sub    $0xc,%esp
80108273:	56                   	push   %esi
      return 0;
80108274:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80108276:	e8 15 ff ff ff       	call   80108190 <freevm>
      return 0;
8010827b:	83 c4 10             	add    $0x10,%esp
}
8010827e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108281:	89 f0                	mov    %esi,%eax
80108283:	5b                   	pop    %ebx
80108284:	5e                   	pop    %esi
80108285:	5d                   	pop    %ebp
80108286:	c3                   	ret    
80108287:	89 f6                	mov    %esi,%esi
80108289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108290 <kvmalloc>:
{
80108290:	55                   	push   %ebp
80108291:	89 e5                	mov    %esp,%ebp
80108293:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80108296:	e8 75 ff ff ff       	call   80108210 <setupkvm>
8010829b:	a3 a4 b4 13 80       	mov    %eax,0x8013b4a4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801082a0:	05 00 00 00 80       	add    $0x80000000,%eax
801082a5:	0f 22 d8             	mov    %eax,%cr3
}
801082a8:	c9                   	leave  
801082a9:	c3                   	ret    
801082aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801082b0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801082b0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801082b1:	31 c9                	xor    %ecx,%ecx
{
801082b3:	89 e5                	mov    %esp,%ebp
801082b5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
801082b8:	8b 55 0c             	mov    0xc(%ebp),%edx
801082bb:	8b 45 08             	mov    0x8(%ebp),%eax
801082be:	e8 bd f8 ff ff       	call   80107b80 <walkpgdir>
  if(pte == 0)
801082c3:	85 c0                	test   %eax,%eax
801082c5:	74 05                	je     801082cc <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
801082c7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801082ca:	c9                   	leave  
801082cb:	c3                   	ret    
    panic("clearpteu");
801082cc:	83 ec 0c             	sub    $0xc,%esp
801082cf:	68 ea 8f 10 80       	push   $0x80108fea
801082d4:	e8 b7 80 ff ff       	call   80100390 <panic>
801082d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801082e0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801082e0:	55                   	push   %ebp
801082e1:	89 e5                	mov    %esp,%ebp
801082e3:	57                   	push   %edi
801082e4:	56                   	push   %esi
801082e5:	53                   	push   %ebx
801082e6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801082e9:	e8 22 ff ff ff       	call   80108210 <setupkvm>
801082ee:	85 c0                	test   %eax,%eax
801082f0:	89 45 e0             	mov    %eax,-0x20(%ebp)
801082f3:	0f 84 9f 00 00 00    	je     80108398 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801082f9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801082fc:	85 c9                	test   %ecx,%ecx
801082fe:	0f 84 94 00 00 00    	je     80108398 <copyuvm+0xb8>
80108304:	31 ff                	xor    %edi,%edi
80108306:	eb 4a                	jmp    80108352 <copyuvm+0x72>
80108308:	90                   	nop
80108309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80108310:	83 ec 04             	sub    $0x4,%esp
80108313:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80108319:	68 00 10 00 00       	push   $0x1000
8010831e:	53                   	push   %ebx
8010831f:	50                   	push   %eax
80108320:	e8 9b c7 ff ff       	call   80104ac0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80108325:	58                   	pop    %eax
80108326:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
8010832c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80108331:	5a                   	pop    %edx
80108332:	ff 75 e4             	pushl  -0x1c(%ebp)
80108335:	50                   	push   %eax
80108336:	89 fa                	mov    %edi,%edx
80108338:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010833b:	e8 c0 f8 ff ff       	call   80107c00 <mappages>
80108340:	83 c4 10             	add    $0x10,%esp
80108343:	85 c0                	test   %eax,%eax
80108345:	78 61                	js     801083a8 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80108347:	81 c7 00 10 00 00    	add    $0x1000,%edi
8010834d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80108350:	76 46                	jbe    80108398 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80108352:	8b 45 08             	mov    0x8(%ebp),%eax
80108355:	31 c9                	xor    %ecx,%ecx
80108357:	89 fa                	mov    %edi,%edx
80108359:	e8 22 f8 ff ff       	call   80107b80 <walkpgdir>
8010835e:	85 c0                	test   %eax,%eax
80108360:	74 61                	je     801083c3 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80108362:	8b 00                	mov    (%eax),%eax
80108364:	a8 01                	test   $0x1,%al
80108366:	74 4e                	je     801083b6 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80108368:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
8010836a:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
8010836f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80108375:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80108378:	e8 63 a1 ff ff       	call   801024e0 <kalloc>
8010837d:	85 c0                	test   %eax,%eax
8010837f:	89 c6                	mov    %eax,%esi
80108381:	75 8d                	jne    80108310 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80108383:	83 ec 0c             	sub    $0xc,%esp
80108386:	ff 75 e0             	pushl  -0x20(%ebp)
80108389:	e8 02 fe ff ff       	call   80108190 <freevm>
  return 0;
8010838e:	83 c4 10             	add    $0x10,%esp
80108391:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80108398:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010839b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010839e:	5b                   	pop    %ebx
8010839f:	5e                   	pop    %esi
801083a0:	5f                   	pop    %edi
801083a1:	5d                   	pop    %ebp
801083a2:	c3                   	ret    
801083a3:	90                   	nop
801083a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
801083a8:	83 ec 0c             	sub    $0xc,%esp
801083ab:	56                   	push   %esi
801083ac:	e8 7f 9f ff ff       	call   80102330 <kfree>
      goto bad;
801083b1:	83 c4 10             	add    $0x10,%esp
801083b4:	eb cd                	jmp    80108383 <copyuvm+0xa3>
      panic("copyuvm: page not present");
801083b6:	83 ec 0c             	sub    $0xc,%esp
801083b9:	68 0e 90 10 80       	push   $0x8010900e
801083be:	e8 cd 7f ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
801083c3:	83 ec 0c             	sub    $0xc,%esp
801083c6:	68 f4 8f 10 80       	push   $0x80108ff4
801083cb:	e8 c0 7f ff ff       	call   80100390 <panic>

801083d0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801083d0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801083d1:	31 c9                	xor    %ecx,%ecx
{
801083d3:	89 e5                	mov    %esp,%ebp
801083d5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
801083d8:	8b 55 0c             	mov    0xc(%ebp),%edx
801083db:	8b 45 08             	mov    0x8(%ebp),%eax
801083de:	e8 9d f7 ff ff       	call   80107b80 <walkpgdir>
  if((*pte & PTE_P) == 0)
801083e3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
801083e5:	c9                   	leave  
  if((*pte & PTE_U) == 0)
801083e6:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801083e8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
801083ed:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801083f0:	05 00 00 00 80       	add    $0x80000000,%eax
801083f5:	83 fa 05             	cmp    $0x5,%edx
801083f8:	ba 00 00 00 00       	mov    $0x0,%edx
801083fd:	0f 45 c2             	cmovne %edx,%eax
}
80108400:	c3                   	ret    
80108401:	eb 0d                	jmp    80108410 <copyout>
80108403:	90                   	nop
80108404:	90                   	nop
80108405:	90                   	nop
80108406:	90                   	nop
80108407:	90                   	nop
80108408:	90                   	nop
80108409:	90                   	nop
8010840a:	90                   	nop
8010840b:	90                   	nop
8010840c:	90                   	nop
8010840d:	90                   	nop
8010840e:	90                   	nop
8010840f:	90                   	nop

80108410 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108410:	55                   	push   %ebp
80108411:	89 e5                	mov    %esp,%ebp
80108413:	57                   	push   %edi
80108414:	56                   	push   %esi
80108415:	53                   	push   %ebx
80108416:	83 ec 1c             	sub    $0x1c,%esp
80108419:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010841c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010841f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80108422:	85 db                	test   %ebx,%ebx
80108424:	75 40                	jne    80108466 <copyout+0x56>
80108426:	eb 70                	jmp    80108498 <copyout+0x88>
80108428:	90                   	nop
80108429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80108430:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80108433:	89 f1                	mov    %esi,%ecx
80108435:	29 d1                	sub    %edx,%ecx
80108437:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010843d:	39 d9                	cmp    %ebx,%ecx
8010843f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80108442:	29 f2                	sub    %esi,%edx
80108444:	83 ec 04             	sub    $0x4,%esp
80108447:	01 d0                	add    %edx,%eax
80108449:	51                   	push   %ecx
8010844a:	57                   	push   %edi
8010844b:	50                   	push   %eax
8010844c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010844f:	e8 6c c6 ff ff       	call   80104ac0 <memmove>
    len -= n;
    buf += n;
80108454:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80108457:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
8010845a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80108460:	01 cf                	add    %ecx,%edi
  while(len > 0){
80108462:	29 cb                	sub    %ecx,%ebx
80108464:	74 32                	je     80108498 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80108466:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80108468:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
8010846b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010846e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80108474:	56                   	push   %esi
80108475:	ff 75 08             	pushl  0x8(%ebp)
80108478:	e8 53 ff ff ff       	call   801083d0 <uva2ka>
    if(pa0 == 0)
8010847d:	83 c4 10             	add    $0x10,%esp
80108480:	85 c0                	test   %eax,%eax
80108482:	75 ac                	jne    80108430 <copyout+0x20>
  }
  return 0;
}
80108484:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80108487:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010848c:	5b                   	pop    %ebx
8010848d:	5e                   	pop    %esi
8010848e:	5f                   	pop    %edi
8010848f:	5d                   	pop    %ebp
80108490:	c3                   	ret    
80108491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108498:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010849b:	31 c0                	xor    %eax,%eax
}
8010849d:	5b                   	pop    %ebx
8010849e:	5e                   	pop    %esi
8010849f:	5f                   	pop    %edi
801084a0:	5d                   	pop    %ebp
801084a1:	c3                   	ret    
