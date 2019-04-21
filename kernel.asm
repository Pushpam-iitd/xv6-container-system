
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
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
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
80100028:	bc d0 c5 10 80       	mov    $0x8010c5d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 d0 2e 10 80       	mov    $0x80102ed0,%eax
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
80100044:	bb f4 cd 10 80       	mov    $0x8010cdf4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 00 85 10 80       	push   $0x80108500
80100051:	68 c0 cd 10 80       	push   $0x8010cdc0
80100056:	e8 75 47 00 00       	call   801047d0 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 0c 15 11 80 bc 	movl   $0x801114bc,0x8011150c
80100062:	14 11 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 10 15 11 80 bc 	movl   $0x801114bc,0x80111510
8010006c:	14 11 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba bc 14 11 80       	mov    $0x801114bc,%edx
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
8010008b:	c7 43 50 bc 14 11 80 	movl   $0x801114bc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 07 85 10 80       	push   $0x80108507
80100097:	50                   	push   %eax
80100098:	e8 03 46 00 00       	call   801046a0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 15 11 80       	mov    0x80111510,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 10 15 11 80    	mov    %ebx,0x80111510
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d bc 14 11 80       	cmp    $0x801114bc,%eax
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
801000df:	68 c0 cd 10 80       	push   $0x8010cdc0
801000e4:	e8 27 48 00 00       	call   80104910 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 15 11 80    	mov    0x80111510,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc 14 11 80    	cmp    $0x801114bc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc 14 11 80    	cmp    $0x801114bc,%ebx
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
80100120:	8b 1d 0c 15 11 80    	mov    0x8011150c,%ebx
80100126:	81 fb bc 14 11 80    	cmp    $0x801114bc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc 14 11 80    	cmp    $0x801114bc,%ebx
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
8010015d:	68 c0 cd 10 80       	push   $0x8010cdc0
80100162:	e8 69 48 00 00       	call   801049d0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 6e 45 00 00       	call   801046e0 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 cd 1f 00 00       	call   80102150 <iderw>
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
80100193:	68 0e 85 10 80       	push   $0x8010850e
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
801001ae:	e8 cd 45 00 00       	call   80104780 <holdingsleep>
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
801001c4:	e9 87 1f 00 00       	jmp    80102150 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 1f 85 10 80       	push   $0x8010851f
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
801001ef:	e8 8c 45 00 00       	call   80104780 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 3c 45 00 00       	call   80104740 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 cd 10 80 	movl   $0x8010cdc0,(%esp)
8010020b:	e8 00 47 00 00       	call   80104910 <acquire>
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
80100232:	a1 10 15 11 80       	mov    0x80111510,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 bc 14 11 80 	movl   $0x801114bc,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 10 15 11 80       	mov    0x80111510,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 10 15 11 80    	mov    %ebx,0x80111510
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 c0 cd 10 80 	movl   $0x8010cdc0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 6f 47 00 00       	jmp    801049d0 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 26 85 10 80       	push   $0x80108526
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
80100285:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010028c:	e8 7f 46 00 00       	call   80104910 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 80 81 14 80    	mov    0x80148180,%edx
801002a7:	39 15 84 81 14 80    	cmp    %edx,0x80148184
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
801002bb:	68 20 b5 10 80       	push   $0x8010b520
801002c0:	68 80 81 14 80       	push   $0x80148180
801002c5:	e8 a6 3b 00 00       	call   80103e70 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 80 81 14 80    	mov    0x80148180,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 84 81 14 80    	cmp    0x80148184,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 30 35 00 00       	call   80103810 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 b5 10 80       	push   $0x8010b520
801002ef:	e8 dc 46 00 00       	call   801049d0 <release>
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
80100313:	a3 80 81 14 80       	mov    %eax,0x80148180
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 00 81 14 80 	movsbl -0x7feb7f00(%eax),%eax
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
80100348:	68 20 b5 10 80       	push   $0x8010b520
8010034d:	e8 7e 46 00 00       	call   801049d0 <release>
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
80100372:	89 15 80 81 14 80    	mov    %edx,0x80148180
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
80100399:	c7 05 54 b5 10 80 00 	movl   $0x0,0x8010b554
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 b2 23 00 00       	call   80102760 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 2d 85 10 80       	push   $0x8010852d
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 24 8d 10 80 	movl   $0x80108d24,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 13 44 00 00       	call   801047f0 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 41 85 10 80       	push   $0x80108541
801003ed:	e8 6e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 58 b5 10 80 01 	movl   $0x1,0x8010b558
80100400:	00 00 00 
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc>:
  if(panicked){
80100410:	8b 0d 58 b5 10 80    	mov    0x8010b558,%ecx
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
8010043a:	e8 c1 6c 00 00       	call   80107100 <uartputc>
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
801004ec:	e8 0f 6c 00 00       	call   80107100 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 03 6c 00 00       	call   80107100 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 f7 6b 00 00       	call   80107100 <uartputc>
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
80100524:	e8 a7 45 00 00       	call   80104ad0 <memmove>
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
80100541:	e8 da 44 00 00       	call   80104a20 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 45 85 10 80       	push   $0x80108545
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
801005b1:	0f b6 92 70 85 10 80 	movzbl -0x7fef7a90(%edx),%edx
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
80100614:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010061b:	e8 f0 42 00 00       	call   80104910 <acquire>
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
80100642:	68 20 b5 10 80       	push   $0x8010b520
80100647:	e8 84 43 00 00       	call   801049d0 <release>
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
80100669:	a1 54 b5 10 80       	mov    0x8010b554,%eax
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
8010071a:	68 20 b5 10 80       	push   $0x8010b520
8010071f:	e8 ac 42 00 00       	call   801049d0 <release>
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
801007d0:	ba 58 85 10 80       	mov    $0x80108558,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 b5 10 80       	push   $0x8010b520
801007f0:	e8 1b 41 00 00       	call   80104910 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 5f 85 10 80       	push   $0x8010855f
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
8010081e:	68 20 b5 10 80       	push   $0x8010b520
80100823:	e8 e8 40 00 00       	call   80104910 <acquire>
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
80100851:	a1 88 81 14 80       	mov    0x80148188,%eax
80100856:	3b 05 84 81 14 80    	cmp    0x80148184,%eax
8010085c:	74 d2                	je     80100830 <consoleintr+0x20>
        input.e--;
8010085e:	83 e8 01             	sub    $0x1,%eax
80100861:	a3 88 81 14 80       	mov    %eax,0x80148188
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
80100883:	68 20 b5 10 80       	push   $0x8010b520
80100888:	e8 43 41 00 00       	call   801049d0 <release>
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
801008a9:	a1 88 81 14 80       	mov    0x80148188,%eax
801008ae:	89 c2                	mov    %eax,%edx
801008b0:	2b 15 80 81 14 80    	sub    0x80148180,%edx
801008b6:	83 fa 7f             	cmp    $0x7f,%edx
801008b9:	0f 87 71 ff ff ff    	ja     80100830 <consoleintr+0x20>
801008bf:	8d 50 01             	lea    0x1(%eax),%edx
801008c2:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801008c5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008c8:	89 15 88 81 14 80    	mov    %edx,0x80148188
        c = (c == '\r') ? '\n' : c;
801008ce:	0f 84 cc 00 00 00    	je     801009a0 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d4:	89 f9                	mov    %edi,%ecx
801008d6:	88 88 00 81 14 80    	mov    %cl,-0x7feb7f00(%eax)
        consputc(c);
801008dc:	89 f8                	mov    %edi,%eax
801008de:	e8 2d fb ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e3:	83 ff 0a             	cmp    $0xa,%edi
801008e6:	0f 84 c5 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008ec:	83 ff 04             	cmp    $0x4,%edi
801008ef:	0f 84 bc 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008f5:	a1 80 81 14 80       	mov    0x80148180,%eax
801008fa:	83 e8 80             	sub    $0xffffff80,%eax
801008fd:	39 05 88 81 14 80    	cmp    %eax,0x80148188
80100903:	0f 85 27 ff ff ff    	jne    80100830 <consoleintr+0x20>
          wakeup(&input.r);
80100909:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
8010090c:	a3 84 81 14 80       	mov    %eax,0x80148184
          wakeup(&input.r);
80100911:	68 80 81 14 80       	push   $0x80148180
80100916:	e8 15 37 00 00       	call   80104030 <wakeup>
8010091b:	83 c4 10             	add    $0x10,%esp
8010091e:	e9 0d ff ff ff       	jmp    80100830 <consoleintr+0x20>
80100923:	90                   	nop
80100924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
80100928:	be 01 00 00 00       	mov    $0x1,%esi
8010092d:	e9 fe fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100938:	a1 88 81 14 80       	mov    0x80148188,%eax
8010093d:	39 05 84 81 14 80    	cmp    %eax,0x80148184
80100943:	75 2b                	jne    80100970 <consoleintr+0x160>
80100945:	e9 e6 fe ff ff       	jmp    80100830 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100950:	a3 88 81 14 80       	mov    %eax,0x80148188
        consputc(BACKSPACE);
80100955:	b8 00 01 00 00       	mov    $0x100,%eax
8010095a:	e8 b1 fa ff ff       	call   80100410 <consputc>
      while(input.e != input.w &&
8010095f:	a1 88 81 14 80       	mov    0x80148188,%eax
80100964:	3b 05 84 81 14 80    	cmp    0x80148184,%eax
8010096a:	0f 84 c0 fe ff ff    	je     80100830 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100970:	83 e8 01             	sub    $0x1,%eax
80100973:	89 c2                	mov    %eax,%edx
80100975:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100978:	80 ba 00 81 14 80 0a 	cmpb   $0xa,-0x7feb7f00(%edx)
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
80100997:	e9 74 37 00 00       	jmp    80104110 <procdump>
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
801009a0:	c6 80 00 81 14 80 0a 	movb   $0xa,-0x7feb7f00(%eax)
        consputc(c);
801009a7:	b8 0a 00 00 00       	mov    $0xa,%eax
801009ac:	e8 5f fa ff ff       	call   80100410 <consputc>
801009b1:	a1 88 81 14 80       	mov    0x80148188,%eax
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
801009c6:	68 68 85 10 80       	push   $0x80108568
801009cb:	68 20 b5 10 80       	push   $0x8010b520
801009d0:	e8 fb 3d 00 00       	call   801047d0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009d5:	58                   	pop    %eax
801009d6:	5a                   	pop    %edx
801009d7:	6a 00                	push   $0x0
801009d9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801009db:	c7 05 6c 8e 14 80 00 	movl   $0x80100600,0x80148e6c
801009e2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009e5:	c7 05 68 8e 14 80 70 	movl   $0x80100270,0x80148e68
801009ec:	02 10 80 
  cons.locking = 1;
801009ef:	c7 05 54 b5 10 80 01 	movl   $0x1,0x8010b554
801009f6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801009f9:	e8 02 19 00 00       	call   80102300 <ioapicenable>
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
80100a1c:	e8 ef 2d 00 00       	call   80103810 <myproc>
80100a21:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100a27:	e8 a4 21 00 00       	call   80102bd0 <begin_op>

  if((ip = namei(path)) == 0){
80100a2c:	83 ec 0c             	sub    $0xc,%esp
80100a2f:	ff 75 08             	pushl  0x8(%ebp)
80100a32:	e8 d9 14 00 00       	call   80101f10 <namei>
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
80100a59:	e8 22 0f 00 00       	call   80101980 <readi>
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
80100a6f:	e8 cc 21 00 00       	call   80102c40 <end_op>
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
80100a94:	e8 b7 77 00 00       	call   80108250 <setupkvm>
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
80100af6:	e8 75 75 00 00       	call   80108070 <allocuvm>
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
80100b28:	e8 83 74 00 00       	call   80107fb0 <loaduvm>
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
80100b58:	e8 23 0e 00 00       	call   80101980 <readi>
80100b5d:	83 c4 10             	add    $0x10,%esp
80100b60:	83 f8 20             	cmp    $0x20,%eax
80100b63:	0f 84 5f ff ff ff    	je     80100ac8 <exec+0xb8>
    freevm(pgdir);
80100b69:	83 ec 0c             	sub    $0xc,%esp
80100b6c:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b72:	e8 59 76 00 00       	call   801081d0 <freevm>
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
80100b9a:	e8 a1 20 00 00       	call   80102c40 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b9f:	83 c4 0c             	add    $0xc,%esp
80100ba2:	56                   	push   %esi
80100ba3:	57                   	push   %edi
80100ba4:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100baa:	e8 c1 74 00 00       	call   80108070 <allocuvm>
80100baf:	83 c4 10             	add    $0x10,%esp
80100bb2:	85 c0                	test   %eax,%eax
80100bb4:	89 c6                	mov    %eax,%esi
80100bb6:	75 3a                	jne    80100bf2 <exec+0x1e2>
    freevm(pgdir);
80100bb8:	83 ec 0c             	sub    $0xc,%esp
80100bbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bc1:	e8 0a 76 00 00       	call   801081d0 <freevm>
80100bc6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100bc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bce:	e9 a9 fe ff ff       	jmp    80100a7c <exec+0x6c>
    end_op();
80100bd3:	e8 68 20 00 00       	call   80102c40 <end_op>
    cprintf("exec: fail\n");
80100bd8:	83 ec 0c             	sub    $0xc,%esp
80100bdb:	68 81 85 10 80       	push   $0x80108581
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
80100c06:	e8 e5 76 00 00       	call   801082f0 <clearpteu>
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
80100c39:	e8 02 40 00 00       	call   80104c40 <strlen>
80100c3e:	f7 d0                	not    %eax
80100c40:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c42:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c45:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c46:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c49:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4c:	e8 ef 3f 00 00       	call   80104c40 <strlen>
80100c51:	83 c0 01             	add    $0x1,%eax
80100c54:	50                   	push   %eax
80100c55:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c58:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c5b:	53                   	push   %ebx
80100c5c:	56                   	push   %esi
80100c5d:	e8 ee 77 00 00       	call   80108450 <copyout>
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
80100cc7:	e8 84 77 00 00       	call   80108450 <copyout>
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
80100d0c:	e8 ef 3e 00 00       	call   80104c00 <safestrcpy>
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
80100d36:	e8 e5 70 00 00       	call   80107e20 <switchuvm>
  freevm(oldpgdir);
80100d3b:	89 3c 24             	mov    %edi,(%esp)
80100d3e:	e8 8d 74 00 00       	call   801081d0 <freevm>
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
80100d66:	68 8d 85 10 80       	push   $0x8010858d
80100d6b:	68 a0 81 14 80       	push   $0x801481a0
80100d70:	e8 5b 3a 00 00       	call   801047d0 <initlock>
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
80100d84:	bb d4 81 14 80       	mov    $0x801481d4,%ebx
{
80100d89:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100d8c:	68 a0 81 14 80       	push   $0x801481a0
80100d91:	e8 7a 3b 00 00       	call   80104910 <acquire>
80100d96:	83 c4 10             	add    $0x10,%esp
80100d99:	eb 10                	jmp    80100dab <filealloc+0x2b>
80100d9b:	90                   	nop
80100d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100da0:	83 c3 20             	add    $0x20,%ebx
80100da3:	81 fb 54 8e 14 80    	cmp    $0x80148e54,%ebx
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
80100dbc:	68 a0 81 14 80       	push   $0x801481a0
80100dc1:	e8 0a 3c 00 00       	call   801049d0 <release>
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
80100dd5:	68 a0 81 14 80       	push   $0x801481a0
80100dda:	e8 f1 3b 00 00       	call   801049d0 <release>
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
80100dfa:	68 a0 81 14 80       	push   $0x801481a0
80100dff:	e8 0c 3b 00 00       	call   80104910 <acquire>
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
80100e17:	68 a0 81 14 80       	push   $0x801481a0
80100e1c:	e8 af 3b 00 00       	call   801049d0 <release>
  return f;
}
80100e21:	89 d8                	mov    %ebx,%eax
80100e23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e26:	c9                   	leave  
80100e27:	c3                   	ret    
    panic("filedup");
80100e28:	83 ec 0c             	sub    $0xc,%esp
80100e2b:	68 94 85 10 80       	push   $0x80108594
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
80100e4c:	68 a0 81 14 80       	push   $0x801481a0
80100e51:	e8 ba 3a 00 00       	call   80104910 <acquire>
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
80100e6e:	c7 45 08 a0 81 14 80 	movl   $0x801481a0,0x8(%ebp)
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
80100e7c:	e9 4f 3b 00 00       	jmp    801049d0 <release>
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
80100ea0:	68 a0 81 14 80       	push   $0x801481a0
  ff = *f;
80100ea5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100ea8:	e8 23 3b 00 00       	call   801049d0 <release>
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
80100ed1:	e8 aa 24 00 00       	call   80103380 <pipeclose>
80100ed6:	83 c4 10             	add    $0x10,%esp
80100ed9:	eb df                	jmp    80100eba <fileclose+0x7a>
80100edb:	90                   	nop
80100edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100ee0:	e8 eb 1c 00 00       	call   80102bd0 <begin_op>
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
80100efa:	e9 41 1d 00 00       	jmp    80102c40 <end_op>
    panic("fileclose");
80100eff:	83 ec 0c             	sub    $0xc,%esp
80100f02:	68 9c 85 10 80       	push   $0x8010859c
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
    stati(f->ip, st,f->cid);
80100f2a:	83 c4 0c             	add    $0xc,%esp
80100f2d:	ff 73 18             	pushl  0x18(%ebx)
80100f30:	ff 75 0c             	pushl  0xc(%ebp)
80100f33:	ff 73 10             	pushl  0x10(%ebx)
80100f36:	e8 05 0a 00 00       	call   80101940 <stati>
    // st->cid = f->cid;
    iunlock(f->ip);
80100f3b:	58                   	pop    %eax
80100f3c:	ff 73 10             	pushl  0x10(%ebx)
80100f3f:	e8 2c 08 00 00       	call   80101770 <iunlock>
    return 0;
80100f44:	83 c4 10             	add    $0x10,%esp
80100f47:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f49:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f4c:	c9                   	leave  
80100f4d:	c3                   	ret    
80100f4e:	66 90                	xchg   %ax,%ax
  return -1;
80100f50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f55:	eb f2                	jmp    80100f49 <filestat+0x39>
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
80100f97:	e8 e4 09 00 00       	call   80101980 <readi>
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
80100fcd:	e9 5e 25 00 00       	jmp    80103530 <piperead>
80100fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80100fd8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80100fdd:	eb d7                	jmp    80100fb6 <fileread+0x56>
  panic("fileread");
80100fdf:	83 ec 0c             	sub    $0xc,%esp
80100fe2:	68 a6 85 10 80       	push   $0x801085a6
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
80101049:	e8 f2 1b 00 00       	call   80102c40 <end_op>
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
80101076:	e8 55 1b 00 00       	call   80102bd0 <begin_op>
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
80101093:	e8 e8 09 00 00       	call   80101a80 <writei>
80101098:	83 c4 20             	add    $0x20,%esp
8010109b:	85 c0                	test   %eax,%eax
8010109d:	7f 99                	jg     80101038 <filewrite+0x48>
      iunlock(f->ip);
8010109f:	83 ec 0c             	sub    $0xc,%esp
801010a2:	ff 76 10             	pushl  0x10(%esi)
801010a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010a8:	e8 c3 06 00 00       	call   80101770 <iunlock>
      end_op();
801010ad:	e8 8e 1b 00 00       	call   80102c40 <end_op>
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
801010ed:	e9 2e 23 00 00       	jmp    80103420 <pipewrite>
        panic("short filewrite");
801010f2:	83 ec 0c             	sub    $0xc,%esp
801010f5:	68 af 85 10 80       	push   $0x801085af
801010fa:	e8 91 f2 ff ff       	call   80100390 <panic>
  panic("filewrite");
801010ff:	83 ec 0c             	sub    $0xc,%esp
80101102:	68 b5 85 10 80       	push   $0x801085b5
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
80101119:	8b 0d c0 8e 14 80    	mov    0x80148ec0,%ecx
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
8010113c:	03 05 d8 8e 14 80    	add    0x80148ed8,%eax
80101142:	50                   	push   %eax
80101143:	ff 75 d8             	pushl  -0x28(%ebp)
80101146:	e8 85 ef ff ff       	call   801000d0 <bread>
8010114b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010114e:	a1 c0 8e 14 80       	mov    0x80148ec0,%eax
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
801011a9:	39 05 c0 8e 14 80    	cmp    %eax,0x80148ec0
801011af:	77 80                	ja     80101131 <balloc+0x21>
  }
  panic("balloc: out of blocks");
801011b1:	83 ec 0c             	sub    $0xc,%esp
801011b4:	68 bf 85 10 80       	push   $0x801085bf
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
801011cd:	e8 ce 1b 00 00       	call   80102da0 <log_write>
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
801011f5:	e8 26 38 00 00       	call   80104a20 <memset>
  log_write(bp);
801011fa:	89 1c 24             	mov    %ebx,(%esp)
801011fd:	e8 9e 1b 00 00       	call   80102da0 <log_write>
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
8010122a:	bb 14 8f 14 80       	mov    $0x80148f14,%ebx
{
8010122f:	83 ec 28             	sub    $0x28,%esp
80101232:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101235:	68 e0 8e 14 80       	push   $0x80148ee0
8010123a:	e8 d1 36 00 00       	call   80104910 <acquire>
8010123f:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101242:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101245:	eb 17                	jmp    8010125e <iget+0x3e>
80101247:	89 f6                	mov    %esi,%esi
80101249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101250:	81 c3 94 00 00 00    	add    $0x94,%ebx
80101256:	81 fb fc ab 14 80    	cmp    $0x8014abfc,%ebx
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
80101272:	81 c3 94 00 00 00    	add    $0x94,%ebx
80101278:	81 fb fc ab 14 80    	cmp    $0x8014abfc,%ebx
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
8010129a:	68 e0 8e 14 80       	push   $0x80148ee0
8010129f:	e8 2c 37 00 00       	call   801049d0 <release>

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
801012c5:	68 e0 8e 14 80       	push   $0x80148ee0
      ip->ref++;
801012ca:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801012cd:	e8 fe 36 00 00       	call   801049d0 <release>
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
801012e2:	68 d5 85 10 80       	push   $0x801085d5
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
8010135e:	e8 3d 1a 00 00       	call   80102da0 <log_write>
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
801013b7:	68 e5 85 10 80       	push   $0x801085e5
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
801013f1:	e8 da 36 00 00       	call   80104ad0 <memmove>
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
8010141c:	68 c0 8e 14 80       	push   $0x80148ec0
80101421:	50                   	push   %eax
80101422:	e8 a9 ff ff ff       	call   801013d0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101427:	58                   	pop    %eax
80101428:	5a                   	pop    %edx
80101429:	89 da                	mov    %ebx,%edx
8010142b:	c1 ea 0c             	shr    $0xc,%edx
8010142e:	03 15 d8 8e 14 80    	add    0x80148ed8,%edx
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
8010146a:	e8 31 19 00 00       	call   80102da0 <log_write>
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
80101484:	68 f8 85 10 80       	push   $0x801085f8
80101489:	e8 02 ef ff ff       	call   80100390 <panic>
8010148e:	66 90                	xchg   %ax,%ax

80101490 <iinit>:
{
80101490:	55                   	push   %ebp
80101491:	89 e5                	mov    %esp,%ebp
80101493:	53                   	push   %ebx
80101494:	bb 20 8f 14 80       	mov    $0x80148f20,%ebx
80101499:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010149c:	68 0b 86 10 80       	push   $0x8010860b
801014a1:	68 e0 8e 14 80       	push   $0x80148ee0
801014a6:	e8 25 33 00 00       	call   801047d0 <initlock>
801014ab:	83 c4 10             	add    $0x10,%esp
801014ae:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801014b0:	83 ec 08             	sub    $0x8,%esp
801014b3:	68 12 86 10 80       	push   $0x80108612
801014b8:	53                   	push   %ebx
801014b9:	81 c3 94 00 00 00    	add    $0x94,%ebx
801014bf:	e8 dc 31 00 00       	call   801046a0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014c4:	83 c4 10             	add    $0x10,%esp
801014c7:	81 fb 08 ac 14 80    	cmp    $0x8014ac08,%ebx
801014cd:	75 e1                	jne    801014b0 <iinit+0x20>
  readsb(dev, &sb);
801014cf:	83 ec 08             	sub    $0x8,%esp
801014d2:	68 c0 8e 14 80       	push   $0x80148ec0
801014d7:	ff 75 08             	pushl  0x8(%ebp)
801014da:	e8 f1 fe ff ff       	call   801013d0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014df:	ff 35 d8 8e 14 80    	pushl  0x80148ed8
801014e5:	ff 35 d4 8e 14 80    	pushl  0x80148ed4
801014eb:	ff 35 d0 8e 14 80    	pushl  0x80148ed0
801014f1:	ff 35 cc 8e 14 80    	pushl  0x80148ecc
801014f7:	ff 35 c8 8e 14 80    	pushl  0x80148ec8
801014fd:	ff 35 c4 8e 14 80    	pushl  0x80148ec4
80101503:	ff 35 c0 8e 14 80    	pushl  0x80148ec0
80101509:	68 78 86 10 80       	push   $0x80108678
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
80101529:	83 3d c8 8e 14 80 01 	cmpl   $0x1,0x80148ec8
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
8010155f:	39 1d c8 8e 14 80    	cmp    %ebx,0x80148ec8
80101565:	76 69                	jbe    801015d0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101567:	89 d8                	mov    %ebx,%eax
80101569:	83 ec 08             	sub    $0x8,%esp
8010156c:	c1 e8 03             	shr    $0x3,%eax
8010156f:	03 05 d4 8e 14 80    	add    0x80148ed4,%eax
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
8010159e:	e8 7d 34 00 00       	call   80104a20 <memset>
      dip->type = type;
801015a3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801015a7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801015aa:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801015ad:	89 3c 24             	mov    %edi,(%esp)
801015b0:	e8 eb 17 00 00       	call   80102da0 <log_write>
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
801015d3:	68 18 86 10 80       	push   $0x80108618
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
801015f4:	03 05 d4 8e 14 80    	add    0x80148ed4,%eax
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
80101641:	e8 8a 34 00 00       	call   80104ad0 <memmove>
  log_write(bp);
80101646:	89 34 24             	mov    %esi,(%esp)
80101649:	e8 52 17 00 00       	call   80102da0 <log_write>
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
8010166a:	68 e0 8e 14 80       	push   $0x80148ee0
8010166f:	e8 9c 32 00 00       	call   80104910 <acquire>
  ip->ref++;
80101674:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101678:	c7 04 24 e0 8e 14 80 	movl   $0x80148ee0,(%esp)
8010167f:	e8 4c 33 00 00       	call   801049d0 <release>
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
801016b2:	e8 29 30 00 00       	call   801046e0 <acquiresleep>
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
801016d9:	03 05 d4 8e 14 80    	add    0x80148ed4,%eax
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
80101728:	e8 a3 33 00 00       	call   80104ad0 <memmove>
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
8010174d:	68 30 86 10 80       	push   $0x80108630
80101752:	e8 39 ec ff ff       	call   80100390 <panic>
    panic("ilock");
80101757:	83 ec 0c             	sub    $0xc,%esp
8010175a:	68 2a 86 10 80       	push   $0x8010862a
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
80101783:	e8 f8 2f 00 00       	call   80104780 <holdingsleep>
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
8010179f:	e9 9c 2f 00 00       	jmp    80104740 <releasesleep>
    panic("iunlock");
801017a4:	83 ec 0c             	sub    $0xc,%esp
801017a7:	68 3f 86 10 80       	push   $0x8010863f
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
801017d0:	e8 0b 2f 00 00       	call   801046e0 <acquiresleep>
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
801017ea:	e8 51 2f 00 00       	call   80104740 <releasesleep>
  acquire(&icache.lock);
801017ef:	c7 04 24 e0 8e 14 80 	movl   $0x80148ee0,(%esp)
801017f6:	e8 15 31 00 00       	call   80104910 <acquire>
  ip->ref--;
801017fb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801017ff:	83 c4 10             	add    $0x10,%esp
80101802:	c7 45 08 e0 8e 14 80 	movl   $0x80148ee0,0x8(%ebp)
}
80101809:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010180c:	5b                   	pop    %ebx
8010180d:	5e                   	pop    %esi
8010180e:	5f                   	pop    %edi
8010180f:	5d                   	pop    %ebp
  release(&icache.lock);
80101810:	e9 bb 31 00 00       	jmp    801049d0 <release>
80101815:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101818:	83 ec 0c             	sub    $0xc,%esp
8010181b:	68 e0 8e 14 80       	push   $0x80148ee0
80101820:	e8 eb 30 00 00       	call   80104910 <acquire>
    int r = ip->ref;
80101825:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101828:	c7 04 24 e0 8e 14 80 	movl   $0x80148ee0,(%esp)
8010182f:	e8 9c 31 00 00       	call   801049d0 <release>
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
stati(struct inode *ip, struct stat *st,int cid)
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
  st->cid = cid;
80101969:	8b 55 10             	mov    0x10(%ebp),%edx
8010196c:	89 50 14             	mov    %edx,0x14(%eax)
}
8010196f:	5d                   	pop    %ebp
80101970:	c3                   	ret    
80101971:	eb 0d                	jmp    80101980 <readi>
80101973:	90                   	nop
80101974:	90                   	nop
80101975:	90                   	nop
80101976:	90                   	nop
80101977:	90                   	nop
80101978:	90                   	nop
80101979:	90                   	nop
8010197a:	90                   	nop
8010197b:	90                   	nop
8010197c:	90                   	nop
8010197d:	90                   	nop
8010197e:	90                   	nop
8010197f:	90                   	nop

80101980 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101980:	55                   	push   %ebp
80101981:	89 e5                	mov    %esp,%ebp
80101983:	57                   	push   %edi
80101984:	56                   	push   %esi
80101985:	53                   	push   %ebx
80101986:	83 ec 1c             	sub    $0x1c,%esp
80101989:	8b 45 08             	mov    0x8(%ebp),%eax
8010198c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010198f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101992:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101997:	89 75 e0             	mov    %esi,-0x20(%ebp)
8010199a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010199d:	8b 75 10             	mov    0x10(%ebp),%esi
801019a0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
801019a3:	0f 84 a7 00 00 00    	je     80101a50 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801019a9:	8b 45 d8             	mov    -0x28(%ebp),%eax
801019ac:	8b 40 58             	mov    0x58(%eax),%eax
801019af:	39 c6                	cmp    %eax,%esi
801019b1:	0f 87 ba 00 00 00    	ja     80101a71 <readi+0xf1>
801019b7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801019ba:	89 f9                	mov    %edi,%ecx
801019bc:	01 f1                	add    %esi,%ecx
801019be:	0f 82 ad 00 00 00    	jb     80101a71 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801019c4:	89 c2                	mov    %eax,%edx
801019c6:	29 f2                	sub    %esi,%edx
801019c8:	39 c8                	cmp    %ecx,%eax
801019ca:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019cd:	31 ff                	xor    %edi,%edi
801019cf:	85 d2                	test   %edx,%edx
    n = ip->size - off;
801019d1:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019d4:	74 6c                	je     80101a42 <readi+0xc2>
801019d6:	8d 76 00             	lea    0x0(%esi),%esi
801019d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019e0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801019e3:	89 f2                	mov    %esi,%edx
801019e5:	c1 ea 09             	shr    $0x9,%edx
801019e8:	89 d8                	mov    %ebx,%eax
801019ea:	e8 01 f9 ff ff       	call   801012f0 <bmap>
801019ef:	83 ec 08             	sub    $0x8,%esp
801019f2:	50                   	push   %eax
801019f3:	ff 33                	pushl  (%ebx)
801019f5:	e8 d6 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801019fa:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019fd:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801019ff:	89 f0                	mov    %esi,%eax
80101a01:	25 ff 01 00 00       	and    $0x1ff,%eax
80101a06:	b9 00 02 00 00       	mov    $0x200,%ecx
80101a0b:	83 c4 0c             	add    $0xc,%esp
80101a0e:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101a10:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101a14:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101a17:	29 fb                	sub    %edi,%ebx
80101a19:	39 d9                	cmp    %ebx,%ecx
80101a1b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a1e:	53                   	push   %ebx
80101a1f:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a20:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101a22:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a25:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101a27:	e8 a4 30 00 00       	call   80104ad0 <memmove>
    brelse(bp);
80101a2c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a2f:	89 14 24             	mov    %edx,(%esp)
80101a32:	e8 a9 e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a37:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a3a:	83 c4 10             	add    $0x10,%esp
80101a3d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a40:	77 9e                	ja     801019e0 <readi+0x60>
  }
  return n;
80101a42:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a45:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a48:	5b                   	pop    %ebx
80101a49:	5e                   	pop    %esi
80101a4a:	5f                   	pop    %edi
80101a4b:	5d                   	pop    %ebp
80101a4c:	c3                   	ret    
80101a4d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a50:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101a54:	66 83 f8 09          	cmp    $0x9,%ax
80101a58:	77 17                	ja     80101a71 <readi+0xf1>
80101a5a:	8b 04 c5 60 8e 14 80 	mov    -0x7feb71a0(,%eax,8),%eax
80101a61:	85 c0                	test   %eax,%eax
80101a63:	74 0c                	je     80101a71 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101a65:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101a68:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a6b:	5b                   	pop    %ebx
80101a6c:	5e                   	pop    %esi
80101a6d:	5f                   	pop    %edi
80101a6e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101a6f:	ff e0                	jmp    *%eax
      return -1;
80101a71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a76:	eb cd                	jmp    80101a45 <readi+0xc5>
80101a78:	90                   	nop
80101a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101a80 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a80:	55                   	push   %ebp
80101a81:	89 e5                	mov    %esp,%ebp
80101a83:	57                   	push   %edi
80101a84:	56                   	push   %esi
80101a85:	53                   	push   %ebx
80101a86:	83 ec 1c             	sub    $0x1c,%esp
80101a89:	8b 45 08             	mov    0x8(%ebp),%eax
80101a8c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a8f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a92:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a97:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a9a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a9d:	8b 75 10             	mov    0x10(%ebp),%esi
80101aa0:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101aa3:	0f 84 b7 00 00 00    	je     80101b60 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101aa9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101aac:	39 70 58             	cmp    %esi,0x58(%eax)
80101aaf:	0f 82 eb 00 00 00    	jb     80101ba0 <writei+0x120>
80101ab5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101ab8:	31 d2                	xor    %edx,%edx
80101aba:	89 f8                	mov    %edi,%eax
80101abc:	01 f0                	add    %esi,%eax
80101abe:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101ac1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101ac6:	0f 87 d4 00 00 00    	ja     80101ba0 <writei+0x120>
80101acc:	85 d2                	test   %edx,%edx
80101ace:	0f 85 cc 00 00 00    	jne    80101ba0 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ad4:	85 ff                	test   %edi,%edi
80101ad6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101add:	74 72                	je     80101b51 <writei+0xd1>
80101adf:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ae0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101ae3:	89 f2                	mov    %esi,%edx
80101ae5:	c1 ea 09             	shr    $0x9,%edx
80101ae8:	89 f8                	mov    %edi,%eax
80101aea:	e8 01 f8 ff ff       	call   801012f0 <bmap>
80101aef:	83 ec 08             	sub    $0x8,%esp
80101af2:	50                   	push   %eax
80101af3:	ff 37                	pushl  (%edi)
80101af5:	e8 d6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101afa:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101afd:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b00:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101b02:	89 f0                	mov    %esi,%eax
80101b04:	b9 00 02 00 00       	mov    $0x200,%ecx
80101b09:	83 c4 0c             	add    $0xc,%esp
80101b0c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b11:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101b13:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b17:	39 d9                	cmp    %ebx,%ecx
80101b19:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101b1c:	53                   	push   %ebx
80101b1d:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b20:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101b22:	50                   	push   %eax
80101b23:	e8 a8 2f 00 00       	call   80104ad0 <memmove>
    log_write(bp);
80101b28:	89 3c 24             	mov    %edi,(%esp)
80101b2b:	e8 70 12 00 00       	call   80102da0 <log_write>
    brelse(bp);
80101b30:	89 3c 24             	mov    %edi,(%esp)
80101b33:	e8 a8 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b38:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b3b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b3e:	83 c4 10             	add    $0x10,%esp
80101b41:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b44:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101b47:	77 97                	ja     80101ae0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101b49:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b4c:	3b 70 58             	cmp    0x58(%eax),%esi
80101b4f:	77 37                	ja     80101b88 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b51:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b54:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b57:	5b                   	pop    %ebx
80101b58:	5e                   	pop    %esi
80101b59:	5f                   	pop    %edi
80101b5a:	5d                   	pop    %ebp
80101b5b:	c3                   	ret    
80101b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b60:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b64:	66 83 f8 09          	cmp    $0x9,%ax
80101b68:	77 36                	ja     80101ba0 <writei+0x120>
80101b6a:	8b 04 c5 64 8e 14 80 	mov    -0x7feb719c(,%eax,8),%eax
80101b71:	85 c0                	test   %eax,%eax
80101b73:	74 2b                	je     80101ba0 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101b75:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b7b:	5b                   	pop    %ebx
80101b7c:	5e                   	pop    %esi
80101b7d:	5f                   	pop    %edi
80101b7e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101b7f:	ff e0                	jmp    *%eax
80101b81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101b88:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101b8b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101b8e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b91:	50                   	push   %eax
80101b92:	e8 49 fa ff ff       	call   801015e0 <iupdate>
80101b97:	83 c4 10             	add    $0x10,%esp
80101b9a:	eb b5                	jmp    80101b51 <writei+0xd1>
80101b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101ba0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ba5:	eb ad                	jmp    80101b54 <writei+0xd4>
80101ba7:	89 f6                	mov    %esi,%esi
80101ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bb0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101bb0:	55                   	push   %ebp
80101bb1:	89 e5                	mov    %esp,%ebp
80101bb3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101bb6:	6a 0e                	push   $0xe
80101bb8:	ff 75 0c             	pushl  0xc(%ebp)
80101bbb:	ff 75 08             	pushl  0x8(%ebp)
80101bbe:	e8 7d 2f 00 00       	call   80104b40 <strncmp>
}
80101bc3:	c9                   	leave  
80101bc4:	c3                   	ret    
80101bc5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bd0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101bd0:	55                   	push   %ebp
80101bd1:	89 e5                	mov    %esp,%ebp
80101bd3:	57                   	push   %edi
80101bd4:	56                   	push   %esi
80101bd5:	53                   	push   %ebx
80101bd6:	83 ec 1c             	sub    $0x1c,%esp
80101bd9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bdc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101be1:	0f 85 85 00 00 00    	jne    80101c6c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101be7:	8b 53 58             	mov    0x58(%ebx),%edx
80101bea:	31 ff                	xor    %edi,%edi
80101bec:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101bef:	85 d2                	test   %edx,%edx
80101bf1:	74 3e                	je     80101c31 <dirlookup+0x61>
80101bf3:	90                   	nop
80101bf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101bf8:	6a 10                	push   $0x10
80101bfa:	57                   	push   %edi
80101bfb:	56                   	push   %esi
80101bfc:	53                   	push   %ebx
80101bfd:	e8 7e fd ff ff       	call   80101980 <readi>
80101c02:	83 c4 10             	add    $0x10,%esp
80101c05:	83 f8 10             	cmp    $0x10,%eax
80101c08:	75 55                	jne    80101c5f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101c0a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101c0f:	74 18                	je     80101c29 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101c11:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c14:	83 ec 04             	sub    $0x4,%esp
80101c17:	6a 0e                	push   $0xe
80101c19:	50                   	push   %eax
80101c1a:	ff 75 0c             	pushl  0xc(%ebp)
80101c1d:	e8 1e 2f 00 00       	call   80104b40 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101c22:	83 c4 10             	add    $0x10,%esp
80101c25:	85 c0                	test   %eax,%eax
80101c27:	74 17                	je     80101c40 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101c29:	83 c7 10             	add    $0x10,%edi
80101c2c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101c2f:	72 c7                	jb     80101bf8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101c31:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101c34:	31 c0                	xor    %eax,%eax
}
80101c36:	5b                   	pop    %ebx
80101c37:	5e                   	pop    %esi
80101c38:	5f                   	pop    %edi
80101c39:	5d                   	pop    %ebp
80101c3a:	c3                   	ret    
80101c3b:	90                   	nop
80101c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101c40:	8b 45 10             	mov    0x10(%ebp),%eax
80101c43:	85 c0                	test   %eax,%eax
80101c45:	74 05                	je     80101c4c <dirlookup+0x7c>
        *poff = off;
80101c47:	8b 45 10             	mov    0x10(%ebp),%eax
80101c4a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101c4c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101c50:	8b 03                	mov    (%ebx),%eax
80101c52:	e8 c9 f5 ff ff       	call   80101220 <iget>
}
80101c57:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c5a:	5b                   	pop    %ebx
80101c5b:	5e                   	pop    %esi
80101c5c:	5f                   	pop    %edi
80101c5d:	5d                   	pop    %ebp
80101c5e:	c3                   	ret    
      panic("dirlookup read");
80101c5f:	83 ec 0c             	sub    $0xc,%esp
80101c62:	68 59 86 10 80       	push   $0x80108659
80101c67:	e8 24 e7 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101c6c:	83 ec 0c             	sub    $0xc,%esp
80101c6f:	68 47 86 10 80       	push   $0x80108647
80101c74:	e8 17 e7 ff ff       	call   80100390 <panic>
80101c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101c80 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c80:	55                   	push   %ebp
80101c81:	89 e5                	mov    %esp,%ebp
80101c83:	57                   	push   %edi
80101c84:	56                   	push   %esi
80101c85:	53                   	push   %ebx
80101c86:	89 cf                	mov    %ecx,%edi
80101c88:	89 c3                	mov    %eax,%ebx
80101c8a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c8d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101c90:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101c93:	0f 84 77 01 00 00    	je     80101e10 <namex+0x190>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c99:	e8 72 1b 00 00       	call   80103810 <myproc>
  acquire(&icache.lock);
80101c9e:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101ca1:	8b b0 b8 01 00 00    	mov    0x1b8(%eax),%esi
  acquire(&icache.lock);
80101ca7:	68 e0 8e 14 80       	push   $0x80148ee0
80101cac:	e8 5f 2c 00 00       	call   80104910 <acquire>
  ip->ref++;
80101cb1:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101cb5:	c7 04 24 e0 8e 14 80 	movl   $0x80148ee0,(%esp)
80101cbc:	e8 0f 2d 00 00       	call   801049d0 <release>
80101cc1:	83 c4 10             	add    $0x10,%esp
80101cc4:	eb 0d                	jmp    80101cd3 <namex+0x53>
80101cc6:	8d 76 00             	lea    0x0(%esi),%esi
80101cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101cd0:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101cd3:	0f b6 03             	movzbl (%ebx),%eax
80101cd6:	3c 2f                	cmp    $0x2f,%al
80101cd8:	74 f6                	je     80101cd0 <namex+0x50>
  if(*path == 0)
80101cda:	84 c0                	test   %al,%al
80101cdc:	0f 84 f6 00 00 00    	je     80101dd8 <namex+0x158>
  while(*path != '/' && *path != 0)
80101ce2:	0f b6 03             	movzbl (%ebx),%eax
80101ce5:	3c 2f                	cmp    $0x2f,%al
80101ce7:	0f 84 bb 00 00 00    	je     80101da8 <namex+0x128>
80101ced:	84 c0                	test   %al,%al
80101cef:	89 da                	mov    %ebx,%edx
80101cf1:	75 11                	jne    80101d04 <namex+0x84>
80101cf3:	e9 b0 00 00 00       	jmp    80101da8 <namex+0x128>
80101cf8:	90                   	nop
80101cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d00:	84 c0                	test   %al,%al
80101d02:	74 0a                	je     80101d0e <namex+0x8e>
    path++;
80101d04:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101d07:	0f b6 02             	movzbl (%edx),%eax
80101d0a:	3c 2f                	cmp    $0x2f,%al
80101d0c:	75 f2                	jne    80101d00 <namex+0x80>
80101d0e:	89 d1                	mov    %edx,%ecx
80101d10:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101d12:	83 f9 0d             	cmp    $0xd,%ecx
80101d15:	0f 8e 91 00 00 00    	jle    80101dac <namex+0x12c>
    memmove(name, s, DIRSIZ);
80101d1b:	83 ec 04             	sub    $0x4,%esp
80101d1e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101d21:	6a 0e                	push   $0xe
80101d23:	53                   	push   %ebx
80101d24:	57                   	push   %edi
80101d25:	e8 a6 2d 00 00       	call   80104ad0 <memmove>
    path++;
80101d2a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101d2d:	83 c4 10             	add    $0x10,%esp
    path++;
80101d30:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101d32:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d35:	75 11                	jne    80101d48 <namex+0xc8>
80101d37:	89 f6                	mov    %esi,%esi
80101d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101d40:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d43:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d46:	74 f8                	je     80101d40 <namex+0xc0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d48:	83 ec 0c             	sub    $0xc,%esp
80101d4b:	56                   	push   %esi
80101d4c:	e8 3f f9 ff ff       	call   80101690 <ilock>
    if(ip->type != T_DIR){
80101d51:	83 c4 10             	add    $0x10,%esp
80101d54:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d59:	0f 85 91 00 00 00    	jne    80101df0 <namex+0x170>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d5f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d62:	85 d2                	test   %edx,%edx
80101d64:	74 09                	je     80101d6f <namex+0xef>
80101d66:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d69:	0f 84 b7 00 00 00    	je     80101e26 <namex+0x1a6>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d6f:	83 ec 04             	sub    $0x4,%esp
80101d72:	6a 00                	push   $0x0
80101d74:	57                   	push   %edi
80101d75:	56                   	push   %esi
80101d76:	e8 55 fe ff ff       	call   80101bd0 <dirlookup>
80101d7b:	83 c4 10             	add    $0x10,%esp
80101d7e:	85 c0                	test   %eax,%eax
80101d80:	74 6e                	je     80101df0 <namex+0x170>
  iunlock(ip);
80101d82:	83 ec 0c             	sub    $0xc,%esp
80101d85:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d88:	56                   	push   %esi
80101d89:	e8 e2 f9 ff ff       	call   80101770 <iunlock>
  iput(ip);
80101d8e:	89 34 24             	mov    %esi,(%esp)
80101d91:	e8 2a fa ff ff       	call   801017c0 <iput>
80101d96:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d99:	83 c4 10             	add    $0x10,%esp
80101d9c:	89 c6                	mov    %eax,%esi
80101d9e:	e9 30 ff ff ff       	jmp    80101cd3 <namex+0x53>
80101da3:	90                   	nop
80101da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101da8:	89 da                	mov    %ebx,%edx
80101daa:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101dac:	83 ec 04             	sub    $0x4,%esp
80101daf:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101db2:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101db5:	51                   	push   %ecx
80101db6:	53                   	push   %ebx
80101db7:	57                   	push   %edi
80101db8:	e8 13 2d 00 00       	call   80104ad0 <memmove>
    name[len] = 0;
80101dbd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101dc0:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101dc3:	83 c4 10             	add    $0x10,%esp
80101dc6:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101dca:	89 d3                	mov    %edx,%ebx
80101dcc:	e9 61 ff ff ff       	jmp    80101d32 <namex+0xb2>
80101dd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101dd8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101ddb:	85 c0                	test   %eax,%eax
80101ddd:	75 5d                	jne    80101e3c <namex+0x1bc>
    iput(ip);
    return 0;
  }
  return ip;
}
80101ddf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101de2:	89 f0                	mov    %esi,%eax
80101de4:	5b                   	pop    %ebx
80101de5:	5e                   	pop    %esi
80101de6:	5f                   	pop    %edi
80101de7:	5d                   	pop    %ebp
80101de8:	c3                   	ret    
80101de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101df0:	83 ec 0c             	sub    $0xc,%esp
80101df3:	56                   	push   %esi
80101df4:	e8 77 f9 ff ff       	call   80101770 <iunlock>
  iput(ip);
80101df9:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101dfc:	31 f6                	xor    %esi,%esi
  iput(ip);
80101dfe:	e8 bd f9 ff ff       	call   801017c0 <iput>
      return 0;
80101e03:	83 c4 10             	add    $0x10,%esp
}
80101e06:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e09:	89 f0                	mov    %esi,%eax
80101e0b:	5b                   	pop    %ebx
80101e0c:	5e                   	pop    %esi
80101e0d:	5f                   	pop    %edi
80101e0e:	5d                   	pop    %ebp
80101e0f:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101e10:	ba 01 00 00 00       	mov    $0x1,%edx
80101e15:	b8 01 00 00 00       	mov    $0x1,%eax
80101e1a:	e8 01 f4 ff ff       	call   80101220 <iget>
80101e1f:	89 c6                	mov    %eax,%esi
80101e21:	e9 ad fe ff ff       	jmp    80101cd3 <namex+0x53>
      iunlock(ip);
80101e26:	83 ec 0c             	sub    $0xc,%esp
80101e29:	56                   	push   %esi
80101e2a:	e8 41 f9 ff ff       	call   80101770 <iunlock>
      return ip;
80101e2f:	83 c4 10             	add    $0x10,%esp
}
80101e32:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e35:	89 f0                	mov    %esi,%eax
80101e37:	5b                   	pop    %ebx
80101e38:	5e                   	pop    %esi
80101e39:	5f                   	pop    %edi
80101e3a:	5d                   	pop    %ebp
80101e3b:	c3                   	ret    
    iput(ip);
80101e3c:	83 ec 0c             	sub    $0xc,%esp
80101e3f:	56                   	push   %esi
    return 0;
80101e40:	31 f6                	xor    %esi,%esi
    iput(ip);
80101e42:	e8 79 f9 ff ff       	call   801017c0 <iput>
    return 0;
80101e47:	83 c4 10             	add    $0x10,%esp
80101e4a:	eb 93                	jmp    80101ddf <namex+0x15f>
80101e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101e50 <dirlink>:
{
80101e50:	55                   	push   %ebp
80101e51:	89 e5                	mov    %esp,%ebp
80101e53:	57                   	push   %edi
80101e54:	56                   	push   %esi
80101e55:	53                   	push   %ebx
80101e56:	83 ec 20             	sub    $0x20,%esp
80101e59:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e5c:	6a 00                	push   $0x0
80101e5e:	ff 75 0c             	pushl  0xc(%ebp)
80101e61:	53                   	push   %ebx
80101e62:	e8 69 fd ff ff       	call   80101bd0 <dirlookup>
80101e67:	83 c4 10             	add    $0x10,%esp
80101e6a:	85 c0                	test   %eax,%eax
80101e6c:	75 67                	jne    80101ed5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e6e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101e71:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e74:	85 ff                	test   %edi,%edi
80101e76:	74 29                	je     80101ea1 <dirlink+0x51>
80101e78:	31 ff                	xor    %edi,%edi
80101e7a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e7d:	eb 09                	jmp    80101e88 <dirlink+0x38>
80101e7f:	90                   	nop
80101e80:	83 c7 10             	add    $0x10,%edi
80101e83:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101e86:	73 19                	jae    80101ea1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e88:	6a 10                	push   $0x10
80101e8a:	57                   	push   %edi
80101e8b:	56                   	push   %esi
80101e8c:	53                   	push   %ebx
80101e8d:	e8 ee fa ff ff       	call   80101980 <readi>
80101e92:	83 c4 10             	add    $0x10,%esp
80101e95:	83 f8 10             	cmp    $0x10,%eax
80101e98:	75 4e                	jne    80101ee8 <dirlink+0x98>
    if(de.inum == 0)
80101e9a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e9f:	75 df                	jne    80101e80 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101ea1:	8d 45 da             	lea    -0x26(%ebp),%eax
80101ea4:	83 ec 04             	sub    $0x4,%esp
80101ea7:	6a 0e                	push   $0xe
80101ea9:	ff 75 0c             	pushl  0xc(%ebp)
80101eac:	50                   	push   %eax
80101ead:	e8 ee 2c 00 00       	call   80104ba0 <strncpy>
  de.inum = inum;
80101eb2:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101eb5:	6a 10                	push   $0x10
80101eb7:	57                   	push   %edi
80101eb8:	56                   	push   %esi
80101eb9:	53                   	push   %ebx
  de.inum = inum;
80101eba:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ebe:	e8 bd fb ff ff       	call   80101a80 <writei>
80101ec3:	83 c4 20             	add    $0x20,%esp
80101ec6:	83 f8 10             	cmp    $0x10,%eax
80101ec9:	75 2a                	jne    80101ef5 <dirlink+0xa5>
  return 0;
80101ecb:	31 c0                	xor    %eax,%eax
}
80101ecd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ed0:	5b                   	pop    %ebx
80101ed1:	5e                   	pop    %esi
80101ed2:	5f                   	pop    %edi
80101ed3:	5d                   	pop    %ebp
80101ed4:	c3                   	ret    
    iput(ip);
80101ed5:	83 ec 0c             	sub    $0xc,%esp
80101ed8:	50                   	push   %eax
80101ed9:	e8 e2 f8 ff ff       	call   801017c0 <iput>
    return -1;
80101ede:	83 c4 10             	add    $0x10,%esp
80101ee1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ee6:	eb e5                	jmp    80101ecd <dirlink+0x7d>
      panic("dirlink read");
80101ee8:	83 ec 0c             	sub    $0xc,%esp
80101eeb:	68 68 86 10 80       	push   $0x80108668
80101ef0:	e8 9b e4 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101ef5:	83 ec 0c             	sub    $0xc,%esp
80101ef8:	68 ca 8c 10 80       	push   $0x80108cca
80101efd:	e8 8e e4 ff ff       	call   80100390 <panic>
80101f02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f10 <namei>:

struct inode*
namei(char *path)
{
80101f10:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101f11:	31 d2                	xor    %edx,%edx
{
80101f13:	89 e5                	mov    %esp,%ebp
80101f15:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101f18:	8b 45 08             	mov    0x8(%ebp),%eax
80101f1b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101f1e:	e8 5d fd ff ff       	call   80101c80 <namex>
}
80101f23:	c9                   	leave  
80101f24:	c3                   	ret    
80101f25:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f30 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f30:	55                   	push   %ebp
  return namex(path, 1, name);
80101f31:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101f36:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f38:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f3b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f3e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101f3f:	e9 3c fd ff ff       	jmp    80101c80 <namex>
80101f44:	66 90                	xchg   %ax,%ax
80101f46:	66 90                	xchg   %ax,%ax
80101f48:	66 90                	xchg   %ax,%ax
80101f4a:	66 90                	xchg   %ax,%ax
80101f4c:	66 90                	xchg   %ax,%ax
80101f4e:	66 90                	xchg   %ax,%ax

80101f50 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f50:	55                   	push   %ebp
80101f51:	89 e5                	mov    %esp,%ebp
80101f53:	57                   	push   %edi
80101f54:	56                   	push   %esi
80101f55:	53                   	push   %ebx
80101f56:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80101f59:	85 c0                	test   %eax,%eax
80101f5b:	0f 84 b4 00 00 00    	je     80102015 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f61:	8b 58 08             	mov    0x8(%eax),%ebx
80101f64:	89 c6                	mov    %eax,%esi
80101f66:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f6c:	0f 87 96 00 00 00    	ja     80102008 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f72:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80101f77:	89 f6                	mov    %esi,%esi
80101f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101f80:	89 ca                	mov    %ecx,%edx
80101f82:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f83:	83 e0 c0             	and    $0xffffffc0,%eax
80101f86:	3c 40                	cmp    $0x40,%al
80101f88:	75 f6                	jne    80101f80 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f8a:	31 ff                	xor    %edi,%edi
80101f8c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f91:	89 f8                	mov    %edi,%eax
80101f93:	ee                   	out    %al,(%dx)
80101f94:	b8 01 00 00 00       	mov    $0x1,%eax
80101f99:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f9e:	ee                   	out    %al,(%dx)
80101f9f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101fa4:	89 d8                	mov    %ebx,%eax
80101fa6:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101fa7:	89 d8                	mov    %ebx,%eax
80101fa9:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101fae:	c1 f8 08             	sar    $0x8,%eax
80101fb1:	ee                   	out    %al,(%dx)
80101fb2:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101fb7:	89 f8                	mov    %edi,%eax
80101fb9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101fba:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80101fbe:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101fc3:	c1 e0 04             	shl    $0x4,%eax
80101fc6:	83 e0 10             	and    $0x10,%eax
80101fc9:	83 c8 e0             	or     $0xffffffe0,%eax
80101fcc:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101fcd:	f6 06 04             	testb  $0x4,(%esi)
80101fd0:	75 16                	jne    80101fe8 <idestart+0x98>
80101fd2:	b8 20 00 00 00       	mov    $0x20,%eax
80101fd7:	89 ca                	mov    %ecx,%edx
80101fd9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101fda:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fdd:	5b                   	pop    %ebx
80101fde:	5e                   	pop    %esi
80101fdf:	5f                   	pop    %edi
80101fe0:	5d                   	pop    %ebp
80101fe1:	c3                   	ret    
80101fe2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101fe8:	b8 30 00 00 00       	mov    $0x30,%eax
80101fed:	89 ca                	mov    %ecx,%edx
80101fef:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80101ff0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80101ff5:	83 c6 5c             	add    $0x5c,%esi
80101ff8:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101ffd:	fc                   	cld    
80101ffe:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102000:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102003:	5b                   	pop    %ebx
80102004:	5e                   	pop    %esi
80102005:	5f                   	pop    %edi
80102006:	5d                   	pop    %ebp
80102007:	c3                   	ret    
    panic("incorrect blockno");
80102008:	83 ec 0c             	sub    $0xc,%esp
8010200b:	68 d4 86 10 80       	push   $0x801086d4
80102010:	e8 7b e3 ff ff       	call   80100390 <panic>
    panic("idestart");
80102015:	83 ec 0c             	sub    $0xc,%esp
80102018:	68 cb 86 10 80       	push   $0x801086cb
8010201d:	e8 6e e3 ff ff       	call   80100390 <panic>
80102022:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102030 <ideinit>:
{
80102030:	55                   	push   %ebp
80102031:	89 e5                	mov    %esp,%ebp
80102033:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102036:	68 e6 86 10 80       	push   $0x801086e6
8010203b:	68 80 b5 10 80       	push   $0x8010b580
80102040:	e8 8b 27 00 00       	call   801047d0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102045:	58                   	pop    %eax
80102046:	a1 c0 b2 14 80       	mov    0x8014b2c0,%eax
8010204b:	5a                   	pop    %edx
8010204c:	83 e8 01             	sub    $0x1,%eax
8010204f:	50                   	push   %eax
80102050:	6a 0e                	push   $0xe
80102052:	e8 a9 02 00 00       	call   80102300 <ioapicenable>
80102057:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010205a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010205f:	90                   	nop
80102060:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102061:	83 e0 c0             	and    $0xffffffc0,%eax
80102064:	3c 40                	cmp    $0x40,%al
80102066:	75 f8                	jne    80102060 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102068:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010206d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102072:	ee                   	out    %al,(%dx)
80102073:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102078:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010207d:	eb 06                	jmp    80102085 <ideinit+0x55>
8010207f:	90                   	nop
  for(i=0; i<1000; i++){
80102080:	83 e9 01             	sub    $0x1,%ecx
80102083:	74 0f                	je     80102094 <ideinit+0x64>
80102085:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102086:	84 c0                	test   %al,%al
80102088:	74 f6                	je     80102080 <ideinit+0x50>
      havedisk1 = 1;
8010208a:	c7 05 60 b5 10 80 01 	movl   $0x1,0x8010b560
80102091:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102094:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102099:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010209e:	ee                   	out    %al,(%dx)
}
8010209f:	c9                   	leave  
801020a0:	c3                   	ret    
801020a1:	eb 0d                	jmp    801020b0 <ideintr>
801020a3:	90                   	nop
801020a4:	90                   	nop
801020a5:	90                   	nop
801020a6:	90                   	nop
801020a7:	90                   	nop
801020a8:	90                   	nop
801020a9:	90                   	nop
801020aa:	90                   	nop
801020ab:	90                   	nop
801020ac:	90                   	nop
801020ad:	90                   	nop
801020ae:	90                   	nop
801020af:	90                   	nop

801020b0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801020b0:	55                   	push   %ebp
801020b1:	89 e5                	mov    %esp,%ebp
801020b3:	57                   	push   %edi
801020b4:	56                   	push   %esi
801020b5:	53                   	push   %ebx
801020b6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801020b9:	68 80 b5 10 80       	push   $0x8010b580
801020be:	e8 4d 28 00 00       	call   80104910 <acquire>

  if((b = idequeue) == 0){
801020c3:	8b 1d 64 b5 10 80    	mov    0x8010b564,%ebx
801020c9:	83 c4 10             	add    $0x10,%esp
801020cc:	85 db                	test   %ebx,%ebx
801020ce:	74 67                	je     80102137 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801020d0:	8b 43 58             	mov    0x58(%ebx),%eax
801020d3:	a3 64 b5 10 80       	mov    %eax,0x8010b564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801020d8:	8b 3b                	mov    (%ebx),%edi
801020da:	f7 c7 04 00 00 00    	test   $0x4,%edi
801020e0:	75 31                	jne    80102113 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020e2:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020e7:	89 f6                	mov    %esi,%esi
801020e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801020f0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020f1:	89 c6                	mov    %eax,%esi
801020f3:	83 e6 c0             	and    $0xffffffc0,%esi
801020f6:	89 f1                	mov    %esi,%ecx
801020f8:	80 f9 40             	cmp    $0x40,%cl
801020fb:	75 f3                	jne    801020f0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801020fd:	a8 21                	test   $0x21,%al
801020ff:	75 12                	jne    80102113 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
80102101:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102104:	b9 80 00 00 00       	mov    $0x80,%ecx
80102109:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010210e:	fc                   	cld    
8010210f:	f3 6d                	rep insl (%dx),%es:(%edi)
80102111:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102113:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
80102116:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102119:	89 f9                	mov    %edi,%ecx
8010211b:	83 c9 02             	or     $0x2,%ecx
8010211e:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
80102120:	53                   	push   %ebx
80102121:	e8 0a 1f 00 00       	call   80104030 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102126:	a1 64 b5 10 80       	mov    0x8010b564,%eax
8010212b:	83 c4 10             	add    $0x10,%esp
8010212e:	85 c0                	test   %eax,%eax
80102130:	74 05                	je     80102137 <ideintr+0x87>
    idestart(idequeue);
80102132:	e8 19 fe ff ff       	call   80101f50 <idestart>
    release(&idelock);
80102137:	83 ec 0c             	sub    $0xc,%esp
8010213a:	68 80 b5 10 80       	push   $0x8010b580
8010213f:	e8 8c 28 00 00       	call   801049d0 <release>

  release(&idelock);
}
80102144:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102147:	5b                   	pop    %ebx
80102148:	5e                   	pop    %esi
80102149:	5f                   	pop    %edi
8010214a:	5d                   	pop    %ebp
8010214b:	c3                   	ret    
8010214c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102150 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102150:	55                   	push   %ebp
80102151:	89 e5                	mov    %esp,%ebp
80102153:	53                   	push   %ebx
80102154:	83 ec 10             	sub    $0x10,%esp
80102157:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010215a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010215d:	50                   	push   %eax
8010215e:	e8 1d 26 00 00       	call   80104780 <holdingsleep>
80102163:	83 c4 10             	add    $0x10,%esp
80102166:	85 c0                	test   %eax,%eax
80102168:	0f 84 c6 00 00 00    	je     80102234 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010216e:	8b 03                	mov    (%ebx),%eax
80102170:	83 e0 06             	and    $0x6,%eax
80102173:	83 f8 02             	cmp    $0x2,%eax
80102176:	0f 84 ab 00 00 00    	je     80102227 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010217c:	8b 53 04             	mov    0x4(%ebx),%edx
8010217f:	85 d2                	test   %edx,%edx
80102181:	74 0d                	je     80102190 <iderw+0x40>
80102183:	a1 60 b5 10 80       	mov    0x8010b560,%eax
80102188:	85 c0                	test   %eax,%eax
8010218a:	0f 84 b1 00 00 00    	je     80102241 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102190:	83 ec 0c             	sub    $0xc,%esp
80102193:	68 80 b5 10 80       	push   $0x8010b580
80102198:	e8 73 27 00 00       	call   80104910 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010219d:	8b 15 64 b5 10 80    	mov    0x8010b564,%edx
801021a3:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
801021a6:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021ad:	85 d2                	test   %edx,%edx
801021af:	75 09                	jne    801021ba <iderw+0x6a>
801021b1:	eb 6d                	jmp    80102220 <iderw+0xd0>
801021b3:	90                   	nop
801021b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801021b8:	89 c2                	mov    %eax,%edx
801021ba:	8b 42 58             	mov    0x58(%edx),%eax
801021bd:	85 c0                	test   %eax,%eax
801021bf:	75 f7                	jne    801021b8 <iderw+0x68>
801021c1:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801021c4:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801021c6:	39 1d 64 b5 10 80    	cmp    %ebx,0x8010b564
801021cc:	74 42                	je     80102210 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021ce:	8b 03                	mov    (%ebx),%eax
801021d0:	83 e0 06             	and    $0x6,%eax
801021d3:	83 f8 02             	cmp    $0x2,%eax
801021d6:	74 23                	je     801021fb <iderw+0xab>
801021d8:	90                   	nop
801021d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
801021e0:	83 ec 08             	sub    $0x8,%esp
801021e3:	68 80 b5 10 80       	push   $0x8010b580
801021e8:	53                   	push   %ebx
801021e9:	e8 82 1c 00 00       	call   80103e70 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021ee:	8b 03                	mov    (%ebx),%eax
801021f0:	83 c4 10             	add    $0x10,%esp
801021f3:	83 e0 06             	and    $0x6,%eax
801021f6:	83 f8 02             	cmp    $0x2,%eax
801021f9:	75 e5                	jne    801021e0 <iderw+0x90>
  }


  release(&idelock);
801021fb:	c7 45 08 80 b5 10 80 	movl   $0x8010b580,0x8(%ebp)
}
80102202:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102205:	c9                   	leave  
  release(&idelock);
80102206:	e9 c5 27 00 00       	jmp    801049d0 <release>
8010220b:	90                   	nop
8010220c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
80102210:	89 d8                	mov    %ebx,%eax
80102212:	e8 39 fd ff ff       	call   80101f50 <idestart>
80102217:	eb b5                	jmp    801021ce <iderw+0x7e>
80102219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102220:	ba 64 b5 10 80       	mov    $0x8010b564,%edx
80102225:	eb 9d                	jmp    801021c4 <iderw+0x74>
    panic("iderw: nothing to do");
80102227:	83 ec 0c             	sub    $0xc,%esp
8010222a:	68 00 87 10 80       	push   $0x80108700
8010222f:	e8 5c e1 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102234:	83 ec 0c             	sub    $0xc,%esp
80102237:	68 ea 86 10 80       	push   $0x801086ea
8010223c:	e8 4f e1 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102241:	83 ec 0c             	sub    $0xc,%esp
80102244:	68 15 87 10 80       	push   $0x80108715
80102249:	e8 42 e1 ff ff       	call   80100390 <panic>
8010224e:	66 90                	xchg   %ax,%ax

80102250 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102250:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102251:	c7 05 fc ab 14 80 00 	movl   $0xfec00000,0x8014abfc
80102258:	00 c0 fe 
{
8010225b:	89 e5                	mov    %esp,%ebp
8010225d:	56                   	push   %esi
8010225e:	53                   	push   %ebx
  ioapic->reg = reg;
8010225f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102266:	00 00 00 
  return ioapic->data;
80102269:	a1 fc ab 14 80       	mov    0x8014abfc,%eax
8010226e:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102271:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102277:	8b 0d fc ab 14 80    	mov    0x8014abfc,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010227d:	0f b6 15 20 ad 14 80 	movzbl 0x8014ad20,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102284:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
80102287:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
8010228a:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
8010228d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102290:	39 c2                	cmp    %eax,%edx
80102292:	74 16                	je     801022aa <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102294:	83 ec 0c             	sub    $0xc,%esp
80102297:	68 34 87 10 80       	push   $0x80108734
8010229c:	e8 bf e3 ff ff       	call   80100660 <cprintf>
801022a1:	8b 0d fc ab 14 80    	mov    0x8014abfc,%ecx
801022a7:	83 c4 10             	add    $0x10,%esp
801022aa:	83 c3 21             	add    $0x21,%ebx
{
801022ad:	ba 10 00 00 00       	mov    $0x10,%edx
801022b2:	b8 20 00 00 00       	mov    $0x20,%eax
801022b7:	89 f6                	mov    %esi,%esi
801022b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
801022c0:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
801022c2:	8b 0d fc ab 14 80    	mov    0x8014abfc,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801022c8:	89 c6                	mov    %eax,%esi
801022ca:	81 ce 00 00 01 00    	or     $0x10000,%esi
801022d0:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022d3:	89 71 10             	mov    %esi,0x10(%ecx)
801022d6:	8d 72 01             	lea    0x1(%edx),%esi
801022d9:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
801022dc:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
801022de:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
801022e0:	8b 0d fc ab 14 80    	mov    0x8014abfc,%ecx
801022e6:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801022ed:	75 d1                	jne    801022c0 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801022ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022f2:	5b                   	pop    %ebx
801022f3:	5e                   	pop    %esi
801022f4:	5d                   	pop    %ebp
801022f5:	c3                   	ret    
801022f6:	8d 76 00             	lea    0x0(%esi),%esi
801022f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102300 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102300:	55                   	push   %ebp
  ioapic->reg = reg;
80102301:	8b 0d fc ab 14 80    	mov    0x8014abfc,%ecx
{
80102307:	89 e5                	mov    %esp,%ebp
80102309:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010230c:	8d 50 20             	lea    0x20(%eax),%edx
8010230f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102313:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102315:	8b 0d fc ab 14 80    	mov    0x8014abfc,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010231b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010231e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102321:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102324:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102326:	a1 fc ab 14 80       	mov    0x8014abfc,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010232b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010232e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102331:	5d                   	pop    %ebp
80102332:	c3                   	ret    
80102333:	66 90                	xchg   %ax,%ax
80102335:	66 90                	xchg   %ax,%ax
80102337:	66 90                	xchg   %ax,%ax
80102339:	66 90                	xchg   %ax,%ax
8010233b:	66 90                	xchg   %ax,%ax
8010233d:	66 90                	xchg   %ax,%ax
8010233f:	90                   	nop

80102340 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102340:	55                   	push   %ebp
80102341:	89 e5                	mov    %esp,%ebp
80102343:	53                   	push   %ebx
80102344:	83 ec 04             	sub    $0x4,%esp
80102347:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010234a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102350:	75 70                	jne    801023c2 <kfree+0x82>
80102352:	81 fb 68 2f 15 80    	cmp    $0x80152f68,%ebx
80102358:	72 68                	jb     801023c2 <kfree+0x82>
8010235a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102360:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102365:	77 5b                	ja     801023c2 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102367:	83 ec 04             	sub    $0x4,%esp
8010236a:	68 00 10 00 00       	push   $0x1000
8010236f:	6a 01                	push   $0x1
80102371:	53                   	push   %ebx
80102372:	e8 a9 26 00 00       	call   80104a20 <memset>

  if(kmem.use_lock)
80102377:	8b 15 34 ac 14 80    	mov    0x8014ac34,%edx
8010237d:	83 c4 10             	add    $0x10,%esp
80102380:	85 d2                	test   %edx,%edx
80102382:	75 2c                	jne    801023b0 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102384:	a1 38 ac 14 80       	mov    0x8014ac38,%eax
80102389:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010238b:	a1 34 ac 14 80       	mov    0x8014ac34,%eax
  kmem.freelist = r;
80102390:	89 1d 38 ac 14 80    	mov    %ebx,0x8014ac38
  if(kmem.use_lock)
80102396:	85 c0                	test   %eax,%eax
80102398:	75 06                	jne    801023a0 <kfree+0x60>
    release(&kmem.lock);
}
8010239a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010239d:	c9                   	leave  
8010239e:	c3                   	ret    
8010239f:	90                   	nop
    release(&kmem.lock);
801023a0:	c7 45 08 00 ac 14 80 	movl   $0x8014ac00,0x8(%ebp)
}
801023a7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801023aa:	c9                   	leave  
    release(&kmem.lock);
801023ab:	e9 20 26 00 00       	jmp    801049d0 <release>
    acquire(&kmem.lock);
801023b0:	83 ec 0c             	sub    $0xc,%esp
801023b3:	68 00 ac 14 80       	push   $0x8014ac00
801023b8:	e8 53 25 00 00       	call   80104910 <acquire>
801023bd:	83 c4 10             	add    $0x10,%esp
801023c0:	eb c2                	jmp    80102384 <kfree+0x44>
    panic("kfree");
801023c2:	83 ec 0c             	sub    $0xc,%esp
801023c5:	68 66 87 10 80       	push   $0x80108766
801023ca:	e8 c1 df ff ff       	call   80100390 <panic>
801023cf:	90                   	nop

801023d0 <freerange>:
{
801023d0:	55                   	push   %ebp
801023d1:	89 e5                	mov    %esp,%ebp
801023d3:	56                   	push   %esi
801023d4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801023d5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801023d8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801023db:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023e1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023e7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023ed:	39 de                	cmp    %ebx,%esi
801023ef:	72 23                	jb     80102414 <freerange+0x44>
801023f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801023f8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023fe:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102401:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102407:	50                   	push   %eax
80102408:	e8 33 ff ff ff       	call   80102340 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010240d:	83 c4 10             	add    $0x10,%esp
80102410:	39 f3                	cmp    %esi,%ebx
80102412:	76 e4                	jbe    801023f8 <freerange+0x28>
}
80102414:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102417:	5b                   	pop    %ebx
80102418:	5e                   	pop    %esi
80102419:	5d                   	pop    %ebp
8010241a:	c3                   	ret    
8010241b:	90                   	nop
8010241c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102420 <kinit1>:
{
80102420:	55                   	push   %ebp
80102421:	89 e5                	mov    %esp,%ebp
80102423:	56                   	push   %esi
80102424:	53                   	push   %ebx
80102425:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102428:	83 ec 08             	sub    $0x8,%esp
8010242b:	68 6c 87 10 80       	push   $0x8010876c
80102430:	68 00 ac 14 80       	push   $0x8014ac00
80102435:	e8 96 23 00 00       	call   801047d0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010243a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010243d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102440:	c7 05 34 ac 14 80 00 	movl   $0x0,0x8014ac34
80102447:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010244a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102450:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102456:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010245c:	39 de                	cmp    %ebx,%esi
8010245e:	72 1c                	jb     8010247c <kinit1+0x5c>
    kfree(p);
80102460:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102466:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102469:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010246f:	50                   	push   %eax
80102470:	e8 cb fe ff ff       	call   80102340 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102475:	83 c4 10             	add    $0x10,%esp
80102478:	39 de                	cmp    %ebx,%esi
8010247a:	73 e4                	jae    80102460 <kinit1+0x40>
}
8010247c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010247f:	5b                   	pop    %ebx
80102480:	5e                   	pop    %esi
80102481:	5d                   	pop    %ebp
80102482:	c3                   	ret    
80102483:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102490 <kinit2>:
{
80102490:	55                   	push   %ebp
80102491:	89 e5                	mov    %esp,%ebp
80102493:	56                   	push   %esi
80102494:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102495:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102498:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010249b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801024a1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024a7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801024ad:	39 de                	cmp    %ebx,%esi
801024af:	72 23                	jb     801024d4 <kinit2+0x44>
801024b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801024b8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801024be:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024c1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024c7:	50                   	push   %eax
801024c8:	e8 73 fe ff ff       	call   80102340 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024cd:	83 c4 10             	add    $0x10,%esp
801024d0:	39 de                	cmp    %ebx,%esi
801024d2:	73 e4                	jae    801024b8 <kinit2+0x28>
  kmem.use_lock = 1;
801024d4:	c7 05 34 ac 14 80 01 	movl   $0x1,0x8014ac34
801024db:	00 00 00 
}
801024de:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024e1:	5b                   	pop    %ebx
801024e2:	5e                   	pop    %esi
801024e3:	5d                   	pop    %ebp
801024e4:	c3                   	ret    
801024e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024f0 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
801024f0:	a1 34 ac 14 80       	mov    0x8014ac34,%eax
801024f5:	85 c0                	test   %eax,%eax
801024f7:	75 1f                	jne    80102518 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801024f9:	a1 38 ac 14 80       	mov    0x8014ac38,%eax
  if(r)
801024fe:	85 c0                	test   %eax,%eax
80102500:	74 0e                	je     80102510 <kalloc+0x20>
    kmem.freelist = r->next;
80102502:	8b 10                	mov    (%eax),%edx
80102504:	89 15 38 ac 14 80    	mov    %edx,0x8014ac38
8010250a:	c3                   	ret    
8010250b:	90                   	nop
8010250c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102510:	f3 c3                	repz ret 
80102512:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
80102518:	55                   	push   %ebp
80102519:	89 e5                	mov    %esp,%ebp
8010251b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
8010251e:	68 00 ac 14 80       	push   $0x8014ac00
80102523:	e8 e8 23 00 00       	call   80104910 <acquire>
  r = kmem.freelist;
80102528:	a1 38 ac 14 80       	mov    0x8014ac38,%eax
  if(r)
8010252d:	83 c4 10             	add    $0x10,%esp
80102530:	8b 15 34 ac 14 80    	mov    0x8014ac34,%edx
80102536:	85 c0                	test   %eax,%eax
80102538:	74 08                	je     80102542 <kalloc+0x52>
    kmem.freelist = r->next;
8010253a:	8b 08                	mov    (%eax),%ecx
8010253c:	89 0d 38 ac 14 80    	mov    %ecx,0x8014ac38
  if(kmem.use_lock)
80102542:	85 d2                	test   %edx,%edx
80102544:	74 16                	je     8010255c <kalloc+0x6c>
    release(&kmem.lock);
80102546:	83 ec 0c             	sub    $0xc,%esp
80102549:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010254c:	68 00 ac 14 80       	push   $0x8014ac00
80102551:	e8 7a 24 00 00       	call   801049d0 <release>
  return (char*)r;
80102556:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102559:	83 c4 10             	add    $0x10,%esp
}
8010255c:	c9                   	leave  
8010255d:	c3                   	ret    
8010255e:	66 90                	xchg   %ax,%ax

80102560 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102560:	ba 64 00 00 00       	mov    $0x64,%edx
80102565:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102566:	a8 01                	test   $0x1,%al
80102568:	0f 84 c2 00 00 00    	je     80102630 <kbdgetc+0xd0>
8010256e:	ba 60 00 00 00       	mov    $0x60,%edx
80102573:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102574:	0f b6 d0             	movzbl %al,%edx
80102577:	8b 0d b4 b5 10 80    	mov    0x8010b5b4,%ecx

  if(data == 0xE0){
8010257d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102583:	0f 84 7f 00 00 00    	je     80102608 <kbdgetc+0xa8>
{
80102589:	55                   	push   %ebp
8010258a:	89 e5                	mov    %esp,%ebp
8010258c:	53                   	push   %ebx
8010258d:	89 cb                	mov    %ecx,%ebx
8010258f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102592:	84 c0                	test   %al,%al
80102594:	78 4a                	js     801025e0 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102596:	85 db                	test   %ebx,%ebx
80102598:	74 09                	je     801025a3 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010259a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
8010259d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
801025a0:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
801025a3:	0f b6 82 a0 88 10 80 	movzbl -0x7fef7760(%edx),%eax
801025aa:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
801025ac:	0f b6 82 a0 87 10 80 	movzbl -0x7fef7860(%edx),%eax
801025b3:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801025b5:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
801025b7:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
  c = charcode[shift & (CTL | SHIFT)][data];
801025bd:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801025c0:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801025c3:	8b 04 85 80 87 10 80 	mov    -0x7fef7880(,%eax,4),%eax
801025ca:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
801025ce:	74 31                	je     80102601 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
801025d0:	8d 50 9f             	lea    -0x61(%eax),%edx
801025d3:	83 fa 19             	cmp    $0x19,%edx
801025d6:	77 40                	ja     80102618 <kbdgetc+0xb8>
      c += 'A' - 'a';
801025d8:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025db:	5b                   	pop    %ebx
801025dc:	5d                   	pop    %ebp
801025dd:	c3                   	ret    
801025de:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
801025e0:	83 e0 7f             	and    $0x7f,%eax
801025e3:	85 db                	test   %ebx,%ebx
801025e5:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
801025e8:	0f b6 82 a0 88 10 80 	movzbl -0x7fef7760(%edx),%eax
801025ef:	83 c8 40             	or     $0x40,%eax
801025f2:	0f b6 c0             	movzbl %al,%eax
801025f5:	f7 d0                	not    %eax
801025f7:	21 c1                	and    %eax,%ecx
    return 0;
801025f9:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801025fb:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
}
80102601:	5b                   	pop    %ebx
80102602:	5d                   	pop    %ebp
80102603:	c3                   	ret    
80102604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
80102608:	83 c9 40             	or     $0x40,%ecx
    return 0;
8010260b:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
8010260d:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
    return 0;
80102613:	c3                   	ret    
80102614:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102618:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010261b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010261e:	5b                   	pop    %ebx
      c += 'a' - 'A';
8010261f:	83 f9 1a             	cmp    $0x1a,%ecx
80102622:	0f 42 c2             	cmovb  %edx,%eax
}
80102625:	5d                   	pop    %ebp
80102626:	c3                   	ret    
80102627:	89 f6                	mov    %esi,%esi
80102629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102630:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102635:	c3                   	ret    
80102636:	8d 76 00             	lea    0x0(%esi),%esi
80102639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102640 <kbdintr>:

void
kbdintr(void)
{
80102640:	55                   	push   %ebp
80102641:	89 e5                	mov    %esp,%ebp
80102643:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102646:	68 60 25 10 80       	push   $0x80102560
8010264b:	e8 c0 e1 ff ff       	call   80100810 <consoleintr>
}
80102650:	83 c4 10             	add    $0x10,%esp
80102653:	c9                   	leave  
80102654:	c3                   	ret    
80102655:	66 90                	xchg   %ax,%ax
80102657:	66 90                	xchg   %ax,%ax
80102659:	66 90                	xchg   %ax,%ax
8010265b:	66 90                	xchg   %ax,%ax
8010265d:	66 90                	xchg   %ax,%ax
8010265f:	90                   	nop

80102660 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102660:	a1 3c ac 14 80       	mov    0x8014ac3c,%eax
{
80102665:	55                   	push   %ebp
80102666:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102668:	85 c0                	test   %eax,%eax
8010266a:	0f 84 c8 00 00 00    	je     80102738 <lapicinit+0xd8>
  lapic[index] = value;
80102670:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102677:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010267a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010267d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102684:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102687:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010268a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102691:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102694:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102697:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010269e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801026a1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026a4:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801026ab:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026ae:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026b1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801026b8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026bb:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801026be:	8b 50 30             	mov    0x30(%eax),%edx
801026c1:	c1 ea 10             	shr    $0x10,%edx
801026c4:	80 fa 03             	cmp    $0x3,%dl
801026c7:	77 77                	ja     80102740 <lapicinit+0xe0>
  lapic[index] = value;
801026c9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801026d0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026d3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026d6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026dd:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026e0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026e3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026ea:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026ed:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026f0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801026f7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026fa:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026fd:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102704:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102707:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010270a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102711:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102714:	8b 50 20             	mov    0x20(%eax),%edx
80102717:	89 f6                	mov    %esi,%esi
80102719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102720:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102726:	80 e6 10             	and    $0x10,%dh
80102729:	75 f5                	jne    80102720 <lapicinit+0xc0>
  lapic[index] = value;
8010272b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102732:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102735:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102738:	5d                   	pop    %ebp
80102739:	c3                   	ret    
8010273a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102740:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102747:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010274a:	8b 50 20             	mov    0x20(%eax),%edx
8010274d:	e9 77 ff ff ff       	jmp    801026c9 <lapicinit+0x69>
80102752:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102760 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102760:	8b 15 3c ac 14 80    	mov    0x8014ac3c,%edx
{
80102766:	55                   	push   %ebp
80102767:	31 c0                	xor    %eax,%eax
80102769:	89 e5                	mov    %esp,%ebp
  if (!lapic)
8010276b:	85 d2                	test   %edx,%edx
8010276d:	74 06                	je     80102775 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
8010276f:	8b 42 20             	mov    0x20(%edx),%eax
80102772:	c1 e8 18             	shr    $0x18,%eax
}
80102775:	5d                   	pop    %ebp
80102776:	c3                   	ret    
80102777:	89 f6                	mov    %esi,%esi
80102779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102780 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102780:	a1 3c ac 14 80       	mov    0x8014ac3c,%eax
{
80102785:	55                   	push   %ebp
80102786:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102788:	85 c0                	test   %eax,%eax
8010278a:	74 0d                	je     80102799 <lapiceoi+0x19>
  lapic[index] = value;
8010278c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102793:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102796:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102799:	5d                   	pop    %ebp
8010279a:	c3                   	ret    
8010279b:	90                   	nop
8010279c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801027a0 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
801027a0:	55                   	push   %ebp
801027a1:	89 e5                	mov    %esp,%ebp
}
801027a3:	5d                   	pop    %ebp
801027a4:	c3                   	ret    
801027a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801027a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027b0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801027b0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801027b1:	b8 0f 00 00 00       	mov    $0xf,%eax
801027b6:	ba 70 00 00 00       	mov    $0x70,%edx
801027bb:	89 e5                	mov    %esp,%ebp
801027bd:	53                   	push   %ebx
801027be:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801027c1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801027c4:	ee                   	out    %al,(%dx)
801027c5:	b8 0a 00 00 00       	mov    $0xa,%eax
801027ca:	ba 71 00 00 00       	mov    $0x71,%edx
801027cf:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801027d0:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801027d2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
801027d5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801027db:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801027dd:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
801027e0:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
801027e3:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
801027e5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
801027e8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
801027ee:	a1 3c ac 14 80       	mov    0x8014ac3c,%eax
801027f3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027f9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027fc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102803:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102806:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102809:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102810:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102813:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102816:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010281c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010281f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102825:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102828:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010282e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102831:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102837:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010283a:	5b                   	pop    %ebx
8010283b:	5d                   	pop    %ebp
8010283c:	c3                   	ret    
8010283d:	8d 76 00             	lea    0x0(%esi),%esi

80102840 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102840:	55                   	push   %ebp
80102841:	b8 0b 00 00 00       	mov    $0xb,%eax
80102846:	ba 70 00 00 00       	mov    $0x70,%edx
8010284b:	89 e5                	mov    %esp,%ebp
8010284d:	57                   	push   %edi
8010284e:	56                   	push   %esi
8010284f:	53                   	push   %ebx
80102850:	83 ec 4c             	sub    $0x4c,%esp
80102853:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102854:	ba 71 00 00 00       	mov    $0x71,%edx
80102859:	ec                   	in     (%dx),%al
8010285a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010285d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102862:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102865:	8d 76 00             	lea    0x0(%esi),%esi
80102868:	31 c0                	xor    %eax,%eax
8010286a:	89 da                	mov    %ebx,%edx
8010286c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010286d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102872:	89 ca                	mov    %ecx,%edx
80102874:	ec                   	in     (%dx),%al
80102875:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102878:	89 da                	mov    %ebx,%edx
8010287a:	b8 02 00 00 00       	mov    $0x2,%eax
8010287f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102880:	89 ca                	mov    %ecx,%edx
80102882:	ec                   	in     (%dx),%al
80102883:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102886:	89 da                	mov    %ebx,%edx
80102888:	b8 04 00 00 00       	mov    $0x4,%eax
8010288d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010288e:	89 ca                	mov    %ecx,%edx
80102890:	ec                   	in     (%dx),%al
80102891:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102894:	89 da                	mov    %ebx,%edx
80102896:	b8 07 00 00 00       	mov    $0x7,%eax
8010289b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010289c:	89 ca                	mov    %ecx,%edx
8010289e:	ec                   	in     (%dx),%al
8010289f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028a2:	89 da                	mov    %ebx,%edx
801028a4:	b8 08 00 00 00       	mov    $0x8,%eax
801028a9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028aa:	89 ca                	mov    %ecx,%edx
801028ac:	ec                   	in     (%dx),%al
801028ad:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028af:	89 da                	mov    %ebx,%edx
801028b1:	b8 09 00 00 00       	mov    $0x9,%eax
801028b6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028b7:	89 ca                	mov    %ecx,%edx
801028b9:	ec                   	in     (%dx),%al
801028ba:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028bc:	89 da                	mov    %ebx,%edx
801028be:	b8 0a 00 00 00       	mov    $0xa,%eax
801028c3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028c4:	89 ca                	mov    %ecx,%edx
801028c6:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801028c7:	84 c0                	test   %al,%al
801028c9:	78 9d                	js     80102868 <cmostime+0x28>
  return inb(CMOS_RETURN);
801028cb:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
801028cf:	89 fa                	mov    %edi,%edx
801028d1:	0f b6 fa             	movzbl %dl,%edi
801028d4:	89 f2                	mov    %esi,%edx
801028d6:	0f b6 f2             	movzbl %dl,%esi
801028d9:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028dc:	89 da                	mov    %ebx,%edx
801028de:	89 75 cc             	mov    %esi,-0x34(%ebp)
801028e1:	89 45 b8             	mov    %eax,-0x48(%ebp)
801028e4:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
801028e8:	89 45 bc             	mov    %eax,-0x44(%ebp)
801028eb:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
801028ef:	89 45 c0             	mov    %eax,-0x40(%ebp)
801028f2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801028f6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801028f9:	31 c0                	xor    %eax,%eax
801028fb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028fc:	89 ca                	mov    %ecx,%edx
801028fe:	ec                   	in     (%dx),%al
801028ff:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102902:	89 da                	mov    %ebx,%edx
80102904:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102907:	b8 02 00 00 00       	mov    $0x2,%eax
8010290c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010290d:	89 ca                	mov    %ecx,%edx
8010290f:	ec                   	in     (%dx),%al
80102910:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102913:	89 da                	mov    %ebx,%edx
80102915:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102918:	b8 04 00 00 00       	mov    $0x4,%eax
8010291d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010291e:	89 ca                	mov    %ecx,%edx
80102920:	ec                   	in     (%dx),%al
80102921:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102924:	89 da                	mov    %ebx,%edx
80102926:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102929:	b8 07 00 00 00       	mov    $0x7,%eax
8010292e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010292f:	89 ca                	mov    %ecx,%edx
80102931:	ec                   	in     (%dx),%al
80102932:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102935:	89 da                	mov    %ebx,%edx
80102937:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010293a:	b8 08 00 00 00       	mov    $0x8,%eax
8010293f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102940:	89 ca                	mov    %ecx,%edx
80102942:	ec                   	in     (%dx),%al
80102943:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102946:	89 da                	mov    %ebx,%edx
80102948:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010294b:	b8 09 00 00 00       	mov    $0x9,%eax
80102950:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102951:	89 ca                	mov    %ecx,%edx
80102953:	ec                   	in     (%dx),%al
80102954:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102957:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
8010295a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010295d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102960:	6a 18                	push   $0x18
80102962:	50                   	push   %eax
80102963:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102966:	50                   	push   %eax
80102967:	e8 04 21 00 00       	call   80104a70 <memcmp>
8010296c:	83 c4 10             	add    $0x10,%esp
8010296f:	85 c0                	test   %eax,%eax
80102971:	0f 85 f1 fe ff ff    	jne    80102868 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102977:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
8010297b:	75 78                	jne    801029f5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010297d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102980:	89 c2                	mov    %eax,%edx
80102982:	83 e0 0f             	and    $0xf,%eax
80102985:	c1 ea 04             	shr    $0x4,%edx
80102988:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010298b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010298e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102991:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102994:	89 c2                	mov    %eax,%edx
80102996:	83 e0 0f             	and    $0xf,%eax
80102999:	c1 ea 04             	shr    $0x4,%edx
8010299c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010299f:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029a2:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
801029a5:	8b 45 c0             	mov    -0x40(%ebp),%eax
801029a8:	89 c2                	mov    %eax,%edx
801029aa:	83 e0 0f             	and    $0xf,%eax
801029ad:	c1 ea 04             	shr    $0x4,%edx
801029b0:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029b3:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029b6:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
801029b9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029bc:	89 c2                	mov    %eax,%edx
801029be:	83 e0 0f             	and    $0xf,%eax
801029c1:	c1 ea 04             	shr    $0x4,%edx
801029c4:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029c7:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029ca:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
801029cd:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029d0:	89 c2                	mov    %eax,%edx
801029d2:	83 e0 0f             	and    $0xf,%eax
801029d5:	c1 ea 04             	shr    $0x4,%edx
801029d8:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029db:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029de:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801029e1:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029e4:	89 c2                	mov    %eax,%edx
801029e6:	83 e0 0f             	and    $0xf,%eax
801029e9:	c1 ea 04             	shr    $0x4,%edx
801029ec:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029ef:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029f2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
801029f5:	8b 75 08             	mov    0x8(%ebp),%esi
801029f8:	8b 45 b8             	mov    -0x48(%ebp),%eax
801029fb:	89 06                	mov    %eax,(%esi)
801029fd:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a00:	89 46 04             	mov    %eax,0x4(%esi)
80102a03:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a06:	89 46 08             	mov    %eax,0x8(%esi)
80102a09:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a0c:	89 46 0c             	mov    %eax,0xc(%esi)
80102a0f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a12:	89 46 10             	mov    %eax,0x10(%esi)
80102a15:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a18:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102a1b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102a22:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a25:	5b                   	pop    %ebx
80102a26:	5e                   	pop    %esi
80102a27:	5f                   	pop    %edi
80102a28:	5d                   	pop    %ebp
80102a29:	c3                   	ret    
80102a2a:	66 90                	xchg   %ax,%ax
80102a2c:	66 90                	xchg   %ax,%ax
80102a2e:	66 90                	xchg   %ax,%ax

80102a30 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a30:	8b 0d 88 ac 14 80    	mov    0x8014ac88,%ecx
80102a36:	85 c9                	test   %ecx,%ecx
80102a38:	0f 8e 8a 00 00 00    	jle    80102ac8 <install_trans+0x98>
{
80102a3e:	55                   	push   %ebp
80102a3f:	89 e5                	mov    %esp,%ebp
80102a41:	57                   	push   %edi
80102a42:	56                   	push   %esi
80102a43:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102a44:	31 db                	xor    %ebx,%ebx
{
80102a46:	83 ec 0c             	sub    $0xc,%esp
80102a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102a50:	a1 74 ac 14 80       	mov    0x8014ac74,%eax
80102a55:	83 ec 08             	sub    $0x8,%esp
80102a58:	01 d8                	add    %ebx,%eax
80102a5a:	83 c0 01             	add    $0x1,%eax
80102a5d:	50                   	push   %eax
80102a5e:	ff 35 84 ac 14 80    	pushl  0x8014ac84
80102a64:	e8 67 d6 ff ff       	call   801000d0 <bread>
80102a69:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a6b:	58                   	pop    %eax
80102a6c:	5a                   	pop    %edx
80102a6d:	ff 34 9d 8c ac 14 80 	pushl  -0x7feb5374(,%ebx,4)
80102a74:	ff 35 84 ac 14 80    	pushl  0x8014ac84
  for (tail = 0; tail < log.lh.n; tail++) {
80102a7a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a7d:	e8 4e d6 ff ff       	call   801000d0 <bread>
80102a82:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102a84:	8d 47 5c             	lea    0x5c(%edi),%eax
80102a87:	83 c4 0c             	add    $0xc,%esp
80102a8a:	68 00 02 00 00       	push   $0x200
80102a8f:	50                   	push   %eax
80102a90:	8d 46 5c             	lea    0x5c(%esi),%eax
80102a93:	50                   	push   %eax
80102a94:	e8 37 20 00 00       	call   80104ad0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102a99:	89 34 24             	mov    %esi,(%esp)
80102a9c:	e8 ff d6 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102aa1:	89 3c 24             	mov    %edi,(%esp)
80102aa4:	e8 37 d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102aa9:	89 34 24             	mov    %esi,(%esp)
80102aac:	e8 2f d7 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102ab1:	83 c4 10             	add    $0x10,%esp
80102ab4:	39 1d 88 ac 14 80    	cmp    %ebx,0x8014ac88
80102aba:	7f 94                	jg     80102a50 <install_trans+0x20>
  }
}
80102abc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102abf:	5b                   	pop    %ebx
80102ac0:	5e                   	pop    %esi
80102ac1:	5f                   	pop    %edi
80102ac2:	5d                   	pop    %ebp
80102ac3:	c3                   	ret    
80102ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102ac8:	f3 c3                	repz ret 
80102aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102ad0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102ad0:	55                   	push   %ebp
80102ad1:	89 e5                	mov    %esp,%ebp
80102ad3:	56                   	push   %esi
80102ad4:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102ad5:	83 ec 08             	sub    $0x8,%esp
80102ad8:	ff 35 74 ac 14 80    	pushl  0x8014ac74
80102ade:	ff 35 84 ac 14 80    	pushl  0x8014ac84
80102ae4:	e8 e7 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102ae9:	8b 1d 88 ac 14 80    	mov    0x8014ac88,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102aef:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102af2:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102af4:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102af6:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102af9:	7e 16                	jle    80102b11 <write_head+0x41>
80102afb:	c1 e3 02             	shl    $0x2,%ebx
80102afe:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102b00:	8b 8a 8c ac 14 80    	mov    -0x7feb5374(%edx),%ecx
80102b06:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102b0a:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102b0d:	39 da                	cmp    %ebx,%edx
80102b0f:	75 ef                	jne    80102b00 <write_head+0x30>
  }
  bwrite(buf);
80102b11:	83 ec 0c             	sub    $0xc,%esp
80102b14:	56                   	push   %esi
80102b15:	e8 86 d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102b1a:	89 34 24             	mov    %esi,(%esp)
80102b1d:	e8 be d6 ff ff       	call   801001e0 <brelse>
}
80102b22:	83 c4 10             	add    $0x10,%esp
80102b25:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b28:	5b                   	pop    %ebx
80102b29:	5e                   	pop    %esi
80102b2a:	5d                   	pop    %ebp
80102b2b:	c3                   	ret    
80102b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102b30 <initlog>:
{
80102b30:	55                   	push   %ebp
80102b31:	89 e5                	mov    %esp,%ebp
80102b33:	53                   	push   %ebx
80102b34:	83 ec 2c             	sub    $0x2c,%esp
80102b37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102b3a:	68 a0 89 10 80       	push   $0x801089a0
80102b3f:	68 40 ac 14 80       	push   $0x8014ac40
80102b44:	e8 87 1c 00 00       	call   801047d0 <initlock>
  readsb(dev, &sb);
80102b49:	58                   	pop    %eax
80102b4a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102b4d:	5a                   	pop    %edx
80102b4e:	50                   	push   %eax
80102b4f:	53                   	push   %ebx
80102b50:	e8 7b e8 ff ff       	call   801013d0 <readsb>
  log.size = sb.nlog;
80102b55:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102b58:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102b5b:	59                   	pop    %ecx
  log.dev = dev;
80102b5c:	89 1d 84 ac 14 80    	mov    %ebx,0x8014ac84
  log.size = sb.nlog;
80102b62:	89 15 78 ac 14 80    	mov    %edx,0x8014ac78
  log.start = sb.logstart;
80102b68:	a3 74 ac 14 80       	mov    %eax,0x8014ac74
  struct buf *buf = bread(log.dev, log.start);
80102b6d:	5a                   	pop    %edx
80102b6e:	50                   	push   %eax
80102b6f:	53                   	push   %ebx
80102b70:	e8 5b d5 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102b75:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102b78:	83 c4 10             	add    $0x10,%esp
80102b7b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102b7d:	89 1d 88 ac 14 80    	mov    %ebx,0x8014ac88
  for (i = 0; i < log.lh.n; i++) {
80102b83:	7e 1c                	jle    80102ba1 <initlog+0x71>
80102b85:	c1 e3 02             	shl    $0x2,%ebx
80102b88:	31 d2                	xor    %edx,%edx
80102b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102b90:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102b94:	83 c2 04             	add    $0x4,%edx
80102b97:	89 8a 88 ac 14 80    	mov    %ecx,-0x7feb5378(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102b9d:	39 d3                	cmp    %edx,%ebx
80102b9f:	75 ef                	jne    80102b90 <initlog+0x60>
  brelse(buf);
80102ba1:	83 ec 0c             	sub    $0xc,%esp
80102ba4:	50                   	push   %eax
80102ba5:	e8 36 d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102baa:	e8 81 fe ff ff       	call   80102a30 <install_trans>
  log.lh.n = 0;
80102baf:	c7 05 88 ac 14 80 00 	movl   $0x0,0x8014ac88
80102bb6:	00 00 00 
  write_head(); // clear the log
80102bb9:	e8 12 ff ff ff       	call   80102ad0 <write_head>
}
80102bbe:	83 c4 10             	add    $0x10,%esp
80102bc1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102bc4:	c9                   	leave  
80102bc5:	c3                   	ret    
80102bc6:	8d 76 00             	lea    0x0(%esi),%esi
80102bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102bd0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102bd0:	55                   	push   %ebp
80102bd1:	89 e5                	mov    %esp,%ebp
80102bd3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102bd6:	68 40 ac 14 80       	push   $0x8014ac40
80102bdb:	e8 30 1d 00 00       	call   80104910 <acquire>
80102be0:	83 c4 10             	add    $0x10,%esp
80102be3:	eb 18                	jmp    80102bfd <begin_op+0x2d>
80102be5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102be8:	83 ec 08             	sub    $0x8,%esp
80102beb:	68 40 ac 14 80       	push   $0x8014ac40
80102bf0:	68 40 ac 14 80       	push   $0x8014ac40
80102bf5:	e8 76 12 00 00       	call   80103e70 <sleep>
80102bfa:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102bfd:	a1 80 ac 14 80       	mov    0x8014ac80,%eax
80102c02:	85 c0                	test   %eax,%eax
80102c04:	75 e2                	jne    80102be8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102c06:	a1 7c ac 14 80       	mov    0x8014ac7c,%eax
80102c0b:	8b 15 88 ac 14 80    	mov    0x8014ac88,%edx
80102c11:	83 c0 01             	add    $0x1,%eax
80102c14:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102c17:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102c1a:	83 fa 1e             	cmp    $0x1e,%edx
80102c1d:	7f c9                	jg     80102be8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102c1f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102c22:	a3 7c ac 14 80       	mov    %eax,0x8014ac7c
      release(&log.lock);
80102c27:	68 40 ac 14 80       	push   $0x8014ac40
80102c2c:	e8 9f 1d 00 00       	call   801049d0 <release>
      break;
    }
  }
}
80102c31:	83 c4 10             	add    $0x10,%esp
80102c34:	c9                   	leave  
80102c35:	c3                   	ret    
80102c36:	8d 76 00             	lea    0x0(%esi),%esi
80102c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c40 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102c40:	55                   	push   %ebp
80102c41:	89 e5                	mov    %esp,%ebp
80102c43:	57                   	push   %edi
80102c44:	56                   	push   %esi
80102c45:	53                   	push   %ebx
80102c46:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102c49:	68 40 ac 14 80       	push   $0x8014ac40
80102c4e:	e8 bd 1c 00 00       	call   80104910 <acquire>
  log.outstanding -= 1;
80102c53:	a1 7c ac 14 80       	mov    0x8014ac7c,%eax
  if(log.committing)
80102c58:	8b 35 80 ac 14 80    	mov    0x8014ac80,%esi
80102c5e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102c61:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102c64:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102c66:	89 1d 7c ac 14 80    	mov    %ebx,0x8014ac7c
  if(log.committing)
80102c6c:	0f 85 1a 01 00 00    	jne    80102d8c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80102c72:	85 db                	test   %ebx,%ebx
80102c74:	0f 85 ee 00 00 00    	jne    80102d68 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102c7a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102c7d:	c7 05 80 ac 14 80 01 	movl   $0x1,0x8014ac80
80102c84:	00 00 00 
  release(&log.lock);
80102c87:	68 40 ac 14 80       	push   $0x8014ac40
80102c8c:	e8 3f 1d 00 00       	call   801049d0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c91:	8b 0d 88 ac 14 80    	mov    0x8014ac88,%ecx
80102c97:	83 c4 10             	add    $0x10,%esp
80102c9a:	85 c9                	test   %ecx,%ecx
80102c9c:	0f 8e 85 00 00 00    	jle    80102d27 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102ca2:	a1 74 ac 14 80       	mov    0x8014ac74,%eax
80102ca7:	83 ec 08             	sub    $0x8,%esp
80102caa:	01 d8                	add    %ebx,%eax
80102cac:	83 c0 01             	add    $0x1,%eax
80102caf:	50                   	push   %eax
80102cb0:	ff 35 84 ac 14 80    	pushl  0x8014ac84
80102cb6:	e8 15 d4 ff ff       	call   801000d0 <bread>
80102cbb:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102cbd:	58                   	pop    %eax
80102cbe:	5a                   	pop    %edx
80102cbf:	ff 34 9d 8c ac 14 80 	pushl  -0x7feb5374(,%ebx,4)
80102cc6:	ff 35 84 ac 14 80    	pushl  0x8014ac84
  for (tail = 0; tail < log.lh.n; tail++) {
80102ccc:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102ccf:	e8 fc d3 ff ff       	call   801000d0 <bread>
80102cd4:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102cd6:	8d 40 5c             	lea    0x5c(%eax),%eax
80102cd9:	83 c4 0c             	add    $0xc,%esp
80102cdc:	68 00 02 00 00       	push   $0x200
80102ce1:	50                   	push   %eax
80102ce2:	8d 46 5c             	lea    0x5c(%esi),%eax
80102ce5:	50                   	push   %eax
80102ce6:	e8 e5 1d 00 00       	call   80104ad0 <memmove>
    bwrite(to);  // write the log
80102ceb:	89 34 24             	mov    %esi,(%esp)
80102cee:	e8 ad d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102cf3:	89 3c 24             	mov    %edi,(%esp)
80102cf6:	e8 e5 d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102cfb:	89 34 24             	mov    %esi,(%esp)
80102cfe:	e8 dd d4 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102d03:	83 c4 10             	add    $0x10,%esp
80102d06:	3b 1d 88 ac 14 80    	cmp    0x8014ac88,%ebx
80102d0c:	7c 94                	jl     80102ca2 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102d0e:	e8 bd fd ff ff       	call   80102ad0 <write_head>
    install_trans(); // Now install writes to home locations
80102d13:	e8 18 fd ff ff       	call   80102a30 <install_trans>
    log.lh.n = 0;
80102d18:	c7 05 88 ac 14 80 00 	movl   $0x0,0x8014ac88
80102d1f:	00 00 00 
    write_head();    // Erase the transaction from the log
80102d22:	e8 a9 fd ff ff       	call   80102ad0 <write_head>
    acquire(&log.lock);
80102d27:	83 ec 0c             	sub    $0xc,%esp
80102d2a:	68 40 ac 14 80       	push   $0x8014ac40
80102d2f:	e8 dc 1b 00 00       	call   80104910 <acquire>
    wakeup(&log);
80102d34:	c7 04 24 40 ac 14 80 	movl   $0x8014ac40,(%esp)
    log.committing = 0;
80102d3b:	c7 05 80 ac 14 80 00 	movl   $0x0,0x8014ac80
80102d42:	00 00 00 
    wakeup(&log);
80102d45:	e8 e6 12 00 00       	call   80104030 <wakeup>
    release(&log.lock);
80102d4a:	c7 04 24 40 ac 14 80 	movl   $0x8014ac40,(%esp)
80102d51:	e8 7a 1c 00 00       	call   801049d0 <release>
80102d56:	83 c4 10             	add    $0x10,%esp
}
80102d59:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d5c:	5b                   	pop    %ebx
80102d5d:	5e                   	pop    %esi
80102d5e:	5f                   	pop    %edi
80102d5f:	5d                   	pop    %ebp
80102d60:	c3                   	ret    
80102d61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80102d68:	83 ec 0c             	sub    $0xc,%esp
80102d6b:	68 40 ac 14 80       	push   $0x8014ac40
80102d70:	e8 bb 12 00 00       	call   80104030 <wakeup>
  release(&log.lock);
80102d75:	c7 04 24 40 ac 14 80 	movl   $0x8014ac40,(%esp)
80102d7c:	e8 4f 1c 00 00       	call   801049d0 <release>
80102d81:	83 c4 10             	add    $0x10,%esp
}
80102d84:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d87:	5b                   	pop    %ebx
80102d88:	5e                   	pop    %esi
80102d89:	5f                   	pop    %edi
80102d8a:	5d                   	pop    %ebp
80102d8b:	c3                   	ret    
    panic("log.committing");
80102d8c:	83 ec 0c             	sub    $0xc,%esp
80102d8f:	68 a4 89 10 80       	push   $0x801089a4
80102d94:	e8 f7 d5 ff ff       	call   80100390 <panic>
80102d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102da0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102da0:	55                   	push   %ebp
80102da1:	89 e5                	mov    %esp,%ebp
80102da3:	53                   	push   %ebx
80102da4:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102da7:	8b 15 88 ac 14 80    	mov    0x8014ac88,%edx
{
80102dad:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102db0:	83 fa 1d             	cmp    $0x1d,%edx
80102db3:	0f 8f 9d 00 00 00    	jg     80102e56 <log_write+0xb6>
80102db9:	a1 78 ac 14 80       	mov    0x8014ac78,%eax
80102dbe:	83 e8 01             	sub    $0x1,%eax
80102dc1:	39 c2                	cmp    %eax,%edx
80102dc3:	0f 8d 8d 00 00 00    	jge    80102e56 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102dc9:	a1 7c ac 14 80       	mov    0x8014ac7c,%eax
80102dce:	85 c0                	test   %eax,%eax
80102dd0:	0f 8e 8d 00 00 00    	jle    80102e63 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102dd6:	83 ec 0c             	sub    $0xc,%esp
80102dd9:	68 40 ac 14 80       	push   $0x8014ac40
80102dde:	e8 2d 1b 00 00       	call   80104910 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102de3:	8b 0d 88 ac 14 80    	mov    0x8014ac88,%ecx
80102de9:	83 c4 10             	add    $0x10,%esp
80102dec:	83 f9 00             	cmp    $0x0,%ecx
80102def:	7e 57                	jle    80102e48 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102df1:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102df4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102df6:	3b 15 8c ac 14 80    	cmp    0x8014ac8c,%edx
80102dfc:	75 0b                	jne    80102e09 <log_write+0x69>
80102dfe:	eb 38                	jmp    80102e38 <log_write+0x98>
80102e00:	39 14 85 8c ac 14 80 	cmp    %edx,-0x7feb5374(,%eax,4)
80102e07:	74 2f                	je     80102e38 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102e09:	83 c0 01             	add    $0x1,%eax
80102e0c:	39 c1                	cmp    %eax,%ecx
80102e0e:	75 f0                	jne    80102e00 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102e10:	89 14 85 8c ac 14 80 	mov    %edx,-0x7feb5374(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102e17:	83 c0 01             	add    $0x1,%eax
80102e1a:	a3 88 ac 14 80       	mov    %eax,0x8014ac88
  b->flags |= B_DIRTY; // prevent eviction
80102e1f:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102e22:	c7 45 08 40 ac 14 80 	movl   $0x8014ac40,0x8(%ebp)
}
80102e29:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e2c:	c9                   	leave  
  release(&log.lock);
80102e2d:	e9 9e 1b 00 00       	jmp    801049d0 <release>
80102e32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102e38:	89 14 85 8c ac 14 80 	mov    %edx,-0x7feb5374(,%eax,4)
80102e3f:	eb de                	jmp    80102e1f <log_write+0x7f>
80102e41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e48:	8b 43 08             	mov    0x8(%ebx),%eax
80102e4b:	a3 8c ac 14 80       	mov    %eax,0x8014ac8c
  if (i == log.lh.n)
80102e50:	75 cd                	jne    80102e1f <log_write+0x7f>
80102e52:	31 c0                	xor    %eax,%eax
80102e54:	eb c1                	jmp    80102e17 <log_write+0x77>
    panic("too big a transaction");
80102e56:	83 ec 0c             	sub    $0xc,%esp
80102e59:	68 b3 89 10 80       	push   $0x801089b3
80102e5e:	e8 2d d5 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102e63:	83 ec 0c             	sub    $0xc,%esp
80102e66:	68 c9 89 10 80       	push   $0x801089c9
80102e6b:	e8 20 d5 ff ff       	call   80100390 <panic>

80102e70 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102e70:	55                   	push   %ebp
80102e71:	89 e5                	mov    %esp,%ebp
80102e73:	53                   	push   %ebx
80102e74:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102e77:	e8 74 09 00 00       	call   801037f0 <cpuid>
80102e7c:	89 c3                	mov    %eax,%ebx
80102e7e:	e8 6d 09 00 00       	call   801037f0 <cpuid>
80102e83:	83 ec 04             	sub    $0x4,%esp
80102e86:	53                   	push   %ebx
80102e87:	50                   	push   %eax
80102e88:	68 e4 89 10 80       	push   $0x801089e4
80102e8d:	e8 ce d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102e92:	e8 79 3e 00 00       	call   80106d10 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102e97:	e8 d4 08 00 00       	call   80103770 <mycpu>
80102e9c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e9e:	b8 01 00 00 00       	mov    $0x1,%eax
80102ea3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102eaa:	e8 31 0c 00 00       	call   80103ae0 <scheduler>
80102eaf:	90                   	nop

80102eb0 <mpenter>:
{
80102eb0:	55                   	push   %ebp
80102eb1:	89 e5                	mov    %esp,%ebp
80102eb3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102eb6:	e8 45 4f 00 00       	call   80107e00 <switchkvm>
  seginit();
80102ebb:	e8 b0 4e 00 00       	call   80107d70 <seginit>
  lapicinit();
80102ec0:	e8 9b f7 ff ff       	call   80102660 <lapicinit>
  mpmain();
80102ec5:	e8 a6 ff ff ff       	call   80102e70 <mpmain>
80102eca:	66 90                	xchg   %ax,%ax
80102ecc:	66 90                	xchg   %ax,%ax
80102ece:	66 90                	xchg   %ax,%ax

80102ed0 <main>:
{
80102ed0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102ed4:	83 e4 f0             	and    $0xfffffff0,%esp
80102ed7:	ff 71 fc             	pushl  -0x4(%ecx)
80102eda:	55                   	push   %ebp
80102edb:	89 e5                	mov    %esp,%ebp
80102edd:	53                   	push   %ebx
80102ede:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102edf:	83 ec 08             	sub    $0x8,%esp
80102ee2:	68 00 00 40 80       	push   $0x80400000
80102ee7:	68 68 2f 15 80       	push   $0x80152f68
80102eec:	e8 2f f5 ff ff       	call   80102420 <kinit1>
  kvmalloc();      // kernel page table
80102ef1:	e8 da 53 00 00       	call   801082d0 <kvmalloc>
  mpinit();        // detect other processors
80102ef6:	e8 75 01 00 00       	call   80103070 <mpinit>
  lapicinit();     // interrupt controller
80102efb:	e8 60 f7 ff ff       	call   80102660 <lapicinit>
  seginit();       // segment descriptors
80102f00:	e8 6b 4e 00 00       	call   80107d70 <seginit>
  picinit();       // disable pic
80102f05:	e8 46 03 00 00       	call   80103250 <picinit>
  ioapicinit();    // another interrupt controller
80102f0a:	e8 41 f3 ff ff       	call   80102250 <ioapicinit>
  consoleinit();   // console hardware
80102f0f:	e8 ac da ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80102f14:	e8 27 41 00 00       	call   80107040 <uartinit>
  pinit();         // process table
80102f19:	e8 32 08 00 00       	call   80103750 <pinit>
  tvinit();        // trap vectors
80102f1e:	e8 6d 3d 00 00       	call   80106c90 <tvinit>
  binit();         // buffer cache
80102f23:	e8 18 d1 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102f28:	e8 33 de ff ff       	call   80100d60 <fileinit>
  ideinit();       // disk 
80102f2d:	e8 fe f0 ff ff       	call   80102030 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102f32:	83 c4 0c             	add    $0xc,%esp
80102f35:	68 8a 00 00 00       	push   $0x8a
80102f3a:	68 8c b4 10 80       	push   $0x8010b48c
80102f3f:	68 00 70 00 80       	push   $0x80007000
80102f44:	e8 87 1b 00 00       	call   80104ad0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102f49:	69 05 c0 b2 14 80 b0 	imul   $0xb0,0x8014b2c0,%eax
80102f50:	00 00 00 
80102f53:	83 c4 10             	add    $0x10,%esp
80102f56:	05 40 ad 14 80       	add    $0x8014ad40,%eax
80102f5b:	3d 40 ad 14 80       	cmp    $0x8014ad40,%eax
80102f60:	76 71                	jbe    80102fd3 <main+0x103>
80102f62:	bb 40 ad 14 80       	mov    $0x8014ad40,%ebx
80102f67:	89 f6                	mov    %esi,%esi
80102f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80102f70:	e8 fb 07 00 00       	call   80103770 <mycpu>
80102f75:	39 d8                	cmp    %ebx,%eax
80102f77:	74 41                	je     80102fba <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102f79:	e8 72 f5 ff ff       	call   801024f0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f7e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80102f83:	c7 05 f8 6f 00 80 b0 	movl   $0x80102eb0,0x80006ff8
80102f8a:	2e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102f8d:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80102f94:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f97:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
80102f9c:	0f b6 03             	movzbl (%ebx),%eax
80102f9f:	83 ec 08             	sub    $0x8,%esp
80102fa2:	68 00 70 00 00       	push   $0x7000
80102fa7:	50                   	push   %eax
80102fa8:	e8 03 f8 ff ff       	call   801027b0 <lapicstartap>
80102fad:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102fb0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102fb6:	85 c0                	test   %eax,%eax
80102fb8:	74 f6                	je     80102fb0 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
80102fba:	69 05 c0 b2 14 80 b0 	imul   $0xb0,0x8014b2c0,%eax
80102fc1:	00 00 00 
80102fc4:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102fca:	05 40 ad 14 80       	add    $0x8014ad40,%eax
80102fcf:	39 c3                	cmp    %eax,%ebx
80102fd1:	72 9d                	jb     80102f70 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102fd3:	83 ec 08             	sub    $0x8,%esp
80102fd6:	68 00 00 00 8e       	push   $0x8e000000
80102fdb:	68 00 00 40 80       	push   $0x80400000
80102fe0:	e8 ab f4 ff ff       	call   80102490 <kinit2>
  userinit();      // first user process
80102fe5:	e8 56 08 00 00       	call   80103840 <userinit>
  mpmain();        // finish this processor's setup
80102fea:	e8 81 fe ff ff       	call   80102e70 <mpmain>
80102fef:	90                   	nop

80102ff0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102ff0:	55                   	push   %ebp
80102ff1:	89 e5                	mov    %esp,%ebp
80102ff3:	57                   	push   %edi
80102ff4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102ff5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80102ffb:	53                   	push   %ebx
  e = addr+len;
80102ffc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80102fff:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103002:	39 de                	cmp    %ebx,%esi
80103004:	72 10                	jb     80103016 <mpsearch1+0x26>
80103006:	eb 50                	jmp    80103058 <mpsearch1+0x68>
80103008:	90                   	nop
80103009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103010:	39 fb                	cmp    %edi,%ebx
80103012:	89 fe                	mov    %edi,%esi
80103014:	76 42                	jbe    80103058 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103016:	83 ec 04             	sub    $0x4,%esp
80103019:	8d 7e 10             	lea    0x10(%esi),%edi
8010301c:	6a 04                	push   $0x4
8010301e:	68 f8 89 10 80       	push   $0x801089f8
80103023:	56                   	push   %esi
80103024:	e8 47 1a 00 00       	call   80104a70 <memcmp>
80103029:	83 c4 10             	add    $0x10,%esp
8010302c:	85 c0                	test   %eax,%eax
8010302e:	75 e0                	jne    80103010 <mpsearch1+0x20>
80103030:	89 f1                	mov    %esi,%ecx
80103032:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103038:	0f b6 11             	movzbl (%ecx),%edx
8010303b:	83 c1 01             	add    $0x1,%ecx
8010303e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
80103040:	39 f9                	cmp    %edi,%ecx
80103042:	75 f4                	jne    80103038 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103044:	84 c0                	test   %al,%al
80103046:	75 c8                	jne    80103010 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103048:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010304b:	89 f0                	mov    %esi,%eax
8010304d:	5b                   	pop    %ebx
8010304e:	5e                   	pop    %esi
8010304f:	5f                   	pop    %edi
80103050:	5d                   	pop    %ebp
80103051:	c3                   	ret    
80103052:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103058:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010305b:	31 f6                	xor    %esi,%esi
}
8010305d:	89 f0                	mov    %esi,%eax
8010305f:	5b                   	pop    %ebx
80103060:	5e                   	pop    %esi
80103061:	5f                   	pop    %edi
80103062:	5d                   	pop    %ebp
80103063:	c3                   	ret    
80103064:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010306a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103070 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103070:	55                   	push   %ebp
80103071:	89 e5                	mov    %esp,%ebp
80103073:	57                   	push   %edi
80103074:	56                   	push   %esi
80103075:	53                   	push   %ebx
80103076:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103079:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103080:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103087:	c1 e0 08             	shl    $0x8,%eax
8010308a:	09 d0                	or     %edx,%eax
8010308c:	c1 e0 04             	shl    $0x4,%eax
8010308f:	85 c0                	test   %eax,%eax
80103091:	75 1b                	jne    801030ae <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103093:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010309a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801030a1:	c1 e0 08             	shl    $0x8,%eax
801030a4:	09 d0                	or     %edx,%eax
801030a6:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801030a9:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
801030ae:	ba 00 04 00 00       	mov    $0x400,%edx
801030b3:	e8 38 ff ff ff       	call   80102ff0 <mpsearch1>
801030b8:	85 c0                	test   %eax,%eax
801030ba:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801030bd:	0f 84 3d 01 00 00    	je     80103200 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801030c3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801030c6:	8b 58 04             	mov    0x4(%eax),%ebx
801030c9:	85 db                	test   %ebx,%ebx
801030cb:	0f 84 4f 01 00 00    	je     80103220 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801030d1:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
801030d7:	83 ec 04             	sub    $0x4,%esp
801030da:	6a 04                	push   $0x4
801030dc:	68 15 8a 10 80       	push   $0x80108a15
801030e1:	56                   	push   %esi
801030e2:	e8 89 19 00 00       	call   80104a70 <memcmp>
801030e7:	83 c4 10             	add    $0x10,%esp
801030ea:	85 c0                	test   %eax,%eax
801030ec:	0f 85 2e 01 00 00    	jne    80103220 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
801030f2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801030f9:	3c 01                	cmp    $0x1,%al
801030fb:	0f 95 c2             	setne  %dl
801030fe:	3c 04                	cmp    $0x4,%al
80103100:	0f 95 c0             	setne  %al
80103103:	20 c2                	and    %al,%dl
80103105:	0f 85 15 01 00 00    	jne    80103220 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
8010310b:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
80103112:	66 85 ff             	test   %di,%di
80103115:	74 1a                	je     80103131 <mpinit+0xc1>
80103117:	89 f0                	mov    %esi,%eax
80103119:	01 f7                	add    %esi,%edi
  sum = 0;
8010311b:	31 d2                	xor    %edx,%edx
8010311d:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103120:	0f b6 08             	movzbl (%eax),%ecx
80103123:	83 c0 01             	add    $0x1,%eax
80103126:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103128:	39 c7                	cmp    %eax,%edi
8010312a:	75 f4                	jne    80103120 <mpinit+0xb0>
8010312c:	84 d2                	test   %dl,%dl
8010312e:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103131:	85 f6                	test   %esi,%esi
80103133:	0f 84 e7 00 00 00    	je     80103220 <mpinit+0x1b0>
80103139:	84 d2                	test   %dl,%dl
8010313b:	0f 85 df 00 00 00    	jne    80103220 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103141:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103147:	a3 3c ac 14 80       	mov    %eax,0x8014ac3c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010314c:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103153:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103159:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010315e:	01 d6                	add    %edx,%esi
80103160:	39 c6                	cmp    %eax,%esi
80103162:	76 23                	jbe    80103187 <mpinit+0x117>
    switch(*p){
80103164:	0f b6 10             	movzbl (%eax),%edx
80103167:	80 fa 04             	cmp    $0x4,%dl
8010316a:	0f 87 ca 00 00 00    	ja     8010323a <mpinit+0x1ca>
80103170:	ff 24 95 3c 8a 10 80 	jmp    *-0x7fef75c4(,%edx,4)
80103177:	89 f6                	mov    %esi,%esi
80103179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103180:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103183:	39 c6                	cmp    %eax,%esi
80103185:	77 dd                	ja     80103164 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103187:	85 db                	test   %ebx,%ebx
80103189:	0f 84 9e 00 00 00    	je     8010322d <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010318f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103192:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103196:	74 15                	je     801031ad <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103198:	b8 70 00 00 00       	mov    $0x70,%eax
8010319d:	ba 22 00 00 00       	mov    $0x22,%edx
801031a2:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801031a3:	ba 23 00 00 00       	mov    $0x23,%edx
801031a8:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801031a9:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801031ac:	ee                   	out    %al,(%dx)
  }
}
801031ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031b0:	5b                   	pop    %ebx
801031b1:	5e                   	pop    %esi
801031b2:	5f                   	pop    %edi
801031b3:	5d                   	pop    %ebp
801031b4:	c3                   	ret    
801031b5:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
801031b8:	8b 0d c0 b2 14 80    	mov    0x8014b2c0,%ecx
801031be:	83 f9 07             	cmp    $0x7,%ecx
801031c1:	7f 19                	jg     801031dc <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031c3:	0f b6 50 01          	movzbl 0x1(%eax),%edx
801031c7:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
801031cd:	83 c1 01             	add    $0x1,%ecx
801031d0:	89 0d c0 b2 14 80    	mov    %ecx,0x8014b2c0
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031d6:	88 97 40 ad 14 80    	mov    %dl,-0x7feb52c0(%edi)
      p += sizeof(struct mpproc);
801031dc:	83 c0 14             	add    $0x14,%eax
      continue;
801031df:	e9 7c ff ff ff       	jmp    80103160 <mpinit+0xf0>
801031e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
801031e8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801031ec:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801031ef:	88 15 20 ad 14 80    	mov    %dl,0x8014ad20
      continue;
801031f5:	e9 66 ff ff ff       	jmp    80103160 <mpinit+0xf0>
801031fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
80103200:	ba 00 00 01 00       	mov    $0x10000,%edx
80103205:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010320a:	e8 e1 fd ff ff       	call   80102ff0 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010320f:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
80103211:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103214:	0f 85 a9 fe ff ff    	jne    801030c3 <mpinit+0x53>
8010321a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103220:	83 ec 0c             	sub    $0xc,%esp
80103223:	68 fd 89 10 80       	push   $0x801089fd
80103228:	e8 63 d1 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010322d:	83 ec 0c             	sub    $0xc,%esp
80103230:	68 1c 8a 10 80       	push   $0x80108a1c
80103235:	e8 56 d1 ff ff       	call   80100390 <panic>
      ismp = 0;
8010323a:	31 db                	xor    %ebx,%ebx
8010323c:	e9 26 ff ff ff       	jmp    80103167 <mpinit+0xf7>
80103241:	66 90                	xchg   %ax,%ax
80103243:	66 90                	xchg   %ax,%ax
80103245:	66 90                	xchg   %ax,%ax
80103247:	66 90                	xchg   %ax,%ax
80103249:	66 90                	xchg   %ax,%ax
8010324b:	66 90                	xchg   %ax,%ax
8010324d:	66 90                	xchg   %ax,%ax
8010324f:	90                   	nop

80103250 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103250:	55                   	push   %ebp
80103251:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103256:	ba 21 00 00 00       	mov    $0x21,%edx
8010325b:	89 e5                	mov    %esp,%ebp
8010325d:	ee                   	out    %al,(%dx)
8010325e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103263:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103264:	5d                   	pop    %ebp
80103265:	c3                   	ret    
80103266:	66 90                	xchg   %ax,%ax
80103268:	66 90                	xchg   %ax,%ax
8010326a:	66 90                	xchg   %ax,%ax
8010326c:	66 90                	xchg   %ax,%ax
8010326e:	66 90                	xchg   %ax,%ax

80103270 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103270:	55                   	push   %ebp
80103271:	89 e5                	mov    %esp,%ebp
80103273:	57                   	push   %edi
80103274:	56                   	push   %esi
80103275:	53                   	push   %ebx
80103276:	83 ec 0c             	sub    $0xc,%esp
80103279:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010327c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010327f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103285:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010328b:	e8 f0 da ff ff       	call   80100d80 <filealloc>
80103290:	85 c0                	test   %eax,%eax
80103292:	89 03                	mov    %eax,(%ebx)
80103294:	74 22                	je     801032b8 <pipealloc+0x48>
80103296:	e8 e5 da ff ff       	call   80100d80 <filealloc>
8010329b:	85 c0                	test   %eax,%eax
8010329d:	89 06                	mov    %eax,(%esi)
8010329f:	74 3f                	je     801032e0 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801032a1:	e8 4a f2 ff ff       	call   801024f0 <kalloc>
801032a6:	85 c0                	test   %eax,%eax
801032a8:	89 c7                	mov    %eax,%edi
801032aa:	75 54                	jne    80103300 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801032ac:	8b 03                	mov    (%ebx),%eax
801032ae:	85 c0                	test   %eax,%eax
801032b0:	75 34                	jne    801032e6 <pipealloc+0x76>
801032b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
801032b8:	8b 06                	mov    (%esi),%eax
801032ba:	85 c0                	test   %eax,%eax
801032bc:	74 0c                	je     801032ca <pipealloc+0x5a>
    fileclose(*f1);
801032be:	83 ec 0c             	sub    $0xc,%esp
801032c1:	50                   	push   %eax
801032c2:	e8 79 db ff ff       	call   80100e40 <fileclose>
801032c7:	83 c4 10             	add    $0x10,%esp
  return -1;
}
801032ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801032cd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801032d2:	5b                   	pop    %ebx
801032d3:	5e                   	pop    %esi
801032d4:	5f                   	pop    %edi
801032d5:	5d                   	pop    %ebp
801032d6:	c3                   	ret    
801032d7:	89 f6                	mov    %esi,%esi
801032d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
801032e0:	8b 03                	mov    (%ebx),%eax
801032e2:	85 c0                	test   %eax,%eax
801032e4:	74 e4                	je     801032ca <pipealloc+0x5a>
    fileclose(*f0);
801032e6:	83 ec 0c             	sub    $0xc,%esp
801032e9:	50                   	push   %eax
801032ea:	e8 51 db ff ff       	call   80100e40 <fileclose>
  if(*f1)
801032ef:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
801032f1:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801032f4:	85 c0                	test   %eax,%eax
801032f6:	75 c6                	jne    801032be <pipealloc+0x4e>
801032f8:	eb d0                	jmp    801032ca <pipealloc+0x5a>
801032fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
80103300:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
80103303:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010330a:	00 00 00 
  p->writeopen = 1;
8010330d:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103314:	00 00 00 
  p->nwrite = 0;
80103317:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010331e:	00 00 00 
  p->nread = 0;
80103321:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103328:	00 00 00 
  initlock(&p->lock, "pipe");
8010332b:	68 50 8a 10 80       	push   $0x80108a50
80103330:	50                   	push   %eax
80103331:	e8 9a 14 00 00       	call   801047d0 <initlock>
  (*f0)->type = FD_PIPE;
80103336:	8b 03                	mov    (%ebx),%eax
  return 0;
80103338:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
8010333b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103341:	8b 03                	mov    (%ebx),%eax
80103343:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103347:	8b 03                	mov    (%ebx),%eax
80103349:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010334d:	8b 03                	mov    (%ebx),%eax
8010334f:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103352:	8b 06                	mov    (%esi),%eax
80103354:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010335a:	8b 06                	mov    (%esi),%eax
8010335c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103360:	8b 06                	mov    (%esi),%eax
80103362:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103366:	8b 06                	mov    (%esi),%eax
80103368:	89 78 0c             	mov    %edi,0xc(%eax)
}
8010336b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010336e:	31 c0                	xor    %eax,%eax
}
80103370:	5b                   	pop    %ebx
80103371:	5e                   	pop    %esi
80103372:	5f                   	pop    %edi
80103373:	5d                   	pop    %ebp
80103374:	c3                   	ret    
80103375:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103380 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103380:	55                   	push   %ebp
80103381:	89 e5                	mov    %esp,%ebp
80103383:	56                   	push   %esi
80103384:	53                   	push   %ebx
80103385:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103388:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010338b:	83 ec 0c             	sub    $0xc,%esp
8010338e:	53                   	push   %ebx
8010338f:	e8 7c 15 00 00       	call   80104910 <acquire>
  if(writable){
80103394:	83 c4 10             	add    $0x10,%esp
80103397:	85 f6                	test   %esi,%esi
80103399:	74 45                	je     801033e0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010339b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801033a1:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
801033a4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801033ab:	00 00 00 
    wakeup(&p->nread);
801033ae:	50                   	push   %eax
801033af:	e8 7c 0c 00 00       	call   80104030 <wakeup>
801033b4:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801033b7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801033bd:	85 d2                	test   %edx,%edx
801033bf:	75 0a                	jne    801033cb <pipeclose+0x4b>
801033c1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801033c7:	85 c0                	test   %eax,%eax
801033c9:	74 35                	je     80103400 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801033cb:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801033ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801033d1:	5b                   	pop    %ebx
801033d2:	5e                   	pop    %esi
801033d3:	5d                   	pop    %ebp
    release(&p->lock);
801033d4:	e9 f7 15 00 00       	jmp    801049d0 <release>
801033d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801033e0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801033e6:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
801033e9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801033f0:	00 00 00 
    wakeup(&p->nwrite);
801033f3:	50                   	push   %eax
801033f4:	e8 37 0c 00 00       	call   80104030 <wakeup>
801033f9:	83 c4 10             	add    $0x10,%esp
801033fc:	eb b9                	jmp    801033b7 <pipeclose+0x37>
801033fe:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103400:	83 ec 0c             	sub    $0xc,%esp
80103403:	53                   	push   %ebx
80103404:	e8 c7 15 00 00       	call   801049d0 <release>
    kfree((char*)p);
80103409:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010340c:	83 c4 10             	add    $0x10,%esp
}
8010340f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103412:	5b                   	pop    %ebx
80103413:	5e                   	pop    %esi
80103414:	5d                   	pop    %ebp
    kfree((char*)p);
80103415:	e9 26 ef ff ff       	jmp    80102340 <kfree>
8010341a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103420 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103420:	55                   	push   %ebp
80103421:	89 e5                	mov    %esp,%ebp
80103423:	57                   	push   %edi
80103424:	56                   	push   %esi
80103425:	53                   	push   %ebx
80103426:	83 ec 28             	sub    $0x28,%esp
80103429:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010342c:	53                   	push   %ebx
8010342d:	e8 de 14 00 00       	call   80104910 <acquire>
  for(i = 0; i < n; i++){
80103432:	8b 45 10             	mov    0x10(%ebp),%eax
80103435:	83 c4 10             	add    $0x10,%esp
80103438:	85 c0                	test   %eax,%eax
8010343a:	0f 8e c9 00 00 00    	jle    80103509 <pipewrite+0xe9>
80103440:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103443:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103449:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010344f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103452:	03 4d 10             	add    0x10(%ebp),%ecx
80103455:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103458:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010345e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103464:	39 d0                	cmp    %edx,%eax
80103466:	75 71                	jne    801034d9 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103468:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010346e:	85 c0                	test   %eax,%eax
80103470:	74 4e                	je     801034c0 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103472:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103478:	eb 3a                	jmp    801034b4 <pipewrite+0x94>
8010347a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103480:	83 ec 0c             	sub    $0xc,%esp
80103483:	57                   	push   %edi
80103484:	e8 a7 0b 00 00       	call   80104030 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103489:	5a                   	pop    %edx
8010348a:	59                   	pop    %ecx
8010348b:	53                   	push   %ebx
8010348c:	56                   	push   %esi
8010348d:	e8 de 09 00 00       	call   80103e70 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103492:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103498:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010349e:	83 c4 10             	add    $0x10,%esp
801034a1:	05 00 02 00 00       	add    $0x200,%eax
801034a6:	39 c2                	cmp    %eax,%edx
801034a8:	75 36                	jne    801034e0 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
801034aa:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801034b0:	85 c0                	test   %eax,%eax
801034b2:	74 0c                	je     801034c0 <pipewrite+0xa0>
801034b4:	e8 57 03 00 00       	call   80103810 <myproc>
801034b9:	8b 40 24             	mov    0x24(%eax),%eax
801034bc:	85 c0                	test   %eax,%eax
801034be:	74 c0                	je     80103480 <pipewrite+0x60>
        release(&p->lock);
801034c0:	83 ec 0c             	sub    $0xc,%esp
801034c3:	53                   	push   %ebx
801034c4:	e8 07 15 00 00       	call   801049d0 <release>
        return -1;
801034c9:	83 c4 10             	add    $0x10,%esp
801034cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801034d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801034d4:	5b                   	pop    %ebx
801034d5:	5e                   	pop    %esi
801034d6:	5f                   	pop    %edi
801034d7:	5d                   	pop    %ebp
801034d8:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801034d9:	89 c2                	mov    %eax,%edx
801034db:	90                   	nop
801034dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034e0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801034e3:	8d 42 01             	lea    0x1(%edx),%eax
801034e6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801034ec:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801034f2:	83 c6 01             	add    $0x1,%esi
801034f5:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
801034f9:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801034fc:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034ff:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103503:	0f 85 4f ff ff ff    	jne    80103458 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103509:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010350f:	83 ec 0c             	sub    $0xc,%esp
80103512:	50                   	push   %eax
80103513:	e8 18 0b 00 00       	call   80104030 <wakeup>
  release(&p->lock);
80103518:	89 1c 24             	mov    %ebx,(%esp)
8010351b:	e8 b0 14 00 00       	call   801049d0 <release>
  return n;
80103520:	83 c4 10             	add    $0x10,%esp
80103523:	8b 45 10             	mov    0x10(%ebp),%eax
80103526:	eb a9                	jmp    801034d1 <pipewrite+0xb1>
80103528:	90                   	nop
80103529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103530 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103530:	55                   	push   %ebp
80103531:	89 e5                	mov    %esp,%ebp
80103533:	57                   	push   %edi
80103534:	56                   	push   %esi
80103535:	53                   	push   %ebx
80103536:	83 ec 18             	sub    $0x18,%esp
80103539:	8b 75 08             	mov    0x8(%ebp),%esi
8010353c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010353f:	56                   	push   %esi
80103540:	e8 cb 13 00 00       	call   80104910 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103545:	83 c4 10             	add    $0x10,%esp
80103548:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010354e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103554:	75 6a                	jne    801035c0 <piperead+0x90>
80103556:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010355c:	85 db                	test   %ebx,%ebx
8010355e:	0f 84 c4 00 00 00    	je     80103628 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103564:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010356a:	eb 2d                	jmp    80103599 <piperead+0x69>
8010356c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103570:	83 ec 08             	sub    $0x8,%esp
80103573:	56                   	push   %esi
80103574:	53                   	push   %ebx
80103575:	e8 f6 08 00 00       	call   80103e70 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010357a:	83 c4 10             	add    $0x10,%esp
8010357d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103583:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103589:	75 35                	jne    801035c0 <piperead+0x90>
8010358b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103591:	85 d2                	test   %edx,%edx
80103593:	0f 84 8f 00 00 00    	je     80103628 <piperead+0xf8>
    if(myproc()->killed){
80103599:	e8 72 02 00 00       	call   80103810 <myproc>
8010359e:	8b 48 24             	mov    0x24(%eax),%ecx
801035a1:	85 c9                	test   %ecx,%ecx
801035a3:	74 cb                	je     80103570 <piperead+0x40>
      release(&p->lock);
801035a5:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801035a8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801035ad:	56                   	push   %esi
801035ae:	e8 1d 14 00 00       	call   801049d0 <release>
      return -1;
801035b3:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801035b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035b9:	89 d8                	mov    %ebx,%eax
801035bb:	5b                   	pop    %ebx
801035bc:	5e                   	pop    %esi
801035bd:	5f                   	pop    %edi
801035be:	5d                   	pop    %ebp
801035bf:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035c0:	8b 45 10             	mov    0x10(%ebp),%eax
801035c3:	85 c0                	test   %eax,%eax
801035c5:	7e 61                	jle    80103628 <piperead+0xf8>
    if(p->nread == p->nwrite)
801035c7:	31 db                	xor    %ebx,%ebx
801035c9:	eb 13                	jmp    801035de <piperead+0xae>
801035cb:	90                   	nop
801035cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035d0:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801035d6:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801035dc:	74 1f                	je     801035fd <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
801035de:	8d 41 01             	lea    0x1(%ecx),%eax
801035e1:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801035e7:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
801035ed:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
801035f2:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035f5:	83 c3 01             	add    $0x1,%ebx
801035f8:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801035fb:	75 d3                	jne    801035d0 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801035fd:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103603:	83 ec 0c             	sub    $0xc,%esp
80103606:	50                   	push   %eax
80103607:	e8 24 0a 00 00       	call   80104030 <wakeup>
  release(&p->lock);
8010360c:	89 34 24             	mov    %esi,(%esp)
8010360f:	e8 bc 13 00 00       	call   801049d0 <release>
  return i;
80103614:	83 c4 10             	add    $0x10,%esp
}
80103617:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010361a:	89 d8                	mov    %ebx,%eax
8010361c:	5b                   	pop    %ebx
8010361d:	5e                   	pop    %esi
8010361e:	5f                   	pop    %edi
8010361f:	5d                   	pop    %ebp
80103620:	c3                   	ret    
80103621:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103628:	31 db                	xor    %ebx,%ebx
8010362a:	eb d1                	jmp    801035fd <piperead+0xcd>
8010362c:	66 90                	xchg   %ax,%ax
8010362e:	66 90                	xchg   %ax,%ax

80103630 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103630:	55                   	push   %ebp
80103631:	89 e5                	mov    %esp,%ebp
80103633:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103634:	bb 14 b3 14 80       	mov    $0x8014b314,%ebx
{
80103639:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010363c:	68 e0 b2 14 80       	push   $0x8014b2e0
80103641:	e8 ca 12 00 00       	call   80104910 <acquire>
80103646:	83 c4 10             	add    $0x10,%esp
80103649:	eb 13                	jmp    8010365e <allocproc+0x2e>
8010364b:	90                   	nop
8010364c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103650:	81 c3 d0 01 00 00    	add    $0x1d0,%ebx
80103656:	81 fb 14 27 15 80    	cmp    $0x80152714,%ebx
8010365c:	73 7a                	jae    801036d8 <allocproc+0xa8>
    if(p->state == UNUSED)
8010365e:	8b 43 0c             	mov    0xc(%ebx),%eax
80103661:	85 c0                	test   %eax,%eax
80103663:	75 eb                	jne    80103650 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103665:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
8010366a:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
8010366d:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103674:	8d 50 01             	lea    0x1(%eax),%edx
80103677:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
8010367a:	68 e0 b2 14 80       	push   $0x8014b2e0
  p->pid = nextpid++;
8010367f:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
80103685:	e8 46 13 00 00       	call   801049d0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010368a:	e8 61 ee ff ff       	call   801024f0 <kalloc>
8010368f:	83 c4 10             	add    $0x10,%esp
80103692:	85 c0                	test   %eax,%eax
80103694:	89 43 08             	mov    %eax,0x8(%ebx)
80103697:	74 58                	je     801036f1 <allocproc+0xc1>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103699:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010369f:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
801036a2:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
801036a7:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
801036aa:	c7 40 14 83 6c 10 80 	movl   $0x80106c83,0x14(%eax)
  p->context = (struct context*)sp;
801036b1:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801036b4:	6a 14                	push   $0x14
801036b6:	6a 00                	push   $0x0
801036b8:	50                   	push   %eax
801036b9:	e8 62 13 00 00       	call   80104a20 <memset>
  p->context->eip = (uint)forkret;
801036be:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
801036c1:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
801036c4:	c7 40 10 00 37 10 80 	movl   $0x80103700,0x10(%eax)
}
801036cb:	89 d8                	mov    %ebx,%eax
801036cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801036d0:	c9                   	leave  
801036d1:	c3                   	ret    
801036d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
801036d8:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801036db:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
801036dd:	68 e0 b2 14 80       	push   $0x8014b2e0
801036e2:	e8 e9 12 00 00       	call   801049d0 <release>
}
801036e7:	89 d8                	mov    %ebx,%eax
  return 0;
801036e9:	83 c4 10             	add    $0x10,%esp
}
801036ec:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801036ef:	c9                   	leave  
801036f0:	c3                   	ret    
    p->state = UNUSED;
801036f1:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801036f8:	31 db                	xor    %ebx,%ebx
801036fa:	eb cf                	jmp    801036cb <allocproc+0x9b>
801036fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103700 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103700:	55                   	push   %ebp
80103701:	89 e5                	mov    %esp,%ebp
80103703:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103706:	68 e0 b2 14 80       	push   $0x8014b2e0
8010370b:	e8 c0 12 00 00       	call   801049d0 <release>

  if (first) {
80103710:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103715:	83 c4 10             	add    $0x10,%esp
80103718:	85 c0                	test   %eax,%eax
8010371a:	75 04                	jne    80103720 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010371c:	c9                   	leave  
8010371d:	c3                   	ret    
8010371e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103720:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103723:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
8010372a:	00 00 00 
    iinit(ROOTDEV);
8010372d:	6a 01                	push   $0x1
8010372f:	e8 5c dd ff ff       	call   80101490 <iinit>
    initlog(ROOTDEV);
80103734:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010373b:	e8 f0 f3 ff ff       	call   80102b30 <initlog>
80103740:	83 c4 10             	add    $0x10,%esp
}
80103743:	c9                   	leave  
80103744:	c3                   	ret    
80103745:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103750 <pinit>:
{
80103750:	55                   	push   %ebp
80103751:	89 e5                	mov    %esp,%ebp
80103753:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103756:	68 55 8a 10 80       	push   $0x80108a55
8010375b:	68 e0 b2 14 80       	push   $0x8014b2e0
80103760:	e8 6b 10 00 00       	call   801047d0 <initlock>
}
80103765:	83 c4 10             	add    $0x10,%esp
80103768:	c9                   	leave  
80103769:	c3                   	ret    
8010376a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103770 <mycpu>:
{
80103770:	55                   	push   %ebp
80103771:	89 e5                	mov    %esp,%ebp
80103773:	56                   	push   %esi
80103774:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103775:	9c                   	pushf  
80103776:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103777:	f6 c4 02             	test   $0x2,%ah
8010377a:	75 5e                	jne    801037da <mycpu+0x6a>
  apicid = lapicid();
8010377c:	e8 df ef ff ff       	call   80102760 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103781:	8b 35 c0 b2 14 80    	mov    0x8014b2c0,%esi
80103787:	85 f6                	test   %esi,%esi
80103789:	7e 42                	jle    801037cd <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
8010378b:	0f b6 15 40 ad 14 80 	movzbl 0x8014ad40,%edx
80103792:	39 d0                	cmp    %edx,%eax
80103794:	74 30                	je     801037c6 <mycpu+0x56>
80103796:	b9 f0 ad 14 80       	mov    $0x8014adf0,%ecx
  for (i = 0; i < ncpu; ++i) {
8010379b:	31 d2                	xor    %edx,%edx
8010379d:	8d 76 00             	lea    0x0(%esi),%esi
801037a0:	83 c2 01             	add    $0x1,%edx
801037a3:	39 f2                	cmp    %esi,%edx
801037a5:	74 26                	je     801037cd <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
801037a7:	0f b6 19             	movzbl (%ecx),%ebx
801037aa:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
801037b0:	39 c3                	cmp    %eax,%ebx
801037b2:	75 ec                	jne    801037a0 <mycpu+0x30>
801037b4:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
801037ba:	05 40 ad 14 80       	add    $0x8014ad40,%eax
}
801037bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801037c2:	5b                   	pop    %ebx
801037c3:	5e                   	pop    %esi
801037c4:	5d                   	pop    %ebp
801037c5:	c3                   	ret    
    if (cpus[i].apicid == apicid)
801037c6:	b8 40 ad 14 80       	mov    $0x8014ad40,%eax
      return &cpus[i];
801037cb:	eb f2                	jmp    801037bf <mycpu+0x4f>
  panic("unknown apicid\n");
801037cd:	83 ec 0c             	sub    $0xc,%esp
801037d0:	68 5c 8a 10 80       	push   $0x80108a5c
801037d5:	e8 b6 cb ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
801037da:	83 ec 0c             	sub    $0xc,%esp
801037dd:	68 60 8b 10 80       	push   $0x80108b60
801037e2:	e8 a9 cb ff ff       	call   80100390 <panic>
801037e7:	89 f6                	mov    %esi,%esi
801037e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801037f0 <cpuid>:
cpuid() {
801037f0:	55                   	push   %ebp
801037f1:	89 e5                	mov    %esp,%ebp
801037f3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801037f6:	e8 75 ff ff ff       	call   80103770 <mycpu>
801037fb:	2d 40 ad 14 80       	sub    $0x8014ad40,%eax
}
80103800:	c9                   	leave  
  return mycpu()-cpus;
80103801:	c1 f8 04             	sar    $0x4,%eax
80103804:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010380a:	c3                   	ret    
8010380b:	90                   	nop
8010380c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103810 <myproc>:
myproc(void) {
80103810:	55                   	push   %ebp
80103811:	89 e5                	mov    %esp,%ebp
80103813:	53                   	push   %ebx
80103814:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103817:	e8 24 10 00 00       	call   80104840 <pushcli>
  c = mycpu();
8010381c:	e8 4f ff ff ff       	call   80103770 <mycpu>
  p = c->proc;
80103821:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103827:	e8 54 10 00 00       	call   80104880 <popcli>
}
8010382c:	83 c4 04             	add    $0x4,%esp
8010382f:	89 d8                	mov    %ebx,%eax
80103831:	5b                   	pop    %ebx
80103832:	5d                   	pop    %ebp
80103833:	c3                   	ret    
80103834:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010383a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103840 <userinit>:
{
80103840:	55                   	push   %ebp
80103841:	89 e5                	mov    %esp,%ebp
80103843:	53                   	push   %ebx
80103844:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103847:	e8 e4 fd ff ff       	call   80103630 <allocproc>
8010384c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010384e:	a3 bc b5 10 80       	mov    %eax,0x8010b5bc
  if((p->pgdir = setupkvm()) == 0)
80103853:	e8 f8 49 00 00       	call   80108250 <setupkvm>
80103858:	85 c0                	test   %eax,%eax
8010385a:	89 43 04             	mov    %eax,0x4(%ebx)
8010385d:	0f 84 c3 00 00 00    	je     80103926 <userinit+0xe6>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103863:	83 ec 04             	sub    $0x4,%esp
80103866:	68 2c 00 00 00       	push   $0x2c
8010386b:	68 60 b4 10 80       	push   $0x8010b460
80103870:	50                   	push   %eax
80103871:	e8 ba 46 00 00       	call   80107f30 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103876:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103879:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010387f:	6a 4c                	push   $0x4c
80103881:	6a 00                	push   $0x0
80103883:	ff 73 18             	pushl  0x18(%ebx)
80103886:	e8 95 11 00 00       	call   80104a20 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010388b:	8b 43 18             	mov    0x18(%ebx),%eax
8010388e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103893:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103898:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010389b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010389f:	8b 43 18             	mov    0x18(%ebx),%eax
801038a2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801038a6:	8b 43 18             	mov    0x18(%ebx),%eax
801038a9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801038ad:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801038b1:	8b 43 18             	mov    0x18(%ebx),%eax
801038b4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801038b8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801038bc:	8b 43 18             	mov    0x18(%ebx),%eax
801038bf:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801038c6:	8b 43 18             	mov    0x18(%ebx),%eax
801038c9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801038d0:	8b 43 18             	mov    0x18(%ebx),%eax
801038d3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
801038da:	8d 83 bc 01 00 00    	lea    0x1bc(%ebx),%eax
801038e0:	6a 10                	push   $0x10
801038e2:	68 85 8a 10 80       	push   $0x80108a85
801038e7:	50                   	push   %eax
801038e8:	e8 13 13 00 00       	call   80104c00 <safestrcpy>
  p->cwd = namei("/");
801038ed:	c7 04 24 06 8d 10 80 	movl   $0x80108d06,(%esp)
801038f4:	e8 17 e6 ff ff       	call   80101f10 <namei>
801038f9:	89 83 b8 01 00 00    	mov    %eax,0x1b8(%ebx)
  acquire(&ptable.lock);
801038ff:	c7 04 24 e0 b2 14 80 	movl   $0x8014b2e0,(%esp)
80103906:	e8 05 10 00 00       	call   80104910 <acquire>
  p->state = RUNNABLE;
8010390b:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103912:	c7 04 24 e0 b2 14 80 	movl   $0x8014b2e0,(%esp)
80103919:	e8 b2 10 00 00       	call   801049d0 <release>
}
8010391e:	83 c4 10             	add    $0x10,%esp
80103921:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103924:	c9                   	leave  
80103925:	c3                   	ret    
    panic("userinit: out of memory?");
80103926:	83 ec 0c             	sub    $0xc,%esp
80103929:	68 6c 8a 10 80       	push   $0x80108a6c
8010392e:	e8 5d ca ff ff       	call   80100390 <panic>
80103933:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103940 <growproc>:
{
80103940:	55                   	push   %ebp
80103941:	89 e5                	mov    %esp,%ebp
80103943:	56                   	push   %esi
80103944:	53                   	push   %ebx
80103945:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103948:	e8 f3 0e 00 00       	call   80104840 <pushcli>
  c = mycpu();
8010394d:	e8 1e fe ff ff       	call   80103770 <mycpu>
  p = c->proc;
80103952:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103958:	e8 23 0f 00 00       	call   80104880 <popcli>
  if(n > 0){
8010395d:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103960:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103962:	7f 1c                	jg     80103980 <growproc+0x40>
  } else if(n < 0){
80103964:	75 3a                	jne    801039a0 <growproc+0x60>
  switchuvm(curproc);
80103966:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103969:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
8010396b:	53                   	push   %ebx
8010396c:	e8 af 44 00 00       	call   80107e20 <switchuvm>
  return 0;
80103971:	83 c4 10             	add    $0x10,%esp
80103974:	31 c0                	xor    %eax,%eax
}
80103976:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103979:	5b                   	pop    %ebx
8010397a:	5e                   	pop    %esi
8010397b:	5d                   	pop    %ebp
8010397c:	c3                   	ret    
8010397d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103980:	83 ec 04             	sub    $0x4,%esp
80103983:	01 c6                	add    %eax,%esi
80103985:	56                   	push   %esi
80103986:	50                   	push   %eax
80103987:	ff 73 04             	pushl  0x4(%ebx)
8010398a:	e8 e1 46 00 00       	call   80108070 <allocuvm>
8010398f:	83 c4 10             	add    $0x10,%esp
80103992:	85 c0                	test   %eax,%eax
80103994:	75 d0                	jne    80103966 <growproc+0x26>
      return -1;
80103996:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010399b:	eb d9                	jmp    80103976 <growproc+0x36>
8010399d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
801039a0:	83 ec 04             	sub    $0x4,%esp
801039a3:	01 c6                	add    %eax,%esi
801039a5:	56                   	push   %esi
801039a6:	50                   	push   %eax
801039a7:	ff 73 04             	pushl  0x4(%ebx)
801039aa:	e8 f1 47 00 00       	call   801081a0 <deallocuvm>
801039af:	83 c4 10             	add    $0x10,%esp
801039b2:	85 c0                	test   %eax,%eax
801039b4:	75 b0                	jne    80103966 <growproc+0x26>
801039b6:	eb de                	jmp    80103996 <growproc+0x56>
801039b8:	90                   	nop
801039b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801039c0 <fork>:
{
801039c0:	55                   	push   %ebp
801039c1:	89 e5                	mov    %esp,%ebp
801039c3:	57                   	push   %edi
801039c4:	56                   	push   %esi
801039c5:	53                   	push   %ebx
801039c6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
801039c9:	e8 72 0e 00 00       	call   80104840 <pushcli>
  c = mycpu();
801039ce:	e8 9d fd ff ff       	call   80103770 <mycpu>
  p = c->proc;
801039d3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039d9:	e8 a2 0e 00 00       	call   80104880 <popcli>
  if((np = allocproc()) == 0){
801039de:	e8 4d fc ff ff       	call   80103630 <allocproc>
801039e3:	85 c0                	test   %eax,%eax
801039e5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801039e8:	0f 84 c3 00 00 00    	je     80103ab1 <fork+0xf1>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
801039ee:	83 ec 08             	sub    $0x8,%esp
801039f1:	ff 33                	pushl  (%ebx)
801039f3:	ff 73 04             	pushl  0x4(%ebx)
801039f6:	89 c7                	mov    %eax,%edi
801039f8:	e8 23 49 00 00       	call   80108320 <copyuvm>
801039fd:	83 c4 10             	add    $0x10,%esp
80103a00:	85 c0                	test   %eax,%eax
80103a02:	89 47 04             	mov    %eax,0x4(%edi)
80103a05:	0f 84 ad 00 00 00    	je     80103ab8 <fork+0xf8>
  np->sz = curproc->sz;
80103a0b:	8b 03                	mov    (%ebx),%eax
80103a0d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103a10:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103a12:	89 59 14             	mov    %ebx,0x14(%ecx)
80103a15:	89 c8                	mov    %ecx,%eax
  *np->tf = *curproc->tf;
80103a17:	8b 79 18             	mov    0x18(%ecx),%edi
80103a1a:	8b 73 18             	mov    0x18(%ebx),%esi
80103a1d:	b9 13 00 00 00       	mov    $0x13,%ecx
80103a22:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103a24:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103a26:	8b 40 18             	mov    0x18(%eax),%eax
80103a29:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103a30:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103a34:	85 c0                	test   %eax,%eax
80103a36:	74 13                	je     80103a4b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103a38:	83 ec 0c             	sub    $0xc,%esp
80103a3b:	50                   	push   %eax
80103a3c:	e8 af d3 ff ff       	call   80100df0 <filedup>
80103a41:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103a44:	83 c4 10             	add    $0x10,%esp
80103a47:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103a4b:	83 c6 01             	add    $0x1,%esi
80103a4e:	83 fe 64             	cmp    $0x64,%esi
80103a51:	75 dd                	jne    80103a30 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103a53:	83 ec 0c             	sub    $0xc,%esp
80103a56:	ff b3 b8 01 00 00    	pushl  0x1b8(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a5c:	81 c3 bc 01 00 00    	add    $0x1bc,%ebx
  np->cwd = idup(curproc->cwd);
80103a62:	e8 f9 db ff ff       	call   80101660 <idup>
80103a67:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a6a:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103a6d:	89 87 b8 01 00 00    	mov    %eax,0x1b8(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a73:	8d 87 bc 01 00 00    	lea    0x1bc(%edi),%eax
80103a79:	6a 10                	push   $0x10
80103a7b:	53                   	push   %ebx
80103a7c:	50                   	push   %eax
80103a7d:	e8 7e 11 00 00       	call   80104c00 <safestrcpy>
  pid = np->pid;
80103a82:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103a85:	c7 04 24 e0 b2 14 80 	movl   $0x8014b2e0,(%esp)
80103a8c:	e8 7f 0e 00 00       	call   80104910 <acquire>
  np->state = RUNNABLE;
80103a91:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103a98:	c7 04 24 e0 b2 14 80 	movl   $0x8014b2e0,(%esp)
80103a9f:	e8 2c 0f 00 00       	call   801049d0 <release>
  return pid;
80103aa4:	83 c4 10             	add    $0x10,%esp
}
80103aa7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103aaa:	89 d8                	mov    %ebx,%eax
80103aac:	5b                   	pop    %ebx
80103aad:	5e                   	pop    %esi
80103aae:	5f                   	pop    %edi
80103aaf:	5d                   	pop    %ebp
80103ab0:	c3                   	ret    
    return -1;
80103ab1:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103ab6:	eb ef                	jmp    80103aa7 <fork+0xe7>
    kfree(np->kstack);
80103ab8:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103abb:	83 ec 0c             	sub    $0xc,%esp
    return -1;
80103abe:	83 cb ff             	or     $0xffffffff,%ebx
    kfree(np->kstack);
80103ac1:	ff 77 08             	pushl  0x8(%edi)
80103ac4:	e8 77 e8 ff ff       	call   80102340 <kfree>
    np->kstack = 0;
80103ac9:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103ad0:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103ad7:	83 c4 10             	add    $0x10,%esp
80103ada:	eb cb                	jmp    80103aa7 <fork+0xe7>
80103adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103ae0 <scheduler>:
{
80103ae0:	55                   	push   %ebp
80103ae1:	89 e5                	mov    %esp,%ebp
80103ae3:	57                   	push   %edi
80103ae4:	56                   	push   %esi
80103ae5:	53                   	push   %ebx
80103ae6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103ae9:	e8 82 fc ff ff       	call   80103770 <mycpu>
80103aee:	8d 78 04             	lea    0x4(%eax),%edi
80103af1:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103af3:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103afa:	00 00 00 
80103afd:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103b00:	fb                   	sti    
    acquire(&ptable.lock);
80103b01:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b04:	bb 14 b3 14 80       	mov    $0x8014b314,%ebx
    acquire(&ptable.lock);
80103b09:	68 e0 b2 14 80       	push   $0x8014b2e0
80103b0e:	e8 fd 0d 00 00       	call   80104910 <acquire>
80103b13:	83 c4 10             	add    $0x10,%esp
80103b16:	8d 76 00             	lea    0x0(%esi),%esi
80103b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(p->state != RUNNABLE)
80103b20:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103b24:	75 33                	jne    80103b59 <scheduler+0x79>
      switchuvm(p);
80103b26:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103b29:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103b2f:	53                   	push   %ebx
80103b30:	e8 eb 42 00 00       	call   80107e20 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103b35:	58                   	pop    %eax
80103b36:	5a                   	pop    %edx
80103b37:	ff 73 1c             	pushl  0x1c(%ebx)
80103b3a:	57                   	push   %edi
      p->state = RUNNING;
80103b3b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103b42:	e8 14 11 00 00       	call   80104c5b <swtch>
      switchkvm();
80103b47:	e8 b4 42 00 00       	call   80107e00 <switchkvm>
      c->proc = 0;
80103b4c:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103b53:	00 00 00 
80103b56:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b59:	81 c3 d0 01 00 00    	add    $0x1d0,%ebx
80103b5f:	81 fb 14 27 15 80    	cmp    $0x80152714,%ebx
80103b65:	72 b9                	jb     80103b20 <scheduler+0x40>
    release(&ptable.lock);
80103b67:	83 ec 0c             	sub    $0xc,%esp
80103b6a:	68 e0 b2 14 80       	push   $0x8014b2e0
80103b6f:	e8 5c 0e 00 00       	call   801049d0 <release>
    sti();
80103b74:	83 c4 10             	add    $0x10,%esp
80103b77:	eb 87                	jmp    80103b00 <scheduler+0x20>
80103b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103b80 <scheduler2>:
{
80103b80:	55                   	push   %ebp
80103b81:	89 e5                	mov    %esp,%ebp
80103b83:	57                   	push   %edi
80103b84:	56                   	push   %esi
80103b85:	53                   	push   %ebx
80103b86:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103b89:	e8 e2 fb ff ff       	call   80103770 <mycpu>
80103b8e:	8d 78 04             	lea    0x4(%eax),%edi
80103b91:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103b93:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103b9a:	00 00 00 
80103b9d:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&ptable.lock);
80103ba0:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ba3:	bb 14 b3 14 80       	mov    $0x8014b314,%ebx
    acquire(&ptable.lock);
80103ba8:	68 e0 b2 14 80       	push   $0x8014b2e0
80103bad:	e8 5e 0d 00 00       	call   80104910 <acquire>
80103bb2:	83 c4 10             	add    $0x10,%esp
80103bb5:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->state != RUNNABLE)
80103bb8:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103bbc:	75 33                	jne    80103bf1 <scheduler2+0x71>
      switchuvm(p);
80103bbe:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103bc1:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103bc7:	53                   	push   %ebx
80103bc8:	e8 53 42 00 00       	call   80107e20 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103bcd:	58                   	pop    %eax
80103bce:	5a                   	pop    %edx
80103bcf:	ff 73 1c             	pushl  0x1c(%ebx)
80103bd2:	57                   	push   %edi
      p->state = RUNNING;
80103bd3:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103bda:	e8 7c 10 00 00       	call   80104c5b <swtch>
      switchkvm();
80103bdf:	e8 1c 42 00 00       	call   80107e00 <switchkvm>
      c->proc = 0;
80103be4:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103beb:	00 00 00 
80103bee:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bf1:	81 c3 d0 01 00 00    	add    $0x1d0,%ebx
80103bf7:	81 fb 14 27 15 80    	cmp    $0x80152714,%ebx
80103bfd:	72 b9                	jb     80103bb8 <scheduler2+0x38>
    release(&ptable.lock);
80103bff:	83 ec 0c             	sub    $0xc,%esp
80103c02:	68 e0 b2 14 80       	push   $0x8014b2e0
80103c07:	e8 c4 0d 00 00       	call   801049d0 <release>
    acquire(&ptable.lock);
80103c0c:	83 c4 10             	add    $0x10,%esp
80103c0f:	eb 8f                	jmp    80103ba0 <scheduler2+0x20>
80103c11:	eb 0d                	jmp    80103c20 <sched>
80103c13:	90                   	nop
80103c14:	90                   	nop
80103c15:	90                   	nop
80103c16:	90                   	nop
80103c17:	90                   	nop
80103c18:	90                   	nop
80103c19:	90                   	nop
80103c1a:	90                   	nop
80103c1b:	90                   	nop
80103c1c:	90                   	nop
80103c1d:	90                   	nop
80103c1e:	90                   	nop
80103c1f:	90                   	nop

80103c20 <sched>:
{
80103c20:	55                   	push   %ebp
80103c21:	89 e5                	mov    %esp,%ebp
80103c23:	56                   	push   %esi
80103c24:	53                   	push   %ebx
  pushcli();
80103c25:	e8 16 0c 00 00       	call   80104840 <pushcli>
  c = mycpu();
80103c2a:	e8 41 fb ff ff       	call   80103770 <mycpu>
  p = c->proc;
80103c2f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c35:	e8 46 0c 00 00       	call   80104880 <popcli>
  if(!holding(&ptable.lock))
80103c3a:	83 ec 0c             	sub    $0xc,%esp
80103c3d:	68 e0 b2 14 80       	push   $0x8014b2e0
80103c42:	e8 99 0c 00 00       	call   801048e0 <holding>
80103c47:	83 c4 10             	add    $0x10,%esp
80103c4a:	85 c0                	test   %eax,%eax
80103c4c:	74 4f                	je     80103c9d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103c4e:	e8 1d fb ff ff       	call   80103770 <mycpu>
80103c53:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103c5a:	75 68                	jne    80103cc4 <sched+0xa4>
  if(p->state == RUNNING)
80103c5c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103c60:	74 55                	je     80103cb7 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103c62:	9c                   	pushf  
80103c63:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103c64:	f6 c4 02             	test   $0x2,%ah
80103c67:	75 41                	jne    80103caa <sched+0x8a>
  intena = mycpu()->intena;
80103c69:	e8 02 fb ff ff       	call   80103770 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103c6e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103c71:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103c77:	e8 f4 fa ff ff       	call   80103770 <mycpu>
80103c7c:	83 ec 08             	sub    $0x8,%esp
80103c7f:	ff 70 04             	pushl  0x4(%eax)
80103c82:	53                   	push   %ebx
80103c83:	e8 d3 0f 00 00       	call   80104c5b <swtch>
  mycpu()->intena = intena;
80103c88:	e8 e3 fa ff ff       	call   80103770 <mycpu>
}
80103c8d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103c90:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103c96:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c99:	5b                   	pop    %ebx
80103c9a:	5e                   	pop    %esi
80103c9b:	5d                   	pop    %ebp
80103c9c:	c3                   	ret    
    panic("sched ptable.lock");
80103c9d:	83 ec 0c             	sub    $0xc,%esp
80103ca0:	68 8e 8a 10 80       	push   $0x80108a8e
80103ca5:	e8 e6 c6 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103caa:	83 ec 0c             	sub    $0xc,%esp
80103cad:	68 ba 8a 10 80       	push   $0x80108aba
80103cb2:	e8 d9 c6 ff ff       	call   80100390 <panic>
    panic("sched running");
80103cb7:	83 ec 0c             	sub    $0xc,%esp
80103cba:	68 ac 8a 10 80       	push   $0x80108aac
80103cbf:	e8 cc c6 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103cc4:	83 ec 0c             	sub    $0xc,%esp
80103cc7:	68 a0 8a 10 80       	push   $0x80108aa0
80103ccc:	e8 bf c6 ff ff       	call   80100390 <panic>
80103cd1:	eb 0d                	jmp    80103ce0 <exit>
80103cd3:	90                   	nop
80103cd4:	90                   	nop
80103cd5:	90                   	nop
80103cd6:	90                   	nop
80103cd7:	90                   	nop
80103cd8:	90                   	nop
80103cd9:	90                   	nop
80103cda:	90                   	nop
80103cdb:	90                   	nop
80103cdc:	90                   	nop
80103cdd:	90                   	nop
80103cde:	90                   	nop
80103cdf:	90                   	nop

80103ce0 <exit>:
{
80103ce0:	55                   	push   %ebp
80103ce1:	89 e5                	mov    %esp,%ebp
80103ce3:	57                   	push   %edi
80103ce4:	56                   	push   %esi
80103ce5:	53                   	push   %ebx
80103ce6:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103ce9:	e8 52 0b 00 00       	call   80104840 <pushcli>
  c = mycpu();
80103cee:	e8 7d fa ff ff       	call   80103770 <mycpu>
  p = c->proc;
80103cf3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103cf9:	e8 82 0b 00 00       	call   80104880 <popcli>
  if(curproc == initproc)
80103cfe:	39 35 bc b5 10 80    	cmp    %esi,0x8010b5bc
80103d04:	8d 5e 28             	lea    0x28(%esi),%ebx
80103d07:	8d be b8 01 00 00    	lea    0x1b8(%esi),%edi
80103d0d:	0f 84 fe 00 00 00    	je     80103e11 <exit+0x131>
80103d13:	90                   	nop
80103d14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd]){
80103d18:	8b 03                	mov    (%ebx),%eax
80103d1a:	85 c0                	test   %eax,%eax
80103d1c:	74 12                	je     80103d30 <exit+0x50>
      fileclose(curproc->ofile[fd]);
80103d1e:	83 ec 0c             	sub    $0xc,%esp
80103d21:	50                   	push   %eax
80103d22:	e8 19 d1 ff ff       	call   80100e40 <fileclose>
      curproc->ofile[fd] = 0;
80103d27:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103d2d:	83 c4 10             	add    $0x10,%esp
80103d30:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80103d33:	39 fb                	cmp    %edi,%ebx
80103d35:	75 e1                	jne    80103d18 <exit+0x38>
  begin_op();
80103d37:	e8 94 ee ff ff       	call   80102bd0 <begin_op>
  iput(curproc->cwd);
80103d3c:	83 ec 0c             	sub    $0xc,%esp
80103d3f:	ff b6 b8 01 00 00    	pushl  0x1b8(%esi)
80103d45:	e8 76 da ff ff       	call   801017c0 <iput>
  end_op();
80103d4a:	e8 f1 ee ff ff       	call   80102c40 <end_op>
  curproc->cwd = 0;
80103d4f:	c7 86 b8 01 00 00 00 	movl   $0x0,0x1b8(%esi)
80103d56:	00 00 00 
  acquire(&ptable.lock);
80103d59:	c7 04 24 e0 b2 14 80 	movl   $0x8014b2e0,(%esp)
80103d60:	e8 ab 0b 00 00       	call   80104910 <acquire>
  wakeup1(curproc->parent);
80103d65:	8b 56 14             	mov    0x14(%esi),%edx
80103d68:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d6b:	b8 14 b3 14 80       	mov    $0x8014b314,%eax
80103d70:	eb 12                	jmp    80103d84 <exit+0xa4>
80103d72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103d78:	05 d0 01 00 00       	add    $0x1d0,%eax
80103d7d:	3d 14 27 15 80       	cmp    $0x80152714,%eax
80103d82:	73 1e                	jae    80103da2 <exit+0xc2>
    if(p->state == SLEEPING && p->chan == chan)
80103d84:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103d88:	75 ee                	jne    80103d78 <exit+0x98>
80103d8a:	3b 50 20             	cmp    0x20(%eax),%edx
80103d8d:	75 e9                	jne    80103d78 <exit+0x98>
      p->state = RUNNABLE;
80103d8f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d96:	05 d0 01 00 00       	add    $0x1d0,%eax
80103d9b:	3d 14 27 15 80       	cmp    $0x80152714,%eax
80103da0:	72 e2                	jb     80103d84 <exit+0xa4>
      p->parent = initproc;
80103da2:	8b 0d bc b5 10 80    	mov    0x8010b5bc,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103da8:	ba 14 b3 14 80       	mov    $0x8014b314,%edx
80103dad:	eb 0f                	jmp    80103dbe <exit+0xde>
80103daf:	90                   	nop
80103db0:	81 c2 d0 01 00 00    	add    $0x1d0,%edx
80103db6:	81 fa 14 27 15 80    	cmp    $0x80152714,%edx
80103dbc:	73 3a                	jae    80103df8 <exit+0x118>
    if(p->parent == curproc){
80103dbe:	39 72 14             	cmp    %esi,0x14(%edx)
80103dc1:	75 ed                	jne    80103db0 <exit+0xd0>
      if(p->state == ZOMBIE)
80103dc3:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103dc7:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103dca:	75 e4                	jne    80103db0 <exit+0xd0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103dcc:	b8 14 b3 14 80       	mov    $0x8014b314,%eax
80103dd1:	eb 11                	jmp    80103de4 <exit+0x104>
80103dd3:	90                   	nop
80103dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103dd8:	05 d0 01 00 00       	add    $0x1d0,%eax
80103ddd:	3d 14 27 15 80       	cmp    $0x80152714,%eax
80103de2:	73 cc                	jae    80103db0 <exit+0xd0>
    if(p->state == SLEEPING && p->chan == chan)
80103de4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103de8:	75 ee                	jne    80103dd8 <exit+0xf8>
80103dea:	3b 48 20             	cmp    0x20(%eax),%ecx
80103ded:	75 e9                	jne    80103dd8 <exit+0xf8>
      p->state = RUNNABLE;
80103def:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103df6:	eb e0                	jmp    80103dd8 <exit+0xf8>
  curproc->state = ZOMBIE;
80103df8:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103dff:	e8 1c fe ff ff       	call   80103c20 <sched>
  panic("zombie exit");
80103e04:	83 ec 0c             	sub    $0xc,%esp
80103e07:	68 db 8a 10 80       	push   $0x80108adb
80103e0c:	e8 7f c5 ff ff       	call   80100390 <panic>
    panic("init exiting");
80103e11:	83 ec 0c             	sub    $0xc,%esp
80103e14:	68 ce 8a 10 80       	push   $0x80108ace
80103e19:	e8 72 c5 ff ff       	call   80100390 <panic>
80103e1e:	66 90                	xchg   %ax,%ax

80103e20 <yield>:
{
80103e20:	55                   	push   %ebp
80103e21:	89 e5                	mov    %esp,%ebp
80103e23:	53                   	push   %ebx
80103e24:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103e27:	68 e0 b2 14 80       	push   $0x8014b2e0
80103e2c:	e8 df 0a 00 00       	call   80104910 <acquire>
  pushcli();
80103e31:	e8 0a 0a 00 00       	call   80104840 <pushcli>
  c = mycpu();
80103e36:	e8 35 f9 ff ff       	call   80103770 <mycpu>
  p = c->proc;
80103e3b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e41:	e8 3a 0a 00 00       	call   80104880 <popcli>
  myproc()->state = RUNNABLE;
80103e46:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103e4d:	e8 ce fd ff ff       	call   80103c20 <sched>
  release(&ptable.lock);
80103e52:	c7 04 24 e0 b2 14 80 	movl   $0x8014b2e0,(%esp)
80103e59:	e8 72 0b 00 00       	call   801049d0 <release>
}
80103e5e:	83 c4 10             	add    $0x10,%esp
80103e61:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e64:	c9                   	leave  
80103e65:	c3                   	ret    
80103e66:	8d 76 00             	lea    0x0(%esi),%esi
80103e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e70 <sleep>:
{
80103e70:	55                   	push   %ebp
80103e71:	89 e5                	mov    %esp,%ebp
80103e73:	57                   	push   %edi
80103e74:	56                   	push   %esi
80103e75:	53                   	push   %ebx
80103e76:	83 ec 0c             	sub    $0xc,%esp
80103e79:	8b 7d 08             	mov    0x8(%ebp),%edi
80103e7c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103e7f:	e8 bc 09 00 00       	call   80104840 <pushcli>
  c = mycpu();
80103e84:	e8 e7 f8 ff ff       	call   80103770 <mycpu>
  p = c->proc;
80103e89:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e8f:	e8 ec 09 00 00       	call   80104880 <popcli>
  if(p == 0)
80103e94:	85 db                	test   %ebx,%ebx
80103e96:	0f 84 87 00 00 00    	je     80103f23 <sleep+0xb3>
  if(lk == 0)
80103e9c:	85 f6                	test   %esi,%esi
80103e9e:	74 76                	je     80103f16 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103ea0:	81 fe e0 b2 14 80    	cmp    $0x8014b2e0,%esi
80103ea6:	74 50                	je     80103ef8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103ea8:	83 ec 0c             	sub    $0xc,%esp
80103eab:	68 e0 b2 14 80       	push   $0x8014b2e0
80103eb0:	e8 5b 0a 00 00       	call   80104910 <acquire>
    release(lk);
80103eb5:	89 34 24             	mov    %esi,(%esp)
80103eb8:	e8 13 0b 00 00       	call   801049d0 <release>
  p->chan = chan;
80103ebd:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103ec0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103ec7:	e8 54 fd ff ff       	call   80103c20 <sched>
  p->chan = 0;
80103ecc:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103ed3:	c7 04 24 e0 b2 14 80 	movl   $0x8014b2e0,(%esp)
80103eda:	e8 f1 0a 00 00       	call   801049d0 <release>
    acquire(lk);
80103edf:	89 75 08             	mov    %esi,0x8(%ebp)
80103ee2:	83 c4 10             	add    $0x10,%esp
}
80103ee5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ee8:	5b                   	pop    %ebx
80103ee9:	5e                   	pop    %esi
80103eea:	5f                   	pop    %edi
80103eeb:	5d                   	pop    %ebp
    acquire(lk);
80103eec:	e9 1f 0a 00 00       	jmp    80104910 <acquire>
80103ef1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80103ef8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103efb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103f02:	e8 19 fd ff ff       	call   80103c20 <sched>
  p->chan = 0;
80103f07:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103f0e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f11:	5b                   	pop    %ebx
80103f12:	5e                   	pop    %esi
80103f13:	5f                   	pop    %edi
80103f14:	5d                   	pop    %ebp
80103f15:	c3                   	ret    
    panic("sleep without lk");
80103f16:	83 ec 0c             	sub    $0xc,%esp
80103f19:	68 ed 8a 10 80       	push   $0x80108aed
80103f1e:	e8 6d c4 ff ff       	call   80100390 <panic>
    panic("sleep");
80103f23:	83 ec 0c             	sub    $0xc,%esp
80103f26:	68 e7 8a 10 80       	push   $0x80108ae7
80103f2b:	e8 60 c4 ff ff       	call   80100390 <panic>

80103f30 <wait>:
{
80103f30:	55                   	push   %ebp
80103f31:	89 e5                	mov    %esp,%ebp
80103f33:	56                   	push   %esi
80103f34:	53                   	push   %ebx
  pushcli();
80103f35:	e8 06 09 00 00       	call   80104840 <pushcli>
  c = mycpu();
80103f3a:	e8 31 f8 ff ff       	call   80103770 <mycpu>
  p = c->proc;
80103f3f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103f45:	e8 36 09 00 00       	call   80104880 <popcli>
  acquire(&ptable.lock);
80103f4a:	83 ec 0c             	sub    $0xc,%esp
80103f4d:	68 e0 b2 14 80       	push   $0x8014b2e0
80103f52:	e8 b9 09 00 00       	call   80104910 <acquire>
80103f57:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103f5a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f5c:	bb 14 b3 14 80       	mov    $0x8014b314,%ebx
80103f61:	eb 13                	jmp    80103f76 <wait+0x46>
80103f63:	90                   	nop
80103f64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f68:	81 c3 d0 01 00 00    	add    $0x1d0,%ebx
80103f6e:	81 fb 14 27 15 80    	cmp    $0x80152714,%ebx
80103f74:	73 1e                	jae    80103f94 <wait+0x64>
      if(p->parent != curproc)
80103f76:	39 73 14             	cmp    %esi,0x14(%ebx)
80103f79:	75 ed                	jne    80103f68 <wait+0x38>
      if(p->state == ZOMBIE){
80103f7b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103f7f:	74 37                	je     80103fb8 <wait+0x88>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f81:	81 c3 d0 01 00 00    	add    $0x1d0,%ebx
      havekids = 1;
80103f87:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f8c:	81 fb 14 27 15 80    	cmp    $0x80152714,%ebx
80103f92:	72 e2                	jb     80103f76 <wait+0x46>
    if(!havekids || curproc->killed){
80103f94:	85 c0                	test   %eax,%eax
80103f96:	74 79                	je     80104011 <wait+0xe1>
80103f98:	8b 46 24             	mov    0x24(%esi),%eax
80103f9b:	85 c0                	test   %eax,%eax
80103f9d:	75 72                	jne    80104011 <wait+0xe1>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103f9f:	83 ec 08             	sub    $0x8,%esp
80103fa2:	68 e0 b2 14 80       	push   $0x8014b2e0
80103fa7:	56                   	push   %esi
80103fa8:	e8 c3 fe ff ff       	call   80103e70 <sleep>
    havekids = 0;
80103fad:	83 c4 10             	add    $0x10,%esp
80103fb0:	eb a8                	jmp    80103f5a <wait+0x2a>
80103fb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
80103fb8:	83 ec 0c             	sub    $0xc,%esp
80103fbb:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80103fbe:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103fc1:	e8 7a e3 ff ff       	call   80102340 <kfree>
        freevm(p->pgdir);
80103fc6:	5a                   	pop    %edx
80103fc7:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80103fca:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103fd1:	e8 fa 41 00 00       	call   801081d0 <freevm>
        release(&ptable.lock);
80103fd6:	c7 04 24 e0 b2 14 80 	movl   $0x8014b2e0,(%esp)
        p->pid = 0;
80103fdd:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103fe4:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103feb:	c6 83 bc 01 00 00 00 	movb   $0x0,0x1bc(%ebx)
        p->killed = 0;
80103ff2:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103ff9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104000:	e8 cb 09 00 00       	call   801049d0 <release>
        return pid;
80104005:	83 c4 10             	add    $0x10,%esp
}
80104008:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010400b:	89 f0                	mov    %esi,%eax
8010400d:	5b                   	pop    %ebx
8010400e:	5e                   	pop    %esi
8010400f:	5d                   	pop    %ebp
80104010:	c3                   	ret    
      release(&ptable.lock);
80104011:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104014:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104019:	68 e0 b2 14 80       	push   $0x8014b2e0
8010401e:	e8 ad 09 00 00       	call   801049d0 <release>
      return -1;
80104023:	83 c4 10             	add    $0x10,%esp
80104026:	eb e0                	jmp    80104008 <wait+0xd8>
80104028:	90                   	nop
80104029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104030 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104030:	55                   	push   %ebp
80104031:	89 e5                	mov    %esp,%ebp
80104033:	53                   	push   %ebx
80104034:	83 ec 10             	sub    $0x10,%esp
80104037:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010403a:	68 e0 b2 14 80       	push   $0x8014b2e0
8010403f:	e8 cc 08 00 00       	call   80104910 <acquire>
80104044:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104047:	b8 14 b3 14 80       	mov    $0x8014b314,%eax
8010404c:	eb 0e                	jmp    8010405c <wakeup+0x2c>
8010404e:	66 90                	xchg   %ax,%ax
80104050:	05 d0 01 00 00       	add    $0x1d0,%eax
80104055:	3d 14 27 15 80       	cmp    $0x80152714,%eax
8010405a:	73 1e                	jae    8010407a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
8010405c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104060:	75 ee                	jne    80104050 <wakeup+0x20>
80104062:	3b 58 20             	cmp    0x20(%eax),%ebx
80104065:	75 e9                	jne    80104050 <wakeup+0x20>
      p->state = RUNNABLE;
80104067:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010406e:	05 d0 01 00 00       	add    $0x1d0,%eax
80104073:	3d 14 27 15 80       	cmp    $0x80152714,%eax
80104078:	72 e2                	jb     8010405c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
8010407a:	c7 45 08 e0 b2 14 80 	movl   $0x8014b2e0,0x8(%ebp)
}
80104081:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104084:	c9                   	leave  
  release(&ptable.lock);
80104085:	e9 46 09 00 00       	jmp    801049d0 <release>
8010408a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104090 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104090:	55                   	push   %ebp
80104091:	89 e5                	mov    %esp,%ebp
80104093:	53                   	push   %ebx
80104094:	83 ec 10             	sub    $0x10,%esp
80104097:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010409a:	68 e0 b2 14 80       	push   $0x8014b2e0
8010409f:	e8 6c 08 00 00       	call   80104910 <acquire>
801040a4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040a7:	b8 14 b3 14 80       	mov    $0x8014b314,%eax
801040ac:	eb 0e                	jmp    801040bc <kill+0x2c>
801040ae:	66 90                	xchg   %ax,%ax
801040b0:	05 d0 01 00 00       	add    $0x1d0,%eax
801040b5:	3d 14 27 15 80       	cmp    $0x80152714,%eax
801040ba:	73 34                	jae    801040f0 <kill+0x60>
    if(p->pid == pid){
801040bc:	39 58 10             	cmp    %ebx,0x10(%eax)
801040bf:	75 ef                	jne    801040b0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801040c1:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
801040c5:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
801040cc:	75 07                	jne    801040d5 <kill+0x45>
        p->state = RUNNABLE;
801040ce:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801040d5:	83 ec 0c             	sub    $0xc,%esp
801040d8:	68 e0 b2 14 80       	push   $0x8014b2e0
801040dd:	e8 ee 08 00 00       	call   801049d0 <release>
      return 0;
801040e2:	83 c4 10             	add    $0x10,%esp
801040e5:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
801040e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040ea:	c9                   	leave  
801040eb:	c3                   	ret    
801040ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801040f0:	83 ec 0c             	sub    $0xc,%esp
801040f3:	68 e0 b2 14 80       	push   $0x8014b2e0
801040f8:	e8 d3 08 00 00       	call   801049d0 <release>
  return -1;
801040fd:	83 c4 10             	add    $0x10,%esp
80104100:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104105:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104108:	c9                   	leave  
80104109:	c3                   	ret    
8010410a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104110 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104110:	55                   	push   %ebp
80104111:	89 e5                	mov    %esp,%ebp
80104113:	57                   	push   %edi
80104114:	56                   	push   %esi
80104115:	53                   	push   %ebx
80104116:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104119:	bb 14 b3 14 80       	mov    $0x8014b314,%ebx
{
8010411e:	83 ec 3c             	sub    $0x3c,%esp
80104121:	eb 27                	jmp    8010414a <procdump+0x3a>
80104123:	90                   	nop
80104124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104128:	83 ec 0c             	sub    $0xc,%esp
8010412b:	68 24 8d 10 80       	push   $0x80108d24
80104130:	e8 2b c5 ff ff       	call   80100660 <cprintf>
80104135:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104138:	81 c3 d0 01 00 00    	add    $0x1d0,%ebx
8010413e:	81 fb 14 27 15 80    	cmp    $0x80152714,%ebx
80104144:	0f 83 96 00 00 00    	jae    801041e0 <procdump+0xd0>
    if(p->state == UNUSED)
8010414a:	8b 43 0c             	mov    0xc(%ebx),%eax
8010414d:	85 c0                	test   %eax,%eax
8010414f:	74 e7                	je     80104138 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104151:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104154:	ba fe 8a 10 80       	mov    $0x80108afe,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104159:	77 11                	ja     8010416c <procdump+0x5c>
8010415b:	8b 14 85 88 8b 10 80 	mov    -0x7fef7478(,%eax,4),%edx
      state = "???";
80104162:	b8 fe 8a 10 80       	mov    $0x80108afe,%eax
80104167:	85 d2                	test   %edx,%edx
80104169:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010416c:	8d 83 bc 01 00 00    	lea    0x1bc(%ebx),%eax
80104172:	50                   	push   %eax
80104173:	52                   	push   %edx
80104174:	ff 73 10             	pushl  0x10(%ebx)
80104177:	68 02 8b 10 80       	push   $0x80108b02
8010417c:	e8 df c4 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
80104181:	83 c4 10             	add    $0x10,%esp
80104184:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104188:	75 9e                	jne    80104128 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
8010418a:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010418d:	83 ec 08             	sub    $0x8,%esp
80104190:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104193:	50                   	push   %eax
80104194:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104197:	8b 40 0c             	mov    0xc(%eax),%eax
8010419a:	83 c0 08             	add    $0x8,%eax
8010419d:	50                   	push   %eax
8010419e:	e8 4d 06 00 00       	call   801047f0 <getcallerpcs>
801041a3:	83 c4 10             	add    $0x10,%esp
801041a6:	8d 76 00             	lea    0x0(%esi),%esi
801041a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      for(i=0; i<10 && pc[i] != 0; i++)
801041b0:	8b 17                	mov    (%edi),%edx
801041b2:	85 d2                	test   %edx,%edx
801041b4:	0f 84 6e ff ff ff    	je     80104128 <procdump+0x18>
        cprintf(" %p", pc[i]);
801041ba:	83 ec 08             	sub    $0x8,%esp
801041bd:	83 c7 04             	add    $0x4,%edi
801041c0:	52                   	push   %edx
801041c1:	68 41 85 10 80       	push   $0x80108541
801041c6:	e8 95 c4 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801041cb:	83 c4 10             	add    $0x10,%esp
801041ce:	39 fe                	cmp    %edi,%esi
801041d0:	75 de                	jne    801041b0 <procdump+0xa0>
801041d2:	e9 51 ff ff ff       	jmp    80104128 <procdump+0x18>
801041d7:	89 f6                	mov    %esi,%esi
801041d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }
}
801041e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041e3:	5b                   	pop    %ebx
801041e4:	5e                   	pop    %esi
801041e5:	5f                   	pop    %edi
801041e6:	5d                   	pop    %ebp
801041e7:	c3                   	ret    
801041e8:	90                   	nop
801041e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801041f0 <running_procs>:
/*
///////////////////// MY CODE /////////////////////
*/
void
running_procs(void)
{
801041f0:	55                   	push   %ebp
801041f1:	89 e5                	mov    %esp,%ebp
801041f3:	57                   	push   %edi
801041f4:	56                   	push   %esi
801041f5:	53                   	push   %ebx
801041f6:	83 ec 1c             	sub    $0x1c,%esp
  if (cid_to_ptable!=1){
801041f9:	83 3d b8 b5 10 80 01 	cmpl   $0x1,0x8010b5b8
80104200:	74 4a                	je     8010424c <running_procs+0x5c>
    // cprintf("Done in ps%s\n");
    acquire(&ptable.lock);
80104202:	83 ec 0c             	sub    $0xc,%esp
80104205:	68 e0 b2 14 80       	push   $0x8014b2e0
8010420a:	e8 01 07 00 00       	call   80104910 <acquire>
8010420f:	b8 e0 b4 14 80       	mov    $0x8014b4e0,%eax
80104214:	83 c4 10             	add    $0x10,%esp
80104217:	89 f6                	mov    %esi,%esi
80104219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      for(int p = 0; p < NPROC; p++)
      {
        struct proc *pr;
        pr = &ptable.proc[p];
        pr->cid = -1;
80104220:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
80104226:	05 d0 01 00 00       	add    $0x1d0,%eax
      for(int p = 0; p < NPROC; p++)
8010422b:	3d e0 28 15 80       	cmp    $0x801528e0,%eax
80104230:	75 ee                	jne    80104220 <running_procs+0x30>
      }
    release(&ptable.lock);
80104232:	83 ec 0c             	sub    $0xc,%esp
80104235:	68 e0 b2 14 80       	push   $0x8014b2e0
8010423a:	e8 91 07 00 00       	call   801049d0 <release>
    cid_to_ptable = 1;
8010423f:	c7 05 b8 b5 10 80 01 	movl   $0x1,0x8010b5b8
80104246:	00 00 00 
80104249:	83 c4 10             	add    $0x10,%esp
  pushcli();
8010424c:	e8 ef 05 00 00       	call   80104840 <pushcli>
  c = mycpu();
80104251:	e8 1a f5 ff ff       	call   80103770 <mycpu>
  p = c->proc;
80104256:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010425c:	e8 1f 06 00 00       	call   80104880 <popcli>
  }
  struct proc *curproc = myproc();
  int cid = curproc->cid;
80104261:	8b 93 cc 01 00 00    	mov    0x1cc(%ebx),%edx
    release(&ptable.lock);
  }
  else{
    // cprintf("Doosre me ghusa%s\n");
    int c = 0;
    for (int i = 0; i < 100; i++) {
80104267:	31 db                	xor    %ebx,%ebx
  if (cid== -1){
80104269:	83 fa ff             	cmp    $0xffffffff,%edx
8010426c:	75 16                	jne    80104284 <running_procs+0x94>
8010426e:	e9 e7 00 00 00       	jmp    8010435a <running_procs+0x16a>
80104273:	90                   	nop
80104274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for (int i = 0; i < 100; i++) {
80104278:	83 c3 01             	add    $0x1,%ebx
8010427b:	83 fb 64             	cmp    $0x64,%ebx
8010427e:	0f 84 cf 00 00 00    	je     80104353 <running_procs+0x163>
      if (container_location[i]==1){
80104284:	83 3c 9d e0 79 14 80 	cmpl   $0x1,-0x7feb8620(,%ebx,4)
8010428b:	01 
8010428c:	75 ea                	jne    80104278 <running_procs+0x88>
        if(container_array[i].cid==cid){
8010428e:	69 c3 a4 08 00 00    	imul   $0x8a4,%ebx,%eax
80104294:	39 90 c0 18 11 80    	cmp    %edx,-0x7feee740(%eax)
8010429a:	75 dc                	jne    80104278 <running_procs+0x88>
          c=i;
          break;
        }
      }
    }
    acquire(&ptable.lock);
8010429c:	83 ec 0c             	sub    $0xc,%esp
8010429f:	68 e0 b2 14 80       	push   $0x8014b2e0
801042a4:	e8 67 06 00 00       	call   80104910 <acquire>
    for (int i = 0; i < container_array[c].number_of_process+1; i++) {
801042a9:	69 d3 a4 08 00 00    	imul   $0x8a4,%ebx,%edx
801042af:	83 c4 10             	add    $0x10,%esp
801042b2:	8b 8a c4 18 11 80    	mov    -0x7feee73c(%edx),%ecx
801042b8:	8d 82 c0 18 11 80    	lea    -0x7feee740(%edx),%eax
801042be:	85 c9                	test   %ecx,%ecx
801042c0:	78 7c                	js     8010433e <running_procs+0x14e>
801042c2:	8d ba cc 18 11 80    	lea    -0x7feee734(%edx),%edi
801042c8:	31 f6                	xor    %esi,%esi
801042ca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801042cd:	8d 76 00             	lea    0x0(%esi),%esi
801042d0:	bb 20 b3 14 80       	mov    $0x8014b320,%ebx
801042d5:	eb 17                	jmp    801042ee <running_procs+0xfe>
801042d7:	89 f6                	mov    %esi,%esi
801042d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801042e0:	81 c3 d0 01 00 00    	add    $0x1d0,%ebx
      for(int p = 0; p < NPROC; p++)
801042e6:	81 fb 20 27 15 80    	cmp    $0x80152720,%ebx
801042ec:	74 42                	je     80104330 <running_procs+0x140>
      {
        struct proc *pr;
        pr = &ptable.proc[p];
        if(pr->pid==container_array[c].mypid[i] && pr->state != UNUSED)
801042ee:	8b 43 04             	mov    0x4(%ebx),%eax
801042f1:	3b 07                	cmp    (%edi),%eax
801042f3:	75 eb                	jne    801042e0 <running_procs+0xf0>
801042f5:	8b 13                	mov    (%ebx),%edx
801042f7:	85 d2                	test   %edx,%edx
801042f9:	74 e5                	je     801042e0 <running_procs+0xf0>
        {
          cprintf("pid:%d name:%s",pr->pid,pr->name);
801042fb:	8d 8b b0 01 00 00    	lea    0x1b0(%ebx),%ecx
80104301:	83 ec 04             	sub    $0x4,%esp
80104304:	81 c3 d0 01 00 00    	add    $0x1d0,%ebx
8010430a:	51                   	push   %ecx
8010430b:	50                   	push   %eax
8010430c:	68 0b 8b 10 80       	push   $0x80108b0b
80104311:	e8 4a c3 ff ff       	call   80100660 <cprintf>
          cprintf("\n");
80104316:	c7 04 24 24 8d 10 80 	movl   $0x80108d24,(%esp)
8010431d:	e8 3e c3 ff ff       	call   80100660 <cprintf>
80104322:	83 c4 10             	add    $0x10,%esp
      for(int p = 0; p < NPROC; p++)
80104325:	81 fb 20 27 15 80    	cmp    $0x80152720,%ebx
8010432b:	75 c1                	jne    801042ee <running_procs+0xfe>
8010432d:	8d 76 00             	lea    0x0(%esi),%esi
    for (int i = 0; i < container_array[c].number_of_process+1; i++) {
80104330:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80104333:	83 c6 01             	add    $0x1,%esi
80104336:	83 c7 04             	add    $0x4,%edi
80104339:	39 70 04             	cmp    %esi,0x4(%eax)
8010433c:	7d 92                	jge    801042d0 <running_procs+0xe0>
    release(&ptable.lock);
8010433e:	83 ec 0c             	sub    $0xc,%esp
80104341:	68 e0 b2 14 80       	push   $0x8014b2e0
80104346:	e8 85 06 00 00       	call   801049d0 <release>
        }
      }
    }
    release(&ptable.lock);
  }
}
8010434b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010434e:	5b                   	pop    %ebx
8010434f:	5e                   	pop    %esi
80104350:	5f                   	pop    %edi
80104351:	5d                   	pop    %ebp
80104352:	c3                   	ret    
    int c = 0;
80104353:	31 db                	xor    %ebx,%ebx
80104355:	e9 42 ff ff ff       	jmp    8010429c <running_procs+0xac>
    acquire(&ptable.lock);
8010435a:	83 ec 0c             	sub    $0xc,%esp
8010435d:	bb d0 b4 14 80       	mov    $0x8014b4d0,%ebx
80104362:	be d0 28 15 80       	mov    $0x801528d0,%esi
80104367:	68 e0 b2 14 80       	push   $0x8014b2e0
8010436c:	e8 9f 05 00 00       	call   80104910 <acquire>
80104371:	83 c4 10             	add    $0x10,%esp
80104374:	eb 14                	jmp    8010438a <running_procs+0x19a>
80104376:	8d 76 00             	lea    0x0(%esi),%esi
80104379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104380:	81 c3 d0 01 00 00    	add    $0x1d0,%ebx
      for(int p = 0; p < NPROC; p++)
80104386:	39 de                	cmp    %ebx,%esi
80104388:	74 b4                	je     8010433e <running_procs+0x14e>
        if(pr->state != UNUSED)
8010438a:	8b bb 50 fe ff ff    	mov    -0x1b0(%ebx),%edi
80104390:	85 ff                	test   %edi,%edi
80104392:	74 ec                	je     80104380 <running_procs+0x190>
          cprintf("pid:%d name:%s",pr->pid,pr->name);
80104394:	83 ec 04             	sub    $0x4,%esp
80104397:	53                   	push   %ebx
80104398:	ff b3 54 fe ff ff    	pushl  -0x1ac(%ebx)
8010439e:	68 0b 8b 10 80       	push   $0x80108b0b
801043a3:	e8 b8 c2 ff ff       	call   80100660 <cprintf>
          cprintf("\n");
801043a8:	c7 04 24 24 8d 10 80 	movl   $0x80108d24,(%esp)
801043af:	e8 ac c2 ff ff       	call   80100660 <cprintf>
801043b4:	83 c4 10             	add    $0x10,%esp
801043b7:	eb c7                	jmp    80104380 <running_procs+0x190>
801043b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801043c0 <join_cont>:


int
join_cont(int cid){
801043c0:	55                   	push   %ebp
801043c1:	89 e5                	mov    %esp,%ebp
801043c3:	57                   	push   %edi
801043c4:	56                   	push   %esi
801043c5:	53                   	push   %ebx
801043c6:	83 ec 1c             	sub    $0x1c,%esp
  // cprintf("cid_to_ptable is:%d\n",cid_to_ptable);
  if (cid_to_ptable!=1){
801043c9:	83 3d b8 b5 10 80 01 	cmpl   $0x1,0x8010b5b8
join_cont(int cid){
801043d0:	8b 55 08             	mov    0x8(%ebp),%edx
  if (cid_to_ptable!=1){
801043d3:	0f 85 87 00 00 00    	jne    80104460 <join_cont+0xa0>
        pr->cid = -1;
      }
    release(&ptable.lock);
    cid_to_ptable = 1;
  }
  for (int i = 0; i < 100; i++) {
801043d9:	31 db                	xor    %ebx,%ebx
801043db:	eb 0f                	jmp    801043ec <join_cont+0x2c>
801043dd:	8d 76 00             	lea    0x0(%esi),%esi
801043e0:	83 c3 01             	add    $0x1,%ebx
801043e3:	83 fb 64             	cmp    $0x64,%ebx
801043e6:	0f 84 cb 00 00 00    	je     801044b7 <join_cont+0xf7>
    if (container_location[i]==1) {
801043ec:	8b 34 9d e0 79 14 80 	mov    -0x7feb8620(,%ebx,4),%esi
801043f3:	83 fe 01             	cmp    $0x1,%esi
801043f6:	75 e8                	jne    801043e0 <join_cont+0x20>
      if(container_array[i].cid==cid){
801043f8:	69 fb a4 08 00 00    	imul   $0x8a4,%ebx,%edi
801043fe:	39 97 c0 18 11 80    	cmp    %edx,-0x7feee740(%edi)
80104404:	75 da                	jne    801043e0 <join_cont+0x20>
80104406:	89 55 e0             	mov    %edx,-0x20(%ebp)
  pushcli();
80104409:	e8 32 04 00 00       	call   80104840 <pushcli>
  c = mycpu();
8010440e:	e8 5d f3 ff ff       	call   80103770 <mycpu>
  p = c->proc;
80104413:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
        struct proc *curproc = myproc();
        container_array[i].mypid[container_array[i].number_of_process]=curproc->pid;
80104419:	69 db 29 02 00 00    	imul   $0x229,%ebx,%ebx
  p = c->proc;
8010441f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  popcli();
80104422:	e8 59 04 00 00       	call   80104880 <popcli>
        container_array[i].mypid[container_array[i].number_of_process]=curproc->pid;
80104427:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010442a:	03 9f c4 18 11 80    	add    -0x7feee73c(%edi),%ebx
80104430:	81 c7 c0 18 11 80    	add    $0x801118c0,%edi
        curproc->cid = cid;
80104436:	8b 55 e0             	mov    -0x20(%ebp),%edx
        container_array[i].mypid[container_array[i].number_of_process]=curproc->pid;
80104439:	8b 48 10             	mov    0x10(%eax),%ecx
8010443c:	89 0c 9d cc 18 11 80 	mov    %ecx,-0x7feee734(,%ebx,4)
        curproc->cid = cid;
80104443:	89 90 cc 01 00 00    	mov    %edx,0x1cc(%eax)
        return 1;
      }
    }
  }
  return -1;
}
80104449:	89 f0                	mov    %esi,%eax
        container_array[i].number_of_process++;
8010444b:	83 47 04 01          	addl   $0x1,0x4(%edi)
}
8010444f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104452:	5b                   	pop    %ebx
80104453:	5e                   	pop    %esi
80104454:	5f                   	pop    %edi
80104455:	5d                   	pop    %ebp
80104456:	c3                   	ret    
80104457:	89 f6                	mov    %esi,%esi
80104459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    acquire(&ptable.lock);
80104460:	83 ec 0c             	sub    $0xc,%esp
80104463:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80104466:	68 e0 b2 14 80       	push   $0x8014b2e0
8010446b:	e8 a0 04 00 00       	call   80104910 <acquire>
80104470:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104473:	b8 e0 b4 14 80       	mov    $0x8014b4e0,%eax
80104478:	83 c4 10             	add    $0x10,%esp
8010447b:	90                   	nop
8010447c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        pr->cid = -1;
80104480:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
80104486:	05 d0 01 00 00       	add    $0x1d0,%eax
      for(int p = 0; p < NPROC; p++)
8010448b:	3d e0 28 15 80       	cmp    $0x801528e0,%eax
80104490:	75 ee                	jne    80104480 <join_cont+0xc0>
    release(&ptable.lock);
80104492:	83 ec 0c             	sub    $0xc,%esp
80104495:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80104498:	68 e0 b2 14 80       	push   $0x8014b2e0
8010449d:	e8 2e 05 00 00       	call   801049d0 <release>
    cid_to_ptable = 1;
801044a2:	c7 05 b8 b5 10 80 01 	movl   $0x1,0x8010b5b8
801044a9:	00 00 00 
801044ac:	83 c4 10             	add    $0x10,%esp
801044af:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801044b2:	e9 22 ff ff ff       	jmp    801043d9 <join_cont+0x19>
}
801044b7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801044ba:	be ff ff ff ff       	mov    $0xffffffff,%esi
}
801044bf:	89 f0                	mov    %esi,%eax
801044c1:	5b                   	pop    %ebx
801044c2:	5e                   	pop    %esi
801044c3:	5f                   	pop    %edi
801044c4:	5d                   	pop    %ebp
801044c5:	c3                   	ret    
801044c6:	8d 76 00             	lea    0x0(%esi),%esi
801044c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801044d0 <TransferMessage>:



void
TransferMessage(int msg_no, char* msg)
{
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	83 ec 0c             	sub    $0xc,%esp
  int len = 8;
  copyFromSystemSpace(msg,messageBuffers[msg_no],len);          // message size is 8
801044d6:	8b 45 08             	mov    0x8(%ebp),%eax
801044d9:	6a 08                	push   $0x8
801044db:	ff 34 85 e0 c5 10 80 	pushl  -0x7fef3a20(,%eax,4)
801044e2:	ff 75 0c             	pushl  0xc(%ebp)
801044e5:	e8 36 0c 00 00       	call   80105120 <copyFromSystemSpace>
  // freeMessageBuffer(msg_no);
}
801044ea:	83 c4 10             	add    $0x10,%esp
801044ed:	c9                   	leave  
801044ee:	c3                   	ret    
801044ef:	90                   	nop

801044f0 <sys_send>:


// sys call for send message//
int
sys_send(int sender_pid, int rec_pid, void *msg)
{
801044f0:	55                   	push   %ebp
801044f1:	89 e5                	mov    %esp,%ebp
801044f3:	53                   	push   %ebx
801044f4:	83 ec 24             	sub    $0x24,%esp
  if(isTraceOn==1)
801044f7:	83 3d b0 18 11 80 01 	cmpl   $0x1,0x801118b0
801044fe:	75 07                	jne    80104507 <sys_send+0x17>
  {num_calls[SYS_send] ++;}
80104500:	83 05 34 7e 14 80 01 	addl   $0x1,0x80147e34

  argint(0,&sender_pid);
80104507:	8d 45 08             	lea    0x8(%ebp),%eax
8010450a:	83 ec 08             	sub    $0x8,%esp
8010450d:	50                   	push   %eax
8010450e:	6a 00                	push   $0x0
80104510:	e8 0b 08 00 00       	call   80104d20 <argint>
  argint(1,&rec_pid);
80104515:	5a                   	pop    %edx
80104516:	8d 45 0c             	lea    0xc(%ebp),%eax
80104519:	59                   	pop    %ecx
8010451a:	50                   	push   %eax
8010451b:	6a 01                	push   $0x1
8010451d:	e8 fe 07 00 00       	call   80104d20 <argint>
  char * str;
  argstr(2,&str);
80104522:	5b                   	pop    %ebx
80104523:	58                   	pop    %eax
80104524:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104527:	50                   	push   %eax
80104528:	6a 02                	push   $0x2
8010452a:	e8 a1 08 00 00       	call   80104dd0 <argstr>
  // int len = 8;       //fixed for now
  int msg_no = getMessageBuffer();
8010452f:	e8 1c 0c 00 00       	call   80105150 <getMessageBuffer>
  if(msg_no ==EndOfFreeList)
80104534:	83 c4 10             	add    $0x10,%esp
80104537:	39 05 a0 8c 10 80    	cmp    %eax,0x80108ca0
  int msg_no = getMessageBuffer();
8010453d:	89 c3                	mov    %eax,%ebx
  if(msg_no ==EndOfFreeList)
8010453f:	74 7f                	je     801045c0 <sys_send+0xd0>
  cprintf("message buffers consumed\n");

  messageBuffers[msg_no] = (char *)kalloc();
80104541:	e8 aa df ff ff       	call   801024f0 <kalloc>
  safestrcpy(messageBuffers[msg_no],str,8);
80104546:	83 ec 04             	sub    $0x4,%esp
  messageBuffers[msg_no] = (char *)kalloc();
80104549:	89 04 9d e0 c5 10 80 	mov    %eax,-0x7fef3a20(,%ebx,4)
  safestrcpy(messageBuffers[msg_no],str,8);
80104550:	6a 08                	push   $0x8
80104552:	ff 75 f4             	pushl  -0xc(%ebp)
80104555:	50                   	push   %eax
80104556:	e8 a5 06 00 00       	call   80104c00 <safestrcpy>

  if( isWaitEmpty(wait_queue[rec_pid]) == 0 )          // some proc is waiting
8010455b:	58                   	pop    %eax
8010455c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010455f:	ff 34 85 e0 78 14 80 	pushl  -0x7feb8720(,%eax,4)
80104566:	e8 25 0a 00 00       	call   80104f90 <isWaitEmpty>
8010456b:	83 c4 10             	add    $0x10,%esp
8010456e:	85 c0                	test   %eax,%eax
80104570:	75 2a                	jne    8010459c <sys_send+0xac>
  {                                                    // amke that process runnable so that scheduler can run it
    int pid = (waitdequeue(wait_queue[rec_pid])).pid;  // and it can recieve.
80104572:	8b 55 0c             	mov    0xc(%ebp),%edx
80104575:	8d 45 e0             	lea    -0x20(%ebp),%eax
80104578:	83 ec 08             	sub    $0x8,%esp
8010457b:	ff 34 95 e0 78 14 80 	pushl  -0x7feb8720(,%edx,4)
80104582:	50                   	push   %eax
80104583:	e8 68 0a 00 00       	call   80104ff0 <waitdequeue>
    ptable.proc[pid].state = RUNNABLE;
80104588:	69 45 e0 d0 01 00 00 	imul   $0x1d0,-0x20(%ebp),%eax
8010458f:	83 c4 0c             	add    $0xc,%esp
80104592:	c7 80 20 b3 14 80 03 	movl   $0x3,-0x7feb4ce0(%eax)
80104599:	00 00 00 
  }

  enqueue(int_message_queue[rec_pid],msg_no);
8010459c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010459f:	83 ec 08             	sub    $0x8,%esp
801045a2:	53                   	push   %ebx
801045a3:	ff 34 85 00 80 14 80 	pushl  -0x7feb8000(,%eax,4)
801045aa:	e8 c1 0a 00 00       	call   80105070 <enqueue>

  return 1;
}
801045af:	b8 01 00 00 00       	mov    $0x1,%eax
801045b4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801045b7:	c9                   	leave  
801045b8:	c3                   	ret    
801045b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  cprintf("message buffers consumed\n");
801045c0:	83 ec 0c             	sub    $0xc,%esp
801045c3:	68 1a 8b 10 80       	push   $0x80108b1a
801045c8:	e8 93 c0 ff ff       	call   80100660 <cprintf>
801045cd:	83 c4 10             	add    $0x10,%esp
801045d0:	e9 6c ff ff ff       	jmp    80104541 <sys_send+0x51>
801045d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045e0 <sys_recv>:


int
sys_recv(void *msg)
{
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
801045e3:	53                   	push   %ebx
801045e4:	83 ec 14             	sub    $0x14,%esp

  if(isTraceOn==1)
801045e7:	83 3d b0 18 11 80 01 	cmpl   $0x1,0x801118b0
801045ee:	75 07                	jne    801045f7 <sys_recv+0x17>
  {num_calls[SYS_recv] ++;}
801045f0:	83 05 38 7e 14 80 01 	addl   $0x1,0x80147e38

  char* str;
  argstr(0,&str);
801045f7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801045fa:	83 ec 08             	sub    $0x8,%esp
801045fd:	50                   	push   %eax
801045fe:	6a 00                	push   $0x0
80104600:	e8 cb 07 00 00       	call   80104dd0 <argstr>
  pushcli();
80104605:	e8 36 02 00 00       	call   80104840 <pushcli>
  c = mycpu();
8010460a:	e8 61 f1 ff ff       	call   80103770 <mycpu>
  p = c->proc;
8010460f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104615:	e8 66 02 00 00       	call   80104880 <popcli>
  struct proc *curproc = myproc();
  if(isEmpty(int_message_queue[curproc->pid]) == 1)
8010461a:	58                   	pop    %eax
8010461b:	8b 43 10             	mov    0x10(%ebx),%eax
8010461e:	ff 34 85 00 80 14 80 	pushl  -0x7feb8000(,%eax,4)
80104625:	e8 26 0a 00 00       	call   80105050 <isEmpty>
8010462a:	83 c4 10             	add    $0x10,%esp
8010462d:	83 f8 01             	cmp    $0x1,%eax
80104630:	74 36                	je     80104668 <sys_recv+0x88>
    item.buffer = str;                            // block the current item
    waitenqueue(wait_queue[curproc->pid],item);   // and put in wait queue.
    sched();                                     // call the scheduler (non-blocking)
  }
  else{
  int msg_no= dequeue(int_message_queue[curproc->pid]);
80104632:	8b 43 10             	mov    0x10(%ebx),%eax
80104635:	83 ec 0c             	sub    $0xc,%esp
80104638:	ff 34 85 00 80 14 80 	pushl  -0x7feb8000(,%eax,4)
8010463f:	e8 5c 0a 00 00       	call   801050a0 <dequeue>
  safestrcpy(str,messageBuffers[msg_no],8);            // if there is message in the message queue then recieve it
80104644:	83 c4 0c             	add    $0xc,%esp
80104647:	6a 08                	push   $0x8
80104649:	ff 34 85 e0 c5 10 80 	pushl  -0x7fef3a20(,%eax,4)
80104650:	ff 75 f4             	pushl  -0xc(%ebp)
80104653:	e8 a8 05 00 00       	call   80104c00 <safestrcpy>
80104658:	83 c4 10             	add    $0x10,%esp
  }
  return 1;
}
8010465b:	b8 01 00 00 00       	mov    $0x1,%eax
80104660:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104663:	c9                   	leave  
80104664:	c3                   	ret    
80104665:	8d 76 00             	lea    0x0(%esi),%esi
    item.pid = curproc->pid;
80104668:	8b 4b 10             	mov    0x10(%ebx),%ecx
    item.buffer = str;                            // block the current item
8010466b:	8b 55 f4             	mov    -0xc(%ebp),%edx
    waitenqueue(wait_queue[curproc->pid],item);   // and put in wait queue.
8010466e:	83 ec 04             	sub    $0x4,%esp
    curproc->state = SLEEPING;                    // block the current process
80104671:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
    waitenqueue(wait_queue[curproc->pid],item);   // and put in wait queue.
80104678:	52                   	push   %edx
80104679:	51                   	push   %ecx
8010467a:	ff 34 8d e0 78 14 80 	pushl  -0x7feb8720(,%ecx,4)
80104681:	e8 2a 09 00 00       	call   80104fb0 <waitenqueue>
    sched();                                     // call the scheduler (non-blocking)
80104686:	e8 95 f5 ff ff       	call   80103c20 <sched>
8010468b:	83 c4 10             	add    $0x10,%esp
}
8010468e:	b8 01 00 00 00       	mov    $0x1,%eax
80104693:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104696:	c9                   	leave  
80104697:	c3                   	ret    
80104698:	66 90                	xchg   %ax,%ax
8010469a:	66 90                	xchg   %ax,%ax
8010469c:	66 90                	xchg   %ax,%ax
8010469e:	66 90                	xchg   %ax,%ax

801046a0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801046a0:	55                   	push   %ebp
801046a1:	89 e5                	mov    %esp,%ebp
801046a3:	53                   	push   %ebx
801046a4:	83 ec 0c             	sub    $0xc,%esp
801046a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801046aa:	68 a0 8b 10 80       	push   $0x80108ba0
801046af:	8d 43 04             	lea    0x4(%ebx),%eax
801046b2:	50                   	push   %eax
801046b3:	e8 18 01 00 00       	call   801047d0 <initlock>
  lk->name = name;
801046b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801046bb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801046c1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801046c4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801046cb:	89 43 38             	mov    %eax,0x38(%ebx)
}
801046ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801046d1:	c9                   	leave  
801046d2:	c3                   	ret    
801046d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801046d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046e0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801046e0:	55                   	push   %ebp
801046e1:	89 e5                	mov    %esp,%ebp
801046e3:	56                   	push   %esi
801046e4:	53                   	push   %ebx
801046e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801046e8:	83 ec 0c             	sub    $0xc,%esp
801046eb:	8d 73 04             	lea    0x4(%ebx),%esi
801046ee:	56                   	push   %esi
801046ef:	e8 1c 02 00 00       	call   80104910 <acquire>
  while (lk->locked) {
801046f4:	8b 13                	mov    (%ebx),%edx
801046f6:	83 c4 10             	add    $0x10,%esp
801046f9:	85 d2                	test   %edx,%edx
801046fb:	74 16                	je     80104713 <acquiresleep+0x33>
801046fd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104700:	83 ec 08             	sub    $0x8,%esp
80104703:	56                   	push   %esi
80104704:	53                   	push   %ebx
80104705:	e8 66 f7 ff ff       	call   80103e70 <sleep>
  while (lk->locked) {
8010470a:	8b 03                	mov    (%ebx),%eax
8010470c:	83 c4 10             	add    $0x10,%esp
8010470f:	85 c0                	test   %eax,%eax
80104711:	75 ed                	jne    80104700 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104713:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104719:	e8 f2 f0 ff ff       	call   80103810 <myproc>
8010471e:	8b 40 10             	mov    0x10(%eax),%eax
80104721:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104724:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104727:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010472a:	5b                   	pop    %ebx
8010472b:	5e                   	pop    %esi
8010472c:	5d                   	pop    %ebp
  release(&lk->lk);
8010472d:	e9 9e 02 00 00       	jmp    801049d0 <release>
80104732:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104740 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
80104743:	56                   	push   %esi
80104744:	53                   	push   %ebx
80104745:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104748:	83 ec 0c             	sub    $0xc,%esp
8010474b:	8d 73 04             	lea    0x4(%ebx),%esi
8010474e:	56                   	push   %esi
8010474f:	e8 bc 01 00 00       	call   80104910 <acquire>
  lk->locked = 0;
80104754:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010475a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104761:	89 1c 24             	mov    %ebx,(%esp)
80104764:	e8 c7 f8 ff ff       	call   80104030 <wakeup>
  release(&lk->lk);
80104769:	89 75 08             	mov    %esi,0x8(%ebp)
8010476c:	83 c4 10             	add    $0x10,%esp
}
8010476f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104772:	5b                   	pop    %ebx
80104773:	5e                   	pop    %esi
80104774:	5d                   	pop    %ebp
  release(&lk->lk);
80104775:	e9 56 02 00 00       	jmp    801049d0 <release>
8010477a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104780 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104780:	55                   	push   %ebp
80104781:	89 e5                	mov    %esp,%ebp
80104783:	57                   	push   %edi
80104784:	56                   	push   %esi
80104785:	53                   	push   %ebx
80104786:	31 ff                	xor    %edi,%edi
80104788:	83 ec 18             	sub    $0x18,%esp
8010478b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010478e:	8d 73 04             	lea    0x4(%ebx),%esi
80104791:	56                   	push   %esi
80104792:	e8 79 01 00 00       	call   80104910 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104797:	8b 03                	mov    (%ebx),%eax
80104799:	83 c4 10             	add    $0x10,%esp
8010479c:	85 c0                	test   %eax,%eax
8010479e:	74 13                	je     801047b3 <holdingsleep+0x33>
801047a0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801047a3:	e8 68 f0 ff ff       	call   80103810 <myproc>
801047a8:	39 58 10             	cmp    %ebx,0x10(%eax)
801047ab:	0f 94 c0             	sete   %al
801047ae:	0f b6 c0             	movzbl %al,%eax
801047b1:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
801047b3:	83 ec 0c             	sub    $0xc,%esp
801047b6:	56                   	push   %esi
801047b7:	e8 14 02 00 00       	call   801049d0 <release>
  return r;
}
801047bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801047bf:	89 f8                	mov    %edi,%eax
801047c1:	5b                   	pop    %ebx
801047c2:	5e                   	pop    %esi
801047c3:	5f                   	pop    %edi
801047c4:	5d                   	pop    %ebp
801047c5:	c3                   	ret    
801047c6:	66 90                	xchg   %ax,%ax
801047c8:	66 90                	xchg   %ax,%ax
801047ca:	66 90                	xchg   %ax,%ax
801047cc:	66 90                	xchg   %ax,%ax
801047ce:	66 90                	xchg   %ax,%ax

801047d0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801047d0:	55                   	push   %ebp
801047d1:	89 e5                	mov    %esp,%ebp
801047d3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801047d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801047d9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801047df:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801047e2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801047e9:	5d                   	pop    %ebp
801047ea:	c3                   	ret    
801047eb:	90                   	nop
801047ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801047f0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801047f0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801047f1:	31 d2                	xor    %edx,%edx
{
801047f3:	89 e5                	mov    %esp,%ebp
801047f5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801047f6:	8b 45 08             	mov    0x8(%ebp),%eax
{
801047f9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
801047fc:	83 e8 08             	sub    $0x8,%eax
801047ff:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104800:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104806:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010480c:	77 1a                	ja     80104828 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010480e:	8b 58 04             	mov    0x4(%eax),%ebx
80104811:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104814:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104817:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104819:	83 fa 0a             	cmp    $0xa,%edx
8010481c:	75 e2                	jne    80104800 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010481e:	5b                   	pop    %ebx
8010481f:	5d                   	pop    %ebp
80104820:	c3                   	ret    
80104821:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104828:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010482b:	83 c1 28             	add    $0x28,%ecx
8010482e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104830:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104836:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104839:	39 c1                	cmp    %eax,%ecx
8010483b:	75 f3                	jne    80104830 <getcallerpcs+0x40>
}
8010483d:	5b                   	pop    %ebx
8010483e:	5d                   	pop    %ebp
8010483f:	c3                   	ret    

80104840 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104840:	55                   	push   %ebp
80104841:	89 e5                	mov    %esp,%ebp
80104843:	53                   	push   %ebx
80104844:	83 ec 04             	sub    $0x4,%esp
80104847:	9c                   	pushf  
80104848:	5b                   	pop    %ebx
  asm volatile("cli");
80104849:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010484a:	e8 21 ef ff ff       	call   80103770 <mycpu>
8010484f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104855:	85 c0                	test   %eax,%eax
80104857:	75 11                	jne    8010486a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104859:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010485f:	e8 0c ef ff ff       	call   80103770 <mycpu>
80104864:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010486a:	e8 01 ef ff ff       	call   80103770 <mycpu>
8010486f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104876:	83 c4 04             	add    $0x4,%esp
80104879:	5b                   	pop    %ebx
8010487a:	5d                   	pop    %ebp
8010487b:	c3                   	ret    
8010487c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104880 <popcli>:

void
popcli(void)
{
80104880:	55                   	push   %ebp
80104881:	89 e5                	mov    %esp,%ebp
80104883:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104886:	9c                   	pushf  
80104887:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104888:	f6 c4 02             	test   $0x2,%ah
8010488b:	75 35                	jne    801048c2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010488d:	e8 de ee ff ff       	call   80103770 <mycpu>
80104892:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104899:	78 34                	js     801048cf <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010489b:	e8 d0 ee ff ff       	call   80103770 <mycpu>
801048a0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801048a6:	85 d2                	test   %edx,%edx
801048a8:	74 06                	je     801048b0 <popcli+0x30>
    sti();
}
801048aa:	c9                   	leave  
801048ab:	c3                   	ret    
801048ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801048b0:	e8 bb ee ff ff       	call   80103770 <mycpu>
801048b5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801048bb:	85 c0                	test   %eax,%eax
801048bd:	74 eb                	je     801048aa <popcli+0x2a>
  asm volatile("sti");
801048bf:	fb                   	sti    
}
801048c0:	c9                   	leave  
801048c1:	c3                   	ret    
    panic("popcli - interruptible");
801048c2:	83 ec 0c             	sub    $0xc,%esp
801048c5:	68 ab 8b 10 80       	push   $0x80108bab
801048ca:	e8 c1 ba ff ff       	call   80100390 <panic>
    panic("popcli");
801048cf:	83 ec 0c             	sub    $0xc,%esp
801048d2:	68 c2 8b 10 80       	push   $0x80108bc2
801048d7:	e8 b4 ba ff ff       	call   80100390 <panic>
801048dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801048e0 <holding>:
{
801048e0:	55                   	push   %ebp
801048e1:	89 e5                	mov    %esp,%ebp
801048e3:	56                   	push   %esi
801048e4:	53                   	push   %ebx
801048e5:	8b 75 08             	mov    0x8(%ebp),%esi
801048e8:	31 db                	xor    %ebx,%ebx
  pushcli();
801048ea:	e8 51 ff ff ff       	call   80104840 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801048ef:	8b 06                	mov    (%esi),%eax
801048f1:	85 c0                	test   %eax,%eax
801048f3:	74 10                	je     80104905 <holding+0x25>
801048f5:	8b 5e 08             	mov    0x8(%esi),%ebx
801048f8:	e8 73 ee ff ff       	call   80103770 <mycpu>
801048fd:	39 c3                	cmp    %eax,%ebx
801048ff:	0f 94 c3             	sete   %bl
80104902:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104905:	e8 76 ff ff ff       	call   80104880 <popcli>
}
8010490a:	89 d8                	mov    %ebx,%eax
8010490c:	5b                   	pop    %ebx
8010490d:	5e                   	pop    %esi
8010490e:	5d                   	pop    %ebp
8010490f:	c3                   	ret    

80104910 <acquire>:
{
80104910:	55                   	push   %ebp
80104911:	89 e5                	mov    %esp,%ebp
80104913:	56                   	push   %esi
80104914:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104915:	e8 26 ff ff ff       	call   80104840 <pushcli>
  if(holding(lk))
8010491a:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010491d:	83 ec 0c             	sub    $0xc,%esp
80104920:	53                   	push   %ebx
80104921:	e8 ba ff ff ff       	call   801048e0 <holding>
80104926:	83 c4 10             	add    $0x10,%esp
80104929:	85 c0                	test   %eax,%eax
8010492b:	0f 85 83 00 00 00    	jne    801049b4 <acquire+0xa4>
80104931:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104933:	ba 01 00 00 00       	mov    $0x1,%edx
80104938:	eb 09                	jmp    80104943 <acquire+0x33>
8010493a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104940:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104943:	89 d0                	mov    %edx,%eax
80104945:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104948:	85 c0                	test   %eax,%eax
8010494a:	75 f4                	jne    80104940 <acquire+0x30>
  __sync_synchronize();
8010494c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104951:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104954:	e8 17 ee ff ff       	call   80103770 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104959:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
8010495c:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
8010495f:	89 e8                	mov    %ebp,%eax
80104961:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104968:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
8010496e:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104974:	77 1a                	ja     80104990 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104976:	8b 48 04             	mov    0x4(%eax),%ecx
80104979:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
8010497c:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
8010497f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104981:	83 fe 0a             	cmp    $0xa,%esi
80104984:	75 e2                	jne    80104968 <acquire+0x58>
}
80104986:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104989:	5b                   	pop    %ebx
8010498a:	5e                   	pop    %esi
8010498b:	5d                   	pop    %ebp
8010498c:	c3                   	ret    
8010498d:	8d 76 00             	lea    0x0(%esi),%esi
80104990:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104993:	83 c2 28             	add    $0x28,%edx
80104996:	8d 76 00             	lea    0x0(%esi),%esi
80104999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
801049a0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801049a6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801049a9:	39 d0                	cmp    %edx,%eax
801049ab:	75 f3                	jne    801049a0 <acquire+0x90>
}
801049ad:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049b0:	5b                   	pop    %ebx
801049b1:	5e                   	pop    %esi
801049b2:	5d                   	pop    %ebp
801049b3:	c3                   	ret    
    panic("acquire");
801049b4:	83 ec 0c             	sub    $0xc,%esp
801049b7:	68 c9 8b 10 80       	push   $0x80108bc9
801049bc:	e8 cf b9 ff ff       	call   80100390 <panic>
801049c1:	eb 0d                	jmp    801049d0 <release>
801049c3:	90                   	nop
801049c4:	90                   	nop
801049c5:	90                   	nop
801049c6:	90                   	nop
801049c7:	90                   	nop
801049c8:	90                   	nop
801049c9:	90                   	nop
801049ca:	90                   	nop
801049cb:	90                   	nop
801049cc:	90                   	nop
801049cd:	90                   	nop
801049ce:	90                   	nop
801049cf:	90                   	nop

801049d0 <release>:
{
801049d0:	55                   	push   %ebp
801049d1:	89 e5                	mov    %esp,%ebp
801049d3:	53                   	push   %ebx
801049d4:	83 ec 10             	sub    $0x10,%esp
801049d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
801049da:	53                   	push   %ebx
801049db:	e8 00 ff ff ff       	call   801048e0 <holding>
801049e0:	83 c4 10             	add    $0x10,%esp
801049e3:	85 c0                	test   %eax,%eax
801049e5:	74 22                	je     80104a09 <release+0x39>
  lk->pcs[0] = 0;
801049e7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801049ee:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
801049f5:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801049fa:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104a00:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a03:	c9                   	leave  
  popcli();
80104a04:	e9 77 fe ff ff       	jmp    80104880 <popcli>
    panic("release");
80104a09:	83 ec 0c             	sub    $0xc,%esp
80104a0c:	68 d1 8b 10 80       	push   $0x80108bd1
80104a11:	e8 7a b9 ff ff       	call   80100390 <panic>
80104a16:	66 90                	xchg   %ax,%ax
80104a18:	66 90                	xchg   %ax,%ax
80104a1a:	66 90                	xchg   %ax,%ax
80104a1c:	66 90                	xchg   %ax,%ax
80104a1e:	66 90                	xchg   %ax,%ax

80104a20 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	57                   	push   %edi
80104a24:	53                   	push   %ebx
80104a25:	8b 55 08             	mov    0x8(%ebp),%edx
80104a28:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104a2b:	f6 c2 03             	test   $0x3,%dl
80104a2e:	75 05                	jne    80104a35 <memset+0x15>
80104a30:	f6 c1 03             	test   $0x3,%cl
80104a33:	74 13                	je     80104a48 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104a35:	89 d7                	mov    %edx,%edi
80104a37:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a3a:	fc                   	cld    
80104a3b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104a3d:	5b                   	pop    %ebx
80104a3e:	89 d0                	mov    %edx,%eax
80104a40:	5f                   	pop    %edi
80104a41:	5d                   	pop    %ebp
80104a42:	c3                   	ret    
80104a43:	90                   	nop
80104a44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104a48:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104a4c:	c1 e9 02             	shr    $0x2,%ecx
80104a4f:	89 f8                	mov    %edi,%eax
80104a51:	89 fb                	mov    %edi,%ebx
80104a53:	c1 e0 18             	shl    $0x18,%eax
80104a56:	c1 e3 10             	shl    $0x10,%ebx
80104a59:	09 d8                	or     %ebx,%eax
80104a5b:	09 f8                	or     %edi,%eax
80104a5d:	c1 e7 08             	shl    $0x8,%edi
80104a60:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104a62:	89 d7                	mov    %edx,%edi
80104a64:	fc                   	cld    
80104a65:	f3 ab                	rep stos %eax,%es:(%edi)
}
80104a67:	5b                   	pop    %ebx
80104a68:	89 d0                	mov    %edx,%eax
80104a6a:	5f                   	pop    %edi
80104a6b:	5d                   	pop    %ebp
80104a6c:	c3                   	ret    
80104a6d:	8d 76 00             	lea    0x0(%esi),%esi

80104a70 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104a70:	55                   	push   %ebp
80104a71:	89 e5                	mov    %esp,%ebp
80104a73:	57                   	push   %edi
80104a74:	56                   	push   %esi
80104a75:	53                   	push   %ebx
80104a76:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104a79:	8b 75 08             	mov    0x8(%ebp),%esi
80104a7c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104a7f:	85 db                	test   %ebx,%ebx
80104a81:	74 29                	je     80104aac <memcmp+0x3c>
    if(*s1 != *s2)
80104a83:	0f b6 16             	movzbl (%esi),%edx
80104a86:	0f b6 0f             	movzbl (%edi),%ecx
80104a89:	38 d1                	cmp    %dl,%cl
80104a8b:	75 2b                	jne    80104ab8 <memcmp+0x48>
80104a8d:	b8 01 00 00 00       	mov    $0x1,%eax
80104a92:	eb 14                	jmp    80104aa8 <memcmp+0x38>
80104a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a98:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80104a9c:	83 c0 01             	add    $0x1,%eax
80104a9f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104aa4:	38 ca                	cmp    %cl,%dl
80104aa6:	75 10                	jne    80104ab8 <memcmp+0x48>
  while(n-- > 0){
80104aa8:	39 d8                	cmp    %ebx,%eax
80104aaa:	75 ec                	jne    80104a98 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80104aac:	5b                   	pop    %ebx
  return 0;
80104aad:	31 c0                	xor    %eax,%eax
}
80104aaf:	5e                   	pop    %esi
80104ab0:	5f                   	pop    %edi
80104ab1:	5d                   	pop    %ebp
80104ab2:	c3                   	ret    
80104ab3:	90                   	nop
80104ab4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104ab8:	0f b6 c2             	movzbl %dl,%eax
}
80104abb:	5b                   	pop    %ebx
      return *s1 - *s2;
80104abc:	29 c8                	sub    %ecx,%eax
}
80104abe:	5e                   	pop    %esi
80104abf:	5f                   	pop    %edi
80104ac0:	5d                   	pop    %ebp
80104ac1:	c3                   	ret    
80104ac2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ad0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104ad0:	55                   	push   %ebp
80104ad1:	89 e5                	mov    %esp,%ebp
80104ad3:	56                   	push   %esi
80104ad4:	53                   	push   %ebx
80104ad5:	8b 45 08             	mov    0x8(%ebp),%eax
80104ad8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104adb:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104ade:	39 c3                	cmp    %eax,%ebx
80104ae0:	73 26                	jae    80104b08 <memmove+0x38>
80104ae2:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104ae5:	39 c8                	cmp    %ecx,%eax
80104ae7:	73 1f                	jae    80104b08 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104ae9:	85 f6                	test   %esi,%esi
80104aeb:	8d 56 ff             	lea    -0x1(%esi),%edx
80104aee:	74 0f                	je     80104aff <memmove+0x2f>
      *--d = *--s;
80104af0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104af4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104af7:	83 ea 01             	sub    $0x1,%edx
80104afa:	83 fa ff             	cmp    $0xffffffff,%edx
80104afd:	75 f1                	jne    80104af0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104aff:	5b                   	pop    %ebx
80104b00:	5e                   	pop    %esi
80104b01:	5d                   	pop    %ebp
80104b02:	c3                   	ret    
80104b03:	90                   	nop
80104b04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104b08:	31 d2                	xor    %edx,%edx
80104b0a:	85 f6                	test   %esi,%esi
80104b0c:	74 f1                	je     80104aff <memmove+0x2f>
80104b0e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104b10:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104b14:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104b17:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
80104b1a:	39 d6                	cmp    %edx,%esi
80104b1c:	75 f2                	jne    80104b10 <memmove+0x40>
}
80104b1e:	5b                   	pop    %ebx
80104b1f:	5e                   	pop    %esi
80104b20:	5d                   	pop    %ebp
80104b21:	c3                   	ret    
80104b22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b30 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104b30:	55                   	push   %ebp
80104b31:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104b33:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104b34:	eb 9a                	jmp    80104ad0 <memmove>
80104b36:	8d 76 00             	lea    0x0(%esi),%esi
80104b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b40 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104b40:	55                   	push   %ebp
80104b41:	89 e5                	mov    %esp,%ebp
80104b43:	57                   	push   %edi
80104b44:	56                   	push   %esi
80104b45:	8b 7d 10             	mov    0x10(%ebp),%edi
80104b48:	53                   	push   %ebx
80104b49:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104b4c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
80104b4f:	85 ff                	test   %edi,%edi
80104b51:	74 2f                	je     80104b82 <strncmp+0x42>
80104b53:	0f b6 01             	movzbl (%ecx),%eax
80104b56:	0f b6 1e             	movzbl (%esi),%ebx
80104b59:	84 c0                	test   %al,%al
80104b5b:	74 37                	je     80104b94 <strncmp+0x54>
80104b5d:	38 c3                	cmp    %al,%bl
80104b5f:	75 33                	jne    80104b94 <strncmp+0x54>
80104b61:	01 f7                	add    %esi,%edi
80104b63:	eb 13                	jmp    80104b78 <strncmp+0x38>
80104b65:	8d 76 00             	lea    0x0(%esi),%esi
80104b68:	0f b6 01             	movzbl (%ecx),%eax
80104b6b:	84 c0                	test   %al,%al
80104b6d:	74 21                	je     80104b90 <strncmp+0x50>
80104b6f:	0f b6 1a             	movzbl (%edx),%ebx
80104b72:	89 d6                	mov    %edx,%esi
80104b74:	38 d8                	cmp    %bl,%al
80104b76:	75 1c                	jne    80104b94 <strncmp+0x54>
    n--, p++, q++;
80104b78:	8d 56 01             	lea    0x1(%esi),%edx
80104b7b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104b7e:	39 fa                	cmp    %edi,%edx
80104b80:	75 e6                	jne    80104b68 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104b82:	5b                   	pop    %ebx
    return 0;
80104b83:	31 c0                	xor    %eax,%eax
}
80104b85:	5e                   	pop    %esi
80104b86:	5f                   	pop    %edi
80104b87:	5d                   	pop    %ebp
80104b88:	c3                   	ret    
80104b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b90:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104b94:	29 d8                	sub    %ebx,%eax
}
80104b96:	5b                   	pop    %ebx
80104b97:	5e                   	pop    %esi
80104b98:	5f                   	pop    %edi
80104b99:	5d                   	pop    %ebp
80104b9a:	c3                   	ret    
80104b9b:	90                   	nop
80104b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ba0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104ba0:	55                   	push   %ebp
80104ba1:	89 e5                	mov    %esp,%ebp
80104ba3:	56                   	push   %esi
80104ba4:	53                   	push   %ebx
80104ba5:	8b 45 08             	mov    0x8(%ebp),%eax
80104ba8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104bab:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104bae:	89 c2                	mov    %eax,%edx
80104bb0:	eb 19                	jmp    80104bcb <strncpy+0x2b>
80104bb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104bb8:	83 c3 01             	add    $0x1,%ebx
80104bbb:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
80104bbf:	83 c2 01             	add    $0x1,%edx
80104bc2:	84 c9                	test   %cl,%cl
80104bc4:	88 4a ff             	mov    %cl,-0x1(%edx)
80104bc7:	74 09                	je     80104bd2 <strncpy+0x32>
80104bc9:	89 f1                	mov    %esi,%ecx
80104bcb:	85 c9                	test   %ecx,%ecx
80104bcd:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104bd0:	7f e6                	jg     80104bb8 <strncpy+0x18>
    ;
  while(n-- > 0)
80104bd2:	31 c9                	xor    %ecx,%ecx
80104bd4:	85 f6                	test   %esi,%esi
80104bd6:	7e 17                	jle    80104bef <strncpy+0x4f>
80104bd8:	90                   	nop
80104bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104be0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104be4:	89 f3                	mov    %esi,%ebx
80104be6:	83 c1 01             	add    $0x1,%ecx
80104be9:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
80104beb:	85 db                	test   %ebx,%ebx
80104bed:	7f f1                	jg     80104be0 <strncpy+0x40>
  return os;
}
80104bef:	5b                   	pop    %ebx
80104bf0:	5e                   	pop    %esi
80104bf1:	5d                   	pop    %ebp
80104bf2:	c3                   	ret    
80104bf3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c00 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104c00:	55                   	push   %ebp
80104c01:	89 e5                	mov    %esp,%ebp
80104c03:	56                   	push   %esi
80104c04:	53                   	push   %ebx
80104c05:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104c08:	8b 45 08             	mov    0x8(%ebp),%eax
80104c0b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80104c0e:	85 c9                	test   %ecx,%ecx
80104c10:	7e 26                	jle    80104c38 <safestrcpy+0x38>
80104c12:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104c16:	89 c1                	mov    %eax,%ecx
80104c18:	eb 17                	jmp    80104c31 <safestrcpy+0x31>
80104c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104c20:	83 c2 01             	add    $0x1,%edx
80104c23:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104c27:	83 c1 01             	add    $0x1,%ecx
80104c2a:	84 db                	test   %bl,%bl
80104c2c:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104c2f:	74 04                	je     80104c35 <safestrcpy+0x35>
80104c31:	39 f2                	cmp    %esi,%edx
80104c33:	75 eb                	jne    80104c20 <safestrcpy+0x20>
    ;
  *s = 0;
80104c35:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104c38:	5b                   	pop    %ebx
80104c39:	5e                   	pop    %esi
80104c3a:	5d                   	pop    %ebp
80104c3b:	c3                   	ret    
80104c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c40 <strlen>:

int
strlen(const char *s)
{
80104c40:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104c41:	31 c0                	xor    %eax,%eax
{
80104c43:	89 e5                	mov    %esp,%ebp
80104c45:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104c48:	80 3a 00             	cmpb   $0x0,(%edx)
80104c4b:	74 0c                	je     80104c59 <strlen+0x19>
80104c4d:	8d 76 00             	lea    0x0(%esi),%esi
80104c50:	83 c0 01             	add    $0x1,%eax
80104c53:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104c57:	75 f7                	jne    80104c50 <strlen+0x10>
    ;
  return n;
}
80104c59:	5d                   	pop    %ebp
80104c5a:	c3                   	ret    

80104c5b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104c5b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104c5f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104c63:	55                   	push   %ebp
  pushl %ebx
80104c64:	53                   	push   %ebx
  pushl %esi
80104c65:	56                   	push   %esi
  pushl %edi
80104c66:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104c67:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104c69:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104c6b:	5f                   	pop    %edi
  popl %esi
80104c6c:	5e                   	pop    %esi
  popl %ebx
80104c6d:	5b                   	pop    %ebx
  popl %ebp
80104c6e:	5d                   	pop    %ebp
  ret
80104c6f:	c3                   	ret    

80104c70 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104c70:	55                   	push   %ebp
80104c71:	89 e5                	mov    %esp,%ebp
80104c73:	53                   	push   %ebx
80104c74:	83 ec 04             	sub    $0x4,%esp
80104c77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104c7a:	e8 91 eb ff ff       	call   80103810 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104c7f:	8b 00                	mov    (%eax),%eax
80104c81:	39 d8                	cmp    %ebx,%eax
80104c83:	76 1b                	jbe    80104ca0 <fetchint+0x30>
80104c85:	8d 53 04             	lea    0x4(%ebx),%edx
80104c88:	39 d0                	cmp    %edx,%eax
80104c8a:	72 14                	jb     80104ca0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104c8c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104c8f:	8b 13                	mov    (%ebx),%edx
80104c91:	89 10                	mov    %edx,(%eax)
  return 0;
80104c93:	31 c0                	xor    %eax,%eax
}
80104c95:	83 c4 04             	add    $0x4,%esp
80104c98:	5b                   	pop    %ebx
80104c99:	5d                   	pop    %ebp
80104c9a:	c3                   	ret    
80104c9b:	90                   	nop
80104c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104ca0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ca5:	eb ee                	jmp    80104c95 <fetchint+0x25>
80104ca7:	89 f6                	mov    %esi,%esi
80104ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104cb0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104cb0:	55                   	push   %ebp
80104cb1:	89 e5                	mov    %esp,%ebp
80104cb3:	53                   	push   %ebx
80104cb4:	83 ec 04             	sub    $0x4,%esp
80104cb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104cba:	e8 51 eb ff ff       	call   80103810 <myproc>

  if(addr >= curproc->sz)
80104cbf:	39 18                	cmp    %ebx,(%eax)
80104cc1:	76 29                	jbe    80104cec <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104cc3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104cc6:	89 da                	mov    %ebx,%edx
80104cc8:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80104cca:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80104ccc:	39 c3                	cmp    %eax,%ebx
80104cce:	73 1c                	jae    80104cec <fetchstr+0x3c>
    if(*s == 0)
80104cd0:	80 3b 00             	cmpb   $0x0,(%ebx)
80104cd3:	75 10                	jne    80104ce5 <fetchstr+0x35>
80104cd5:	eb 39                	jmp    80104d10 <fetchstr+0x60>
80104cd7:	89 f6                	mov    %esi,%esi
80104cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104ce0:	80 3a 00             	cmpb   $0x0,(%edx)
80104ce3:	74 1b                	je     80104d00 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80104ce5:	83 c2 01             	add    $0x1,%edx
80104ce8:	39 d0                	cmp    %edx,%eax
80104cea:	77 f4                	ja     80104ce0 <fetchstr+0x30>
    return -1;
80104cec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80104cf1:	83 c4 04             	add    $0x4,%esp
80104cf4:	5b                   	pop    %ebx
80104cf5:	5d                   	pop    %ebp
80104cf6:	c3                   	ret    
80104cf7:	89 f6                	mov    %esi,%esi
80104cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104d00:	83 c4 04             	add    $0x4,%esp
80104d03:	89 d0                	mov    %edx,%eax
80104d05:	29 d8                	sub    %ebx,%eax
80104d07:	5b                   	pop    %ebx
80104d08:	5d                   	pop    %ebp
80104d09:	c3                   	ret    
80104d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80104d10:	31 c0                	xor    %eax,%eax
      return s - *pp;
80104d12:	eb dd                	jmp    80104cf1 <fetchstr+0x41>
80104d14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104d20 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104d20:	55                   	push   %ebp
80104d21:	89 e5                	mov    %esp,%ebp
80104d23:	56                   	push   %esi
80104d24:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d25:	e8 e6 ea ff ff       	call   80103810 <myproc>
80104d2a:	8b 40 18             	mov    0x18(%eax),%eax
80104d2d:	8b 55 08             	mov    0x8(%ebp),%edx
80104d30:	8b 40 44             	mov    0x44(%eax),%eax
80104d33:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104d36:	e8 d5 ea ff ff       	call   80103810 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104d3b:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d3d:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104d40:	39 c6                	cmp    %eax,%esi
80104d42:	73 1c                	jae    80104d60 <argint+0x40>
80104d44:	8d 53 08             	lea    0x8(%ebx),%edx
80104d47:	39 d0                	cmp    %edx,%eax
80104d49:	72 15                	jb     80104d60 <argint+0x40>
  *ip = *(int*)(addr);
80104d4b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d4e:	8b 53 04             	mov    0x4(%ebx),%edx
80104d51:	89 10                	mov    %edx,(%eax)
  return 0;
80104d53:	31 c0                	xor    %eax,%eax
}
80104d55:	5b                   	pop    %ebx
80104d56:	5e                   	pop    %esi
80104d57:	5d                   	pop    %ebp
80104d58:	c3                   	ret    
80104d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104d60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d65:	eb ee                	jmp    80104d55 <argint+0x35>
80104d67:	89 f6                	mov    %esi,%esi
80104d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d70 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104d70:	55                   	push   %ebp
80104d71:	89 e5                	mov    %esp,%ebp
80104d73:	56                   	push   %esi
80104d74:	53                   	push   %ebx
80104d75:	83 ec 10             	sub    $0x10,%esp
80104d78:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104d7b:	e8 90 ea ff ff       	call   80103810 <myproc>
80104d80:	89 c6                	mov    %eax,%esi

  if(argint(n, &i) < 0)
80104d82:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d85:	83 ec 08             	sub    $0x8,%esp
80104d88:	50                   	push   %eax
80104d89:	ff 75 08             	pushl  0x8(%ebp)
80104d8c:	e8 8f ff ff ff       	call   80104d20 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104d91:	83 c4 10             	add    $0x10,%esp
80104d94:	85 c0                	test   %eax,%eax
80104d96:	78 28                	js     80104dc0 <argptr+0x50>
80104d98:	85 db                	test   %ebx,%ebx
80104d9a:	78 24                	js     80104dc0 <argptr+0x50>
80104d9c:	8b 16                	mov    (%esi),%edx
80104d9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104da1:	39 c2                	cmp    %eax,%edx
80104da3:	76 1b                	jbe    80104dc0 <argptr+0x50>
80104da5:	01 c3                	add    %eax,%ebx
80104da7:	39 da                	cmp    %ebx,%edx
80104da9:	72 15                	jb     80104dc0 <argptr+0x50>
    return -1;
  *pp = (char*)i;
80104dab:	8b 55 0c             	mov    0xc(%ebp),%edx
80104dae:	89 02                	mov    %eax,(%edx)
  return 0;
80104db0:	31 c0                	xor    %eax,%eax
}
80104db2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104db5:	5b                   	pop    %ebx
80104db6:	5e                   	pop    %esi
80104db7:	5d                   	pop    %ebp
80104db8:	c3                   	ret    
80104db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104dc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104dc5:	eb eb                	jmp    80104db2 <argptr+0x42>
80104dc7:	89 f6                	mov    %esi,%esi
80104dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104dd0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104dd0:	55                   	push   %ebp
80104dd1:	89 e5                	mov    %esp,%ebp
80104dd3:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104dd6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104dd9:	50                   	push   %eax
80104dda:	ff 75 08             	pushl  0x8(%ebp)
80104ddd:	e8 3e ff ff ff       	call   80104d20 <argint>
80104de2:	83 c4 10             	add    $0x10,%esp
80104de5:	85 c0                	test   %eax,%eax
80104de7:	78 17                	js     80104e00 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104de9:	83 ec 08             	sub    $0x8,%esp
80104dec:	ff 75 0c             	pushl  0xc(%ebp)
80104def:	ff 75 f4             	pushl  -0xc(%ebp)
80104df2:	e8 b9 fe ff ff       	call   80104cb0 <fetchstr>
80104df7:	83 c4 10             	add    $0x10,%esp
}
80104dfa:	c9                   	leave  
80104dfb:	c3                   	ret    
80104dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104e00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e05:	c9                   	leave  
80104e06:	c3                   	ret    
80104e07:	89 f6                	mov    %esi,%esi
80104e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e10 <createIntQueue>:
//     mq->array = kalloc();
//     return mq;
// }

struct intMessageQueue* createIntQueue(unsigned capacity)
{
80104e10:	55                   	push   %ebp
80104e11:	89 e5                	mov    %esp,%ebp
80104e13:	53                   	push   %ebx
80104e14:	83 ec 04             	sub    $0x4,%esp
    struct intMessageQueue* mq = (struct intMessageQueue*) kalloc();
80104e17:	e8 d4 d6 ff ff       	call   801024f0 <kalloc>
80104e1c:	89 c3                	mov    %eax,%ebx
    mq->capacity = capacity;
80104e1e:	8b 45 08             	mov    0x8(%ebp),%eax
    mq->front =0;
80104e21:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
    mq->size = 0;
80104e27:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    mq->last = -1;  // This is important, see the enqueue
80104e2e:	c7 43 04 ff ff ff ff 	movl   $0xffffffff,0x4(%ebx)
    mq->capacity = capacity;
80104e35:	89 43 0c             	mov    %eax,0xc(%ebx)
    mq->arr = (int*) kalloc();
80104e38:	e8 b3 d6 ff ff       	call   801024f0 <kalloc>
80104e3d:	89 43 10             	mov    %eax,0x10(%ebx)
    return mq;
}
80104e40:	83 c4 04             	add    $0x4,%esp
80104e43:	89 d8                	mov    %ebx,%eax
80104e45:	5b                   	pop    %ebx
80104e46:	5d                   	pop    %ebp
80104e47:	c3                   	ret    
80104e48:	90                   	nop
80104e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104e50 <createWaitQueue>:

struct waitQueue* createWaitQueue(unsigned capacity)
{
80104e50:	55                   	push   %ebp
80104e51:	89 e5                	mov    %esp,%ebp
80104e53:	53                   	push   %ebx
80104e54:	83 ec 04             	sub    $0x4,%esp
    struct waitQueue* mq = (struct waitQueue*) kalloc();
80104e57:	e8 94 d6 ff ff       	call   801024f0 <kalloc>
80104e5c:	89 c3                	mov    %eax,%ebx
    mq->capacity = capacity;
80104e5e:	8b 45 08             	mov    0x8(%ebp),%eax
    mq->front = 0;
80104e61:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
    mq->size = 0;
80104e67:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    mq->last = -1;  // This is important, see the enqueue
80104e6e:	c7 43 04 ff ff ff ff 	movl   $0xffffffff,0x4(%ebx)
    mq->capacity = capacity;
80104e75:	89 43 0c             	mov    %eax,0xc(%ebx)
    mq->array = (struct waitQueueItem*) kalloc();
80104e78:	e8 73 d6 ff ff       	call   801024f0 <kalloc>
80104e7d:	89 43 10             	mov    %eax,0x10(%ebx)
    return mq;
}
80104e80:	83 c4 04             	add    $0x4,%esp
80104e83:	89 d8                	mov    %ebx,%eax
80104e85:	5b                   	pop    %ebx
80104e86:	5d                   	pop    %ebp
80104e87:	c3                   	ret    
80104e88:	90                   	nop
80104e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104e90 <init_queues>:


void
init_queues(void)
{
80104e90:	55                   	push   %ebp
80104e91:	89 e5                	mov    %esp,%ebp
80104e93:	53                   	push   %ebx
80104e94:	31 db                	xor    %ebx,%ebx
80104e96:	83 ec 04             	sub    $0x4,%esp
80104e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  unsigned capacity = 50;             // capacity of one message quque
  for(int p = 0; p < NPROC; p++){
    // message_quque[p] = createQueue(capacity);
    int_message_queue[p] = createIntQueue(capacity);
80104ea0:	83 ec 0c             	sub    $0xc,%esp
80104ea3:	83 c3 04             	add    $0x4,%ebx
80104ea6:	6a 32                	push   $0x32
80104ea8:	e8 63 ff ff ff       	call   80104e10 <createIntQueue>
    wait_queue[p] = createWaitQueue(capacity);
80104ead:	c7 04 24 32 00 00 00 	movl   $0x32,(%esp)
    int_message_queue[p] = createIntQueue(capacity);
80104eb4:	89 83 fc 7f 14 80    	mov    %eax,-0x7feb8004(%ebx)
    wait_queue[p] = createWaitQueue(capacity);
80104eba:	e8 91 ff ff ff       	call   80104e50 <createWaitQueue>
80104ebf:	89 83 dc 78 14 80    	mov    %eax,-0x7feb8724(%ebx)
  for(int p = 0; p < NPROC; p++){
80104ec5:	83 c4 10             	add    $0x10,%esp
80104ec8:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
80104ece:	75 d0                	jne    80104ea0 <init_queues+0x10>
  }
}
80104ed0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ed3:	c9                   	leave  
80104ed4:	c3                   	ret    
80104ed5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ee0 <syscall>:
{
80104ee0:	55                   	push   %ebp
80104ee1:	89 e5                	mov    %esp,%ebp
80104ee3:	53                   	push   %ebx
80104ee4:	83 ec 04             	sub    $0x4,%esp
  if(syscallhappened==0){
80104ee7:	a1 c0 b5 10 80       	mov    0x8010b5c0,%eax
80104eec:	85 c0                	test   %eax,%eax
80104eee:	74 60                	je     80104f50 <syscall+0x70>
  struct proc *curproc = myproc();
80104ef0:	e8 1b e9 ff ff       	call   80103810 <myproc>
80104ef5:	89 c3                	mov    %eax,%ebx
  num = curproc->tf->eax;
80104ef7:	8b 40 18             	mov    0x18(%eax),%eax
80104efa:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104efd:	8d 50 ff             	lea    -0x1(%eax),%edx
80104f00:	83 fa 1e             	cmp    $0x1e,%edx
80104f03:	77 1b                	ja     80104f20 <syscall+0x40>
80104f05:	8b 14 85 20 8c 10 80 	mov    -0x7fef73e0(,%eax,4),%edx
80104f0c:	85 d2                	test   %edx,%edx
80104f0e:	74 10                	je     80104f20 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104f10:	ff d2                	call   *%edx
80104f12:	8b 53 18             	mov    0x18(%ebx),%edx
80104f15:	89 42 1c             	mov    %eax,0x1c(%edx)
}
80104f18:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104f1b:	c9                   	leave  
80104f1c:	c3                   	ret    
80104f1d:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104f20:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104f21:	8d 83 bc 01 00 00    	lea    0x1bc(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104f27:	50                   	push   %eax
80104f28:	ff 73 10             	pushl  0x10(%ebx)
80104f2b:	68 d9 8b 10 80       	push   $0x80108bd9
80104f30:	e8 2b b7 ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
80104f35:	8b 43 18             	mov    0x18(%ebx),%eax
80104f38:	83 c4 10             	add    $0x10,%esp
80104f3b:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104f42:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104f45:	c9                   	leave  
80104f46:	c3                   	ret    
80104f47:	89 f6                	mov    %esi,%esi
80104f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  	init_queues();
80104f50:	e8 3b ff ff ff       	call   80104e90 <init_queues>
  	syscallhappened=1;
80104f55:	c7 05 c0 b5 10 80 01 	movl   $0x1,0x8010b5c0
80104f5c:	00 00 00 
80104f5f:	eb 8f                	jmp    80104ef0 <syscall+0x10>
80104f61:	eb 0d                	jmp    80104f70 <isWaitFull>
80104f63:	90                   	nop
80104f64:	90                   	nop
80104f65:	90                   	nop
80104f66:	90                   	nop
80104f67:	90                   	nop
80104f68:	90                   	nop
80104f69:	90                   	nop
80104f6a:	90                   	nop
80104f6b:	90                   	nop
80104f6c:	90                   	nop
80104f6d:	90                   	nop
80104f6e:	90                   	nop
80104f6f:	90                   	nop

80104f70 <isWaitFull>:
//     return item;
// }


int isWaitFull(struct waitQueue* mq)
{
80104f70:	55                   	push   %ebp
80104f71:	89 e5                	mov    %esp,%ebp
80104f73:	8b 45 08             	mov    0x8(%ebp),%eax
	if(mq->size == mq->capacity)
	return 1;
	else return 0;
}
80104f76:	5d                   	pop    %ebp
	if(mq->size == mq->capacity)
80104f77:	8b 50 0c             	mov    0xc(%eax),%edx
80104f7a:	39 50 08             	cmp    %edx,0x8(%eax)
80104f7d:	0f 94 c0             	sete   %al
80104f80:	0f b6 c0             	movzbl %al,%eax
}
80104f83:	c3                   	ret    
80104f84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104f90 <isWaitEmpty>:


int isWaitEmpty(struct waitQueue* mq)
{
80104f90:	55                   	push   %ebp
80104f91:	89 e5                	mov    %esp,%ebp
	if(mq->size == 0)
80104f93:	8b 45 08             	mov    0x8(%ebp),%eax
	return 1;
	else return 0;
}
80104f96:	5d                   	pop    %ebp
	if(mq->size == 0)
80104f97:	8b 40 08             	mov    0x8(%eax),%eax
80104f9a:	85 c0                	test   %eax,%eax
80104f9c:	0f 94 c0             	sete   %al
80104f9f:	0f b6 c0             	movzbl %al,%eax
}
80104fa2:	c3                   	ret    
80104fa3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104fb0 <waitenqueue>:


void waitenqueue(struct waitQueue* mq, struct waitQueueItem item)
{
80104fb0:	55                   	push   %ebp
80104fb1:	89 e5                	mov    %esp,%ebp
80104fb3:	56                   	push   %esi
80104fb4:	53                   	push   %ebx
80104fb5:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(mq->size == mq->capacity)
80104fb8:	8b 41 0c             	mov    0xc(%ecx),%eax
80104fbb:	39 41 08             	cmp    %eax,0x8(%ecx)
80104fbe:	74 1d                	je     80104fdd <waitenqueue+0x2d>
    if (isWaitFull(mq))
        return;
    mq->last = mq->last + 1;
80104fc0:	8b 41 04             	mov    0x4(%ecx),%eax
    mq->array[mq->last] = item;
80104fc3:	8b 71 10             	mov    0x10(%ecx),%esi
80104fc6:	8b 55 10             	mov    0x10(%ebp),%edx
    mq->last = mq->last + 1;
80104fc9:	8d 58 01             	lea    0x1(%eax),%ebx
    mq->array[mq->last] = item;
80104fcc:	8b 45 0c             	mov    0xc(%ebp),%eax
    mq->last = mq->last + 1;
80104fcf:	89 59 04             	mov    %ebx,0x4(%ecx)
    mq->array[mq->last] = item;
80104fd2:	89 54 de 04          	mov    %edx,0x4(%esi,%ebx,8)
80104fd6:	89 04 de             	mov    %eax,(%esi,%ebx,8)
    mq->size = mq->size + 1;
80104fd9:	83 41 08 01          	addl   $0x1,0x8(%ecx)
    // printf("%d enqueued to queue\n", item);
}
80104fdd:	5b                   	pop    %ebx
80104fde:	5e                   	pop    %esi
80104fdf:	5d                   	pop    %ebp
80104fe0:	c3                   	ret    
80104fe1:	eb 0d                	jmp    80104ff0 <waitdequeue>
80104fe3:	90                   	nop
80104fe4:	90                   	nop
80104fe5:	90                   	nop
80104fe6:	90                   	nop
80104fe7:	90                   	nop
80104fe8:	90                   	nop
80104fe9:	90                   	nop
80104fea:	90                   	nop
80104feb:	90                   	nop
80104fec:	90                   	nop
80104fed:	90                   	nop
80104fee:	90                   	nop
80104fef:	90                   	nop

80104ff0 <waitdequeue>:

struct waitQueueItem waitdequeue(struct waitQueue* mq)                // ALWAYS CHECK IF EMPTY BEFORE USING DEQUEUE
{
80104ff0:	55                   	push   %ebp
80104ff1:	89 e5                	mov    %esp,%ebp
80104ff3:	56                   	push   %esi
80104ff4:	53                   	push   %ebx
80104ff5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104ff8:	8b 5d 08             	mov    0x8(%ebp),%ebx

    // if (isEmpty(mq))
    //     return;
    struct waitQueueItem item = mq->array[mq->front];
80104ffb:	8b 01                	mov    (%ecx),%eax
80104ffd:	8b 51 10             	mov    0x10(%ecx),%edx
80105000:	8d 14 c2             	lea    (%edx,%eax,8),%edx
    mq->front = (mq->front + 1)%mq->capacity;
80105003:	83 c0 01             	add    $0x1,%eax
    struct waitQueueItem item = mq->array[mq->front];
80105006:	8b 32                	mov    (%edx),%esi
80105008:	89 33                	mov    %esi,(%ebx)
8010500a:	8b 72 04             	mov    0x4(%edx),%esi
    mq->front = (mq->front + 1)%mq->capacity;
8010500d:	31 d2                	xor    %edx,%edx
8010500f:	f7 71 0c             	divl   0xc(%ecx)
    mq->size = mq->size - 1;
80105012:	83 69 08 01          	subl   $0x1,0x8(%ecx)
    return item;
}
80105016:	89 d8                	mov    %ebx,%eax
    struct waitQueueItem item = mq->array[mq->front];
80105018:	89 73 04             	mov    %esi,0x4(%ebx)
    mq->front = (mq->front + 1)%mq->capacity;
8010501b:	89 11                	mov    %edx,(%ecx)
}
8010501d:	5b                   	pop    %ebx
8010501e:	5e                   	pop    %esi
8010501f:	5d                   	pop    %ebp
80105020:	c2 04 00             	ret    $0x4
80105023:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105030 <isFull>:


/////////////////////////////////////////////////////////

int isFull(struct intMessageQueue* mq)
{  if(mq->size == mq->capacity)
80105030:	55                   	push   %ebp
80105031:	89 e5                	mov    %esp,%ebp
80105033:	8b 45 08             	mov    0x8(%ebp),%eax
	return 1;
	else return 0;
}
80105036:	5d                   	pop    %ebp
{  if(mq->size == mq->capacity)
80105037:	8b 50 0c             	mov    0xc(%eax),%edx
8010503a:	39 50 08             	cmp    %edx,0x8(%eax)
8010503d:	0f 94 c0             	sete   %al
80105040:	0f b6 c0             	movzbl %al,%eax
}
80105043:	c3                   	ret    
80105044:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010504a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105050 <isEmpty>:


int isEmpty(struct intMessageQueue* mq)
{
80105050:	55                   	push   %ebp
80105051:	89 e5                	mov    %esp,%ebp
	if(mq->size == 0)
80105053:	8b 45 08             	mov    0x8(%ebp),%eax
	return 1;
	else return 0;
}
80105056:	5d                   	pop    %ebp
	if(mq->size == 0)
80105057:	8b 40 08             	mov    0x8(%eax),%eax
8010505a:	85 c0                	test   %eax,%eax
8010505c:	0f 94 c0             	sete   %al
8010505f:	0f b6 c0             	movzbl %al,%eax
}
80105062:	c3                   	ret    
80105063:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105070 <enqueue>:


void enqueue(struct intMessageQueue* mq, int item)
{
80105070:	55                   	push   %ebp
80105071:	89 e5                	mov    %esp,%ebp
80105073:	53                   	push   %ebx
80105074:	8b 4d 08             	mov    0x8(%ebp),%ecx
{  if(mq->size == mq->capacity)
80105077:	8b 59 0c             	mov    0xc(%ecx),%ebx
8010507a:	39 59 08             	cmp    %ebx,0x8(%ecx)
8010507d:	74 1a                	je     80105099 <enqueue+0x29>
    if (isFull(mq))
        return;
    mq->last = (mq->last + 1)%mq->capacity;
8010507f:	8b 41 04             	mov    0x4(%ecx),%eax
80105082:	31 d2                	xor    %edx,%edx
80105084:	83 c0 01             	add    $0x1,%eax
80105087:	f7 f3                	div    %ebx
    mq->arr[mq->last] = item;
80105089:	8b 41 10             	mov    0x10(%ecx),%eax
8010508c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    mq->last = (mq->last + 1)%mq->capacity;
8010508f:	89 51 04             	mov    %edx,0x4(%ecx)
    mq->arr[mq->last] = item;
80105092:	89 1c 90             	mov    %ebx,(%eax,%edx,4)
    mq->size = mq->size + 1;
80105095:	83 41 08 01          	addl   $0x1,0x8(%ecx)
    // printf("%d enqueued to queue\n", item);
}
80105099:	5b                   	pop    %ebx
8010509a:	5d                   	pop    %ebp
8010509b:	c3                   	ret    
8010509c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801050a0 <dequeue>:

int dequeue(struct intMessageQueue* mq)                // ALWAYS CHECK IF EMPTY BEFORE USING DEQUEUE
{
801050a0:	55                   	push   %ebp
801050a1:	89 e5                	mov    %esp,%ebp
801050a3:	56                   	push   %esi
801050a4:	53                   	push   %ebx
801050a5:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(mq->size == 0)
801050a8:	8b 59 08             	mov    0x8(%ecx),%ebx
801050ab:	85 db                	test   %ebx,%ebx
801050ad:	74 21                	je     801050d0 <dequeue+0x30>

    if (isEmpty(mq))
        {cprintf("dequeue from EMPTY\n");return -3;}
    int item = mq->arr[mq->front];
801050af:	8b 01                	mov    (%ecx),%eax
801050b1:	8b 51 10             	mov    0x10(%ecx),%edx
    mq->front = (mq->front + 1)%mq->capacity;
    mq->size = mq->size - 1;
801050b4:	83 eb 01             	sub    $0x1,%ebx
    int item = mq->arr[mq->front];
801050b7:	8b 34 82             	mov    (%edx,%eax,4),%esi
    mq->front = (mq->front + 1)%mq->capacity;
801050ba:	83 c0 01             	add    $0x1,%eax
801050bd:	31 d2                	xor    %edx,%edx
801050bf:	f7 71 0c             	divl   0xc(%ecx)
    mq->size = mq->size - 1;
801050c2:	89 59 08             	mov    %ebx,0x8(%ecx)
    mq->front = (mq->front + 1)%mq->capacity;
801050c5:	89 11                	mov    %edx,(%ecx)
    return item;
}
801050c7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801050ca:	89 f0                	mov    %esi,%eax
801050cc:	5b                   	pop    %ebx
801050cd:	5e                   	pop    %esi
801050ce:	5d                   	pop    %ebp
801050cf:	c3                   	ret    
        {cprintf("dequeue from EMPTY\n");return -3;}
801050d0:	83 ec 0c             	sub    $0xc,%esp
801050d3:	be fd ff ff ff       	mov    $0xfffffffd,%esi
801050d8:	68 f5 8b 10 80       	push   $0x80108bf5
801050dd:	e8 7e b5 ff ff       	call   80100660 <cprintf>
801050e2:	83 c4 10             	add    $0x10,%esp
801050e5:	eb e0                	jmp    801050c7 <dequeue+0x27>
801050e7:	89 f6                	mov    %esi,%esi
801050e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801050f0 <copyToSystemSpace>:
/////////// COPY TO SYSTEM SPACE AND COPY FROM SYSTEM SPACE///////
*/

void
copyToSystemSpace(char *from,char *to, int len)
{
801050f0:	55                   	push   %ebp
801050f1:	89 e5                	mov    %esp,%ebp
801050f3:	56                   	push   %esi
801050f4:	53                   	push   %ebx
801050f5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801050f8:	8b 5d 08             	mov    0x8(%ebp),%ebx
801050fb:	8b 75 0c             	mov    0xc(%ebp),%esi
	// from = P2V(from);
	while(len-->0){
801050fe:	85 c9                	test   %ecx,%ecx
80105100:	7e 14                	jle    80105116 <copyToSystemSpace+0x26>
80105102:	31 c0                	xor    %eax,%eax
80105104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		*to++= *from++;
80105108:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
8010510c:	88 14 06             	mov    %dl,(%esi,%eax,1)
8010510f:	83 c0 01             	add    $0x1,%eax
	while(len-->0){
80105112:	39 c1                	cmp    %eax,%ecx
80105114:	75 f2                	jne    80105108 <copyToSystemSpace+0x18>
		// to++;
		// from++;
	}
}
80105116:	5b                   	pop    %ebx
80105117:	5e                   	pop    %esi
80105118:	5d                   	pop    %ebp
80105119:	c3                   	ret    
8010511a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105120 <copyFromSystemSpace>:

void
copyFromSystemSpace(char *to,char *from, int len)
{
80105120:	55                   	push   %ebp
80105121:	89 e5                	mov    %esp,%ebp
80105123:	56                   	push   %esi
80105124:	53                   	push   %ebx
80105125:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105128:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010512b:	8b 75 0c             	mov    0xc(%ebp),%esi
	// to = P2V(to);
	while(len-->0){
8010512e:	85 c9                	test   %ecx,%ecx
80105130:	7e 14                	jle    80105146 <copyFromSystemSpace+0x26>
80105132:	31 c0                	xor    %eax,%eax
80105134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		*to++= *from++;
80105138:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
8010513c:	88 14 03             	mov    %dl,(%ebx,%eax,1)
8010513f:	83 c0 01             	add    $0x1,%eax
	while(len-->0){
80105142:	39 c1                	cmp    %eax,%ecx
80105144:	75 f2                	jne    80105138 <copyFromSystemSpace+0x18>
		// to++;
		// from++;
	}
}
80105146:	5b                   	pop    %ebx
80105147:	5e                   	pop    %esi
80105148:	5d                   	pop    %ebp
80105149:	c3                   	ret    
8010514a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105150 <getMessageBuffer>:
	// if(msg_no != EndOfFreeList){
	// 	free_message_buffer = messageBuffers[msg_no][0];
	// }
	// return msg_no;

	lastBufferUsed++;
80105150:	a1 c4 b5 10 80       	mov    0x8010b5c4,%eax
{
80105155:	55                   	push   %ebp
80105156:	89 e5                	mov    %esp,%ebp
	int m = lastBufferUsed;
	lastBufferUsed++;
80105158:	8d 50 02             	lea    0x2(%eax),%edx
	lastBufferUsed++;
8010515b:	83 c0 01             	add    $0x1,%eax

	return m;

}
8010515e:	5d                   	pop    %ebp
	lastBufferUsed++;
8010515f:	89 15 c4 b5 10 80    	mov    %edx,0x8010b5c4
}
80105165:	c3                   	ret    
80105166:	8d 76 00             	lea    0x0(%esi),%esi
80105169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105170 <freeMessageBuffer>:

void
freeMessageBuffer(int msg_no)
{
80105170:	55                   	push   %ebp
	messageBuffers[msg_no][0]= free_message_buffer;
80105171:	8b 0d a0 7d 14 80    	mov    0x80147da0,%ecx
{
80105177:	89 e5                	mov    %esp,%ebp
80105179:	8b 45 08             	mov    0x8(%ebp),%eax
	messageBuffers[msg_no][0]= free_message_buffer;
8010517c:	8b 14 85 e0 c5 10 80 	mov    -0x7fef3a20(,%eax,4),%edx
80105183:	88 0a                	mov    %cl,(%edx)
	free_message_buffer = msg_no;
80105185:	a3 a0 7d 14 80       	mov    %eax,0x80147da0
}
8010518a:	5d                   	pop    %ebp
8010518b:	c3                   	ret    
8010518c:	66 90                	xchg   %ax,%ax
8010518e:	66 90                	xchg   %ax,%ax

80105190 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105190:	55                   	push   %ebp
80105191:	89 e5                	mov    %esp,%ebp
80105193:	57                   	push   %edi
80105194:	56                   	push   %esi
80105195:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105196:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80105199:	83 ec 44             	sub    $0x44,%esp
8010519c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
8010519f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
801051a2:	56                   	push   %esi
801051a3:	50                   	push   %eax
{
801051a4:	89 55 c4             	mov    %edx,-0x3c(%ebp)
801051a7:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801051aa:	e8 81 cd ff ff       	call   80101f30 <nameiparent>
801051af:	83 c4 10             	add    $0x10,%esp
801051b2:	85 c0                	test   %eax,%eax
801051b4:	0f 84 46 01 00 00    	je     80105300 <create+0x170>
    return 0;
  ilock(dp);
801051ba:	83 ec 0c             	sub    $0xc,%esp
801051bd:	89 c3                	mov    %eax,%ebx
801051bf:	50                   	push   %eax
801051c0:	e8 cb c4 ff ff       	call   80101690 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
801051c5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801051c8:	83 c4 0c             	add    $0xc,%esp
801051cb:	50                   	push   %eax
801051cc:	56                   	push   %esi
801051cd:	53                   	push   %ebx
801051ce:	e8 fd c9 ff ff       	call   80101bd0 <dirlookup>
801051d3:	83 c4 10             	add    $0x10,%esp
801051d6:	85 c0                	test   %eax,%eax
801051d8:	89 c7                	mov    %eax,%edi
801051da:	74 34                	je     80105210 <create+0x80>
    iunlockput(dp);
801051dc:	83 ec 0c             	sub    $0xc,%esp
801051df:	53                   	push   %ebx
801051e0:	e8 3b c7 ff ff       	call   80101920 <iunlockput>
    ilock(ip);
801051e5:	89 3c 24             	mov    %edi,(%esp)
801051e8:	e8 a3 c4 ff ff       	call   80101690 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801051ed:	83 c4 10             	add    $0x10,%esp
801051f0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
801051f5:	0f 85 95 00 00 00    	jne    80105290 <create+0x100>
801051fb:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80105200:	0f 85 8a 00 00 00    	jne    80105290 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105206:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105209:	89 f8                	mov    %edi,%eax
8010520b:	5b                   	pop    %ebx
8010520c:	5e                   	pop    %esi
8010520d:	5f                   	pop    %edi
8010520e:	5d                   	pop    %ebp
8010520f:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80105210:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80105214:	83 ec 08             	sub    $0x8,%esp
80105217:	50                   	push   %eax
80105218:	ff 33                	pushl  (%ebx)
8010521a:	e8 01 c3 ff ff       	call   80101520 <ialloc>
8010521f:	83 c4 10             	add    $0x10,%esp
80105222:	85 c0                	test   %eax,%eax
80105224:	89 c7                	mov    %eax,%edi
80105226:	0f 84 e8 00 00 00    	je     80105314 <create+0x184>
  ilock(ip);
8010522c:	83 ec 0c             	sub    $0xc,%esp
8010522f:	50                   	push   %eax
80105230:	e8 5b c4 ff ff       	call   80101690 <ilock>
  ip->major = major;
80105235:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80105239:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
8010523d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80105241:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80105245:	b8 01 00 00 00       	mov    $0x1,%eax
8010524a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
8010524e:	89 3c 24             	mov    %edi,(%esp)
80105251:	e8 8a c3 ff ff       	call   801015e0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105256:	83 c4 10             	add    $0x10,%esp
80105259:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
8010525e:	74 50                	je     801052b0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80105260:	83 ec 04             	sub    $0x4,%esp
80105263:	ff 77 04             	pushl  0x4(%edi)
80105266:	56                   	push   %esi
80105267:	53                   	push   %ebx
80105268:	e8 e3 cb ff ff       	call   80101e50 <dirlink>
8010526d:	83 c4 10             	add    $0x10,%esp
80105270:	85 c0                	test   %eax,%eax
80105272:	0f 88 8f 00 00 00    	js     80105307 <create+0x177>
  iunlockput(dp);
80105278:	83 ec 0c             	sub    $0xc,%esp
8010527b:	53                   	push   %ebx
8010527c:	e8 9f c6 ff ff       	call   80101920 <iunlockput>
  return ip;
80105281:	83 c4 10             	add    $0x10,%esp
}
80105284:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105287:	89 f8                	mov    %edi,%eax
80105289:	5b                   	pop    %ebx
8010528a:	5e                   	pop    %esi
8010528b:	5f                   	pop    %edi
8010528c:	5d                   	pop    %ebp
8010528d:	c3                   	ret    
8010528e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105290:	83 ec 0c             	sub    $0xc,%esp
80105293:	57                   	push   %edi
    return 0;
80105294:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80105296:	e8 85 c6 ff ff       	call   80101920 <iunlockput>
    return 0;
8010529b:	83 c4 10             	add    $0x10,%esp
}
8010529e:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052a1:	89 f8                	mov    %edi,%eax
801052a3:	5b                   	pop    %ebx
801052a4:	5e                   	pop    %esi
801052a5:	5f                   	pop    %edi
801052a6:	5d                   	pop    %ebp
801052a7:	c3                   	ret    
801052a8:	90                   	nop
801052a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
801052b0:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
801052b5:	83 ec 0c             	sub    $0xc,%esp
801052b8:	53                   	push   %ebx
801052b9:	e8 22 c3 ff ff       	call   801015e0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801052be:	83 c4 0c             	add    $0xc,%esp
801052c1:	ff 77 04             	pushl  0x4(%edi)
801052c4:	68 c0 8c 10 80       	push   $0x80108cc0
801052c9:	57                   	push   %edi
801052ca:	e8 81 cb ff ff       	call   80101e50 <dirlink>
801052cf:	83 c4 10             	add    $0x10,%esp
801052d2:	85 c0                	test   %eax,%eax
801052d4:	78 1c                	js     801052f2 <create+0x162>
801052d6:	83 ec 04             	sub    $0x4,%esp
801052d9:	ff 73 04             	pushl  0x4(%ebx)
801052dc:	68 bf 8c 10 80       	push   $0x80108cbf
801052e1:	57                   	push   %edi
801052e2:	e8 69 cb ff ff       	call   80101e50 <dirlink>
801052e7:	83 c4 10             	add    $0x10,%esp
801052ea:	85 c0                	test   %eax,%eax
801052ec:	0f 89 6e ff ff ff    	jns    80105260 <create+0xd0>
      panic("create dots");
801052f2:	83 ec 0c             	sub    $0xc,%esp
801052f5:	68 b3 8c 10 80       	push   $0x80108cb3
801052fa:	e8 91 b0 ff ff       	call   80100390 <panic>
801052ff:	90                   	nop
    return 0;
80105300:	31 ff                	xor    %edi,%edi
80105302:	e9 ff fe ff ff       	jmp    80105206 <create+0x76>
    panic("create: dirlink");
80105307:	83 ec 0c             	sub    $0xc,%esp
8010530a:	68 c2 8c 10 80       	push   $0x80108cc2
8010530f:	e8 7c b0 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80105314:	83 ec 0c             	sub    $0xc,%esp
80105317:	68 a4 8c 10 80       	push   $0x80108ca4
8010531c:	e8 6f b0 ff ff       	call   80100390 <panic>
80105321:	eb 0d                	jmp    80105330 <argfd.constprop.0>
80105323:	90                   	nop
80105324:	90                   	nop
80105325:	90                   	nop
80105326:	90                   	nop
80105327:	90                   	nop
80105328:	90                   	nop
80105329:	90                   	nop
8010532a:	90                   	nop
8010532b:	90                   	nop
8010532c:	90                   	nop
8010532d:	90                   	nop
8010532e:	90                   	nop
8010532f:	90                   	nop

80105330 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80105330:	55                   	push   %ebp
80105331:	89 e5                	mov    %esp,%ebp
80105333:	56                   	push   %esi
80105334:	53                   	push   %ebx
80105335:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80105337:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
8010533a:	89 d6                	mov    %edx,%esi
8010533c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010533f:	50                   	push   %eax
80105340:	6a 00                	push   $0x0
80105342:	e8 d9 f9 ff ff       	call   80104d20 <argint>
80105347:	83 c4 10             	add    $0x10,%esp
8010534a:	85 c0                	test   %eax,%eax
8010534c:	78 2a                	js     80105378 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010534e:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
80105352:	77 24                	ja     80105378 <argfd.constprop.0+0x48>
80105354:	e8 b7 e4 ff ff       	call   80103810 <myproc>
80105359:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010535c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80105360:	85 c0                	test   %eax,%eax
80105362:	74 14                	je     80105378 <argfd.constprop.0+0x48>
  if(pfd)
80105364:	85 db                	test   %ebx,%ebx
80105366:	74 02                	je     8010536a <argfd.constprop.0+0x3a>
    *pfd = fd;
80105368:	89 13                	mov    %edx,(%ebx)
    *pf = f;
8010536a:	89 06                	mov    %eax,(%esi)
  return 0;
8010536c:	31 c0                	xor    %eax,%eax
}
8010536e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105371:	5b                   	pop    %ebx
80105372:	5e                   	pop    %esi
80105373:	5d                   	pop    %ebp
80105374:	c3                   	ret    
80105375:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105378:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010537d:	eb ef                	jmp    8010536e <argfd.constprop.0+0x3e>
8010537f:	90                   	nop

80105380 <sys_dup>:
{ if(isTraceOn==1)
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	56                   	push   %esi
80105384:	53                   	push   %ebx
80105385:	83 ec 10             	sub    $0x10,%esp
80105388:	83 3d b0 18 11 80 01 	cmpl   $0x1,0x801118b0
8010538f:	75 07                	jne    80105398 <sys_dup+0x18>
  {num_calls[SYS_dup] ++;}
80105391:	83 05 e8 7d 14 80 01 	addl   $0x1,0x80147de8
  if(argfd(0, 0, &f) < 0)
80105398:	8d 55 f4             	lea    -0xc(%ebp),%edx
8010539b:	31 c0                	xor    %eax,%eax
8010539d:	e8 8e ff ff ff       	call   80105330 <argfd.constprop.0>
801053a2:	85 c0                	test   %eax,%eax
801053a4:	78 42                	js     801053e8 <sys_dup+0x68>
  if((fd=fdalloc(f)) < 0)
801053a6:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
801053a9:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801053ab:	e8 60 e4 ff ff       	call   80103810 <myproc>
801053b0:	eb 0e                	jmp    801053c0 <sys_dup+0x40>
801053b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
801053b8:	83 c3 01             	add    $0x1,%ebx
801053bb:	83 fb 64             	cmp    $0x64,%ebx
801053be:	74 28                	je     801053e8 <sys_dup+0x68>
    if(curproc->ofile[fd] == 0){
801053c0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801053c4:	85 d2                	test   %edx,%edx
801053c6:	75 f0                	jne    801053b8 <sys_dup+0x38>
      curproc->ofile[fd] = f;
801053c8:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
801053cc:	83 ec 0c             	sub    $0xc,%esp
801053cf:	ff 75 f4             	pushl  -0xc(%ebp)
801053d2:	e8 19 ba ff ff       	call   80100df0 <filedup>
  return fd;
801053d7:	83 c4 10             	add    $0x10,%esp
}
801053da:	8d 65 f8             	lea    -0x8(%ebp),%esp
801053dd:	89 d8                	mov    %ebx,%eax
801053df:	5b                   	pop    %ebx
801053e0:	5e                   	pop    %esi
801053e1:	5d                   	pop    %ebp
801053e2:	c3                   	ret    
801053e3:	90                   	nop
801053e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801053e8:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
801053eb:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
801053f0:	89 d8                	mov    %ebx,%eax
801053f2:	5b                   	pop    %ebx
801053f3:	5e                   	pop    %esi
801053f4:	5d                   	pop    %ebp
801053f5:	c3                   	ret    
801053f6:	8d 76 00             	lea    0x0(%esi),%esi
801053f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105400 <sys_read>:
{ if(isTraceOn==1)
80105400:	55                   	push   %ebp
80105401:	89 e5                	mov    %esp,%ebp
80105403:	83 ec 18             	sub    $0x18,%esp
80105406:	83 3d b0 18 11 80 01 	cmpl   $0x1,0x801118b0
8010540d:	75 07                	jne    80105416 <sys_read+0x16>
  {num_calls[SYS_read] ++;}
8010540f:	83 05 d4 7d 14 80 01 	addl   $0x1,0x80147dd4
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105416:	8d 55 ec             	lea    -0x14(%ebp),%edx
80105419:	31 c0                	xor    %eax,%eax
8010541b:	e8 10 ff ff ff       	call   80105330 <argfd.constprop.0>
80105420:	85 c0                	test   %eax,%eax
80105422:	78 4c                	js     80105470 <sys_read+0x70>
80105424:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105427:	83 ec 08             	sub    $0x8,%esp
8010542a:	50                   	push   %eax
8010542b:	6a 02                	push   $0x2
8010542d:	e8 ee f8 ff ff       	call   80104d20 <argint>
80105432:	83 c4 10             	add    $0x10,%esp
80105435:	85 c0                	test   %eax,%eax
80105437:	78 37                	js     80105470 <sys_read+0x70>
80105439:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010543c:	83 ec 04             	sub    $0x4,%esp
8010543f:	ff 75 f0             	pushl  -0x10(%ebp)
80105442:	50                   	push   %eax
80105443:	6a 01                	push   $0x1
80105445:	e8 26 f9 ff ff       	call   80104d70 <argptr>
8010544a:	83 c4 10             	add    $0x10,%esp
8010544d:	85 c0                	test   %eax,%eax
8010544f:	78 1f                	js     80105470 <sys_read+0x70>
  return fileread(f, p, n);
80105451:	83 ec 04             	sub    $0x4,%esp
80105454:	ff 75 f0             	pushl  -0x10(%ebp)
80105457:	ff 75 f4             	pushl  -0xc(%ebp)
8010545a:	ff 75 ec             	pushl  -0x14(%ebp)
8010545d:	e8 fe ba ff ff       	call   80100f60 <fileread>
80105462:	83 c4 10             	add    $0x10,%esp
}
80105465:	c9                   	leave  
80105466:	c3                   	ret    
80105467:	89 f6                	mov    %esi,%esi
80105469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105470:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105475:	c9                   	leave  
80105476:	c3                   	ret    
80105477:	89 f6                	mov    %esi,%esi
80105479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105480 <sys_write>:
{ if(isTraceOn==1)
80105480:	55                   	push   %ebp
80105481:	89 e5                	mov    %esp,%ebp
80105483:	83 ec 18             	sub    $0x18,%esp
80105486:	83 3d b0 18 11 80 01 	cmpl   $0x1,0x801118b0
8010548d:	75 07                	jne    80105496 <sys_write+0x16>
  {num_calls[SYS_write] ++;}
8010548f:	83 05 00 7e 14 80 01 	addl   $0x1,0x80147e00
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105496:	8d 55 ec             	lea    -0x14(%ebp),%edx
80105499:	31 c0                	xor    %eax,%eax
8010549b:	e8 90 fe ff ff       	call   80105330 <argfd.constprop.0>
801054a0:	85 c0                	test   %eax,%eax
801054a2:	78 4c                	js     801054f0 <sys_write+0x70>
801054a4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801054a7:	83 ec 08             	sub    $0x8,%esp
801054aa:	50                   	push   %eax
801054ab:	6a 02                	push   $0x2
801054ad:	e8 6e f8 ff ff       	call   80104d20 <argint>
801054b2:	83 c4 10             	add    $0x10,%esp
801054b5:	85 c0                	test   %eax,%eax
801054b7:	78 37                	js     801054f0 <sys_write+0x70>
801054b9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054bc:	83 ec 04             	sub    $0x4,%esp
801054bf:	ff 75 f0             	pushl  -0x10(%ebp)
801054c2:	50                   	push   %eax
801054c3:	6a 01                	push   $0x1
801054c5:	e8 a6 f8 ff ff       	call   80104d70 <argptr>
801054ca:	83 c4 10             	add    $0x10,%esp
801054cd:	85 c0                	test   %eax,%eax
801054cf:	78 1f                	js     801054f0 <sys_write+0x70>
  return filewrite(f, p, n);
801054d1:	83 ec 04             	sub    $0x4,%esp
801054d4:	ff 75 f0             	pushl  -0x10(%ebp)
801054d7:	ff 75 f4             	pushl  -0xc(%ebp)
801054da:	ff 75 ec             	pushl  -0x14(%ebp)
801054dd:	e8 0e bb ff ff       	call   80100ff0 <filewrite>
801054e2:	83 c4 10             	add    $0x10,%esp
}
801054e5:	c9                   	leave  
801054e6:	c3                   	ret    
801054e7:	89 f6                	mov    %esi,%esi
801054e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801054f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054f5:	c9                   	leave  
801054f6:	c3                   	ret    
801054f7:	89 f6                	mov    %esi,%esi
801054f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105500 <sys_close>:
{ if(isTraceOn==1)
80105500:	55                   	push   %ebp
80105501:	89 e5                	mov    %esp,%ebp
80105503:	83 ec 18             	sub    $0x18,%esp
80105506:	83 3d b0 18 11 80 01 	cmpl   $0x1,0x801118b0
8010550d:	75 07                	jne    80105516 <sys_close+0x16>
  {num_calls[SYS_close] ++;}
8010550f:	83 05 14 7e 14 80 01 	addl   $0x1,0x80147e14
  if(argfd(0, &fd, &f) < 0)
80105516:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105519:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010551c:	e8 0f fe ff ff       	call   80105330 <argfd.constprop.0>
80105521:	85 c0                	test   %eax,%eax
80105523:	78 2b                	js     80105550 <sys_close+0x50>
  myproc()->ofile[fd] = 0;
80105525:	e8 e6 e2 ff ff       	call   80103810 <myproc>
8010552a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
8010552d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105530:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80105537:	00 
  fileclose(f);
80105538:	ff 75 f4             	pushl  -0xc(%ebp)
8010553b:	e8 00 b9 ff ff       	call   80100e40 <fileclose>
  return 0;
80105540:	83 c4 10             	add    $0x10,%esp
80105543:	31 c0                	xor    %eax,%eax
}
80105545:	c9                   	leave  
80105546:	c3                   	ret    
80105547:	89 f6                	mov    %esi,%esi
80105549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105550:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105555:	c9                   	leave  
80105556:	c3                   	ret    
80105557:	89 f6                	mov    %esi,%esi
80105559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105560 <sys_fstat>:
{ if(isTraceOn==1)
80105560:	55                   	push   %ebp
80105561:	89 e5                	mov    %esp,%ebp
80105563:	83 ec 18             	sub    $0x18,%esp
80105566:	83 3d b0 18 11 80 01 	cmpl   $0x1,0x801118b0
8010556d:	75 07                	jne    80105576 <sys_fstat+0x16>
  {num_calls[SYS_fstat] ++;}
8010556f:	83 05 e0 7d 14 80 01 	addl   $0x1,0x80147de0
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105576:	8d 55 f0             	lea    -0x10(%ebp),%edx
80105579:	31 c0                	xor    %eax,%eax
8010557b:	e8 b0 fd ff ff       	call   80105330 <argfd.constprop.0>
80105580:	85 c0                	test   %eax,%eax
80105582:	78 2c                	js     801055b0 <sys_fstat+0x50>
80105584:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105587:	83 ec 04             	sub    $0x4,%esp
8010558a:	6a 18                	push   $0x18
8010558c:	50                   	push   %eax
8010558d:	6a 01                	push   $0x1
8010558f:	e8 dc f7 ff ff       	call   80104d70 <argptr>
80105594:	83 c4 10             	add    $0x10,%esp
80105597:	85 c0                	test   %eax,%eax
80105599:	78 15                	js     801055b0 <sys_fstat+0x50>
  return filestat(f, st);
8010559b:	83 ec 08             	sub    $0x8,%esp
8010559e:	ff 75 f4             	pushl  -0xc(%ebp)
801055a1:	ff 75 f0             	pushl  -0x10(%ebp)
801055a4:	e8 67 b9 ff ff       	call   80100f10 <filestat>
801055a9:	83 c4 10             	add    $0x10,%esp
}
801055ac:	c9                   	leave  
801055ad:	c3                   	ret    
801055ae:	66 90                	xchg   %ax,%ax
    return -1;
801055b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055b5:	c9                   	leave  
801055b6:	c3                   	ret    
801055b7:	89 f6                	mov    %esi,%esi
801055b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055c0 <sys_link>:
{
801055c0:	55                   	push   %ebp
801055c1:	89 e5                	mov    %esp,%ebp
801055c3:	57                   	push   %edi
801055c4:	56                   	push   %esi
801055c5:	53                   	push   %ebx
801055c6:	83 ec 2c             	sub    $0x2c,%esp
  if(isTraceOn==1)
801055c9:	83 3d b0 18 11 80 01 	cmpl   $0x1,0x801118b0
801055d0:	75 07                	jne    801055d9 <sys_link+0x19>
  {num_calls[SYS_link] ++;}
801055d2:	83 05 0c 7e 14 80 01 	addl   $0x1,0x80147e0c
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801055d9:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801055dc:	83 ec 08             	sub    $0x8,%esp
801055df:	50                   	push   %eax
801055e0:	6a 00                	push   $0x0
801055e2:	e8 e9 f7 ff ff       	call   80104dd0 <argstr>
801055e7:	83 c4 10             	add    $0x10,%esp
801055ea:	85 c0                	test   %eax,%eax
801055ec:	0f 88 f8 00 00 00    	js     801056ea <sys_link+0x12a>
801055f2:	8d 45 d0             	lea    -0x30(%ebp),%eax
801055f5:	83 ec 08             	sub    $0x8,%esp
801055f8:	50                   	push   %eax
801055f9:	6a 01                	push   $0x1
801055fb:	e8 d0 f7 ff ff       	call   80104dd0 <argstr>
80105600:	83 c4 10             	add    $0x10,%esp
80105603:	85 c0                	test   %eax,%eax
80105605:	0f 88 df 00 00 00    	js     801056ea <sys_link+0x12a>
  begin_op();
8010560b:	e8 c0 d5 ff ff       	call   80102bd0 <begin_op>
  if((ip = namei(old)) == 0){
80105610:	83 ec 0c             	sub    $0xc,%esp
80105613:	ff 75 d4             	pushl  -0x2c(%ebp)
80105616:	e8 f5 c8 ff ff       	call   80101f10 <namei>
8010561b:	83 c4 10             	add    $0x10,%esp
8010561e:	85 c0                	test   %eax,%eax
80105620:	89 c3                	mov    %eax,%ebx
80105622:	0f 84 e7 00 00 00    	je     8010570f <sys_link+0x14f>
  ilock(ip);
80105628:	83 ec 0c             	sub    $0xc,%esp
8010562b:	50                   	push   %eax
8010562c:	e8 5f c0 ff ff       	call   80101690 <ilock>
  if(ip->type == T_DIR){
80105631:	83 c4 10             	add    $0x10,%esp
80105634:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105639:	0f 84 b8 00 00 00    	je     801056f7 <sys_link+0x137>
  ip->nlink++;
8010563f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105644:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80105647:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
8010564a:	53                   	push   %ebx
8010564b:	e8 90 bf ff ff       	call   801015e0 <iupdate>
  iunlock(ip);
80105650:	89 1c 24             	mov    %ebx,(%esp)
80105653:	e8 18 c1 ff ff       	call   80101770 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105658:	58                   	pop    %eax
80105659:	5a                   	pop    %edx
8010565a:	57                   	push   %edi
8010565b:	ff 75 d0             	pushl  -0x30(%ebp)
8010565e:	e8 cd c8 ff ff       	call   80101f30 <nameiparent>
80105663:	83 c4 10             	add    $0x10,%esp
80105666:	85 c0                	test   %eax,%eax
80105668:	89 c6                	mov    %eax,%esi
8010566a:	74 58                	je     801056c4 <sys_link+0x104>
  ilock(dp);
8010566c:	83 ec 0c             	sub    $0xc,%esp
8010566f:	50                   	push   %eax
80105670:	e8 1b c0 ff ff       	call   80101690 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105675:	83 c4 10             	add    $0x10,%esp
80105678:	8b 03                	mov    (%ebx),%eax
8010567a:	39 06                	cmp    %eax,(%esi)
8010567c:	75 3a                	jne    801056b8 <sys_link+0xf8>
8010567e:	83 ec 04             	sub    $0x4,%esp
80105681:	ff 73 04             	pushl  0x4(%ebx)
80105684:	57                   	push   %edi
80105685:	56                   	push   %esi
80105686:	e8 c5 c7 ff ff       	call   80101e50 <dirlink>
8010568b:	83 c4 10             	add    $0x10,%esp
8010568e:	85 c0                	test   %eax,%eax
80105690:	78 26                	js     801056b8 <sys_link+0xf8>
  iunlockput(dp);
80105692:	83 ec 0c             	sub    $0xc,%esp
80105695:	56                   	push   %esi
80105696:	e8 85 c2 ff ff       	call   80101920 <iunlockput>
  iput(ip);
8010569b:	89 1c 24             	mov    %ebx,(%esp)
8010569e:	e8 1d c1 ff ff       	call   801017c0 <iput>
  end_op();
801056a3:	e8 98 d5 ff ff       	call   80102c40 <end_op>
  return 0;
801056a8:	83 c4 10             	add    $0x10,%esp
801056ab:	31 c0                	xor    %eax,%eax
}
801056ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056b0:	5b                   	pop    %ebx
801056b1:	5e                   	pop    %esi
801056b2:	5f                   	pop    %edi
801056b3:	5d                   	pop    %ebp
801056b4:	c3                   	ret    
801056b5:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(dp);
801056b8:	83 ec 0c             	sub    $0xc,%esp
801056bb:	56                   	push   %esi
801056bc:	e8 5f c2 ff ff       	call   80101920 <iunlockput>
    goto bad;
801056c1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801056c4:	83 ec 0c             	sub    $0xc,%esp
801056c7:	53                   	push   %ebx
801056c8:	e8 c3 bf ff ff       	call   80101690 <ilock>
  ip->nlink--;
801056cd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801056d2:	89 1c 24             	mov    %ebx,(%esp)
801056d5:	e8 06 bf ff ff       	call   801015e0 <iupdate>
  iunlockput(ip);
801056da:	89 1c 24             	mov    %ebx,(%esp)
801056dd:	e8 3e c2 ff ff       	call   80101920 <iunlockput>
  end_op();
801056e2:	e8 59 d5 ff ff       	call   80102c40 <end_op>
  return -1;
801056e7:	83 c4 10             	add    $0x10,%esp
}
801056ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801056ed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801056f2:	5b                   	pop    %ebx
801056f3:	5e                   	pop    %esi
801056f4:	5f                   	pop    %edi
801056f5:	5d                   	pop    %ebp
801056f6:	c3                   	ret    
    iunlockput(ip);
801056f7:	83 ec 0c             	sub    $0xc,%esp
801056fa:	53                   	push   %ebx
801056fb:	e8 20 c2 ff ff       	call   80101920 <iunlockput>
    end_op();
80105700:	e8 3b d5 ff ff       	call   80102c40 <end_op>
    return -1;
80105705:	83 c4 10             	add    $0x10,%esp
80105708:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010570d:	eb 9e                	jmp    801056ad <sys_link+0xed>
    end_op();
8010570f:	e8 2c d5 ff ff       	call   80102c40 <end_op>
    return -1;
80105714:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105719:	eb 92                	jmp    801056ad <sys_link+0xed>
8010571b:	90                   	nop
8010571c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105720 <sys_unlink>:
{ if(isTraceOn==1)
80105720:	55                   	push   %ebp
80105721:	89 e5                	mov    %esp,%ebp
80105723:	57                   	push   %edi
80105724:	56                   	push   %esi
80105725:	53                   	push   %ebx
80105726:	83 ec 3c             	sub    $0x3c,%esp
80105729:	83 3d b0 18 11 80 01 	cmpl   $0x1,0x801118b0
80105730:	75 07                	jne    80105739 <sys_unlink+0x19>
  {num_calls[SYS_unlink] ++;}
80105732:	83 05 08 7e 14 80 01 	addl   $0x1,0x80147e08
  if(argstr(0, &path) < 0)
80105739:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010573c:	83 ec 08             	sub    $0x8,%esp
8010573f:	50                   	push   %eax
80105740:	6a 00                	push   $0x0
80105742:	e8 89 f6 ff ff       	call   80104dd0 <argstr>
80105747:	83 c4 10             	add    $0x10,%esp
8010574a:	85 c0                	test   %eax,%eax
8010574c:	0f 88 74 01 00 00    	js     801058c6 <sys_unlink+0x1a6>
  if((dp = nameiparent(path, name)) == 0){
80105752:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80105755:	e8 76 d4 ff ff       	call   80102bd0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
8010575a:	83 ec 08             	sub    $0x8,%esp
8010575d:	53                   	push   %ebx
8010575e:	ff 75 c0             	pushl  -0x40(%ebp)
80105761:	e8 ca c7 ff ff       	call   80101f30 <nameiparent>
80105766:	83 c4 10             	add    $0x10,%esp
80105769:	85 c0                	test   %eax,%eax
8010576b:	89 c6                	mov    %eax,%esi
8010576d:	0f 84 5d 01 00 00    	je     801058d0 <sys_unlink+0x1b0>
  ilock(dp);
80105773:	83 ec 0c             	sub    $0xc,%esp
80105776:	50                   	push   %eax
80105777:	e8 14 bf ff ff       	call   80101690 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010577c:	58                   	pop    %eax
8010577d:	5a                   	pop    %edx
8010577e:	68 c0 8c 10 80       	push   $0x80108cc0
80105783:	53                   	push   %ebx
80105784:	e8 27 c4 ff ff       	call   80101bb0 <namecmp>
80105789:	83 c4 10             	add    $0x10,%esp
8010578c:	85 c0                	test   %eax,%eax
8010578e:	0f 84 00 01 00 00    	je     80105894 <sys_unlink+0x174>
80105794:	83 ec 08             	sub    $0x8,%esp
80105797:	68 bf 8c 10 80       	push   $0x80108cbf
8010579c:	53                   	push   %ebx
8010579d:	e8 0e c4 ff ff       	call   80101bb0 <namecmp>
801057a2:	83 c4 10             	add    $0x10,%esp
801057a5:	85 c0                	test   %eax,%eax
801057a7:	0f 84 e7 00 00 00    	je     80105894 <sys_unlink+0x174>
  if((ip = dirlookup(dp, name, &off)) == 0)
801057ad:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801057b0:	83 ec 04             	sub    $0x4,%esp
801057b3:	50                   	push   %eax
801057b4:	53                   	push   %ebx
801057b5:	56                   	push   %esi
801057b6:	e8 15 c4 ff ff       	call   80101bd0 <dirlookup>
801057bb:	83 c4 10             	add    $0x10,%esp
801057be:	85 c0                	test   %eax,%eax
801057c0:	89 c3                	mov    %eax,%ebx
801057c2:	0f 84 cc 00 00 00    	je     80105894 <sys_unlink+0x174>
  ilock(ip);
801057c8:	83 ec 0c             	sub    $0xc,%esp
801057cb:	50                   	push   %eax
801057cc:	e8 bf be ff ff       	call   80101690 <ilock>
  if(ip->nlink < 1)
801057d1:	83 c4 10             	add    $0x10,%esp
801057d4:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801057d9:	0f 8e 0d 01 00 00    	jle    801058ec <sys_unlink+0x1cc>
  if(ip->type == T_DIR && !isdirempty(ip)){
801057df:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801057e4:	74 6a                	je     80105850 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
801057e6:	8d 45 d8             	lea    -0x28(%ebp),%eax
801057e9:	83 ec 04             	sub    $0x4,%esp
801057ec:	6a 10                	push   $0x10
801057ee:	6a 00                	push   $0x0
801057f0:	50                   	push   %eax
801057f1:	e8 2a f2 ff ff       	call   80104a20 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801057f6:	8d 45 d8             	lea    -0x28(%ebp),%eax
801057f9:	6a 10                	push   $0x10
801057fb:	ff 75 c4             	pushl  -0x3c(%ebp)
801057fe:	50                   	push   %eax
801057ff:	56                   	push   %esi
80105800:	e8 7b c2 ff ff       	call   80101a80 <writei>
80105805:	83 c4 20             	add    $0x20,%esp
80105808:	83 f8 10             	cmp    $0x10,%eax
8010580b:	0f 85 e8 00 00 00    	jne    801058f9 <sys_unlink+0x1d9>
  if(ip->type == T_DIR){
80105811:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105816:	0f 84 94 00 00 00    	je     801058b0 <sys_unlink+0x190>
  iunlockput(dp);
8010581c:	83 ec 0c             	sub    $0xc,%esp
8010581f:	56                   	push   %esi
80105820:	e8 fb c0 ff ff       	call   80101920 <iunlockput>
  ip->nlink--;
80105825:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010582a:	89 1c 24             	mov    %ebx,(%esp)
8010582d:	e8 ae bd ff ff       	call   801015e0 <iupdate>
  iunlockput(ip);
80105832:	89 1c 24             	mov    %ebx,(%esp)
80105835:	e8 e6 c0 ff ff       	call   80101920 <iunlockput>
  end_op();
8010583a:	e8 01 d4 ff ff       	call   80102c40 <end_op>
  return 0;
8010583f:	83 c4 10             	add    $0x10,%esp
80105842:	31 c0                	xor    %eax,%eax
}
80105844:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105847:	5b                   	pop    %ebx
80105848:	5e                   	pop    %esi
80105849:	5f                   	pop    %edi
8010584a:	5d                   	pop    %ebp
8010584b:	c3                   	ret    
8010584c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105850:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105854:	76 90                	jbe    801057e6 <sys_unlink+0xc6>
80105856:	bf 20 00 00 00       	mov    $0x20,%edi
8010585b:	eb 0f                	jmp    8010586c <sys_unlink+0x14c>
8010585d:	8d 76 00             	lea    0x0(%esi),%esi
80105860:	83 c7 10             	add    $0x10,%edi
80105863:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105866:	0f 83 7a ff ff ff    	jae    801057e6 <sys_unlink+0xc6>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010586c:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010586f:	6a 10                	push   $0x10
80105871:	57                   	push   %edi
80105872:	50                   	push   %eax
80105873:	53                   	push   %ebx
80105874:	e8 07 c1 ff ff       	call   80101980 <readi>
80105879:	83 c4 10             	add    $0x10,%esp
8010587c:	83 f8 10             	cmp    $0x10,%eax
8010587f:	75 5e                	jne    801058df <sys_unlink+0x1bf>
    if(de.inum != 0)
80105881:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105886:	74 d8                	je     80105860 <sys_unlink+0x140>
    iunlockput(ip);
80105888:	83 ec 0c             	sub    $0xc,%esp
8010588b:	53                   	push   %ebx
8010588c:	e8 8f c0 ff ff       	call   80101920 <iunlockput>
    goto bad;
80105891:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80105894:	83 ec 0c             	sub    $0xc,%esp
80105897:	56                   	push   %esi
80105898:	e8 83 c0 ff ff       	call   80101920 <iunlockput>
  end_op();
8010589d:	e8 9e d3 ff ff       	call   80102c40 <end_op>
  return -1;
801058a2:	83 c4 10             	add    $0x10,%esp
801058a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058aa:	eb 98                	jmp    80105844 <sys_unlink+0x124>
801058ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
801058b0:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
801058b5:	83 ec 0c             	sub    $0xc,%esp
801058b8:	56                   	push   %esi
801058b9:	e8 22 bd ff ff       	call   801015e0 <iupdate>
801058be:	83 c4 10             	add    $0x10,%esp
801058c1:	e9 56 ff ff ff       	jmp    8010581c <sys_unlink+0xfc>
    return -1;
801058c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058cb:	e9 74 ff ff ff       	jmp    80105844 <sys_unlink+0x124>
    end_op();
801058d0:	e8 6b d3 ff ff       	call   80102c40 <end_op>
    return -1;
801058d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058da:	e9 65 ff ff ff       	jmp    80105844 <sys_unlink+0x124>
      panic("isdirempty: readi");
801058df:	83 ec 0c             	sub    $0xc,%esp
801058e2:	68 e4 8c 10 80       	push   $0x80108ce4
801058e7:	e8 a4 aa ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
801058ec:	83 ec 0c             	sub    $0xc,%esp
801058ef:	68 d2 8c 10 80       	push   $0x80108cd2
801058f4:	e8 97 aa ff ff       	call   80100390 <panic>
    panic("unlink: writei");
801058f9:	83 ec 0c             	sub    $0xc,%esp
801058fc:	68 f6 8c 10 80       	push   $0x80108cf6
80105901:	e8 8a aa ff ff       	call   80100390 <panic>
80105906:	8d 76 00             	lea    0x0(%esi),%esi
80105909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105910 <sys_mkdir>:
// end  new code


int
sys_mkdir(void)
{ if(isTraceOn==1)
80105910:	55                   	push   %ebp
80105911:	89 e5                	mov    %esp,%ebp
80105913:	83 ec 18             	sub    $0x18,%esp
80105916:	83 3d b0 18 11 80 01 	cmpl   $0x1,0x801118b0
8010591d:	75 07                	jne    80105926 <sys_mkdir+0x16>
  {num_calls[SYS_mkdir] ++;}
8010591f:	83 05 10 7e 14 80 01 	addl   $0x1,0x80147e10
  char *path;
  struct inode *ip;

  begin_op();
80105926:	e8 a5 d2 ff ff       	call   80102bd0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010592b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010592e:	83 ec 08             	sub    $0x8,%esp
80105931:	50                   	push   %eax
80105932:	6a 00                	push   $0x0
80105934:	e8 97 f4 ff ff       	call   80104dd0 <argstr>
80105939:	83 c4 10             	add    $0x10,%esp
8010593c:	85 c0                	test   %eax,%eax
8010593e:	78 30                	js     80105970 <sys_mkdir+0x60>
80105940:	83 ec 0c             	sub    $0xc,%esp
80105943:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105946:	31 c9                	xor    %ecx,%ecx
80105948:	6a 00                	push   $0x0
8010594a:	ba 01 00 00 00       	mov    $0x1,%edx
8010594f:	e8 3c f8 ff ff       	call   80105190 <create>
80105954:	83 c4 10             	add    $0x10,%esp
80105957:	85 c0                	test   %eax,%eax
80105959:	74 15                	je     80105970 <sys_mkdir+0x60>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010595b:	83 ec 0c             	sub    $0xc,%esp
8010595e:	50                   	push   %eax
8010595f:	e8 bc bf ff ff       	call   80101920 <iunlockput>
  end_op();
80105964:	e8 d7 d2 ff ff       	call   80102c40 <end_op>
  return 0;
80105969:	83 c4 10             	add    $0x10,%esp
8010596c:	31 c0                	xor    %eax,%eax
}
8010596e:	c9                   	leave  
8010596f:	c3                   	ret    
    end_op();
80105970:	e8 cb d2 ff ff       	call   80102c40 <end_op>
    return -1;
80105975:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010597a:	c9                   	leave  
8010597b:	c3                   	ret    
8010597c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105980 <sys_mknod>:

int
sys_mknod(void)
{ if(isTraceOn==1)
80105980:	55                   	push   %ebp
80105981:	89 e5                	mov    %esp,%ebp
80105983:	83 ec 18             	sub    $0x18,%esp
80105986:	83 3d b0 18 11 80 01 	cmpl   $0x1,0x801118b0
8010598d:	75 07                	jne    80105996 <sys_mknod+0x16>
  {num_calls[SYS_mknod] ++;}
8010598f:	83 05 04 7e 14 80 01 	addl   $0x1,0x80147e04
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105996:	e8 35 d2 ff ff       	call   80102bd0 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010599b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010599e:	83 ec 08             	sub    $0x8,%esp
801059a1:	50                   	push   %eax
801059a2:	6a 00                	push   $0x0
801059a4:	e8 27 f4 ff ff       	call   80104dd0 <argstr>
801059a9:	83 c4 10             	add    $0x10,%esp
801059ac:	85 c0                	test   %eax,%eax
801059ae:	78 60                	js     80105a10 <sys_mknod+0x90>
     argint(1, &major) < 0 ||
801059b0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801059b3:	83 ec 08             	sub    $0x8,%esp
801059b6:	50                   	push   %eax
801059b7:	6a 01                	push   $0x1
801059b9:	e8 62 f3 ff ff       	call   80104d20 <argint>
  if((argstr(0, &path)) < 0 ||
801059be:	83 c4 10             	add    $0x10,%esp
801059c1:	85 c0                	test   %eax,%eax
801059c3:	78 4b                	js     80105a10 <sys_mknod+0x90>
     argint(2, &minor) < 0 ||
801059c5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801059c8:	83 ec 08             	sub    $0x8,%esp
801059cb:	50                   	push   %eax
801059cc:	6a 02                	push   $0x2
801059ce:	e8 4d f3 ff ff       	call   80104d20 <argint>
     argint(1, &major) < 0 ||
801059d3:	83 c4 10             	add    $0x10,%esp
801059d6:	85 c0                	test   %eax,%eax
801059d8:	78 36                	js     80105a10 <sys_mknod+0x90>
     (ip = create(path, T_DEV, major, minor)) == 0){
801059da:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
801059de:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
801059e1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
801059e5:	ba 03 00 00 00       	mov    $0x3,%edx
801059ea:	50                   	push   %eax
801059eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801059ee:	e8 9d f7 ff ff       	call   80105190 <create>
801059f3:	83 c4 10             	add    $0x10,%esp
801059f6:	85 c0                	test   %eax,%eax
801059f8:	74 16                	je     80105a10 <sys_mknod+0x90>
    end_op();
    return -1;
  }
  iunlockput(ip);
801059fa:	83 ec 0c             	sub    $0xc,%esp
801059fd:	50                   	push   %eax
801059fe:	e8 1d bf ff ff       	call   80101920 <iunlockput>
  end_op();
80105a03:	e8 38 d2 ff ff       	call   80102c40 <end_op>
  return 0;
80105a08:	83 c4 10             	add    $0x10,%esp
80105a0b:	31 c0                	xor    %eax,%eax
}
80105a0d:	c9                   	leave  
80105a0e:	c3                   	ret    
80105a0f:	90                   	nop
    end_op();
80105a10:	e8 2b d2 ff ff       	call   80102c40 <end_op>
    return -1;
80105a15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a1a:	c9                   	leave  
80105a1b:	c3                   	ret    
80105a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105a20 <sys_chdir>:

int
sys_chdir(void)
{ if(isTraceOn==1)
80105a20:	55                   	push   %ebp
80105a21:	89 e5                	mov    %esp,%ebp
80105a23:	56                   	push   %esi
80105a24:	53                   	push   %ebx
80105a25:	83 ec 10             	sub    $0x10,%esp
80105a28:	83 3d b0 18 11 80 01 	cmpl   $0x1,0x801118b0
80105a2f:	75 07                	jne    80105a38 <sys_chdir+0x18>
  {num_calls[SYS_chdir] ++;}
80105a31:	83 05 e4 7d 14 80 01 	addl   $0x1,0x80147de4
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105a38:	e8 d3 dd ff ff       	call   80103810 <myproc>
80105a3d:	89 c6                	mov    %eax,%esi

  begin_op();
80105a3f:	e8 8c d1 ff ff       	call   80102bd0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105a44:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a47:	83 ec 08             	sub    $0x8,%esp
80105a4a:	50                   	push   %eax
80105a4b:	6a 00                	push   $0x0
80105a4d:	e8 7e f3 ff ff       	call   80104dd0 <argstr>
80105a52:	83 c4 10             	add    $0x10,%esp
80105a55:	85 c0                	test   %eax,%eax
80105a57:	78 77                	js     80105ad0 <sys_chdir+0xb0>
80105a59:	83 ec 0c             	sub    $0xc,%esp
80105a5c:	ff 75 f4             	pushl  -0xc(%ebp)
80105a5f:	e8 ac c4 ff ff       	call   80101f10 <namei>
80105a64:	83 c4 10             	add    $0x10,%esp
80105a67:	85 c0                	test   %eax,%eax
80105a69:	89 c3                	mov    %eax,%ebx
80105a6b:	74 63                	je     80105ad0 <sys_chdir+0xb0>
    end_op();
    return -1;
  }
  ilock(ip);
80105a6d:	83 ec 0c             	sub    $0xc,%esp
80105a70:	50                   	push   %eax
80105a71:	e8 1a bc ff ff       	call   80101690 <ilock>
  if(ip->type != T_DIR){
80105a76:	83 c4 10             	add    $0x10,%esp
80105a79:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105a7e:	75 30                	jne    80105ab0 <sys_chdir+0x90>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105a80:	83 ec 0c             	sub    $0xc,%esp
80105a83:	53                   	push   %ebx
80105a84:	e8 e7 bc ff ff       	call   80101770 <iunlock>
  iput(curproc->cwd);
80105a89:	58                   	pop    %eax
80105a8a:	ff b6 b8 01 00 00    	pushl  0x1b8(%esi)
80105a90:	e8 2b bd ff ff       	call   801017c0 <iput>
  end_op();
80105a95:	e8 a6 d1 ff ff       	call   80102c40 <end_op>
  curproc->cwd = ip;
80105a9a:	89 9e b8 01 00 00    	mov    %ebx,0x1b8(%esi)
  return 0;
80105aa0:	83 c4 10             	add    $0x10,%esp
80105aa3:	31 c0                	xor    %eax,%eax
}
80105aa5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105aa8:	5b                   	pop    %ebx
80105aa9:	5e                   	pop    %esi
80105aaa:	5d                   	pop    %ebp
80105aab:	c3                   	ret    
80105aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
80105ab0:	83 ec 0c             	sub    $0xc,%esp
80105ab3:	53                   	push   %ebx
80105ab4:	e8 67 be ff ff       	call   80101920 <iunlockput>
    end_op();
80105ab9:	e8 82 d1 ff ff       	call   80102c40 <end_op>
    return -1;
80105abe:	83 c4 10             	add    $0x10,%esp
80105ac1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ac6:	eb dd                	jmp    80105aa5 <sys_chdir+0x85>
80105ac8:	90                   	nop
80105ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105ad0:	e8 6b d1 ff ff       	call   80102c40 <end_op>
    return -1;
80105ad5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ada:	eb c9                	jmp    80105aa5 <sys_chdir+0x85>
80105adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ae0 <sys_exec>:

int
sys_exec(void)
{ if(isTraceOn==1)
80105ae0:	55                   	push   %ebp
80105ae1:	89 e5                	mov    %esp,%ebp
80105ae3:	57                   	push   %edi
80105ae4:	56                   	push   %esi
80105ae5:	53                   	push   %ebx
80105ae6:	81 ec 9c 00 00 00    	sub    $0x9c,%esp
80105aec:	83 3d b0 18 11 80 01 	cmpl   $0x1,0x801118b0
80105af3:	75 07                	jne    80105afc <sys_exec+0x1c>
  {num_calls[SYS_exec] ++;}
80105af5:	83 05 dc 7d 14 80 01 	addl   $0x1,0x80147ddc
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105afc:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80105b02:	83 ec 08             	sub    $0x8,%esp
80105b05:	50                   	push   %eax
80105b06:	6a 00                	push   $0x0
80105b08:	e8 c3 f2 ff ff       	call   80104dd0 <argstr>
80105b0d:	83 c4 10             	add    $0x10,%esp
80105b10:	85 c0                	test   %eax,%eax
80105b12:	0f 88 8c 00 00 00    	js     80105ba4 <sys_exec+0xc4>
80105b18:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105b1e:	83 ec 08             	sub    $0x8,%esp
80105b21:	50                   	push   %eax
80105b22:	6a 01                	push   $0x1
80105b24:	e8 f7 f1 ff ff       	call   80104d20 <argint>
80105b29:	83 c4 10             	add    $0x10,%esp
80105b2c:	85 c0                	test   %eax,%eax
80105b2e:	78 74                	js     80105ba4 <sys_exec+0xc4>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105b30:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105b36:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105b39:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105b3b:	68 80 00 00 00       	push   $0x80
80105b40:	6a 00                	push   $0x0
80105b42:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105b48:	50                   	push   %eax
80105b49:	e8 d2 ee ff ff       	call   80104a20 <memset>
80105b4e:	83 c4 10             	add    $0x10,%esp
80105b51:	eb 31                	jmp    80105b84 <sys_exec+0xa4>
80105b53:	90                   	nop
80105b54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80105b58:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105b5e:	85 c0                	test   %eax,%eax
80105b60:	74 56                	je     80105bb8 <sys_exec+0xd8>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105b62:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105b68:	83 ec 08             	sub    $0x8,%esp
80105b6b:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105b6e:	52                   	push   %edx
80105b6f:	50                   	push   %eax
80105b70:	e8 3b f1 ff ff       	call   80104cb0 <fetchstr>
80105b75:	83 c4 10             	add    $0x10,%esp
80105b78:	85 c0                	test   %eax,%eax
80105b7a:	78 28                	js     80105ba4 <sys_exec+0xc4>
  for(i=0;; i++){
80105b7c:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105b7f:	83 fb 20             	cmp    $0x20,%ebx
80105b82:	74 20                	je     80105ba4 <sys_exec+0xc4>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105b84:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105b8a:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105b91:	83 ec 08             	sub    $0x8,%esp
80105b94:	57                   	push   %edi
80105b95:	01 f0                	add    %esi,%eax
80105b97:	50                   	push   %eax
80105b98:	e8 d3 f0 ff ff       	call   80104c70 <fetchint>
80105b9d:	83 c4 10             	add    $0x10,%esp
80105ba0:	85 c0                	test   %eax,%eax
80105ba2:	79 b4                	jns    80105b58 <sys_exec+0x78>
      return -1;
  }
  return exec(path, argv);
}
80105ba4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105ba7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105bac:	5b                   	pop    %ebx
80105bad:	5e                   	pop    %esi
80105bae:	5f                   	pop    %edi
80105baf:	5d                   	pop    %ebp
80105bb0:	c3                   	ret    
80105bb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105bb8:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105bbe:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105bc1:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105bc8:	00 00 00 00 
  return exec(path, argv);
80105bcc:	50                   	push   %eax
80105bcd:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105bd3:	e8 38 ae ff ff       	call   80100a10 <exec>
80105bd8:	83 c4 10             	add    $0x10,%esp
}
80105bdb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bde:	5b                   	pop    %ebx
80105bdf:	5e                   	pop    %esi
80105be0:	5f                   	pop    %edi
80105be1:	5d                   	pop    %ebp
80105be2:	c3                   	ret    
80105be3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105bf0 <sys_pipe>:

int
sys_pipe(void)
{ if(isTraceOn==1)
80105bf0:	55                   	push   %ebp
80105bf1:	89 e5                	mov    %esp,%ebp
80105bf3:	57                   	push   %edi
80105bf4:	56                   	push   %esi
80105bf5:	53                   	push   %ebx
80105bf6:	83 ec 1c             	sub    $0x1c,%esp
80105bf9:	83 3d b0 18 11 80 01 	cmpl   $0x1,0x801118b0
80105c00:	75 07                	jne    80105c09 <sys_pipe+0x19>
  {num_calls[SYS_pipe] ++;}
80105c02:	83 05 d0 7d 14 80 01 	addl   $0x1,0x80147dd0
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105c09:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105c0c:	83 ec 04             	sub    $0x4,%esp
80105c0f:	6a 08                	push   $0x8
80105c11:	50                   	push   %eax
80105c12:	6a 00                	push   $0x0
80105c14:	e8 57 f1 ff ff       	call   80104d70 <argptr>
80105c19:	83 c4 10             	add    $0x10,%esp
80105c1c:	85 c0                	test   %eax,%eax
80105c1e:	0f 88 a3 00 00 00    	js     80105cc7 <sys_pipe+0xd7>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105c24:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105c27:	83 ec 08             	sub    $0x8,%esp
80105c2a:	50                   	push   %eax
80105c2b:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105c2e:	50                   	push   %eax
80105c2f:	e8 3c d6 ff ff       	call   80103270 <pipealloc>
80105c34:	83 c4 10             	add    $0x10,%esp
80105c37:	85 c0                	test   %eax,%eax
80105c39:	0f 88 88 00 00 00    	js     80105cc7 <sys_pipe+0xd7>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105c3f:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105c42:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105c44:	e8 c7 db ff ff       	call   80103810 <myproc>
80105c49:	eb 0d                	jmp    80105c58 <sys_pipe+0x68>
80105c4b:	90                   	nop
80105c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105c50:	83 c3 01             	add    $0x1,%ebx
80105c53:	83 fb 64             	cmp    $0x64,%ebx
80105c56:	74 58                	je     80105cb0 <sys_pipe+0xc0>
    if(curproc->ofile[fd] == 0){
80105c58:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105c5c:	85 f6                	test   %esi,%esi
80105c5e:	75 f0                	jne    80105c50 <sys_pipe+0x60>
      curproc->ofile[fd] = f;
80105c60:	8d 73 08             	lea    0x8(%ebx),%esi
80105c63:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105c67:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105c6a:	e8 a1 db ff ff       	call   80103810 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105c6f:	31 d2                	xor    %edx,%edx
80105c71:	eb 0d                	jmp    80105c80 <sys_pipe+0x90>
80105c73:	90                   	nop
80105c74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c78:	83 c2 01             	add    $0x1,%edx
80105c7b:	83 fa 64             	cmp    $0x64,%edx
80105c7e:	74 21                	je     80105ca1 <sys_pipe+0xb1>
    if(curproc->ofile[fd] == 0){
80105c80:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105c84:	85 c9                	test   %ecx,%ecx
80105c86:	75 f0                	jne    80105c78 <sys_pipe+0x88>
      curproc->ofile[fd] = f;
80105c88:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105c8c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105c8f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105c91:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105c94:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105c97:	31 c0                	xor    %eax,%eax
}
80105c99:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c9c:	5b                   	pop    %ebx
80105c9d:	5e                   	pop    %esi
80105c9e:	5f                   	pop    %edi
80105c9f:	5d                   	pop    %ebp
80105ca0:	c3                   	ret    
      myproc()->ofile[fd0] = 0;
80105ca1:	e8 6a db ff ff       	call   80103810 <myproc>
80105ca6:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105cad:	00 
80105cae:	66 90                	xchg   %ax,%ax
    fileclose(rf);
80105cb0:	83 ec 0c             	sub    $0xc,%esp
80105cb3:	ff 75 e0             	pushl  -0x20(%ebp)
80105cb6:	e8 85 b1 ff ff       	call   80100e40 <fileclose>
    fileclose(wf);
80105cbb:	58                   	pop    %eax
80105cbc:	ff 75 e4             	pushl  -0x1c(%ebp)
80105cbf:	e8 7c b1 ff ff       	call   80100e40 <fileclose>
    return -1;
80105cc4:	83 c4 10             	add    $0x10,%esp
80105cc7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ccc:	eb cb                	jmp    80105c99 <sys_pipe+0xa9>
80105cce:	66 90                	xchg   %ax,%ax

80105cd0 <my_itoa>:

char* my_itoa(int i, char* b){
80105cd0:	55                   	push   %ebp
    char const digit[] = "0123456789";
80105cd1:	b8 38 39 00 00       	mov    $0x3938,%eax
char* my_itoa(int i, char* b){
80105cd6:	89 e5                	mov    %esp,%ebp
80105cd8:	57                   	push   %edi
80105cd9:	56                   	push   %esi
80105cda:	53                   	push   %ebx
80105cdb:	83 ec 10             	sub    $0x10,%esp
80105cde:	8b 4d 08             	mov    0x8(%ebp),%ecx
    char const digit[] = "0123456789";
80105ce1:	c7 45 e9 30 31 32 33 	movl   $0x33323130,-0x17(%ebp)
80105ce8:	c7 45 ed 34 35 36 37 	movl   $0x37363534,-0x13(%ebp)
80105cef:	66 89 45 f1          	mov    %ax,-0xf(%ebp)
80105cf3:	c6 45 f3 00          	movb   $0x0,-0xd(%ebp)
    char const sig[] = "_";
    char* p = b;
80105cf7:	8b 75 0c             	mov    0xc(%ebp),%esi
    // if(i<0){
    //     *p++ = '-';
    //     i *= -1;
    // }
    int n = i;
80105cfa:	89 cb                	mov    %ecx,%ebx
80105cfc:	eb 04                	jmp    80105d02 <my_itoa+0x32>
80105cfe:	66 90                	xchg   %ax,%ax
    do{
        ++p;
80105d00:	89 fe                	mov    %edi,%esi
        n = n/10;
80105d02:	b8 67 66 66 66       	mov    $0x66666667,%eax
        ++p;
80105d07:	8d 7e 01             	lea    0x1(%esi),%edi
        n = n/10;
80105d0a:	f7 eb                	imul   %ebx
80105d0c:	c1 fb 1f             	sar    $0x1f,%ebx
80105d0f:	c1 fa 02             	sar    $0x2,%edx
    }while(n);
80105d12:	29 da                	sub    %ebx,%edx
80105d14:	89 d3                	mov    %edx,%ebx
80105d16:	75 e8                	jne    80105d00 <my_itoa+0x30>
    p++;
80105d18:	83 c6 02             	add    $0x2,%esi
    *p = '\0';
80105d1b:	c6 47 01 00          	movb   $0x0,0x1(%edi)
    do{
        *--p = digit[i%10];
80105d1f:	bb 67 66 66 66       	mov    $0x66666667,%ebx
80105d24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d28:	89 c8                	mov    %ecx,%eax
80105d2a:	83 ee 01             	sub    $0x1,%esi
80105d2d:	f7 eb                	imul   %ebx
80105d2f:	89 c8                	mov    %ecx,%eax
80105d31:	c1 f8 1f             	sar    $0x1f,%eax
80105d34:	c1 fa 02             	sar    $0x2,%edx
80105d37:	29 c2                	sub    %eax,%edx
80105d39:	8d 04 92             	lea    (%edx,%edx,4),%eax
80105d3c:	01 c0                	add    %eax,%eax
80105d3e:	29 c1                	sub    %eax,%ecx
        i = i/10;
    }while(i);
80105d40:	85 d2                	test   %edx,%edx
        *--p = digit[i%10];
80105d42:	0f b6 44 0d e9       	movzbl -0x17(%ebp,%ecx,1),%eax
        i = i/10;
80105d47:	89 d1                	mov    %edx,%ecx
        *--p = digit[i%10];
80105d49:	88 06                	mov    %al,(%esi)
    }while(i);
80105d4b:	75 db                	jne    80105d28 <my_itoa+0x58>
    // p--;
    *--p = sig[0];
80105d4d:	c6 46 ff 5f          	movb   $0x5f,-0x1(%esi)

    return b;
}
80105d51:	8b 45 0c             	mov    0xc(%ebp),%eax
80105d54:	83 c4 10             	add    $0x10,%esp
80105d57:	5b                   	pop    %ebx
80105d58:	5e                   	pop    %esi
80105d59:	5f                   	pop    %edi
80105d5a:	5d                   	pop    %ebp
80105d5b:	c3                   	ret    
80105d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d60 <strcat>:

char* strcat(char* s1,const char* s2)
{
80105d60:	55                   	push   %ebp
80105d61:	89 e5                	mov    %esp,%ebp
80105d63:	56                   	push   %esi
80105d64:	53                   	push   %ebx
80105d65:	8b 75 08             	mov    0x8(%ebp),%esi
80105d68:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char* b = (char*)kalloc();
80105d6b:	e8 80 c7 ff ff       	call   801024f0 <kalloc>
80105d70:	89 c2                	mov    %eax,%edx
  char* c= b;

  while (*s1)  *b++=*s1++;
80105d72:	0f b6 0e             	movzbl (%esi),%ecx
80105d75:	84 c9                	test   %cl,%cl
80105d77:	74 2f                	je     80105da8 <strcat+0x48>
80105d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d80:	83 c6 01             	add    $0x1,%esi
80105d83:	83 c2 01             	add    $0x1,%edx
80105d86:	88 4a ff             	mov    %cl,-0x1(%edx)
80105d89:	0f b6 0e             	movzbl (%esi),%ecx
80105d8c:	84 c9                	test   %cl,%cl
80105d8e:	75 f0                	jne    80105d80 <strcat+0x20>
  while (*s2) {
80105d90:	0f b6 0b             	movzbl (%ebx),%ecx
80105d93:	84 c9                	test   %cl,%cl
80105d95:	74 18                	je     80105daf <strcat+0x4f>
80105d97:	89 f6                	mov    %esi,%esi
80105d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    *b=*s2;
80105da0:	88 0a                	mov    %cl,(%edx)
    b++;
    s2++;}
80105da2:	83 c3 01             	add    $0x1,%ebx
    b++;
80105da5:	83 c2 01             	add    $0x1,%edx
  while (*s2) {
80105da8:	0f b6 0b             	movzbl (%ebx),%ecx
80105dab:	84 c9                	test   %cl,%cl
80105dad:	75 f1                	jne    80105da0 <strcat+0x40>
  *b = 0;
80105daf:	c6 02 00             	movb   $0x0,(%edx)

  return c;
}
80105db2:	5b                   	pop    %ebx
80105db3:	5e                   	pop    %esi
80105db4:	5d                   	pop    %ebp
80105db5:	c3                   	ret    
80105db6:	8d 76 00             	lea    0x0(%esi),%esi
80105db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105dc0 <mystrcmp>:
int
mystrcmp (char *s1, char *s2)
{
80105dc0:	55                   	push   %ebp
80105dc1:	89 e5                	mov    %esp,%ebp
80105dc3:	56                   	push   %esi
    int a =0,b=0;
80105dc4:	31 f6                	xor    %esi,%esi
{
80105dc6:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105dc9:	53                   	push   %ebx
80105dca:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    while(*s1){a++;s1++;}
80105dcd:	80 39 00             	cmpb   $0x0,(%ecx)
80105dd0:	0f b6 03             	movzbl (%ebx),%eax
80105dd3:	74 5b                	je     80105e30 <mystrcmp+0x70>
80105dd5:	8d 76 00             	lea    0x0(%esi),%esi
80105dd8:	83 c1 01             	add    $0x1,%ecx
80105ddb:	83 c6 01             	add    $0x1,%esi
80105dde:	80 39 00             	cmpb   $0x0,(%ecx)
80105de1:	75 f5                	jne    80105dd8 <mystrcmp+0x18>
    while(*s2){b++;s2++;}
80105de3:	84 c0                	test   %al,%al
80105de5:	74 3f                	je     80105e26 <mystrcmp+0x66>
    int a =0,b=0;
80105de7:	31 d2                	xor    %edx,%edx
80105de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(*s2){b++;s2++;}
80105df0:	83 c3 01             	add    $0x1,%ebx
80105df3:	83 c2 01             	add    $0x1,%edx
80105df6:	80 3b 00             	cmpb   $0x0,(%ebx)
80105df9:	75 f5                	jne    80105df0 <mystrcmp+0x30>

    if(a!=b)return 0;
80105dfb:	31 c0                	xor    %eax,%eax
80105dfd:	39 f2                	cmp    %esi,%edx
80105dff:	74 07                	je     80105e08 <mystrcmp+0x48>
    // printf("here");
    while(a--){
        if(*s1-- != *s2--)return 0;
    }
    return 1;
}
80105e01:	5b                   	pop    %ebx
80105e02:	5e                   	pop    %esi
80105e03:	5d                   	pop    %ebp
80105e04:	c3                   	ret    
80105e05:	8d 76 00             	lea    0x0(%esi),%esi
80105e08:	89 d6                	mov    %edx,%esi
80105e0a:	f7 de                	neg    %esi
        if(*s1-- != *s2--)return 0;
80105e0c:	01 f1                	add    %esi,%ecx
80105e0e:	66 90                	xchg   %ax,%ax
    while(a--){
80105e10:	83 ea 01             	sub    $0x1,%edx
80105e13:	83 fa ff             	cmp    $0xffffffff,%edx
80105e16:	74 1c                	je     80105e34 <mystrcmp+0x74>
        if(*s1-- != *s2--)return 0;
80105e18:	8d 04 33             	lea    (%ebx,%esi,1),%eax
80105e1b:	0f b6 44 02 01       	movzbl 0x1(%edx,%eax,1),%eax
80105e20:	38 44 0a 01          	cmp    %al,0x1(%edx,%ecx,1)
80105e24:	74 ea                	je     80105e10 <mystrcmp+0x50>
}
80105e26:	5b                   	pop    %ebx
    if(a!=b)return 0;
80105e27:	31 c0                	xor    %eax,%eax
}
80105e29:	5e                   	pop    %esi
80105e2a:	5d                   	pop    %ebp
80105e2b:	c3                   	ret    
80105e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(*s2){b++;s2++;}
80105e30:	84 c0                	test   %al,%al
80105e32:	75 b3                	jne    80105de7 <mystrcmp+0x27>
}
80105e34:	5b                   	pop    %ebx
    return 1;
80105e35:	b8 01 00 00 00       	mov    $0x1,%eax
}
80105e3a:	5e                   	pop    %esi
80105e3b:	5d                   	pop    %ebp
80105e3c:	c3                   	ret    
80105e3d:	8d 76 00             	lea    0x0(%esi),%esi

80105e40 <sys_open>:
// char buf[4];


int
sys_open(void)
{
80105e40:	55                   	push   %ebp
80105e41:	89 e5                	mov    %esp,%ebp
80105e43:	57                   	push   %edi
80105e44:	56                   	push   %esi
80105e45:	53                   	push   %ebx
80105e46:	83 ec 4c             	sub    $0x4c,%esp
  int create_in_container = 0;
  struct proc *curproc = myproc();
80105e49:	e8 c2 d9 ff ff       	call   80103810 <myproc>
  int cid = curproc->cid;

  // cprintf("cid is :%d",cid);


  if(isTraceOn==1)
80105e4e:	83 3d b0 18 11 80 01 	cmpl   $0x1,0x801118b0
  struct proc *curproc = myproc();
80105e55:	89 45 b8             	mov    %eax,-0x48(%ebp)
  int cid = curproc->cid;
80105e58:	8b 80 cc 01 00 00    	mov    0x1cc(%eax),%eax
80105e5e:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  if(isTraceOn==1)
80105e61:	75 07                	jne    80105e6a <sys_open+0x2a>
  {num_calls[SYS_open] ++;}
80105e63:	83 05 fc 7d 14 80 01 	addl   $0x1,0x80147dfc
  int fd, omode;
  struct file *f;
  struct inode *ip;


  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105e6a:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80105e6d:	83 ec 08             	sub    $0x8,%esp
80105e70:	50                   	push   %eax
80105e71:	6a 00                	push   $0x0
80105e73:	e8 58 ef ff ff       	call   80104dd0 <argstr>
80105e78:	83 c4 10             	add    $0x10,%esp
80105e7b:	85 c0                	test   %eax,%eax
80105e7d:	0f 88 76 04 00 00    	js     801062f9 <sys_open+0x4b9>
80105e83:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105e86:	83 ec 08             	sub    $0x8,%esp
80105e89:	50                   	push   %eax
80105e8a:	6a 01                	push   $0x1
80105e8c:	e8 8f ee ff ff       	call   80104d20 <argint>
80105e91:	83 c4 10             	add    $0x10,%esp
80105e94:	85 c0                	test   %eax,%eax
80105e96:	0f 88 5d 04 00 00    	js     801062f9 <sys_open+0x4b9>



  int pehle_se_hai_conatiner_me = 0;

  for (int i = 0; i < 100; i++) {
80105e9c:	31 db                	xor    %ebx,%ebx
80105e9e:	8b 55 c4             	mov    -0x3c(%ebp),%edx
80105ea1:	eb 11                	jmp    80105eb4 <sys_open+0x74>
80105ea3:	90                   	nop
80105ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105ea8:	83 c3 01             	add    $0x1,%ebx
80105eab:	83 fb 64             	cmp    $0x64,%ebx
80105eae:	0f 84 1c 01 00 00    	je     80105fd0 <sys_open+0x190>
    if (container_location[i]==1){
80105eb4:	8b 34 9d e0 79 14 80 	mov    -0x7feb8620(,%ebx,4),%esi
80105ebb:	83 fe 01             	cmp    $0x1,%esi
80105ebe:	75 e8                	jne    80105ea8 <sys_open+0x68>
80105ec0:	69 c3 a4 08 00 00    	imul   $0x8a4,%ebx,%eax
      if(container_array[i].cid==cid){
80105ec6:	39 90 c0 18 11 80    	cmp    %edx,-0x7feee740(%eax)
80105ecc:	75 da                	jne    80105ea8 <sys_open+0x68>
80105ece:	89 45 ac             	mov    %eax,-0x54(%ebp)
        int ind = curproc->cid;
80105ed1:	8b 45 b8             	mov    -0x48(%ebp),%eax
80105ed4:	8b b8 cc 01 00 00    	mov    0x1cc(%eax),%edi
        // int ind = 67;
        char *sind = (char *)kalloc();
80105eda:	e8 11 c6 ff ff       	call   801024f0 <kalloc>
        // strncpy(sind,my_itoa(ind,sind),);
        char *ipath = path;
80105edf:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    char const digit[] = "0123456789";
80105ee2:	ba 38 39 00 00       	mov    $0x3938,%edx
80105ee7:	89 5d b0             	mov    %ebx,-0x50(%ebp)
        char *sind = (char *)kalloc();
80105eea:	89 45 c0             	mov    %eax,-0x40(%ebp)
    char const digit[] = "0123456789";
80105eed:	c7 45 dd 30 31 32 33 	movl   $0x33323130,-0x23(%ebp)
80105ef4:	89 c3                	mov    %eax,%ebx
80105ef6:	c7 45 e1 34 35 36 37 	movl   $0x37363534,-0x1f(%ebp)
80105efd:	66 89 55 e5          	mov    %dx,-0x1b(%ebp)
        char *ipath = path;
80105f01:	89 4d bc             	mov    %ecx,-0x44(%ebp)
    char const digit[] = "0123456789";
80105f04:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
    int n = i;
80105f08:	89 f9                	mov    %edi,%ecx
80105f0a:	89 75 b4             	mov    %esi,-0x4c(%ebp)
80105f0d:	eb 03                	jmp    80105f12 <sys_open+0xd2>
80105f0f:	90                   	nop
        ++p;
80105f10:	89 f3                	mov    %esi,%ebx
        n = n/10;
80105f12:	b8 67 66 66 66       	mov    $0x66666667,%eax
        ++p;
80105f17:	8d 73 01             	lea    0x1(%ebx),%esi
        n = n/10;
80105f1a:	f7 e9                	imul   %ecx
80105f1c:	c1 f9 1f             	sar    $0x1f,%ecx
80105f1f:	c1 fa 02             	sar    $0x2,%edx
    }while(n);
80105f22:	29 ca                	sub    %ecx,%edx
80105f24:	89 d1                	mov    %edx,%ecx
80105f26:	75 e8                	jne    80105f10 <sys_open+0xd0>
80105f28:	89 f2                	mov    %esi,%edx
80105f2a:	89 d8                	mov    %ebx,%eax
80105f2c:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80105f2f:	8b 5d b0             	mov    -0x50(%ebp),%ebx
    p++;
80105f32:	83 c0 02             	add    $0x2,%eax
    *p = '\0';
80105f35:	c6 42 01 00          	movb   $0x0,0x1(%edx)
    p++;
80105f39:	89 c1                	mov    %eax,%ecx
80105f3b:	90                   	nop
80105f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        *--p = digit[i%10];
80105f40:	b8 67 66 66 66       	mov    $0x66666667,%eax
80105f45:	83 e9 01             	sub    $0x1,%ecx
80105f48:	f7 ef                	imul   %edi
80105f4a:	89 f8                	mov    %edi,%eax
80105f4c:	c1 f8 1f             	sar    $0x1f,%eax
80105f4f:	c1 fa 02             	sar    $0x2,%edx
80105f52:	29 c2                	sub    %eax,%edx
80105f54:	8d 04 92             	lea    (%edx,%edx,4),%eax
80105f57:	01 c0                	add    %eax,%eax
80105f59:	29 c7                	sub    %eax,%edi
    }while(i);
80105f5b:	85 d2                	test   %edx,%edx
        *--p = digit[i%10];
80105f5d:	0f b6 44 3d dd       	movzbl -0x23(%ebp,%edi,1),%eax
        i = i/10;
80105f62:	89 d7                	mov    %edx,%edi
        *--p = digit[i%10];
80105f64:	88 01                	mov    %al,(%ecx)
    }while(i);
80105f66:	75 d8                	jne    80105f40 <sys_open+0x100>
        sind = my_itoa(ind,sind);
        char *path4 = strcat(ipath,sind);
        // cprintf("path is:%s\n",path4);
          for (int j = 0; j < container_array[i].number_of_files; j++) {
80105f68:	69 db a4 08 00 00    	imul   $0x8a4,%ebx,%ebx
        char *path4 = strcat(ipath,sind);
80105f6e:	83 ec 08             	sub    $0x8,%esp
    *--p = sig[0];
80105f71:	c6 41 ff 5f          	movb   $0x5f,-0x1(%ecx)
        char *path4 = strcat(ipath,sind);
80105f75:	ff 75 c0             	pushl  -0x40(%ebp)
80105f78:	ff 75 bc             	pushl  -0x44(%ebp)
80105f7b:	e8 e0 fd ff ff       	call   80105d60 <strcat>
          for (int j = 0; j < container_array[i].number_of_files; j++) {
80105f80:	8b 9b c8 18 11 80    	mov    -0x7feee738(%ebx),%ebx
80105f86:	83 c4 10             	add    $0x10,%esp
        char *path4 = strcat(ipath,sind);
80105f89:	89 45 c0             	mov    %eax,-0x40(%ebp)
          for (int j = 0; j < container_array[i].number_of_files; j++) {
80105f8c:	85 db                	test   %ebx,%ebx
80105f8e:	7e 40                	jle    80105fd0 <sys_open+0x190>
80105f90:	89 75 bc             	mov    %esi,-0x44(%ebp)
80105f93:	89 fe                	mov    %edi,%esi
80105f95:	89 df                	mov    %ebx,%edi
80105f97:	8b 5d ac             	mov    -0x54(%ebp),%ebx
80105f9a:	eb 0b                	jmp    80105fa7 <sys_open+0x167>
80105f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105fa0:	83 c6 01             	add    $0x1,%esi
80105fa3:	39 fe                	cmp    %edi,%esi
80105fa5:	74 29                	je     80105fd0 <sys_open+0x190>
            // cprintf("path is: %s\n",container_array[i].container_files[j]);
            if (mystrcmp(container_array[i].container_files[j],path4)){
80105fa7:	83 ec 08             	sub    $0x8,%esp
80105faa:	ff 75 c0             	pushl  -0x40(%ebp)
80105fad:	ff b4 b3 5c 1a 11 80 	pushl  -0x7feee5a4(%ebx,%esi,4)
80105fb4:	e8 07 fe ff ff       	call   80105dc0 <mystrcmp>
80105fb9:	83 c4 10             	add    $0x10,%esp
80105fbc:	85 c0                	test   %eax,%eax
80105fbe:	74 e0                	je     80105fa0 <sys_open+0x160>
              // cprintf("yahan aya\n");
              pehle_se_hai_conatiner_me = 1;
              path = path4;
80105fc0:	8b 45 c0             	mov    -0x40(%ebp),%eax
80105fc3:	8b 75 bc             	mov    -0x44(%ebp),%esi
80105fc6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
              break;
80105fc9:	eb 07                	jmp    80105fd2 <sys_open+0x192>
80105fcb:	90                   	nop
80105fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int pehle_se_hai_conatiner_me = 0;
80105fd0:	31 f6                	xor    %esi,%esi
          break;
      }
    }
  }

  begin_op();
80105fd2:	e8 f9 cb ff ff       	call   80102bd0 <begin_op>

  if(omode & O_CREATE){
80105fd7:	8b 45 d8             	mov    -0x28(%ebp),%eax
80105fda:	25 00 02 00 00       	and    $0x200,%eax
80105fdf:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105fe2:	0f 84 38 03 00 00    	je     80106320 <sys_open+0x4e0>
    // cprintf("yahan nahi aana chahiye 1\n");
    if (cid==-1 || create_container_called == 0){
80105fe8:	83 7d c4 ff          	cmpl   $0xffffffff,-0x3c(%ebp)
80105fec:	74 0d                	je     80105ffb <sys_open+0x1bb>
80105fee:	a1 c8 b5 10 80       	mov    0x8010b5c8,%eax
80105ff3:	85 c0                	test   %eax,%eax
80105ff5:	0f 85 7f 03 00 00    	jne    8010637a <sys_open+0x53a>
    ip = create(path, T_FILE, 0, 0);
80105ffb:	83 ec 0c             	sub    $0xc,%esp
80105ffe:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80106001:	31 c9                	xor    %ecx,%ecx
80106003:	6a 00                	push   $0x0
80106005:	ba 02 00 00 00       	mov    $0x2,%edx
8010600a:	e8 81 f1 ff ff       	call   80105190 <create>
8010600f:	83 c4 10             	add    $0x10,%esp
80106012:	89 45 bc             	mov    %eax,-0x44(%ebp)
  int create_in_container = 0;
80106015:	c7 45 b4 00 00 00 00 	movl   $0x0,-0x4c(%ebp)
      char *ipath2 = path;
      char *path5 = strcat(ipath2,sind);
      // cprintf("path is:%s\n",path5 );
      ip = create(path5, T_FILE, 0, 0);
    }
    if(ip == 0){
8010601c:	8b 4d bc             	mov    -0x44(%ebp),%ecx
8010601f:	85 c9                	test   %ecx,%ecx
80106021:	0f 84 6f 07 00 00    	je     80106796 <sys_open+0x956>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80106027:	e8 54 ad ff ff       	call   80100d80 <filealloc>
8010602c:	85 c0                	test   %eax,%eax
8010602e:	89 45 c0             	mov    %eax,-0x40(%ebp)
80106031:	0f 84 29 03 00 00    	je     80106360 <sys_open+0x520>
  struct proc *curproc = myproc();
80106037:	e8 d4 d7 ff ff       	call   80103810 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010603c:	31 ff                	xor    %edi,%edi
8010603e:	eb 0c                	jmp    8010604c <sys_open+0x20c>
80106040:	83 c7 01             	add    $0x1,%edi
80106043:	83 ff 64             	cmp    $0x64,%edi
80106046:	0f 84 37 07 00 00    	je     80106783 <sys_open+0x943>
    if(curproc->ofile[fd] == 0){
8010604c:	8b 54 b8 28          	mov    0x28(%eax,%edi,4),%edx
80106050:	85 d2                	test   %edx,%edx
80106052:	75 ec                	jne    80106040 <sys_open+0x200>
      curproc->ofile[fd] = f;
80106054:	8b 5d c0             	mov    -0x40(%ebp),%ebx
80106057:	8d 4f 08             	lea    0x8(%edi),%ecx
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
8010605a:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
8010605d:	89 4d b0             	mov    %ecx,-0x50(%ebp)
80106060:	89 5c 88 08          	mov    %ebx,0x8(%eax,%ecx,4)
  iunlock(ip);
80106064:	ff 75 bc             	pushl  -0x44(%ebp)
80106067:	e8 04 b7 ff ff       	call   80101770 <iunlock>
  end_op();
8010606c:	e8 cf cb ff ff       	call   80102c40 <end_op>

  f->type = FD_INODE;
80106071:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  f->ip = ip;
80106077:	8b 45 bc             	mov    -0x44(%ebp),%eax
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010607a:	83 c4 10             	add    $0x10,%esp
  f->readable = !(omode & O_WRONLY);
8010607d:	8b 55 d8             	mov    -0x28(%ebp),%edx
  f->off = 0;
80106080:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  f->ip = ip;
80106087:	89 43 10             	mov    %eax,0x10(%ebx)
  f->readable = !(omode & O_WRONLY);
8010608a:	89 d0                	mov    %edx,%eax
8010608c:	f7 d0                	not    %eax
8010608e:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106091:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80106094:	88 43 08             	mov    %al,0x8(%ebx)
  f->path = path;
80106097:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010609a:	0f 95 43 09          	setne  0x9(%ebx)
  f->path = path;
8010609e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  int mil_gaya_container_me = 0;
  int cid_no_ofFile;



  for (int i = 0; i < num_all_files; i++) {
801060a1:	a1 80 7c 14 80       	mov    0x80147c80,%eax
801060a6:	31 db                	xor    %ebx,%ebx
801060a8:	85 c0                	test   %eax,%eax
801060aa:	7f 1b                	jg     801060c7 <sys_open+0x287>
801060ac:	e9 5f 02 00 00       	jmp    80106310 <sys_open+0x4d0>
801060b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060b8:	83 c3 01             	add    $0x1,%ebx
801060bb:	39 1d 80 7c 14 80    	cmp    %ebx,0x80147c80
801060c1:	0f 8e 49 02 00 00    	jle    80106310 <sys_open+0x4d0>
    char *dot_slash = "./";
    char* new_path = strcat(dot_slash,all_files[i]);
801060c7:	83 ec 08             	sub    $0x8,%esp
801060ca:	ff 34 9d 60 7e 14 80 	pushl  -0x7feb81a0(,%ebx,4)
801060d1:	68 05 8d 10 80       	push   $0x80108d05
801060d6:	e8 85 fc ff ff       	call   80105d60 <strcat>
    // cprintf("Path %s\n",path);
    // cprintf("New Path %s\n",new_path);
    // cprintf("Ans is %d\n",mystrcmp(path,new_path));
    if (mystrcmp(path,new_path)==1){
801060db:	5a                   	pop    %edx
801060dc:	59                   	pop    %ecx
801060dd:	50                   	push   %eax
801060de:	ff 75 d4             	pushl  -0x2c(%ebp)
801060e1:	e8 da fc ff ff       	call   80105dc0 <mystrcmp>
801060e6:	83 c4 10             	add    $0x10,%esp
801060e9:	83 f8 01             	cmp    $0x1,%eax
801060ec:	75 ca                	jne    801060b8 <sys_open+0x278>
      mil_gaya_container_me=1;
      cid_no_ofFile = corresponding_cid[i];
801060ee:	8b 04 9d 20 17 11 80 	mov    -0x7feee8e0(,%ebx,4),%eax
    }
  }
  // cprintf("mil_gaya_container_me is %d\n",mil_gaya_container_me);
  // cprintf("Contains %s\n",all_files[0]);
  // cprintf("Path %s\n",new_path);
  if (mil_gaya_container_me==1){f->cid = cid_no_ofFile;}
801060f5:	8b 4d c0             	mov    -0x40(%ebp),%ecx
801060f8:	89 41 18             	mov    %eax,0x18(%ecx)
  else{f->cid = -1;}


  if (cid==-1 || create_container_called == 0){
801060fb:	83 7d c4 ff          	cmpl   $0xffffffff,-0x3c(%ebp)
801060ff:	0f 84 f9 01 00 00    	je     801062fe <sys_open+0x4be>

    // if (ip->cid==0) {ip->cid= -1;}
    return fd;}

  if (pehle_se_hai_conatiner_me == 1){
80106105:	8b 1d c8 b5 10 80    	mov    0x8010b5c8,%ebx
8010610b:	85 db                	test   %ebx,%ebx
8010610d:	0f 84 eb 01 00 00    	je     801062fe <sys_open+0x4be>
80106113:	83 e6 01             	and    $0x1,%esi
80106116:	0f 85 e2 01 00 00    	jne    801062fe <sys_open+0x4be>
    // ip->cid = cid;
    return fd;
  }
  // cprintf("here? \n");

  if (create_in_container == 1) {
8010611c:	83 7d b4 01          	cmpl   $0x1,-0x4c(%ebp)
80106120:	8b 45 b8             	mov    -0x48(%ebp),%eax
80106123:	8b 98 cc 01 00 00    	mov    0x1cc(%eax),%ebx
80106129:	0f 84 0d 03 00 00    	je     8010643c <sys_open+0x5fc>
    char const digit[] = "0123456789";
8010612f:	be 38 39 00 00       	mov    $0x3938,%esi
  // struct proc *curproc = myproc();
  struct file *f2;
  int fd2;
  int ind = curproc->cid;
  // int ind = 67;
  char *sind = (char *)kalloc();
80106134:	e8 b7 c3 ff ff       	call   801024f0 <kalloc>
    char const digit[] = "0123456789";
80106139:	66 89 75 e5          	mov    %si,-0x1b(%ebp)
  char *sind = (char *)kalloc();
8010613d:	89 45 bc             	mov    %eax,-0x44(%ebp)
    int n = i;
80106140:	89 d9                	mov    %ebx,%ecx
    char const digit[] = "0123456789";
80106142:	c7 45 dd 30 31 32 33 	movl   $0x33323130,-0x23(%ebp)
80106149:	c7 45 e1 34 35 36 37 	movl   $0x37363534,-0x1f(%ebp)
    char* p = b;
80106150:	89 c6                	mov    %eax,%esi
    char const digit[] = "0123456789";
80106152:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
80106156:	eb 0a                	jmp    80106162 <sys_open+0x322>
80106158:	90                   	nop
80106159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        ++p;
80106160:	89 fe                	mov    %edi,%esi
        n = n/10;
80106162:	b8 67 66 66 66       	mov    $0x66666667,%eax
        ++p;
80106167:	8d 7e 01             	lea    0x1(%esi),%edi
        n = n/10;
8010616a:	f7 e9                	imul   %ecx
8010616c:	c1 f9 1f             	sar    $0x1f,%ecx
8010616f:	c1 fa 02             	sar    $0x2,%edx
    }while(n);
80106172:	29 ca                	sub    %ecx,%edx
80106174:	89 d1                	mov    %edx,%ecx
80106176:	75 e8                	jne    80106160 <sys_open+0x320>
    p++;
80106178:	83 c6 02             	add    $0x2,%esi
    *p = '\0';
8010617b:	c6 47 01 00          	movb   $0x0,0x1(%edi)
        *--p = digit[i%10];
8010617f:	b9 67 66 66 66       	mov    $0x66666667,%ecx
80106184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106188:	89 d8                	mov    %ebx,%eax
8010618a:	83 ee 01             	sub    $0x1,%esi
8010618d:	f7 e9                	imul   %ecx
8010618f:	89 d8                	mov    %ebx,%eax
80106191:	c1 f8 1f             	sar    $0x1f,%eax
80106194:	c1 fa 02             	sar    $0x2,%edx
80106197:	29 c2                	sub    %eax,%edx
80106199:	8d 04 92             	lea    (%edx,%edx,4),%eax
8010619c:	01 c0                	add    %eax,%eax
8010619e:	29 c3                	sub    %eax,%ebx
    }while(i);
801061a0:	85 d2                	test   %edx,%edx
        *--p = digit[i%10];
801061a2:	0f b6 44 1d dd       	movzbl -0x23(%ebp,%ebx,1),%eax
        i = i/10;
801061a7:	89 d3                	mov    %edx,%ebx
        *--p = digit[i%10];
801061a9:	88 06                	mov    %al,(%esi)
    }while(i);
801061ab:	75 db                	jne    80106188 <sys_open+0x348>
  // strncpy(sind,my_itoa(ind,sind));
  sind = my_itoa(ind,sind);
  char *ipath4 = path;
  char *path2 = strcat(ipath4,sind);
801061ad:	83 ec 08             	sub    $0x8,%esp
    *--p = sig[0];
801061b0:	c6 46 ff 5f          	movb   $0x5f,-0x1(%esi)
  char *path2 = strcat(ipath4,sind);
801061b4:	ff 75 bc             	pushl  -0x44(%ebp)
801061b7:	ff 75 d4             	pushl  -0x2c(%ebp)
801061ba:	e8 a1 fb ff ff       	call   80105d60 <strcat>
801061bf:	89 c6                	mov    %eax,%esi
801061c1:	89 45 bc             	mov    %eax,-0x44(%ebp)
  // cprintf("path 2 is %s\n",path2);
  struct inode *ip2;

  begin_op();
801061c4:	e8 07 ca ff ff       	call   80102bd0 <begin_op>
  ip2 = create(path2, T_FILE, 0, 0);
801061c9:	31 c9                	xor    %ecx,%ecx
801061cb:	89 f0                	mov    %esi,%eax
801061cd:	ba 02 00 00 00       	mov    $0x2,%edx
801061d2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801061d9:	e8 b2 ef ff ff       	call   80105190 <create>
  if(ip2 == 0){
801061de:	83 c4 10             	add    $0x10,%esp
801061e1:	85 c0                	test   %eax,%eax
  ip2 = create(path2, T_FILE, 0, 0);
801061e3:	89 c6                	mov    %eax,%esi
  if(ip2 == 0){
801061e5:	0f 84 ab 05 00 00    	je     80106796 <sys_open+0x956>
    // cprintf("ip2 0 \n");
  }


  // cprintf("file 2 is created\n");
  if((f2 = filealloc()) == 0 || (fd2 = fdalloc(f2)) < 0){
801061eb:	e8 90 ab ff ff       	call   80100d80 <filealloc>
801061f0:	85 c0                	test   %eax,%eax
801061f2:	89 c7                	mov    %eax,%edi
801061f4:	0f 84 ee 00 00 00    	je     801062e8 <sys_open+0x4a8>
  struct proc *curproc = myproc();
801061fa:	e8 11 d6 ff ff       	call   80103810 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801061ff:	31 d2                	xor    %edx,%edx
80106201:	eb 11                	jmp    80106214 <sys_open+0x3d4>
80106203:	90                   	nop
80106204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106208:	83 c2 01             	add    $0x1,%edx
8010620b:	83 fa 64             	cmp    $0x64,%edx
8010620e:	0f 84 a2 05 00 00    	je     801067b6 <sys_open+0x976>
    if(curproc->ofile[fd] == 0){
80106214:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80106218:	85 c9                	test   %ecx,%ecx
8010621a:	75 ec                	jne    80106208 <sys_open+0x3c8>
      curproc->ofile[fd] = f;
8010621c:	8d 4a 08             	lea    0x8(%edx),%ecx
    return -1;
  }
  // cprintf("yahan 1 \n");


  iunlock(ip2);
8010621f:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80106222:	89 7c 88 08          	mov    %edi,0x8(%eax,%ecx,4)
  iunlock(ip2);
80106226:	56                   	push   %esi
      curproc->ofile[fd] = f;
80106227:	89 4d b8             	mov    %ecx,-0x48(%ebp)
  iunlock(ip2);
8010622a:	e8 41 b5 ff ff       	call   80101770 <iunlock>
  end_op();
8010622f:	e8 0c ca ff ff       	call   80102c40 <end_op>

  f2->type = FD_INODE;
80106234:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f2->ip = ip2;
  f2->off = 0;
  f2->readable = !(omode & O_WRONLY);
8010623a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  // f2->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  f2->writable =1;
  f2->path = path2;
  if (f2->cid==0 || f2->cid == -1){f2->cid = cid;}
8010623d:	83 c4 10             	add    $0x10,%esp
  f2->ip = ip2;
80106240:	89 77 10             	mov    %esi,0x10(%edi)
  f2->off = 0;
80106243:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f2->writable =1;
8010624a:	c6 47 09 01          	movb   $0x1,0x9(%edi)
  f2->readable = !(omode & O_WRONLY);
8010624e:	f7 d0                	not    %eax
80106250:	83 e0 01             	and    $0x1,%eax
80106253:	88 47 08             	mov    %al,0x8(%edi)
  f2->path = path2;
80106256:	8b 45 bc             	mov    -0x44(%ebp),%eax
80106259:	89 47 1c             	mov    %eax,0x1c(%edi)
  if (f2->cid==0 || f2->cid == -1){f2->cid = cid;}
8010625c:	8b 47 18             	mov    0x18(%edi),%eax
8010625f:	83 c0 01             	add    $0x1,%eax
80106262:	83 f8 01             	cmp    $0x1,%eax
80106265:	77 06                	ja     8010626d <sys_open+0x42d>
80106267:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010626a:	89 47 18             	mov    %eax,0x18(%edi)
8010626d:	8d 75 dd             	lea    -0x23(%ebp),%esi

  // return fd;
  while(1){
    int n1;
    char c[1];
    n1 = fileread(f, c, sizeof(c)) ;
80106270:	83 ec 04             	sub    $0x4,%esp
80106273:	6a 01                	push   $0x1
80106275:	56                   	push   %esi
80106276:	ff 75 c0             	pushl  -0x40(%ebp)
80106279:	e8 e2 ac ff ff       	call   80100f60 <fileread>
    if(n1<=0)break;
8010627e:	83 c4 10             	add    $0x10,%esp
80106281:	85 c0                	test   %eax,%eax
80106283:	0f 8e ea 02 00 00    	jle    80106573 <sys_open+0x733>
    n1 = filewrite(f2,c,sizeof(c));
80106289:	83 ec 04             	sub    $0x4,%esp
8010628c:	6a 01                	push   $0x1
8010628e:	56                   	push   %esi
8010628f:	57                   	push   %edi
80106290:	e8 5b ad ff ff       	call   80100ff0 <filewrite>
    // cprintf("reading  %s \n",c);
    if(n1<0)
80106295:	83 c4 10             	add    $0x10,%esp
80106298:	85 c0                	test   %eax,%eax
8010629a:	79 d4                	jns    80106270 <sys_open+0x430>
      cprintf("error in writing in newopen \n");
8010629c:	83 ec 0c             	sub    $0xc,%esp
8010629f:	68 08 8d 10 80       	push   $0x80108d08
801062a4:	e8 b7 a3 ff ff       	call   80100660 <cprintf>
801062a9:	83 c4 10             	add    $0x10,%esp
  while(1){
801062ac:	eb c2                	jmp    80106270 <sys_open+0x430>
      return -1;
    }
  }

  else {
    if((ip3 = namei(path3)) == 0){
801062ae:	83 ec 0c             	sub    $0xc,%esp
801062b1:	ff 75 bc             	pushl  -0x44(%ebp)
801062b4:	e8 57 bc ff ff       	call   80101f10 <namei>
801062b9:	83 c4 10             	add    $0x10,%esp
801062bc:	85 c0                	test   %eax,%eax
801062be:	89 c6                	mov    %eax,%esi
801062c0:	0f 84 d0 04 00 00    	je     80106796 <sys_open+0x956>
      end_op();
      return -1;
    }
    ilock(ip3);
801062c6:	83 ec 0c             	sub    $0xc,%esp
801062c9:	50                   	push   %eax
801062ca:	e8 c1 b3 ff ff       	call   80101690 <ilock>
    if(ip3->type == T_DIR && omode != O_RDONLY){
801062cf:	83 c4 10             	add    $0x10,%esp
801062d2:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801062d7:	0f 85 0b 03 00 00    	jne    801065e8 <sys_open+0x7a8>
801062dd:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801062e0:	85 c9                	test   %ecx,%ecx
801062e2:	0f 84 00 03 00 00    	je     801065e8 <sys_open+0x7a8>
  }

  if((f3 = filealloc()) == 0 || (fd3 = fdalloc(f3)) < 0){
    if(f3)
      fileclose(f3);
    iunlockput(ip3);
801062e8:	83 ec 0c             	sub    $0xc,%esp
801062eb:	56                   	push   %esi
801062ec:	e8 2f b6 ff ff       	call   80101920 <iunlockput>
    end_op();
801062f1:	e8 4a c9 ff ff       	call   80102c40 <end_op>
    return -1;
801062f6:	83 c4 10             	add    $0x10,%esp
801062f9:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  all_files[num_all_files] = path3;
  // cprintf("File ka naam aya: %s",all_files[0]);
  corresponding_cid[num_all_files] = cid;
  num_all_files++;
  return fd3;
}
801062fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106301:	89 f8                	mov    %edi,%eax
80106303:	5b                   	pop    %ebx
80106304:	5e                   	pop    %esi
80106305:	5f                   	pop    %edi
80106306:	5d                   	pop    %ebp
80106307:	c3                   	ret    
80106308:	90                   	nop
80106309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  else{f->cid = -1;}
80106310:	8b 45 c0             	mov    -0x40(%ebp),%eax
80106313:	c7 40 18 ff ff ff ff 	movl   $0xffffffff,0x18(%eax)
8010631a:	e9 dc fd ff ff       	jmp    801060fb <sys_open+0x2bb>
8010631f:	90                   	nop
    if((ip = namei(path)) == 0){
80106320:	83 ec 0c             	sub    $0xc,%esp
80106323:	ff 75 d4             	pushl  -0x2c(%ebp)
80106326:	e8 e5 bb ff ff       	call   80101f10 <namei>
8010632b:	83 c4 10             	add    $0x10,%esp
8010632e:	85 c0                	test   %eax,%eax
80106330:	89 c7                	mov    %eax,%edi
80106332:	89 45 bc             	mov    %eax,-0x44(%ebp)
80106335:	0f 84 5b 04 00 00    	je     80106796 <sys_open+0x956>
    ilock(ip);
8010633b:	83 ec 0c             	sub    $0xc,%esp
8010633e:	50                   	push   %eax
8010633f:	e8 4c b3 ff ff       	call   80101690 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80106344:	83 c4 10             	add    $0x10,%esp
80106347:	66 83 7f 50 01       	cmpw   $0x1,0x50(%edi)
8010634c:	0f 85 d5 fc ff ff    	jne    80106027 <sys_open+0x1e7>
80106352:	8b 45 d8             	mov    -0x28(%ebp),%eax
80106355:	85 c0                	test   %eax,%eax
80106357:	89 45 b4             	mov    %eax,-0x4c(%ebp)
8010635a:	0f 84 c7 fc ff ff    	je     80106027 <sys_open+0x1e7>
    iunlockput(ip);
80106360:	83 ec 0c             	sub    $0xc,%esp
80106363:	ff 75 bc             	pushl  -0x44(%ebp)
    return -1;
80106366:	bf ff ff ff ff       	mov    $0xffffffff,%edi
    iunlockput(ip);
8010636b:	e8 b0 b5 ff ff       	call   80101920 <iunlockput>
    end_op();
80106370:	e8 cb c8 ff ff       	call   80102c40 <end_op>
    return -1;
80106375:	83 c4 10             	add    $0x10,%esp
80106378:	eb 84                	jmp    801062fe <sys_open+0x4be>
      int ind = curproc->cid;
8010637a:	8b 45 b8             	mov    -0x48(%ebp),%eax
    char const digit[] = "0123456789";
8010637d:	bf 38 39 00 00       	mov    $0x3938,%edi
      int ind = curproc->cid;
80106382:	8b 98 cc 01 00 00    	mov    0x1cc(%eax),%ebx
      char *sind = (char *)kalloc();
80106388:	e8 63 c1 ff ff       	call   801024f0 <kalloc>
    char const digit[] = "0123456789";
8010638d:	66 89 7d e5          	mov    %di,-0x1b(%ebp)
      char *sind = (char *)kalloc();
80106391:	89 45 c0             	mov    %eax,-0x40(%ebp)
    char* p = b;
80106394:	89 c7                	mov    %eax,%edi
    char const digit[] = "0123456789";
80106396:	c7 45 dd 30 31 32 33 	movl   $0x33323130,-0x23(%ebp)
8010639d:	c7 45 e1 34 35 36 37 	movl   $0x37363534,-0x1f(%ebp)
    int n = i;
801063a4:	89 d9                	mov    %ebx,%ecx
    char const digit[] = "0123456789";
801063a6:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
801063aa:	89 75 bc             	mov    %esi,-0x44(%ebp)
801063ad:	eb 03                	jmp    801063b2 <sys_open+0x572>
801063af:	90                   	nop
        ++p;
801063b0:	89 f7                	mov    %esi,%edi
        n = n/10;
801063b2:	b8 67 66 66 66       	mov    $0x66666667,%eax
        ++p;
801063b7:	8d 77 01             	lea    0x1(%edi),%esi
        n = n/10;
801063ba:	f7 e9                	imul   %ecx
801063bc:	c1 f9 1f             	sar    $0x1f,%ecx
801063bf:	c1 fa 02             	sar    $0x2,%edx
    }while(n);
801063c2:	29 ca                	sub    %ecx,%edx
801063c4:	89 d1                	mov    %edx,%ecx
801063c6:	75 e8                	jne    801063b0 <sys_open+0x570>
801063c8:	89 f0                	mov    %esi,%eax
801063ca:	8b 75 bc             	mov    -0x44(%ebp),%esi
    p++;
801063cd:	83 c7 02             	add    $0x2,%edi
    *p = '\0';
801063d0:	c6 40 01 00          	movb   $0x0,0x1(%eax)
        *--p = digit[i%10];
801063d4:	b9 67 66 66 66       	mov    $0x66666667,%ecx
801063d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801063e0:	89 d8                	mov    %ebx,%eax
801063e2:	83 ef 01             	sub    $0x1,%edi
801063e5:	f7 e9                	imul   %ecx
801063e7:	89 d8                	mov    %ebx,%eax
801063e9:	c1 f8 1f             	sar    $0x1f,%eax
801063ec:	c1 fa 02             	sar    $0x2,%edx
801063ef:	29 c2                	sub    %eax,%edx
801063f1:	8d 04 92             	lea    (%edx,%edx,4),%eax
801063f4:	01 c0                	add    %eax,%eax
801063f6:	29 c3                	sub    %eax,%ebx
    }while(i);
801063f8:	85 d2                	test   %edx,%edx
        *--p = digit[i%10];
801063fa:	0f b6 44 1d dd       	movzbl -0x23(%ebp,%ebx,1),%eax
        i = i/10;
801063ff:	89 d3                	mov    %edx,%ebx
        *--p = digit[i%10];
80106401:	88 07                	mov    %al,(%edi)
    }while(i);
80106403:	75 db                	jne    801063e0 <sys_open+0x5a0>
      char *path5 = strcat(ipath2,sind);
80106405:	83 ec 08             	sub    $0x8,%esp
    *--p = sig[0];
80106408:	c6 47 ff 5f          	movb   $0x5f,-0x1(%edi)
      char *path5 = strcat(ipath2,sind);
8010640c:	ff 75 c0             	pushl  -0x40(%ebp)
8010640f:	ff 75 d4             	pushl  -0x2c(%ebp)
80106412:	e8 49 f9 ff ff       	call   80105d60 <strcat>
      ip = create(path5, T_FILE, 0, 0);
80106417:	31 c9                	xor    %ecx,%ecx
80106419:	ba 02 00 00 00       	mov    $0x2,%edx
8010641e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106425:	e8 66 ed ff ff       	call   80105190 <create>
8010642a:	83 c4 10             	add    $0x10,%esp
8010642d:	89 45 bc             	mov    %eax,-0x44(%ebp)
      create_in_container = 1;
80106430:	c7 45 b4 01 00 00 00 	movl   $0x1,-0x4c(%ebp)
80106437:	e9 e0 fb ff ff       	jmp    8010601c <sys_open+0x1dc>
    char *sind = (char *)kalloc();
8010643c:	e8 af c0 ff ff       	call   801024f0 <kalloc>
    char const digit[] = "0123456789";
80106441:	b9 38 39 00 00       	mov    $0x3938,%ecx
80106446:	89 5d b4             	mov    %ebx,-0x4c(%ebp)
    char *sind = (char *)kalloc();
80106449:	89 45 b8             	mov    %eax,-0x48(%ebp)
    char const digit[] = "0123456789";
8010644c:	66 89 4d e5          	mov    %cx,-0x1b(%ebp)
80106450:	c7 45 dd 30 31 32 33 	movl   $0x33323130,-0x23(%ebp)
    int n = i;
80106457:	89 d9                	mov    %ebx,%ecx
    char const digit[] = "0123456789";
80106459:	c7 45 e1 34 35 36 37 	movl   $0x37363534,-0x1f(%ebp)
80106460:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
80106464:	89 c3                	mov    %eax,%ebx
80106466:	eb 0a                	jmp    80106472 <sys_open+0x632>
80106468:	90                   	nop
80106469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        ++p;
80106470:	89 f3                	mov    %esi,%ebx
        n = n/10;
80106472:	b8 67 66 66 66       	mov    $0x66666667,%eax
        ++p;
80106477:	8d 73 01             	lea    0x1(%ebx),%esi
        n = n/10;
8010647a:	f7 e9                	imul   %ecx
8010647c:	c1 f9 1f             	sar    $0x1f,%ecx
8010647f:	c1 fa 02             	sar    $0x2,%edx
    }while(n);
80106482:	29 ca                	sub    %ecx,%edx
80106484:	89 d1                	mov    %edx,%ecx
80106486:	75 e8                	jne    80106470 <sys_open+0x630>
80106488:	89 d8                	mov    %ebx,%eax
8010648a:	8b 5d b4             	mov    -0x4c(%ebp),%ebx
    *p = '\0';
8010648d:	c6 46 01 00          	movb   $0x0,0x1(%esi)
    p++;
80106491:	83 c0 02             	add    $0x2,%eax
        *--p = digit[i%10];
80106494:	be 67 66 66 66       	mov    $0x66666667,%esi
    p++;
80106499:	89 c1                	mov    %eax,%ecx
8010649b:	90                   	nop
8010649c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        *--p = digit[i%10];
801064a0:	89 d8                	mov    %ebx,%eax
801064a2:	83 e9 01             	sub    $0x1,%ecx
801064a5:	f7 ee                	imul   %esi
801064a7:	89 d8                	mov    %ebx,%eax
801064a9:	c1 f8 1f             	sar    $0x1f,%eax
801064ac:	c1 fa 02             	sar    $0x2,%edx
801064af:	29 c2                	sub    %eax,%edx
801064b1:	8d 04 92             	lea    (%edx,%edx,4),%eax
801064b4:	01 c0                	add    %eax,%eax
801064b6:	29 c3                	sub    %eax,%ebx
    }while(i);
801064b8:	85 d2                	test   %edx,%edx
        *--p = digit[i%10];
801064ba:	0f b6 44 1d dd       	movzbl -0x23(%ebp,%ebx,1),%eax
        i = i/10;
801064bf:	89 d3                	mov    %edx,%ebx
        *--p = digit[i%10];
801064c1:	88 01                	mov    %al,(%ecx)
    }while(i);
801064c3:	75 db                	jne    801064a0 <sys_open+0x660>
    char *path6 = strcat(ipath3,sind);
801064c5:	83 ec 08             	sub    $0x8,%esp
    *--p = sig[0];
801064c8:	c6 41 ff 5f          	movb   $0x5f,-0x1(%ecx)
    char *path6 = strcat(ipath3,sind);
801064cc:	ff 75 b8             	pushl  -0x48(%ebp)
801064cf:	ff 75 d4             	pushl  -0x2c(%ebp)
801064d2:	e8 89 f8 ff ff       	call   80105d60 <strcat>
801064d7:	83 c4 10             	add    $0x10,%esp
801064da:	89 45 b8             	mov    %eax,-0x48(%ebp)
801064dd:	8b 75 bc             	mov    -0x44(%ebp),%esi
801064e0:	89 7d b4             	mov    %edi,-0x4c(%ebp)
801064e3:	eb 0f                	jmp    801064f4 <sys_open+0x6b4>
801064e5:	8d 76 00             	lea    0x0(%esi),%esi
    for (int i = 0; i < 100; i++) {
801064e8:	83 c3 01             	add    $0x1,%ebx
801064eb:	83 fb 64             	cmp    $0x64,%ebx
801064ee:	0f 84 44 02 00 00    	je     80106738 <sys_open+0x8f8>
      if (container_location[i]==1){
801064f4:	83 3c 9d e0 79 14 80 	cmpl   $0x1,-0x7feb8620(,%ebx,4)
801064fb:	01 
801064fc:	75 ea                	jne    801064e8 <sys_open+0x6a8>
801064fe:	69 c3 a4 08 00 00    	imul   $0x8a4,%ebx,%eax
        if(container_array[i].cid==cid){
80106504:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
80106507:	39 88 c0 18 11 80    	cmp    %ecx,-0x7feee740(%eax)
8010650d:	75 d9                	jne    801064e8 <sys_open+0x6a8>
            container_array[i].container_files[container_array[i].number_of_files] = path6;
8010650f:	8b 88 c8 18 11 80    	mov    -0x7feee738(%eax),%ecx
80106515:	8b 7d b8             	mov    -0x48(%ebp),%edi
80106518:	69 d3 29 02 00 00    	imul   $0x229,%ebx,%edx
            container_array[i].type[container_array[i].number_of_files]=ip->type;
8010651e:	89 4d bc             	mov    %ecx,-0x44(%ebp)
            container_array[i].container_files[container_array[i].number_of_files] = path6;
80106521:	01 ca                	add    %ecx,%edx
80106523:	89 3c 95 5c 1a 11 80 	mov    %edi,-0x7feee5a4(,%edx,4)
            container_array[i].copied_or_not[container_array[i].number_of_files] = 0;
8010652a:	c7 04 95 ec 1b 11 80 	movl   $0x0,-0x7feee414(,%edx,4)
80106531:	00 00 00 00 
            container_array[i].type[container_array[i].number_of_files]=ip->type;
80106535:	69 fb 52 04 00 00    	imul   $0x452,%ebx,%edi
8010653b:	8d bc 39 58 02 00 00 	lea    0x258(%ecx,%edi,1),%edi
80106542:	0f b7 4e 50          	movzwl 0x50(%esi),%ecx
80106546:	66 89 8c 3f cc 18 11 	mov    %cx,-0x7feee734(%edi,%edi,1)
8010654d:	80 
            container_array[i].ino[container_array[i].number_of_files]=ip->inum;
8010654e:	8b 7e 04             	mov    0x4(%esi),%edi
            container_array[i].number_of_files++;
80106551:	8b 4d bc             	mov    -0x44(%ebp),%ecx
            container_array[i].ino[container_array[i].number_of_files]=ip->inum;
80106554:	89 3c 95 44 1e 11 80 	mov    %edi,-0x7feee1bc(,%edx,4)
            container_array[i].size[container_array[i].number_of_files]=ip->size;
8010655b:	8b 7e 58             	mov    0x58(%esi),%edi
            container_array[i].number_of_files++;
8010655e:	83 c1 01             	add    $0x1,%ecx
            container_array[i].size[container_array[i].number_of_files]=ip->size;
80106561:	89 3c 95 d4 1f 11 80 	mov    %edi,-0x7feee02c(,%edx,4)
            container_array[i].number_of_files++;
80106568:	89 88 c8 18 11 80    	mov    %ecx,-0x7feee738(%eax)
8010656e:	e9 75 ff ff ff       	jmp    801064e8 <sys_open+0x6a8>
  f->off = 0;
80106573:	8b 75 c0             	mov    -0x40(%ebp),%esi
  f2->off = 0;
80106576:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->off = 0;
8010657d:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  myproc()->ofile[fd] = 0;
80106584:	e8 87 d2 ff ff       	call   80103810 <myproc>
80106589:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  fileclose(f);
8010658c:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
8010658f:	c7 44 88 08 00 00 00 	movl   $0x0,0x8(%eax,%ecx,4)
80106596:	00 
  fileclose(f);
80106597:	56                   	push   %esi
80106598:	e8 a3 a8 ff ff       	call   80100e40 <fileclose>
  myproc()->ofile[fd2] = 0;
8010659d:	e8 6e d2 ff ff       	call   80103810 <myproc>
801065a2:	8b 75 b8             	mov    -0x48(%ebp),%esi
801065a5:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801065ac:	00 
  fileclose(f2);
801065ad:	89 3c 24             	mov    %edi,(%esp)
801065b0:	e8 8b a8 ff ff       	call   80100e40 <fileclose>
  begin_op();
801065b5:	e8 16 c6 ff ff       	call   80102bd0 <begin_op>
  if(omode & O_CREATE){
801065ba:	83 c4 10             	add    $0x10,%esp
801065bd:	f6 45 d9 02          	testb  $0x2,-0x27(%ebp)
801065c1:	0f 84 e7 fc ff ff    	je     801062ae <sys_open+0x46e>
    ip3 = create(path3, T_FILE, 0, 0);
801065c7:	83 ec 0c             	sub    $0xc,%esp
801065ca:	8b 45 bc             	mov    -0x44(%ebp),%eax
801065cd:	31 c9                	xor    %ecx,%ecx
801065cf:	6a 00                	push   $0x0
801065d1:	ba 02 00 00 00       	mov    $0x2,%edx
801065d6:	e8 b5 eb ff ff       	call   80105190 <create>
    if(ip3 == 0){
801065db:	83 c4 10             	add    $0x10,%esp
801065de:	85 c0                	test   %eax,%eax
    ip3 = create(path3, T_FILE, 0, 0);
801065e0:	89 c6                	mov    %eax,%esi
    if(ip3 == 0){
801065e2:	0f 84 ae 01 00 00    	je     80106796 <sys_open+0x956>
  if((f3 = filealloc()) == 0 || (fd3 = fdalloc(f3)) < 0){
801065e8:	e8 93 a7 ff ff       	call   80100d80 <filealloc>
801065ed:	85 c0                	test   %eax,%eax
801065ef:	89 45 c0             	mov    %eax,-0x40(%ebp)
801065f2:	0f 84 f0 fc ff ff    	je     801062e8 <sys_open+0x4a8>
  struct proc *curproc = myproc();
801065f8:	e8 13 d2 ff ff       	call   80103810 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801065fd:	31 ff                	xor    %edi,%edi
801065ff:	8b 4d c0             	mov    -0x40(%ebp),%ecx
80106602:	eb 10                	jmp    80106614 <sys_open+0x7d4>
80106604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106608:	83 c7 01             	add    $0x1,%edi
8010660b:	83 ff 64             	cmp    $0x64,%edi
8010660e:	0f 84 91 01 00 00    	je     801067a5 <sys_open+0x965>
    if(curproc->ofile[fd] == 0){
80106614:	8b 54 b8 28          	mov    0x28(%eax,%edi,4),%edx
80106618:	85 d2                	test   %edx,%edx
8010661a:	75 ec                	jne    80106608 <sys_open+0x7c8>
  iunlock(ip3);
8010661c:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
8010661f:	89 4c b8 28          	mov    %ecx,0x28(%eax,%edi,4)
80106623:	89 4d c0             	mov    %ecx,-0x40(%ebp)
  iunlock(ip3);
80106626:	56                   	push   %esi
80106627:	e8 44 b1 ff ff       	call   80101770 <iunlock>
  end_op();
8010662c:	e8 0f c6 ff ff       	call   80102c40 <end_op>
  f3->type = FD_INODE;
80106631:	8b 4d c0             	mov    -0x40(%ebp),%ecx
  f3->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106634:	83 c4 10             	add    $0x10,%esp
  f3->type = FD_INODE;
80106637:	c7 01 02 00 00 00    	movl   $0x2,(%ecx)
  f3->readable = !(omode & O_WRONLY);
8010663d:	8b 55 d8             	mov    -0x28(%ebp),%edx
  f3->ip = ip3;
80106640:	89 71 10             	mov    %esi,0x10(%ecx)
  f3->off = 0;
80106643:	c7 41 14 00 00 00 00 	movl   $0x0,0x14(%ecx)
  f3->readable = !(omode & O_WRONLY);
8010664a:	89 d0                	mov    %edx,%eax
8010664c:	f7 d0                	not    %eax
8010664e:	83 e0 01             	and    $0x1,%eax
  f3->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106651:	83 e2 03             	and    $0x3,%edx
  f3->readable = !(omode & O_WRONLY);
80106654:	88 41 08             	mov    %al,0x8(%ecx)
  f3->path = path3;
80106657:	8b 45 bc             	mov    -0x44(%ebp),%eax
  f3->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010665a:	0f 95 41 09          	setne  0x9(%ecx)
  f3->path = path3;
8010665e:	89 41 1c             	mov    %eax,0x1c(%ecx)
  if (f3->cid==0 || f3->cid == -1){f3->cid = cid;}
80106661:	8b 41 18             	mov    0x18(%ecx),%eax
80106664:	83 c0 01             	add    $0x1,%eax
80106667:	83 f8 01             	cmp    $0x1,%eax
8010666a:	0f 86 05 01 00 00    	jbe    80106775 <sys_open+0x935>
80106670:	89 7d b8             	mov    %edi,-0x48(%ebp)
80106673:	eb 0f                	jmp    80106684 <sys_open+0x844>
80106675:	8d 76 00             	lea    0x0(%esi),%esi
  for (int i = 0; i < 100; i++) {
80106678:	83 c3 01             	add    $0x1,%ebx
8010667b:	83 fb 64             	cmp    $0x64,%ebx
8010667e:	0f 84 86 00 00 00    	je     8010670a <sys_open+0x8ca>
    if (container_location[i]==1){
80106684:	83 3c 9d e0 79 14 80 	cmpl   $0x1,-0x7feb8620(,%ebx,4)
8010668b:	01 
8010668c:	75 ea                	jne    80106678 <sys_open+0x838>
8010668e:	69 c3 a4 08 00 00    	imul   $0x8a4,%ebx,%eax
      if(container_array[i].cid==cid){
80106694:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
80106697:	39 88 c0 18 11 80    	cmp    %ecx,-0x7feee740(%eax)
8010669d:	75 d9                	jne    80106678 <sys_open+0x838>
          container_array[i].container_files[container_array[i].number_of_files] = path3;
8010669f:	8b 88 c8 18 11 80    	mov    -0x7feee738(%eax),%ecx
801066a5:	8b 7d bc             	mov    -0x44(%ebp),%edi
801066a8:	69 d3 29 02 00 00    	imul   $0x229,%ebx,%edx
          container_array[i].type[container_array[i].number_of_files]=ip3->type;
801066ae:	89 4d c0             	mov    %ecx,-0x40(%ebp)
          container_array[i].container_files[container_array[i].number_of_files] = path3;
801066b1:	01 ca                	add    %ecx,%edx
801066b3:	89 3c 95 5c 1a 11 80 	mov    %edi,-0x7feee5a4(,%edx,4)
          container_array[i].copied_or_not[container_array[i].number_of_files] = 1;
801066ba:	c7 04 95 ec 1b 11 80 	movl   $0x1,-0x7feee414(,%edx,4)
801066c1:	01 00 00 00 
          container_array[i].type[container_array[i].number_of_files]=ip3->type;
801066c5:	69 fb 52 04 00 00    	imul   $0x452,%ebx,%edi
  for (int i = 0; i < 100; i++) {
801066cb:	83 c3 01             	add    $0x1,%ebx
          container_array[i].type[container_array[i].number_of_files]=ip3->type;
801066ce:	8d bc 39 58 02 00 00 	lea    0x258(%ecx,%edi,1),%edi
801066d5:	0f b7 4e 50          	movzwl 0x50(%esi),%ecx
801066d9:	66 89 8c 3f cc 18 11 	mov    %cx,-0x7feee734(%edi,%edi,1)
801066e0:	80 
          container_array[i].ino[container_array[i].number_of_files]=ip3->inum;
801066e1:	8b 7e 04             	mov    0x4(%esi),%edi
          container_array[i].number_of_files++;
801066e4:	8b 4d c0             	mov    -0x40(%ebp),%ecx
          container_array[i].ino[container_array[i].number_of_files]=ip3->inum;
801066e7:	89 3c 95 44 1e 11 80 	mov    %edi,-0x7feee1bc(,%edx,4)
          container_array[i].size[container_array[i].number_of_files]=ip3->size;
801066ee:	8b 7e 58             	mov    0x58(%esi),%edi
          container_array[i].number_of_files++;
801066f1:	83 c1 01             	add    $0x1,%ecx
  for (int i = 0; i < 100; i++) {
801066f4:	83 fb 64             	cmp    $0x64,%ebx
          container_array[i].size[container_array[i].number_of_files]=ip3->size;
801066f7:	89 3c 95 d4 1f 11 80 	mov    %edi,-0x7feee02c(,%edx,4)
          container_array[i].number_of_files++;
801066fe:	89 88 c8 18 11 80    	mov    %ecx,-0x7feee738(%eax)
  for (int i = 0; i < 100; i++) {
80106704:	0f 85 7a ff ff ff    	jne    80106684 <sys_open+0x844>
  all_files[num_all_files] = path3;
8010670a:	a1 80 7c 14 80       	mov    0x80147c80,%eax
8010670f:	8b 75 bc             	mov    -0x44(%ebp),%esi
80106712:	8b 7d b8             	mov    -0x48(%ebp),%edi
80106715:	89 34 85 60 7e 14 80 	mov    %esi,-0x7feb81a0(,%eax,4)
  corresponding_cid[num_all_files] = cid;
8010671c:	8b 75 c4             	mov    -0x3c(%ebp),%esi
8010671f:	89 34 85 20 17 11 80 	mov    %esi,-0x7feee8e0(,%eax,4)
  num_all_files++;
80106726:	83 c0 01             	add    $0x1,%eax
80106729:	a3 80 7c 14 80       	mov    %eax,0x80147c80
}
8010672e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106731:	89 f8                	mov    %edi,%eax
80106733:	5b                   	pop    %ebx
80106734:	5e                   	pop    %esi
80106735:	5f                   	pop    %edi
80106736:	5d                   	pop    %ebp
80106737:	c3                   	ret    
    all_files[num_all_files] = path6;
80106738:	a1 80 7c 14 80       	mov    0x80147c80,%eax
8010673d:	8b 75 b8             	mov    -0x48(%ebp),%esi
    corresponding_cid[num_all_files] = cid;
80106740:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
80106743:	8b 7d b4             	mov    -0x4c(%ebp),%edi
    all_files[num_all_files] = path6;
80106746:	89 34 85 60 7e 14 80 	mov    %esi,-0x7feb81a0(,%eax,4)
    corresponding_cid[num_all_files] = cid;
8010674d:	89 0c 85 20 17 11 80 	mov    %ecx,-0x7feee8e0(,%eax,4)
    num_all_files++;
80106754:	83 c0 01             	add    $0x1,%eax
80106757:	a3 80 7c 14 80       	mov    %eax,0x80147c80
    f->path = path6;
8010675c:	8b 45 c0             	mov    -0x40(%ebp),%eax
    if (f->cid==0){f->cid = cid;}
8010675f:	8b 50 18             	mov    0x18(%eax),%edx
    f->path = path6;
80106762:	89 70 1c             	mov    %esi,0x1c(%eax)
    if (f->cid==0){f->cid = cid;}
80106765:	85 d2                	test   %edx,%edx
80106767:	0f 85 91 fb ff ff    	jne    801062fe <sys_open+0x4be>
8010676d:	89 48 18             	mov    %ecx,0x18(%eax)
80106770:	e9 89 fb ff ff       	jmp    801062fe <sys_open+0x4be>
  if (f3->cid==0 || f3->cid == -1){f3->cid = cid;}
80106775:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80106778:	89 7d b8             	mov    %edi,-0x48(%ebp)
8010677b:	89 41 18             	mov    %eax,0x18(%ecx)
8010677e:	e9 01 ff ff ff       	jmp    80106684 <sys_open+0x844>
      fileclose(f);
80106783:	83 ec 0c             	sub    $0xc,%esp
80106786:	ff 75 c0             	pushl  -0x40(%ebp)
80106789:	e8 b2 a6 ff ff       	call   80100e40 <fileclose>
8010678e:	83 c4 10             	add    $0x10,%esp
80106791:	e9 ca fb ff ff       	jmp    80106360 <sys_open+0x520>
      end_op();
80106796:	e8 a5 c4 ff ff       	call   80102c40 <end_op>
      return -1;
8010679b:	bf ff ff ff ff       	mov    $0xffffffff,%edi
801067a0:	e9 59 fb ff ff       	jmp    801062fe <sys_open+0x4be>
      fileclose(f3);
801067a5:	83 ec 0c             	sub    $0xc,%esp
801067a8:	51                   	push   %ecx
801067a9:	e8 92 a6 ff ff       	call   80100e40 <fileclose>
801067ae:	83 c4 10             	add    $0x10,%esp
801067b1:	e9 32 fb ff ff       	jmp    801062e8 <sys_open+0x4a8>
      fileclose(f2);
801067b6:	83 ec 0c             	sub    $0xc,%esp
801067b9:	57                   	push   %edi
801067ba:	e8 81 a6 ff ff       	call   80100e40 <fileclose>
801067bf:	83 c4 10             	add    $0x10,%esp
801067c2:	e9 21 fb ff ff       	jmp    801062e8 <sys_open+0x4a8>
801067c7:	89 f6                	mov    %esi,%esi
801067c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801067d0 <sys_create_container>:

int
sys_create_container(int cid){
801067d0:	55                   	push   %ebp
801067d1:	89 e5                	mov    %esp,%ebp
801067d3:	53                   	push   %ebx
  // cprintf("Create container call hua%s\n");
  // create_container_called = 1;
  argint(0,&cid);
801067d4:	8d 45 08             	lea    0x8(%ebp),%eax
sys_create_container(int cid){
801067d7:	83 ec 0c             	sub    $0xc,%esp
  argint(0,&cid);
801067da:	50                   	push   %eax
801067db:	6a 00                	push   $0x0
801067dd:	e8 3e e5 ff ff       	call   80104d20 <argint>
  for (int i = 0; i < 100; i++) {
    if (container_location[i]==1){
      if(container_array[i].cid==cid){return -1;}
801067e2:	8b 45 08             	mov    0x8(%ebp),%eax
801067e5:	83 c4 10             	add    $0x10,%esp
  for (int i = 0; i < 100; i++) {
801067e8:	31 d2                	xor    %edx,%edx
801067ea:	eb 0c                	jmp    801067f8 <sys_create_container+0x28>
801067ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801067f0:	83 c2 01             	add    $0x1,%edx
801067f3:	83 fa 64             	cmp    $0x64,%edx
801067f6:	74 28                	je     80106820 <sys_create_container+0x50>
    if (container_location[i]==1){
801067f8:	83 3c 95 e0 79 14 80 	cmpl   $0x1,-0x7feb8620(,%edx,4)
801067ff:	01 
80106800:	75 ee                	jne    801067f0 <sys_create_container+0x20>
      if(container_array[i].cid==cid){return -1;}
80106802:	69 ca a4 08 00 00    	imul   $0x8a4,%edx,%ecx
80106808:	39 81 c0 18 11 80    	cmp    %eax,-0x7feee740(%ecx)
8010680e:	75 e0                	jne    801067f0 <sys_create_container+0x20>
80106810:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      container_array[i].number_of_files=0;
      break;
    }
  }
  return cid;
}
80106815:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106818:	c9                   	leave  
80106819:	c3                   	ret    
8010681a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for ( int i=0; i<100 ; i++) {
80106820:	31 d2                	xor    %edx,%edx
80106822:	eb 0c                	jmp    80106830 <sys_create_container+0x60>
80106824:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106828:	83 c2 01             	add    $0x1,%edx
8010682b:	83 fa 64             	cmp    $0x64,%edx
8010682e:	74 e5                	je     80106815 <sys_create_container+0x45>
    if (container_location[i]!=1){
80106830:	83 3c 95 e0 79 14 80 	cmpl   $0x1,-0x7feb8620(,%edx,4)
80106837:	01 
80106838:	74 ee                	je     80106828 <sys_create_container+0x58>
      container_array[i]=new_container;
8010683a:	69 da a4 08 00 00    	imul   $0x8a4,%edx,%ebx
      container_location[i]=1;
80106840:	c7 04 95 e0 79 14 80 	movl   $0x1,-0x7feb8620(,%edx,4)
80106847:	01 00 00 00 
      container_array[i]=new_container;
8010684b:	89 83 c0 18 11 80    	mov    %eax,-0x7feee740(%ebx)
      container_array[i].number_of_process=0;
80106851:	c7 83 c4 18 11 80 00 	movl   $0x0,-0x7feee73c(%ebx)
80106858:	00 00 00 
      container_array[i].number_of_files=0;
8010685b:	c7 83 c8 18 11 80 00 	movl   $0x0,-0x7feee738(%ebx)
80106862:	00 00 00 
}
80106865:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106868:	c9                   	leave  
80106869:	c3                   	ret    
8010686a:	66 90                	xchg   %ax,%ax
8010686c:	66 90                	xchg   %ax,%ax
8010686e:	66 90                	xchg   %ax,%ax

80106870 <sys_fork>:

// #include "queues.h"

int
sys_fork(void)
{ if(isTraceOn==1)
80106870:	83 3d b0 18 11 80 01 	cmpl   $0x1,0x801118b0
80106877:	55                   	push   %ebp
80106878:	89 e5                	mov    %esp,%ebp
8010687a:	75 07                	jne    80106883 <sys_fork+0x13>
  {num_calls[SYS_fork] ++;}
8010687c:	83 05 c4 7d 14 80 01 	addl   $0x1,0x80147dc4
  return fork();
}
80106883:	5d                   	pop    %ebp
  return fork();
80106884:	e9 37 d1 ff ff       	jmp    801039c0 <fork>
80106889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106890 <sys_exit>:

int
sys_exit(void)
{ if(isTraceOn==1)
80106890:	55                   	push   %ebp
80106891:	89 e5                	mov    %esp,%ebp
80106893:	83 ec 08             	sub    $0x8,%esp
80106896:	83 3d b0 18 11 80 01 	cmpl   $0x1,0x801118b0
8010689d:	75 07                	jne    801068a6 <sys_exit+0x16>
  {num_calls[SYS_exit] ++;}
8010689f:	83 05 c8 7d 14 80 01 	addl   $0x1,0x80147dc8
  exit();
801068a6:	e8 35 d4 ff ff       	call   80103ce0 <exit>
  return 0;  // not reached
}
801068ab:	31 c0                	xor    %eax,%eax
801068ad:	c9                   	leave  
801068ae:	c3                   	ret    
801068af:	90                   	nop

801068b0 <sys_wait>:

int
sys_wait(void)
{ if(isTraceOn==1)
801068b0:	83 3d b0 18 11 80 01 	cmpl   $0x1,0x801118b0
801068b7:	55                   	push   %ebp
801068b8:	89 e5                	mov    %esp,%ebp
801068ba:	75 07                	jne    801068c3 <sys_wait+0x13>
  {num_calls[SYS_wait] ++;}
801068bc:	83 05 cc 7d 14 80 01 	addl   $0x1,0x80147dcc
  return wait();
}
801068c3:	5d                   	pop    %ebp
  return wait();
801068c4:	e9 67 d6 ff ff       	jmp    80103f30 <wait>
801068c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801068d0 <sys_kill>:

int
sys_kill(void)
{ if(isTraceOn==1)
801068d0:	55                   	push   %ebp
801068d1:	89 e5                	mov    %esp,%ebp
801068d3:	83 ec 18             	sub    $0x18,%esp
801068d6:	83 3d b0 18 11 80 01 	cmpl   $0x1,0x801118b0
801068dd:	75 07                	jne    801068e6 <sys_kill+0x16>
  {num_calls[SYS_kill] ++;}
801068df:	83 05 d8 7d 14 80 01 	addl   $0x1,0x80147dd8
  int pid;

  if(argint(0, &pid) < 0)
801068e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801068e9:	83 ec 08             	sub    $0x8,%esp
801068ec:	50                   	push   %eax
801068ed:	6a 00                	push   $0x0
801068ef:	e8 2c e4 ff ff       	call   80104d20 <argint>
801068f4:	83 c4 10             	add    $0x10,%esp
801068f7:	85 c0                	test   %eax,%eax
801068f9:	78 15                	js     80106910 <sys_kill+0x40>
    return -1;
  return kill(pid);
801068fb:	83 ec 0c             	sub    $0xc,%esp
801068fe:	ff 75 f4             	pushl  -0xc(%ebp)
80106901:	e8 8a d7 ff ff       	call   80104090 <kill>
80106906:	83 c4 10             	add    $0x10,%esp
}
80106909:	c9                   	leave  
8010690a:	c3                   	ret    
8010690b:	90                   	nop
8010690c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106910:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106915:	c9                   	leave  
80106916:	c3                   	ret    
80106917:	89 f6                	mov    %esi,%esi
80106919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106920 <sys_getpid>:

int
sys_getpid(void)
{ if(isTraceOn==1)
80106920:	55                   	push   %ebp
80106921:	89 e5                	mov    %esp,%ebp
80106923:	83 ec 08             	sub    $0x8,%esp
80106926:	83 3d b0 18 11 80 01 	cmpl   $0x1,0x801118b0
8010692d:	75 07                	jne    80106936 <sys_getpid+0x16>
  {num_calls[SYS_getpid] ++;}
8010692f:	83 05 ec 7d 14 80 01 	addl   $0x1,0x80147dec
  return myproc()->pid;
80106936:	e8 d5 ce ff ff       	call   80103810 <myproc>
8010693b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010693e:	c9                   	leave  
8010693f:	c3                   	ret    

80106940 <sys_getcid>:

int
sys_getcid(void)
{ if(isTraceOn==1)
80106940:	55                   	push   %ebp
80106941:	89 e5                	mov    %esp,%ebp
80106943:	83 ec 08             	sub    $0x8,%esp
80106946:	83 3d b0 18 11 80 01 	cmpl   $0x1,0x801118b0
8010694d:	75 07                	jne    80106956 <sys_getcid+0x16>
  {num_calls[SYS_getpid] ++;}
8010694f:	83 05 ec 7d 14 80 01 	addl   $0x1,0x80147dec
  return myproc()->cid;
80106956:	e8 b5 ce ff ff       	call   80103810 <myproc>
8010695b:	8b 80 cc 01 00 00    	mov    0x1cc(%eax),%eax
}
80106961:	c9                   	leave  
80106962:	c3                   	ret    
80106963:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106970 <sys_sbrk>:

int
sys_sbrk(void)
{ if(isTraceOn==1)
80106970:	55                   	push   %ebp
80106971:	89 e5                	mov    %esp,%ebp
80106973:	53                   	push   %ebx
80106974:	83 ec 14             	sub    $0x14,%esp
80106977:	83 3d b0 18 11 80 01 	cmpl   $0x1,0x801118b0
8010697e:	75 07                	jne    80106987 <sys_sbrk+0x17>
  {num_calls[SYS_sbrk] ++;}
80106980:	83 05 f0 7d 14 80 01 	addl   $0x1,0x80147df0
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106987:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010698a:	83 ec 08             	sub    $0x8,%esp
8010698d:	50                   	push   %eax
8010698e:	6a 00                	push   $0x0
80106990:	e8 8b e3 ff ff       	call   80104d20 <argint>
80106995:	83 c4 10             	add    $0x10,%esp
80106998:	85 c0                	test   %eax,%eax
8010699a:	78 24                	js     801069c0 <sys_sbrk+0x50>
    return -1;
  addr = myproc()->sz;
8010699c:	e8 6f ce ff ff       	call   80103810 <myproc>
  if(growproc(n) < 0)
801069a1:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801069a4:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801069a6:	ff 75 f4             	pushl  -0xc(%ebp)
801069a9:	e8 92 cf ff ff       	call   80103940 <growproc>
801069ae:	83 c4 10             	add    $0x10,%esp
801069b1:	85 c0                	test   %eax,%eax
801069b3:	78 0b                	js     801069c0 <sys_sbrk+0x50>
    return -1;
  return addr;
}
801069b5:	89 d8                	mov    %ebx,%eax
801069b7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801069ba:	c9                   	leave  
801069bb:	c3                   	ret    
801069bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801069c0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801069c5:	eb ee                	jmp    801069b5 <sys_sbrk+0x45>
801069c7:	89 f6                	mov    %esi,%esi
801069c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801069d0 <sys_sleep>:

int
sys_sleep(void)
{ if(isTraceOn==1)
801069d0:	55                   	push   %ebp
801069d1:	89 e5                	mov    %esp,%ebp
801069d3:	53                   	push   %ebx
801069d4:	83 ec 14             	sub    $0x14,%esp
801069d7:	83 3d b0 18 11 80 01 	cmpl   $0x1,0x801118b0
801069de:	75 07                	jne    801069e7 <sys_sleep+0x17>
  {num_calls[SYS_sleep] ++;}
801069e0:	83 05 f4 7d 14 80 01 	addl   $0x1,0x80147df4
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801069e7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801069ea:	83 ec 08             	sub    $0x8,%esp
801069ed:	50                   	push   %eax
801069ee:	6a 00                	push   $0x0
801069f0:	e8 2b e3 ff ff       	call   80104d20 <argint>
801069f5:	83 c4 10             	add    $0x10,%esp
801069f8:	85 c0                	test   %eax,%eax
801069fa:	0f 88 87 00 00 00    	js     80106a87 <sys_sleep+0xb7>
    return -1;
  acquire(&tickslock);
80106a00:	83 ec 0c             	sub    $0xc,%esp
80106a03:	68 20 27 15 80       	push   $0x80152720
80106a08:	e8 03 df ff ff       	call   80104910 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106a0d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106a10:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80106a13:	8b 1d 60 2f 15 80    	mov    0x80152f60,%ebx
  while(ticks - ticks0 < n){
80106a19:	85 d2                	test   %edx,%edx
80106a1b:	75 24                	jne    80106a41 <sys_sleep+0x71>
80106a1d:	eb 51                	jmp    80106a70 <sys_sleep+0xa0>
80106a1f:	90                   	nop
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106a20:	83 ec 08             	sub    $0x8,%esp
80106a23:	68 20 27 15 80       	push   $0x80152720
80106a28:	68 60 2f 15 80       	push   $0x80152f60
80106a2d:	e8 3e d4 ff ff       	call   80103e70 <sleep>
  while(ticks - ticks0 < n){
80106a32:	a1 60 2f 15 80       	mov    0x80152f60,%eax
80106a37:	83 c4 10             	add    $0x10,%esp
80106a3a:	29 d8                	sub    %ebx,%eax
80106a3c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80106a3f:	73 2f                	jae    80106a70 <sys_sleep+0xa0>
    if(myproc()->killed){
80106a41:	e8 ca cd ff ff       	call   80103810 <myproc>
80106a46:	8b 40 24             	mov    0x24(%eax),%eax
80106a49:	85 c0                	test   %eax,%eax
80106a4b:	74 d3                	je     80106a20 <sys_sleep+0x50>
      release(&tickslock);
80106a4d:	83 ec 0c             	sub    $0xc,%esp
80106a50:	68 20 27 15 80       	push   $0x80152720
80106a55:	e8 76 df ff ff       	call   801049d0 <release>
      return -1;
80106a5a:	83 c4 10             	add    $0x10,%esp
80106a5d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80106a62:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106a65:	c9                   	leave  
80106a66:	c3                   	ret    
80106a67:	89 f6                	mov    %esi,%esi
80106a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80106a70:	83 ec 0c             	sub    $0xc,%esp
80106a73:	68 20 27 15 80       	push   $0x80152720
80106a78:	e8 53 df ff ff       	call   801049d0 <release>
  return 0;
80106a7d:	83 c4 10             	add    $0x10,%esp
80106a80:	31 c0                	xor    %eax,%eax
}
80106a82:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106a85:	c9                   	leave  
80106a86:	c3                   	ret    
    return -1;
80106a87:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a8c:	eb f4                	jmp    80106a82 <sys_sleep+0xb2>
80106a8e:	66 90                	xchg   %ax,%ax

80106a90 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{ if(isTraceOn==1)
80106a90:	55                   	push   %ebp
80106a91:	89 e5                	mov    %esp,%ebp
80106a93:	53                   	push   %ebx
80106a94:	83 ec 04             	sub    $0x4,%esp
80106a97:	83 3d b0 18 11 80 01 	cmpl   $0x1,0x801118b0
80106a9e:	75 07                	jne    80106aa7 <sys_uptime+0x17>
  {num_calls[SYS_uptime] ++;}
80106aa0:	83 05 f8 7d 14 80 01 	addl   $0x1,0x80147df8
  uint xticks;

  acquire(&tickslock);
80106aa7:	83 ec 0c             	sub    $0xc,%esp
80106aaa:	68 20 27 15 80       	push   $0x80152720
80106aaf:	e8 5c de ff ff       	call   80104910 <acquire>
  xticks = ticks;
80106ab4:	8b 1d 60 2f 15 80    	mov    0x80152f60,%ebx
  release(&tickslock);
80106aba:	c7 04 24 20 27 15 80 	movl   $0x80152720,(%esp)
80106ac1:	e8 0a df ff ff       	call   801049d0 <release>
  return xticks;
}
80106ac6:	89 d8                	mov    %ebx,%eax
80106ac8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106acb:	c9                   	leave  
80106acc:	c3                   	ret    
80106acd:	8d 76 00             	lea    0x0(%esi),%esi

80106ad0 <sys_halt>:

int
sys_halt(void)
{ if(isTraceOn==1)
80106ad0:	83 3d b0 18 11 80 01 	cmpl   $0x1,0x801118b0
80106ad7:	55                   	push   %ebp
80106ad8:	89 e5                	mov    %esp,%ebp
80106ada:	75 07                	jne    80106ae3 <sys_halt+0x13>
  {num_calls[SYS_halt] ++;}
80106adc:	83 05 18 7e 14 80 01 	addl   $0x1,0x80147e18
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106ae3:	31 c0                	xor    %eax,%eax
80106ae5:	ba f4 00 00 00       	mov    $0xf4,%edx
80106aea:	ee                   	out    %al,(%dx)
  outb(0xf4, 0x00);
  return 0;
}
80106aeb:	31 c0                	xor    %eax,%eax
80106aed:	5d                   	pop    %ebp
80106aee:	c3                   	ret    
80106aef:	90                   	nop

80106af0 <sys_toggle>:

int
sys_toggle(void)
{
  if(isTraceOn==0)
80106af0:	a1 b0 18 11 80       	mov    0x801118b0,%eax
{
80106af5:	55                   	push   %ebp
80106af6:	89 e5                	mov    %esp,%ebp
  if(isTraceOn==0)
80106af8:	85 c0                	test   %eax,%eax
80106afa:	75 2c                	jne    80106b28 <sys_toggle+0x38>
    {
      isTraceOn=1;
80106afc:	c7 05 b0 18 11 80 01 	movl   $0x1,0x801118b0
80106b03:	00 00 00 
80106b06:	b8 c0 7d 14 80       	mov    $0x80147dc0,%eax
80106b0b:	90                   	nop
80106b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(int i =0;i<NELEM(num_calls);i++){num_calls[i]=0;}
80106b10:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80106b16:	83 c0 04             	add    $0x4,%eax
80106b19:	3d 60 7e 14 80       	cmp    $0x80147e60,%eax
80106b1e:	75 f0                	jne    80106b10 <sys_toggle+0x20>
  {
    isTraceOn=0;
    return 0;
  }
  return 0;
}
80106b20:	31 c0                	xor    %eax,%eax
80106b22:	5d                   	pop    %ebp
80106b23:	c3                   	ret    
80106b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(isTraceOn==1)
80106b28:	83 f8 01             	cmp    $0x1,%eax
80106b2b:	75 f3                	jne    80106b20 <sys_toggle+0x30>
}
80106b2d:	31 c0                	xor    %eax,%eax
    isTraceOn=0;
80106b2f:	c7 05 b0 18 11 80 00 	movl   $0x0,0x801118b0
80106b36:	00 00 00 
}
80106b39:	5d                   	pop    %ebp
80106b3a:	c3                   	ret    
80106b3b:	90                   	nop
80106b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106b40 <sys_ps>:



int
sys_ps(void)
{
80106b40:	55                   	push   %ebp
80106b41:	89 e5                	mov    %esp,%ebp
80106b43:	83 ec 08             	sub    $0x8,%esp
  // cprintf("ps call hua%s\n");
  if(isTraceOn==1){num_calls[SYS_ps] ++;}
80106b46:	83 3d b0 18 11 80 01 	cmpl   $0x1,0x801118b0
80106b4d:	75 07                	jne    80106b56 <sys_ps+0x16>
80106b4f:	83 05 20 7e 14 80 01 	addl   $0x1,0x80147e20
  running_procs();
80106b56:	e8 95 d6 ff ff       	call   801041f0 <running_procs>
return 0;
}
80106b5b:	31 c0                	xor    %eax,%eax
80106b5d:	c9                   	leave  
80106b5e:	c3                   	ret    
80106b5f:	90                   	nop

80106b60 <sys_destroy_container>:


int
sys_destroy_container(int cid){
80106b60:	55                   	push   %ebp
80106b61:	89 e5                	mov    %esp,%ebp
80106b63:	53                   	push   %ebx
  argint(0,&cid);
80106b64:	8d 45 08             	lea    0x8(%ebp),%eax
sys_destroy_container(int cid){
80106b67:	83 ec 0c             	sub    $0xc,%esp
  argint(0,&cid);
80106b6a:	50                   	push   %eax
80106b6b:	6a 00                	push   $0x0
80106b6d:	e8 ae e1 ff ff       	call   80104d20 <argint>
  for (int i = 0; i < 100; i++) {
    if (container_location[i]==1){
      if(container_array[i].cid==cid){
80106b72:	8b 5d 08             	mov    0x8(%ebp),%ebx
80106b75:	83 c4 10             	add    $0x10,%esp
  for (int i = 0; i < 100; i++) {
80106b78:	31 d2                	xor    %edx,%edx
80106b7a:	eb 0c                	jmp    80106b88 <sys_destroy_container+0x28>
80106b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106b80:	83 c2 01             	add    $0x1,%edx
80106b83:	83 fa 64             	cmp    $0x64,%edx
80106b86:	74 30                	je     80106bb8 <sys_destroy_container+0x58>
    if (container_location[i]==1){
80106b88:	8b 04 95 e0 79 14 80 	mov    -0x7feb8620(,%edx,4),%eax
80106b8f:	83 f8 01             	cmp    $0x1,%eax
80106b92:	75 ec                	jne    80106b80 <sys_destroy_container+0x20>
      if(container_array[i].cid==cid){
80106b94:	69 ca a4 08 00 00    	imul   $0x8a4,%edx,%ecx
80106b9a:	39 99 c0 18 11 80    	cmp    %ebx,-0x7feee740(%ecx)
80106ba0:	75 de                	jne    80106b80 <sys_destroy_container+0x20>
        // container_array[i]=null;
        container_location[i]=0;
80106ba2:	c7 04 95 e0 79 14 80 	movl   $0x0,-0x7feb8620(,%edx,4)
80106ba9:	00 00 00 00 
        return 1;
        }
    }
  }
  return -1;
}
80106bad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106bb0:	c9                   	leave  
80106bb1:	c3                   	ret    
80106bb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80106bb8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106bbd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106bc0:	c9                   	leave  
80106bc1:	c3                   	ret    
80106bc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106bd0 <sys_join_container>:

int
sys_join_container(int cid){
80106bd0:	55                   	push   %ebp
80106bd1:	89 e5                	mov    %esp,%ebp
80106bd3:	83 ec 10             	sub    $0x10,%esp
  // cprintf("Join container call hua%s\n");
  argint(0,&cid);
80106bd6:	8d 45 08             	lea    0x8(%ebp),%eax
80106bd9:	50                   	push   %eax
80106bda:	6a 00                	push   $0x0
80106bdc:	e8 3f e1 ff ff       	call   80104d20 <argint>
  int r = join_cont(cid);
80106be1:	58                   	pop    %eax
80106be2:	ff 75 08             	pushl  0x8(%ebp)
80106be5:	e8 d6 d7 ff ff       	call   801043c0 <join_cont>
  return r;
}
80106bea:	c9                   	leave  
80106beb:	c3                   	ret    
80106bec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106bf0 <sys_leave_container>:

int
sys_leave_container(void){
80106bf0:	55                   	push   %ebp
80106bf1:	89 e5                	mov    %esp,%ebp
80106bf3:	56                   	push   %esi
80106bf4:	53                   	push   %ebx
  struct proc *curproc = myproc();
80106bf5:	e8 16 cc ff ff       	call   80103810 <myproc>
  int cid = curproc->cid;
  for (int i = 0; i < 100; i++) {
80106bfa:	31 d2                	xor    %edx,%edx
  int cid = curproc->cid;
80106bfc:	8b b0 cc 01 00 00    	mov    0x1cc(%eax),%esi
80106c02:	eb 0c                	jmp    80106c10 <sys_leave_container+0x20>
80106c04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for (int i = 0; i < 100; i++) {
80106c08:	83 c2 01             	add    $0x1,%edx
80106c0b:	83 fa 64             	cmp    $0x64,%edx
80106c0e:	74 50                	je     80106c60 <sys_leave_container+0x70>
    if (container_location[i]==1){
80106c10:	8b 0c 95 e0 79 14 80 	mov    -0x7feb8620(,%edx,4),%ecx
80106c17:	83 f9 01             	cmp    $0x1,%ecx
80106c1a:	75 ec                	jne    80106c08 <sys_leave_container+0x18>
      if(container_array[i].cid==cid){
80106c1c:	69 da a4 08 00 00    	imul   $0x8a4,%edx,%ebx
80106c22:	39 b3 c0 18 11 80    	cmp    %esi,-0x7feee740(%ebx)
80106c28:	75 de                	jne    80106c08 <sys_leave_container+0x18>
        curproc->cid = 0;
80106c2a:	c7 80 cc 01 00 00 00 	movl   $0x0,0x1cc(%eax)
80106c31:	00 00 00 
        container_array[i].mypid[container_array[i].number_of_process] = -1;
80106c34:	8b 83 c4 18 11 80    	mov    -0x7feee73c(%ebx),%eax
80106c3a:	69 d2 29 02 00 00    	imul   $0x229,%edx,%edx
80106c40:	01 c2                	add    %eax,%edx
        container_array[i].number_of_process--;
80106c42:	83 e8 01             	sub    $0x1,%eax
80106c45:	89 83 c4 18 11 80    	mov    %eax,-0x7feee73c(%ebx)
        container_array[i].mypid[container_array[i].number_of_process] = -1;
80106c4b:	c7 04 95 cc 18 11 80 	movl   $0xffffffff,-0x7feee734(,%edx,4)
80106c52:	ff ff ff ff 
        return 1;
      }
    }
  }
  return -1;
}
80106c56:	89 c8                	mov    %ecx,%eax
80106c58:	5b                   	pop    %ebx
80106c59:	5e                   	pop    %esi
80106c5a:	5d                   	pop    %ebp
80106c5b:	c3                   	ret    
80106c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return -1;
80106c60:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
}
80106c65:	5b                   	pop    %ebx
80106c66:	89 c8                	mov    %ecx,%eax
80106c68:	5e                   	pop    %esi
80106c69:	5d                   	pop    %ebp
80106c6a:	c3                   	ret    

80106c6b <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106c6b:	1e                   	push   %ds
  pushl %es
80106c6c:	06                   	push   %es
  pushl %fs
80106c6d:	0f a0                	push   %fs
  pushl %gs
80106c6f:	0f a8                	push   %gs
  pushal
80106c71:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106c72:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106c76:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106c78:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106c7a:	54                   	push   %esp
  call trap
80106c7b:	e8 c0 00 00 00       	call   80106d40 <trap>
  addl $4, %esp
80106c80:	83 c4 04             	add    $0x4,%esp

80106c83 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106c83:	61                   	popa   
  popl %gs
80106c84:	0f a9                	pop    %gs
  popl %fs
80106c86:	0f a1                	pop    %fs
  popl %es
80106c88:	07                   	pop    %es
  popl %ds
80106c89:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106c8a:	83 c4 08             	add    $0x8,%esp
  iret
80106c8d:	cf                   	iret   
80106c8e:	66 90                	xchg   %ax,%ax

80106c90 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106c90:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106c91:	31 c0                	xor    %eax,%eax
{
80106c93:	89 e5                	mov    %esp,%ebp
80106c95:	83 ec 08             	sub    $0x8,%esp
80106c98:	90                   	nop
80106c99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106ca0:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80106ca7:	c7 04 c5 62 27 15 80 	movl   $0x8e000008,-0x7fead89e(,%eax,8)
80106cae:	08 00 00 8e 
80106cb2:	66 89 14 c5 60 27 15 	mov    %dx,-0x7fead8a0(,%eax,8)
80106cb9:	80 
80106cba:	c1 ea 10             	shr    $0x10,%edx
80106cbd:	66 89 14 c5 66 27 15 	mov    %dx,-0x7fead89a(,%eax,8)
80106cc4:	80 
  for(i = 0; i < 256; i++)
80106cc5:	83 c0 01             	add    $0x1,%eax
80106cc8:	3d 00 01 00 00       	cmp    $0x100,%eax
80106ccd:	75 d1                	jne    80106ca0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106ccf:	a1 08 b1 10 80       	mov    0x8010b108,%eax

  initlock(&tickslock, "time");
80106cd4:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106cd7:	c7 05 62 29 15 80 08 	movl   $0xef000008,0x80152962
80106cde:	00 00 ef 
  initlock(&tickslock, "time");
80106ce1:	68 26 8d 10 80       	push   $0x80108d26
80106ce6:	68 20 27 15 80       	push   $0x80152720
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106ceb:	66 a3 60 29 15 80    	mov    %ax,0x80152960
80106cf1:	c1 e8 10             	shr    $0x10,%eax
80106cf4:	66 a3 66 29 15 80    	mov    %ax,0x80152966
  initlock(&tickslock, "time");
80106cfa:	e8 d1 da ff ff       	call   801047d0 <initlock>
}
80106cff:	83 c4 10             	add    $0x10,%esp
80106d02:	c9                   	leave  
80106d03:	c3                   	ret    
80106d04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106d10 <idtinit>:

void
idtinit(void)
{
80106d10:	55                   	push   %ebp
  pd[0] = size-1;
80106d11:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106d16:	89 e5                	mov    %esp,%ebp
80106d18:	83 ec 10             	sub    $0x10,%esp
80106d1b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106d1f:	b8 60 27 15 80       	mov    $0x80152760,%eax
80106d24:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106d28:	c1 e8 10             	shr    $0x10,%eax
80106d2b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80106d2f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106d32:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106d35:	c9                   	leave  
80106d36:	c3                   	ret    
80106d37:	89 f6                	mov    %esi,%esi
80106d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d40 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106d40:	55                   	push   %ebp
80106d41:	89 e5                	mov    %esp,%ebp
80106d43:	57                   	push   %edi
80106d44:	56                   	push   %esi
80106d45:	53                   	push   %ebx
80106d46:	83 ec 1c             	sub    $0x1c,%esp
80106d49:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
80106d4c:	8b 47 30             	mov    0x30(%edi),%eax
80106d4f:	83 f8 40             	cmp    $0x40,%eax
80106d52:	0f 84 f0 00 00 00    	je     80106e48 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80106d58:	83 e8 20             	sub    $0x20,%eax
80106d5b:	83 f8 1f             	cmp    $0x1f,%eax
80106d5e:	77 10                	ja     80106d70 <trap+0x30>
80106d60:	ff 24 85 cc 8d 10 80 	jmp    *-0x7fef7234(,%eax,4)
80106d67:	89 f6                	mov    %esi,%esi
80106d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80106d70:	e8 9b ca ff ff       	call   80103810 <myproc>
80106d75:	85 c0                	test   %eax,%eax
80106d77:	8b 5f 38             	mov    0x38(%edi),%ebx
80106d7a:	0f 84 14 02 00 00    	je     80106f94 <trap+0x254>
80106d80:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80106d84:	0f 84 0a 02 00 00    	je     80106f94 <trap+0x254>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106d8a:	0f 20 d1             	mov    %cr2,%ecx
80106d8d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106d90:	e8 5b ca ff ff       	call   801037f0 <cpuid>
80106d95:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106d98:	8b 47 34             	mov    0x34(%edi),%eax
80106d9b:	8b 77 30             	mov    0x30(%edi),%esi
80106d9e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106da1:	e8 6a ca ff ff       	call   80103810 <myproc>
80106da6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106da9:	e8 62 ca ff ff       	call   80103810 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106dae:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106db1:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106db4:	51                   	push   %ecx
80106db5:	53                   	push   %ebx
80106db6:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80106db7:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106dba:	ff 75 e4             	pushl  -0x1c(%ebp)
80106dbd:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80106dbe:	81 c2 bc 01 00 00    	add    $0x1bc,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106dc4:	52                   	push   %edx
80106dc5:	ff 70 10             	pushl  0x10(%eax)
80106dc8:	68 88 8d 10 80       	push   $0x80108d88
80106dcd:	e8 8e 98 ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80106dd2:	83 c4 20             	add    $0x20,%esp
80106dd5:	e8 36 ca ff ff       	call   80103810 <myproc>
80106dda:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106de1:	e8 2a ca ff ff       	call   80103810 <myproc>
80106de6:	85 c0                	test   %eax,%eax
80106de8:	74 1d                	je     80106e07 <trap+0xc7>
80106dea:	e8 21 ca ff ff       	call   80103810 <myproc>
80106def:	8b 50 24             	mov    0x24(%eax),%edx
80106df2:	85 d2                	test   %edx,%edx
80106df4:	74 11                	je     80106e07 <trap+0xc7>
80106df6:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80106dfa:	83 e0 03             	and    $0x3,%eax
80106dfd:	66 83 f8 03          	cmp    $0x3,%ax
80106e01:	0f 84 49 01 00 00    	je     80106f50 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106e07:	e8 04 ca ff ff       	call   80103810 <myproc>
80106e0c:	85 c0                	test   %eax,%eax
80106e0e:	74 0b                	je     80106e1b <trap+0xdb>
80106e10:	e8 fb c9 ff ff       	call   80103810 <myproc>
80106e15:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106e19:	74 65                	je     80106e80 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106e1b:	e8 f0 c9 ff ff       	call   80103810 <myproc>
80106e20:	85 c0                	test   %eax,%eax
80106e22:	74 19                	je     80106e3d <trap+0xfd>
80106e24:	e8 e7 c9 ff ff       	call   80103810 <myproc>
80106e29:	8b 40 24             	mov    0x24(%eax),%eax
80106e2c:	85 c0                	test   %eax,%eax
80106e2e:	74 0d                	je     80106e3d <trap+0xfd>
80106e30:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80106e34:	83 e0 03             	and    $0x3,%eax
80106e37:	66 83 f8 03          	cmp    $0x3,%ax
80106e3b:	74 34                	je     80106e71 <trap+0x131>
    exit();
}
80106e3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e40:	5b                   	pop    %ebx
80106e41:	5e                   	pop    %esi
80106e42:	5f                   	pop    %edi
80106e43:	5d                   	pop    %ebp
80106e44:	c3                   	ret    
80106e45:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc()->killed)
80106e48:	e8 c3 c9 ff ff       	call   80103810 <myproc>
80106e4d:	8b 58 24             	mov    0x24(%eax),%ebx
80106e50:	85 db                	test   %ebx,%ebx
80106e52:	0f 85 e8 00 00 00    	jne    80106f40 <trap+0x200>
    myproc()->tf = tf;
80106e58:	e8 b3 c9 ff ff       	call   80103810 <myproc>
80106e5d:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80106e60:	e8 7b e0 ff ff       	call   80104ee0 <syscall>
    if(myproc()->killed)
80106e65:	e8 a6 c9 ff ff       	call   80103810 <myproc>
80106e6a:	8b 48 24             	mov    0x24(%eax),%ecx
80106e6d:	85 c9                	test   %ecx,%ecx
80106e6f:	74 cc                	je     80106e3d <trap+0xfd>
}
80106e71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e74:	5b                   	pop    %ebx
80106e75:	5e                   	pop    %esi
80106e76:	5f                   	pop    %edi
80106e77:	5d                   	pop    %ebp
      exit();
80106e78:	e9 63 ce ff ff       	jmp    80103ce0 <exit>
80106e7d:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80106e80:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80106e84:	75 95                	jne    80106e1b <trap+0xdb>
    yield();
80106e86:	e8 95 cf ff ff       	call   80103e20 <yield>
80106e8b:	eb 8e                	jmp    80106e1b <trap+0xdb>
80106e8d:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80106e90:	e8 5b c9 ff ff       	call   801037f0 <cpuid>
80106e95:	85 c0                	test   %eax,%eax
80106e97:	0f 84 c3 00 00 00    	je     80106f60 <trap+0x220>
    lapiceoi();
80106e9d:	e8 de b8 ff ff       	call   80102780 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106ea2:	e8 69 c9 ff ff       	call   80103810 <myproc>
80106ea7:	85 c0                	test   %eax,%eax
80106ea9:	0f 85 3b ff ff ff    	jne    80106dea <trap+0xaa>
80106eaf:	e9 53 ff ff ff       	jmp    80106e07 <trap+0xc7>
80106eb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106eb8:	e8 83 b7 ff ff       	call   80102640 <kbdintr>
    lapiceoi();
80106ebd:	e8 be b8 ff ff       	call   80102780 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106ec2:	e8 49 c9 ff ff       	call   80103810 <myproc>
80106ec7:	85 c0                	test   %eax,%eax
80106ec9:	0f 85 1b ff ff ff    	jne    80106dea <trap+0xaa>
80106ecf:	e9 33 ff ff ff       	jmp    80106e07 <trap+0xc7>
80106ed4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106ed8:	e8 53 02 00 00       	call   80107130 <uartintr>
    lapiceoi();
80106edd:	e8 9e b8 ff ff       	call   80102780 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106ee2:	e8 29 c9 ff ff       	call   80103810 <myproc>
80106ee7:	85 c0                	test   %eax,%eax
80106ee9:	0f 85 fb fe ff ff    	jne    80106dea <trap+0xaa>
80106eef:	e9 13 ff ff ff       	jmp    80106e07 <trap+0xc7>
80106ef4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106ef8:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80106efc:	8b 77 38             	mov    0x38(%edi),%esi
80106eff:	e8 ec c8 ff ff       	call   801037f0 <cpuid>
80106f04:	56                   	push   %esi
80106f05:	53                   	push   %ebx
80106f06:	50                   	push   %eax
80106f07:	68 30 8d 10 80       	push   $0x80108d30
80106f0c:	e8 4f 97 ff ff       	call   80100660 <cprintf>
    lapiceoi();
80106f11:	e8 6a b8 ff ff       	call   80102780 <lapiceoi>
    break;
80106f16:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106f19:	e8 f2 c8 ff ff       	call   80103810 <myproc>
80106f1e:	85 c0                	test   %eax,%eax
80106f20:	0f 85 c4 fe ff ff    	jne    80106dea <trap+0xaa>
80106f26:	e9 dc fe ff ff       	jmp    80106e07 <trap+0xc7>
80106f2b:	90                   	nop
80106f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80106f30:	e8 7b b1 ff ff       	call   801020b0 <ideintr>
80106f35:	e9 63 ff ff ff       	jmp    80106e9d <trap+0x15d>
80106f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106f40:	e8 9b cd ff ff       	call   80103ce0 <exit>
80106f45:	e9 0e ff ff ff       	jmp    80106e58 <trap+0x118>
80106f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
80106f50:	e8 8b cd ff ff       	call   80103ce0 <exit>
80106f55:	e9 ad fe ff ff       	jmp    80106e07 <trap+0xc7>
80106f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80106f60:	83 ec 0c             	sub    $0xc,%esp
80106f63:	68 20 27 15 80       	push   $0x80152720
80106f68:	e8 a3 d9 ff ff       	call   80104910 <acquire>
      wakeup(&ticks);
80106f6d:	c7 04 24 60 2f 15 80 	movl   $0x80152f60,(%esp)
      ticks++;
80106f74:	83 05 60 2f 15 80 01 	addl   $0x1,0x80152f60
      wakeup(&ticks);
80106f7b:	e8 b0 d0 ff ff       	call   80104030 <wakeup>
      release(&tickslock);
80106f80:	c7 04 24 20 27 15 80 	movl   $0x80152720,(%esp)
80106f87:	e8 44 da ff ff       	call   801049d0 <release>
80106f8c:	83 c4 10             	add    $0x10,%esp
80106f8f:	e9 09 ff ff ff       	jmp    80106e9d <trap+0x15d>
80106f94:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106f97:	e8 54 c8 ff ff       	call   801037f0 <cpuid>
80106f9c:	83 ec 0c             	sub    $0xc,%esp
80106f9f:	56                   	push   %esi
80106fa0:	53                   	push   %ebx
80106fa1:	50                   	push   %eax
80106fa2:	ff 77 30             	pushl  0x30(%edi)
80106fa5:	68 54 8d 10 80       	push   $0x80108d54
80106faa:	e8 b1 96 ff ff       	call   80100660 <cprintf>
      panic("trap");
80106faf:	83 c4 14             	add    $0x14,%esp
80106fb2:	68 2b 8d 10 80       	push   $0x80108d2b
80106fb7:	e8 d4 93 ff ff       	call   80100390 <panic>
80106fbc:	66 90                	xchg   %ax,%ax
80106fbe:	66 90                	xchg   %ax,%ax

80106fc0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106fc0:	a1 cc b5 10 80       	mov    0x8010b5cc,%eax
{
80106fc5:	55                   	push   %ebp
80106fc6:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106fc8:	85 c0                	test   %eax,%eax
80106fca:	74 1c                	je     80106fe8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106fcc:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106fd1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106fd2:	a8 01                	test   $0x1,%al
80106fd4:	74 12                	je     80106fe8 <uartgetc+0x28>
80106fd6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106fdb:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106fdc:	0f b6 c0             	movzbl %al,%eax
}
80106fdf:	5d                   	pop    %ebp
80106fe0:	c3                   	ret    
80106fe1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106fe8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106fed:	5d                   	pop    %ebp
80106fee:	c3                   	ret    
80106fef:	90                   	nop

80106ff0 <uartputc.part.0>:
uartputc(int c)
80106ff0:	55                   	push   %ebp
80106ff1:	89 e5                	mov    %esp,%ebp
80106ff3:	57                   	push   %edi
80106ff4:	56                   	push   %esi
80106ff5:	53                   	push   %ebx
80106ff6:	89 c7                	mov    %eax,%edi
80106ff8:	bb 80 00 00 00       	mov    $0x80,%ebx
80106ffd:	be fd 03 00 00       	mov    $0x3fd,%esi
80107002:	83 ec 0c             	sub    $0xc,%esp
80107005:	eb 1b                	jmp    80107022 <uartputc.part.0+0x32>
80107007:	89 f6                	mov    %esi,%esi
80107009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80107010:	83 ec 0c             	sub    $0xc,%esp
80107013:	6a 0a                	push   $0xa
80107015:	e8 86 b7 ff ff       	call   801027a0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010701a:	83 c4 10             	add    $0x10,%esp
8010701d:	83 eb 01             	sub    $0x1,%ebx
80107020:	74 07                	je     80107029 <uartputc.part.0+0x39>
80107022:	89 f2                	mov    %esi,%edx
80107024:	ec                   	in     (%dx),%al
80107025:	a8 20                	test   $0x20,%al
80107027:	74 e7                	je     80107010 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107029:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010702e:	89 f8                	mov    %edi,%eax
80107030:	ee                   	out    %al,(%dx)
}
80107031:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107034:	5b                   	pop    %ebx
80107035:	5e                   	pop    %esi
80107036:	5f                   	pop    %edi
80107037:	5d                   	pop    %ebp
80107038:	c3                   	ret    
80107039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107040 <uartinit>:
{
80107040:	55                   	push   %ebp
80107041:	31 c9                	xor    %ecx,%ecx
80107043:	89 c8                	mov    %ecx,%eax
80107045:	89 e5                	mov    %esp,%ebp
80107047:	57                   	push   %edi
80107048:	56                   	push   %esi
80107049:	53                   	push   %ebx
8010704a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010704f:	89 da                	mov    %ebx,%edx
80107051:	83 ec 0c             	sub    $0xc,%esp
80107054:	ee                   	out    %al,(%dx)
80107055:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010705a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010705f:	89 fa                	mov    %edi,%edx
80107061:	ee                   	out    %al,(%dx)
80107062:	b8 0c 00 00 00       	mov    $0xc,%eax
80107067:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010706c:	ee                   	out    %al,(%dx)
8010706d:	be f9 03 00 00       	mov    $0x3f9,%esi
80107072:	89 c8                	mov    %ecx,%eax
80107074:	89 f2                	mov    %esi,%edx
80107076:	ee                   	out    %al,(%dx)
80107077:	b8 03 00 00 00       	mov    $0x3,%eax
8010707c:	89 fa                	mov    %edi,%edx
8010707e:	ee                   	out    %al,(%dx)
8010707f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80107084:	89 c8                	mov    %ecx,%eax
80107086:	ee                   	out    %al,(%dx)
80107087:	b8 01 00 00 00       	mov    $0x1,%eax
8010708c:	89 f2                	mov    %esi,%edx
8010708e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010708f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80107094:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80107095:	3c ff                	cmp    $0xff,%al
80107097:	74 5a                	je     801070f3 <uartinit+0xb3>
  uart = 1;
80107099:	c7 05 cc b5 10 80 01 	movl   $0x1,0x8010b5cc
801070a0:	00 00 00 
801070a3:	89 da                	mov    %ebx,%edx
801070a5:	ec                   	in     (%dx),%al
801070a6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801070ab:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801070ac:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
801070af:	bb 4c 8e 10 80       	mov    $0x80108e4c,%ebx
  ioapicenable(IRQ_COM1, 0);
801070b4:	6a 00                	push   $0x0
801070b6:	6a 04                	push   $0x4
801070b8:	e8 43 b2 ff ff       	call   80102300 <ioapicenable>
801070bd:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
801070c0:	b8 78 00 00 00       	mov    $0x78,%eax
801070c5:	eb 13                	jmp    801070da <uartinit+0x9a>
801070c7:	89 f6                	mov    %esi,%esi
801070c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801070d0:	83 c3 01             	add    $0x1,%ebx
801070d3:	0f be 03             	movsbl (%ebx),%eax
801070d6:	84 c0                	test   %al,%al
801070d8:	74 19                	je     801070f3 <uartinit+0xb3>
  if(!uart)
801070da:	8b 15 cc b5 10 80    	mov    0x8010b5cc,%edx
801070e0:	85 d2                	test   %edx,%edx
801070e2:	74 ec                	je     801070d0 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
801070e4:	83 c3 01             	add    $0x1,%ebx
801070e7:	e8 04 ff ff ff       	call   80106ff0 <uartputc.part.0>
801070ec:	0f be 03             	movsbl (%ebx),%eax
801070ef:	84 c0                	test   %al,%al
801070f1:	75 e7                	jne    801070da <uartinit+0x9a>
}
801070f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070f6:	5b                   	pop    %ebx
801070f7:	5e                   	pop    %esi
801070f8:	5f                   	pop    %edi
801070f9:	5d                   	pop    %ebp
801070fa:	c3                   	ret    
801070fb:	90                   	nop
801070fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107100 <uartputc>:
  if(!uart)
80107100:	8b 15 cc b5 10 80    	mov    0x8010b5cc,%edx
{
80107106:	55                   	push   %ebp
80107107:	89 e5                	mov    %esp,%ebp
  if(!uart)
80107109:	85 d2                	test   %edx,%edx
{
8010710b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
8010710e:	74 10                	je     80107120 <uartputc+0x20>
}
80107110:	5d                   	pop    %ebp
80107111:	e9 da fe ff ff       	jmp    80106ff0 <uartputc.part.0>
80107116:	8d 76 00             	lea    0x0(%esi),%esi
80107119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107120:	5d                   	pop    %ebp
80107121:	c3                   	ret    
80107122:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107130 <uartintr>:

void
uartintr(void)
{
80107130:	55                   	push   %ebp
80107131:	89 e5                	mov    %esp,%ebp
80107133:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80107136:	68 c0 6f 10 80       	push   $0x80106fc0
8010713b:	e8 d0 96 ff ff       	call   80100810 <consoleintr>
}
80107140:	83 c4 10             	add    $0x10,%esp
80107143:	c9                   	leave  
80107144:	c3                   	ret    

80107145 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80107145:	6a 00                	push   $0x0
  pushl $0
80107147:	6a 00                	push   $0x0
  jmp alltraps
80107149:	e9 1d fb ff ff       	jmp    80106c6b <alltraps>

8010714e <vector1>:
.globl vector1
vector1:
  pushl $0
8010714e:	6a 00                	push   $0x0
  pushl $1
80107150:	6a 01                	push   $0x1
  jmp alltraps
80107152:	e9 14 fb ff ff       	jmp    80106c6b <alltraps>

80107157 <vector2>:
.globl vector2
vector2:
  pushl $0
80107157:	6a 00                	push   $0x0
  pushl $2
80107159:	6a 02                	push   $0x2
  jmp alltraps
8010715b:	e9 0b fb ff ff       	jmp    80106c6b <alltraps>

80107160 <vector3>:
.globl vector3
vector3:
  pushl $0
80107160:	6a 00                	push   $0x0
  pushl $3
80107162:	6a 03                	push   $0x3
  jmp alltraps
80107164:	e9 02 fb ff ff       	jmp    80106c6b <alltraps>

80107169 <vector4>:
.globl vector4
vector4:
  pushl $0
80107169:	6a 00                	push   $0x0
  pushl $4
8010716b:	6a 04                	push   $0x4
  jmp alltraps
8010716d:	e9 f9 fa ff ff       	jmp    80106c6b <alltraps>

80107172 <vector5>:
.globl vector5
vector5:
  pushl $0
80107172:	6a 00                	push   $0x0
  pushl $5
80107174:	6a 05                	push   $0x5
  jmp alltraps
80107176:	e9 f0 fa ff ff       	jmp    80106c6b <alltraps>

8010717b <vector6>:
.globl vector6
vector6:
  pushl $0
8010717b:	6a 00                	push   $0x0
  pushl $6
8010717d:	6a 06                	push   $0x6
  jmp alltraps
8010717f:	e9 e7 fa ff ff       	jmp    80106c6b <alltraps>

80107184 <vector7>:
.globl vector7
vector7:
  pushl $0
80107184:	6a 00                	push   $0x0
  pushl $7
80107186:	6a 07                	push   $0x7
  jmp alltraps
80107188:	e9 de fa ff ff       	jmp    80106c6b <alltraps>

8010718d <vector8>:
.globl vector8
vector8:
  pushl $8
8010718d:	6a 08                	push   $0x8
  jmp alltraps
8010718f:	e9 d7 fa ff ff       	jmp    80106c6b <alltraps>

80107194 <vector9>:
.globl vector9
vector9:
  pushl $0
80107194:	6a 00                	push   $0x0
  pushl $9
80107196:	6a 09                	push   $0x9
  jmp alltraps
80107198:	e9 ce fa ff ff       	jmp    80106c6b <alltraps>

8010719d <vector10>:
.globl vector10
vector10:
  pushl $10
8010719d:	6a 0a                	push   $0xa
  jmp alltraps
8010719f:	e9 c7 fa ff ff       	jmp    80106c6b <alltraps>

801071a4 <vector11>:
.globl vector11
vector11:
  pushl $11
801071a4:	6a 0b                	push   $0xb
  jmp alltraps
801071a6:	e9 c0 fa ff ff       	jmp    80106c6b <alltraps>

801071ab <vector12>:
.globl vector12
vector12:
  pushl $12
801071ab:	6a 0c                	push   $0xc
  jmp alltraps
801071ad:	e9 b9 fa ff ff       	jmp    80106c6b <alltraps>

801071b2 <vector13>:
.globl vector13
vector13:
  pushl $13
801071b2:	6a 0d                	push   $0xd
  jmp alltraps
801071b4:	e9 b2 fa ff ff       	jmp    80106c6b <alltraps>

801071b9 <vector14>:
.globl vector14
vector14:
  pushl $14
801071b9:	6a 0e                	push   $0xe
  jmp alltraps
801071bb:	e9 ab fa ff ff       	jmp    80106c6b <alltraps>

801071c0 <vector15>:
.globl vector15
vector15:
  pushl $0
801071c0:	6a 00                	push   $0x0
  pushl $15
801071c2:	6a 0f                	push   $0xf
  jmp alltraps
801071c4:	e9 a2 fa ff ff       	jmp    80106c6b <alltraps>

801071c9 <vector16>:
.globl vector16
vector16:
  pushl $0
801071c9:	6a 00                	push   $0x0
  pushl $16
801071cb:	6a 10                	push   $0x10
  jmp alltraps
801071cd:	e9 99 fa ff ff       	jmp    80106c6b <alltraps>

801071d2 <vector17>:
.globl vector17
vector17:
  pushl $17
801071d2:	6a 11                	push   $0x11
  jmp alltraps
801071d4:	e9 92 fa ff ff       	jmp    80106c6b <alltraps>

801071d9 <vector18>:
.globl vector18
vector18:
  pushl $0
801071d9:	6a 00                	push   $0x0
  pushl $18
801071db:	6a 12                	push   $0x12
  jmp alltraps
801071dd:	e9 89 fa ff ff       	jmp    80106c6b <alltraps>

801071e2 <vector19>:
.globl vector19
vector19:
  pushl $0
801071e2:	6a 00                	push   $0x0
  pushl $19
801071e4:	6a 13                	push   $0x13
  jmp alltraps
801071e6:	e9 80 fa ff ff       	jmp    80106c6b <alltraps>

801071eb <vector20>:
.globl vector20
vector20:
  pushl $0
801071eb:	6a 00                	push   $0x0
  pushl $20
801071ed:	6a 14                	push   $0x14
  jmp alltraps
801071ef:	e9 77 fa ff ff       	jmp    80106c6b <alltraps>

801071f4 <vector21>:
.globl vector21
vector21:
  pushl $0
801071f4:	6a 00                	push   $0x0
  pushl $21
801071f6:	6a 15                	push   $0x15
  jmp alltraps
801071f8:	e9 6e fa ff ff       	jmp    80106c6b <alltraps>

801071fd <vector22>:
.globl vector22
vector22:
  pushl $0
801071fd:	6a 00                	push   $0x0
  pushl $22
801071ff:	6a 16                	push   $0x16
  jmp alltraps
80107201:	e9 65 fa ff ff       	jmp    80106c6b <alltraps>

80107206 <vector23>:
.globl vector23
vector23:
  pushl $0
80107206:	6a 00                	push   $0x0
  pushl $23
80107208:	6a 17                	push   $0x17
  jmp alltraps
8010720a:	e9 5c fa ff ff       	jmp    80106c6b <alltraps>

8010720f <vector24>:
.globl vector24
vector24:
  pushl $0
8010720f:	6a 00                	push   $0x0
  pushl $24
80107211:	6a 18                	push   $0x18
  jmp alltraps
80107213:	e9 53 fa ff ff       	jmp    80106c6b <alltraps>

80107218 <vector25>:
.globl vector25
vector25:
  pushl $0
80107218:	6a 00                	push   $0x0
  pushl $25
8010721a:	6a 19                	push   $0x19
  jmp alltraps
8010721c:	e9 4a fa ff ff       	jmp    80106c6b <alltraps>

80107221 <vector26>:
.globl vector26
vector26:
  pushl $0
80107221:	6a 00                	push   $0x0
  pushl $26
80107223:	6a 1a                	push   $0x1a
  jmp alltraps
80107225:	e9 41 fa ff ff       	jmp    80106c6b <alltraps>

8010722a <vector27>:
.globl vector27
vector27:
  pushl $0
8010722a:	6a 00                	push   $0x0
  pushl $27
8010722c:	6a 1b                	push   $0x1b
  jmp alltraps
8010722e:	e9 38 fa ff ff       	jmp    80106c6b <alltraps>

80107233 <vector28>:
.globl vector28
vector28:
  pushl $0
80107233:	6a 00                	push   $0x0
  pushl $28
80107235:	6a 1c                	push   $0x1c
  jmp alltraps
80107237:	e9 2f fa ff ff       	jmp    80106c6b <alltraps>

8010723c <vector29>:
.globl vector29
vector29:
  pushl $0
8010723c:	6a 00                	push   $0x0
  pushl $29
8010723e:	6a 1d                	push   $0x1d
  jmp alltraps
80107240:	e9 26 fa ff ff       	jmp    80106c6b <alltraps>

80107245 <vector30>:
.globl vector30
vector30:
  pushl $0
80107245:	6a 00                	push   $0x0
  pushl $30
80107247:	6a 1e                	push   $0x1e
  jmp alltraps
80107249:	e9 1d fa ff ff       	jmp    80106c6b <alltraps>

8010724e <vector31>:
.globl vector31
vector31:
  pushl $0
8010724e:	6a 00                	push   $0x0
  pushl $31
80107250:	6a 1f                	push   $0x1f
  jmp alltraps
80107252:	e9 14 fa ff ff       	jmp    80106c6b <alltraps>

80107257 <vector32>:
.globl vector32
vector32:
  pushl $0
80107257:	6a 00                	push   $0x0
  pushl $32
80107259:	6a 20                	push   $0x20
  jmp alltraps
8010725b:	e9 0b fa ff ff       	jmp    80106c6b <alltraps>

80107260 <vector33>:
.globl vector33
vector33:
  pushl $0
80107260:	6a 00                	push   $0x0
  pushl $33
80107262:	6a 21                	push   $0x21
  jmp alltraps
80107264:	e9 02 fa ff ff       	jmp    80106c6b <alltraps>

80107269 <vector34>:
.globl vector34
vector34:
  pushl $0
80107269:	6a 00                	push   $0x0
  pushl $34
8010726b:	6a 22                	push   $0x22
  jmp alltraps
8010726d:	e9 f9 f9 ff ff       	jmp    80106c6b <alltraps>

80107272 <vector35>:
.globl vector35
vector35:
  pushl $0
80107272:	6a 00                	push   $0x0
  pushl $35
80107274:	6a 23                	push   $0x23
  jmp alltraps
80107276:	e9 f0 f9 ff ff       	jmp    80106c6b <alltraps>

8010727b <vector36>:
.globl vector36
vector36:
  pushl $0
8010727b:	6a 00                	push   $0x0
  pushl $36
8010727d:	6a 24                	push   $0x24
  jmp alltraps
8010727f:	e9 e7 f9 ff ff       	jmp    80106c6b <alltraps>

80107284 <vector37>:
.globl vector37
vector37:
  pushl $0
80107284:	6a 00                	push   $0x0
  pushl $37
80107286:	6a 25                	push   $0x25
  jmp alltraps
80107288:	e9 de f9 ff ff       	jmp    80106c6b <alltraps>

8010728d <vector38>:
.globl vector38
vector38:
  pushl $0
8010728d:	6a 00                	push   $0x0
  pushl $38
8010728f:	6a 26                	push   $0x26
  jmp alltraps
80107291:	e9 d5 f9 ff ff       	jmp    80106c6b <alltraps>

80107296 <vector39>:
.globl vector39
vector39:
  pushl $0
80107296:	6a 00                	push   $0x0
  pushl $39
80107298:	6a 27                	push   $0x27
  jmp alltraps
8010729a:	e9 cc f9 ff ff       	jmp    80106c6b <alltraps>

8010729f <vector40>:
.globl vector40
vector40:
  pushl $0
8010729f:	6a 00                	push   $0x0
  pushl $40
801072a1:	6a 28                	push   $0x28
  jmp alltraps
801072a3:	e9 c3 f9 ff ff       	jmp    80106c6b <alltraps>

801072a8 <vector41>:
.globl vector41
vector41:
  pushl $0
801072a8:	6a 00                	push   $0x0
  pushl $41
801072aa:	6a 29                	push   $0x29
  jmp alltraps
801072ac:	e9 ba f9 ff ff       	jmp    80106c6b <alltraps>

801072b1 <vector42>:
.globl vector42
vector42:
  pushl $0
801072b1:	6a 00                	push   $0x0
  pushl $42
801072b3:	6a 2a                	push   $0x2a
  jmp alltraps
801072b5:	e9 b1 f9 ff ff       	jmp    80106c6b <alltraps>

801072ba <vector43>:
.globl vector43
vector43:
  pushl $0
801072ba:	6a 00                	push   $0x0
  pushl $43
801072bc:	6a 2b                	push   $0x2b
  jmp alltraps
801072be:	e9 a8 f9 ff ff       	jmp    80106c6b <alltraps>

801072c3 <vector44>:
.globl vector44
vector44:
  pushl $0
801072c3:	6a 00                	push   $0x0
  pushl $44
801072c5:	6a 2c                	push   $0x2c
  jmp alltraps
801072c7:	e9 9f f9 ff ff       	jmp    80106c6b <alltraps>

801072cc <vector45>:
.globl vector45
vector45:
  pushl $0
801072cc:	6a 00                	push   $0x0
  pushl $45
801072ce:	6a 2d                	push   $0x2d
  jmp alltraps
801072d0:	e9 96 f9 ff ff       	jmp    80106c6b <alltraps>

801072d5 <vector46>:
.globl vector46
vector46:
  pushl $0
801072d5:	6a 00                	push   $0x0
  pushl $46
801072d7:	6a 2e                	push   $0x2e
  jmp alltraps
801072d9:	e9 8d f9 ff ff       	jmp    80106c6b <alltraps>

801072de <vector47>:
.globl vector47
vector47:
  pushl $0
801072de:	6a 00                	push   $0x0
  pushl $47
801072e0:	6a 2f                	push   $0x2f
  jmp alltraps
801072e2:	e9 84 f9 ff ff       	jmp    80106c6b <alltraps>

801072e7 <vector48>:
.globl vector48
vector48:
  pushl $0
801072e7:	6a 00                	push   $0x0
  pushl $48
801072e9:	6a 30                	push   $0x30
  jmp alltraps
801072eb:	e9 7b f9 ff ff       	jmp    80106c6b <alltraps>

801072f0 <vector49>:
.globl vector49
vector49:
  pushl $0
801072f0:	6a 00                	push   $0x0
  pushl $49
801072f2:	6a 31                	push   $0x31
  jmp alltraps
801072f4:	e9 72 f9 ff ff       	jmp    80106c6b <alltraps>

801072f9 <vector50>:
.globl vector50
vector50:
  pushl $0
801072f9:	6a 00                	push   $0x0
  pushl $50
801072fb:	6a 32                	push   $0x32
  jmp alltraps
801072fd:	e9 69 f9 ff ff       	jmp    80106c6b <alltraps>

80107302 <vector51>:
.globl vector51
vector51:
  pushl $0
80107302:	6a 00                	push   $0x0
  pushl $51
80107304:	6a 33                	push   $0x33
  jmp alltraps
80107306:	e9 60 f9 ff ff       	jmp    80106c6b <alltraps>

8010730b <vector52>:
.globl vector52
vector52:
  pushl $0
8010730b:	6a 00                	push   $0x0
  pushl $52
8010730d:	6a 34                	push   $0x34
  jmp alltraps
8010730f:	e9 57 f9 ff ff       	jmp    80106c6b <alltraps>

80107314 <vector53>:
.globl vector53
vector53:
  pushl $0
80107314:	6a 00                	push   $0x0
  pushl $53
80107316:	6a 35                	push   $0x35
  jmp alltraps
80107318:	e9 4e f9 ff ff       	jmp    80106c6b <alltraps>

8010731d <vector54>:
.globl vector54
vector54:
  pushl $0
8010731d:	6a 00                	push   $0x0
  pushl $54
8010731f:	6a 36                	push   $0x36
  jmp alltraps
80107321:	e9 45 f9 ff ff       	jmp    80106c6b <alltraps>

80107326 <vector55>:
.globl vector55
vector55:
  pushl $0
80107326:	6a 00                	push   $0x0
  pushl $55
80107328:	6a 37                	push   $0x37
  jmp alltraps
8010732a:	e9 3c f9 ff ff       	jmp    80106c6b <alltraps>

8010732f <vector56>:
.globl vector56
vector56:
  pushl $0
8010732f:	6a 00                	push   $0x0
  pushl $56
80107331:	6a 38                	push   $0x38
  jmp alltraps
80107333:	e9 33 f9 ff ff       	jmp    80106c6b <alltraps>

80107338 <vector57>:
.globl vector57
vector57:
  pushl $0
80107338:	6a 00                	push   $0x0
  pushl $57
8010733a:	6a 39                	push   $0x39
  jmp alltraps
8010733c:	e9 2a f9 ff ff       	jmp    80106c6b <alltraps>

80107341 <vector58>:
.globl vector58
vector58:
  pushl $0
80107341:	6a 00                	push   $0x0
  pushl $58
80107343:	6a 3a                	push   $0x3a
  jmp alltraps
80107345:	e9 21 f9 ff ff       	jmp    80106c6b <alltraps>

8010734a <vector59>:
.globl vector59
vector59:
  pushl $0
8010734a:	6a 00                	push   $0x0
  pushl $59
8010734c:	6a 3b                	push   $0x3b
  jmp alltraps
8010734e:	e9 18 f9 ff ff       	jmp    80106c6b <alltraps>

80107353 <vector60>:
.globl vector60
vector60:
  pushl $0
80107353:	6a 00                	push   $0x0
  pushl $60
80107355:	6a 3c                	push   $0x3c
  jmp alltraps
80107357:	e9 0f f9 ff ff       	jmp    80106c6b <alltraps>

8010735c <vector61>:
.globl vector61
vector61:
  pushl $0
8010735c:	6a 00                	push   $0x0
  pushl $61
8010735e:	6a 3d                	push   $0x3d
  jmp alltraps
80107360:	e9 06 f9 ff ff       	jmp    80106c6b <alltraps>

80107365 <vector62>:
.globl vector62
vector62:
  pushl $0
80107365:	6a 00                	push   $0x0
  pushl $62
80107367:	6a 3e                	push   $0x3e
  jmp alltraps
80107369:	e9 fd f8 ff ff       	jmp    80106c6b <alltraps>

8010736e <vector63>:
.globl vector63
vector63:
  pushl $0
8010736e:	6a 00                	push   $0x0
  pushl $63
80107370:	6a 3f                	push   $0x3f
  jmp alltraps
80107372:	e9 f4 f8 ff ff       	jmp    80106c6b <alltraps>

80107377 <vector64>:
.globl vector64
vector64:
  pushl $0
80107377:	6a 00                	push   $0x0
  pushl $64
80107379:	6a 40                	push   $0x40
  jmp alltraps
8010737b:	e9 eb f8 ff ff       	jmp    80106c6b <alltraps>

80107380 <vector65>:
.globl vector65
vector65:
  pushl $0
80107380:	6a 00                	push   $0x0
  pushl $65
80107382:	6a 41                	push   $0x41
  jmp alltraps
80107384:	e9 e2 f8 ff ff       	jmp    80106c6b <alltraps>

80107389 <vector66>:
.globl vector66
vector66:
  pushl $0
80107389:	6a 00                	push   $0x0
  pushl $66
8010738b:	6a 42                	push   $0x42
  jmp alltraps
8010738d:	e9 d9 f8 ff ff       	jmp    80106c6b <alltraps>

80107392 <vector67>:
.globl vector67
vector67:
  pushl $0
80107392:	6a 00                	push   $0x0
  pushl $67
80107394:	6a 43                	push   $0x43
  jmp alltraps
80107396:	e9 d0 f8 ff ff       	jmp    80106c6b <alltraps>

8010739b <vector68>:
.globl vector68
vector68:
  pushl $0
8010739b:	6a 00                	push   $0x0
  pushl $68
8010739d:	6a 44                	push   $0x44
  jmp alltraps
8010739f:	e9 c7 f8 ff ff       	jmp    80106c6b <alltraps>

801073a4 <vector69>:
.globl vector69
vector69:
  pushl $0
801073a4:	6a 00                	push   $0x0
  pushl $69
801073a6:	6a 45                	push   $0x45
  jmp alltraps
801073a8:	e9 be f8 ff ff       	jmp    80106c6b <alltraps>

801073ad <vector70>:
.globl vector70
vector70:
  pushl $0
801073ad:	6a 00                	push   $0x0
  pushl $70
801073af:	6a 46                	push   $0x46
  jmp alltraps
801073b1:	e9 b5 f8 ff ff       	jmp    80106c6b <alltraps>

801073b6 <vector71>:
.globl vector71
vector71:
  pushl $0
801073b6:	6a 00                	push   $0x0
  pushl $71
801073b8:	6a 47                	push   $0x47
  jmp alltraps
801073ba:	e9 ac f8 ff ff       	jmp    80106c6b <alltraps>

801073bf <vector72>:
.globl vector72
vector72:
  pushl $0
801073bf:	6a 00                	push   $0x0
  pushl $72
801073c1:	6a 48                	push   $0x48
  jmp alltraps
801073c3:	e9 a3 f8 ff ff       	jmp    80106c6b <alltraps>

801073c8 <vector73>:
.globl vector73
vector73:
  pushl $0
801073c8:	6a 00                	push   $0x0
  pushl $73
801073ca:	6a 49                	push   $0x49
  jmp alltraps
801073cc:	e9 9a f8 ff ff       	jmp    80106c6b <alltraps>

801073d1 <vector74>:
.globl vector74
vector74:
  pushl $0
801073d1:	6a 00                	push   $0x0
  pushl $74
801073d3:	6a 4a                	push   $0x4a
  jmp alltraps
801073d5:	e9 91 f8 ff ff       	jmp    80106c6b <alltraps>

801073da <vector75>:
.globl vector75
vector75:
  pushl $0
801073da:	6a 00                	push   $0x0
  pushl $75
801073dc:	6a 4b                	push   $0x4b
  jmp alltraps
801073de:	e9 88 f8 ff ff       	jmp    80106c6b <alltraps>

801073e3 <vector76>:
.globl vector76
vector76:
  pushl $0
801073e3:	6a 00                	push   $0x0
  pushl $76
801073e5:	6a 4c                	push   $0x4c
  jmp alltraps
801073e7:	e9 7f f8 ff ff       	jmp    80106c6b <alltraps>

801073ec <vector77>:
.globl vector77
vector77:
  pushl $0
801073ec:	6a 00                	push   $0x0
  pushl $77
801073ee:	6a 4d                	push   $0x4d
  jmp alltraps
801073f0:	e9 76 f8 ff ff       	jmp    80106c6b <alltraps>

801073f5 <vector78>:
.globl vector78
vector78:
  pushl $0
801073f5:	6a 00                	push   $0x0
  pushl $78
801073f7:	6a 4e                	push   $0x4e
  jmp alltraps
801073f9:	e9 6d f8 ff ff       	jmp    80106c6b <alltraps>

801073fe <vector79>:
.globl vector79
vector79:
  pushl $0
801073fe:	6a 00                	push   $0x0
  pushl $79
80107400:	6a 4f                	push   $0x4f
  jmp alltraps
80107402:	e9 64 f8 ff ff       	jmp    80106c6b <alltraps>

80107407 <vector80>:
.globl vector80
vector80:
  pushl $0
80107407:	6a 00                	push   $0x0
  pushl $80
80107409:	6a 50                	push   $0x50
  jmp alltraps
8010740b:	e9 5b f8 ff ff       	jmp    80106c6b <alltraps>

80107410 <vector81>:
.globl vector81
vector81:
  pushl $0
80107410:	6a 00                	push   $0x0
  pushl $81
80107412:	6a 51                	push   $0x51
  jmp alltraps
80107414:	e9 52 f8 ff ff       	jmp    80106c6b <alltraps>

80107419 <vector82>:
.globl vector82
vector82:
  pushl $0
80107419:	6a 00                	push   $0x0
  pushl $82
8010741b:	6a 52                	push   $0x52
  jmp alltraps
8010741d:	e9 49 f8 ff ff       	jmp    80106c6b <alltraps>

80107422 <vector83>:
.globl vector83
vector83:
  pushl $0
80107422:	6a 00                	push   $0x0
  pushl $83
80107424:	6a 53                	push   $0x53
  jmp alltraps
80107426:	e9 40 f8 ff ff       	jmp    80106c6b <alltraps>

8010742b <vector84>:
.globl vector84
vector84:
  pushl $0
8010742b:	6a 00                	push   $0x0
  pushl $84
8010742d:	6a 54                	push   $0x54
  jmp alltraps
8010742f:	e9 37 f8 ff ff       	jmp    80106c6b <alltraps>

80107434 <vector85>:
.globl vector85
vector85:
  pushl $0
80107434:	6a 00                	push   $0x0
  pushl $85
80107436:	6a 55                	push   $0x55
  jmp alltraps
80107438:	e9 2e f8 ff ff       	jmp    80106c6b <alltraps>

8010743d <vector86>:
.globl vector86
vector86:
  pushl $0
8010743d:	6a 00                	push   $0x0
  pushl $86
8010743f:	6a 56                	push   $0x56
  jmp alltraps
80107441:	e9 25 f8 ff ff       	jmp    80106c6b <alltraps>

80107446 <vector87>:
.globl vector87
vector87:
  pushl $0
80107446:	6a 00                	push   $0x0
  pushl $87
80107448:	6a 57                	push   $0x57
  jmp alltraps
8010744a:	e9 1c f8 ff ff       	jmp    80106c6b <alltraps>

8010744f <vector88>:
.globl vector88
vector88:
  pushl $0
8010744f:	6a 00                	push   $0x0
  pushl $88
80107451:	6a 58                	push   $0x58
  jmp alltraps
80107453:	e9 13 f8 ff ff       	jmp    80106c6b <alltraps>

80107458 <vector89>:
.globl vector89
vector89:
  pushl $0
80107458:	6a 00                	push   $0x0
  pushl $89
8010745a:	6a 59                	push   $0x59
  jmp alltraps
8010745c:	e9 0a f8 ff ff       	jmp    80106c6b <alltraps>

80107461 <vector90>:
.globl vector90
vector90:
  pushl $0
80107461:	6a 00                	push   $0x0
  pushl $90
80107463:	6a 5a                	push   $0x5a
  jmp alltraps
80107465:	e9 01 f8 ff ff       	jmp    80106c6b <alltraps>

8010746a <vector91>:
.globl vector91
vector91:
  pushl $0
8010746a:	6a 00                	push   $0x0
  pushl $91
8010746c:	6a 5b                	push   $0x5b
  jmp alltraps
8010746e:	e9 f8 f7 ff ff       	jmp    80106c6b <alltraps>

80107473 <vector92>:
.globl vector92
vector92:
  pushl $0
80107473:	6a 00                	push   $0x0
  pushl $92
80107475:	6a 5c                	push   $0x5c
  jmp alltraps
80107477:	e9 ef f7 ff ff       	jmp    80106c6b <alltraps>

8010747c <vector93>:
.globl vector93
vector93:
  pushl $0
8010747c:	6a 00                	push   $0x0
  pushl $93
8010747e:	6a 5d                	push   $0x5d
  jmp alltraps
80107480:	e9 e6 f7 ff ff       	jmp    80106c6b <alltraps>

80107485 <vector94>:
.globl vector94
vector94:
  pushl $0
80107485:	6a 00                	push   $0x0
  pushl $94
80107487:	6a 5e                	push   $0x5e
  jmp alltraps
80107489:	e9 dd f7 ff ff       	jmp    80106c6b <alltraps>

8010748e <vector95>:
.globl vector95
vector95:
  pushl $0
8010748e:	6a 00                	push   $0x0
  pushl $95
80107490:	6a 5f                	push   $0x5f
  jmp alltraps
80107492:	e9 d4 f7 ff ff       	jmp    80106c6b <alltraps>

80107497 <vector96>:
.globl vector96
vector96:
  pushl $0
80107497:	6a 00                	push   $0x0
  pushl $96
80107499:	6a 60                	push   $0x60
  jmp alltraps
8010749b:	e9 cb f7 ff ff       	jmp    80106c6b <alltraps>

801074a0 <vector97>:
.globl vector97
vector97:
  pushl $0
801074a0:	6a 00                	push   $0x0
  pushl $97
801074a2:	6a 61                	push   $0x61
  jmp alltraps
801074a4:	e9 c2 f7 ff ff       	jmp    80106c6b <alltraps>

801074a9 <vector98>:
.globl vector98
vector98:
  pushl $0
801074a9:	6a 00                	push   $0x0
  pushl $98
801074ab:	6a 62                	push   $0x62
  jmp alltraps
801074ad:	e9 b9 f7 ff ff       	jmp    80106c6b <alltraps>

801074b2 <vector99>:
.globl vector99
vector99:
  pushl $0
801074b2:	6a 00                	push   $0x0
  pushl $99
801074b4:	6a 63                	push   $0x63
  jmp alltraps
801074b6:	e9 b0 f7 ff ff       	jmp    80106c6b <alltraps>

801074bb <vector100>:
.globl vector100
vector100:
  pushl $0
801074bb:	6a 00                	push   $0x0
  pushl $100
801074bd:	6a 64                	push   $0x64
  jmp alltraps
801074bf:	e9 a7 f7 ff ff       	jmp    80106c6b <alltraps>

801074c4 <vector101>:
.globl vector101
vector101:
  pushl $0
801074c4:	6a 00                	push   $0x0
  pushl $101
801074c6:	6a 65                	push   $0x65
  jmp alltraps
801074c8:	e9 9e f7 ff ff       	jmp    80106c6b <alltraps>

801074cd <vector102>:
.globl vector102
vector102:
  pushl $0
801074cd:	6a 00                	push   $0x0
  pushl $102
801074cf:	6a 66                	push   $0x66
  jmp alltraps
801074d1:	e9 95 f7 ff ff       	jmp    80106c6b <alltraps>

801074d6 <vector103>:
.globl vector103
vector103:
  pushl $0
801074d6:	6a 00                	push   $0x0
  pushl $103
801074d8:	6a 67                	push   $0x67
  jmp alltraps
801074da:	e9 8c f7 ff ff       	jmp    80106c6b <alltraps>

801074df <vector104>:
.globl vector104
vector104:
  pushl $0
801074df:	6a 00                	push   $0x0
  pushl $104
801074e1:	6a 68                	push   $0x68
  jmp alltraps
801074e3:	e9 83 f7 ff ff       	jmp    80106c6b <alltraps>

801074e8 <vector105>:
.globl vector105
vector105:
  pushl $0
801074e8:	6a 00                	push   $0x0
  pushl $105
801074ea:	6a 69                	push   $0x69
  jmp alltraps
801074ec:	e9 7a f7 ff ff       	jmp    80106c6b <alltraps>

801074f1 <vector106>:
.globl vector106
vector106:
  pushl $0
801074f1:	6a 00                	push   $0x0
  pushl $106
801074f3:	6a 6a                	push   $0x6a
  jmp alltraps
801074f5:	e9 71 f7 ff ff       	jmp    80106c6b <alltraps>

801074fa <vector107>:
.globl vector107
vector107:
  pushl $0
801074fa:	6a 00                	push   $0x0
  pushl $107
801074fc:	6a 6b                	push   $0x6b
  jmp alltraps
801074fe:	e9 68 f7 ff ff       	jmp    80106c6b <alltraps>

80107503 <vector108>:
.globl vector108
vector108:
  pushl $0
80107503:	6a 00                	push   $0x0
  pushl $108
80107505:	6a 6c                	push   $0x6c
  jmp alltraps
80107507:	e9 5f f7 ff ff       	jmp    80106c6b <alltraps>

8010750c <vector109>:
.globl vector109
vector109:
  pushl $0
8010750c:	6a 00                	push   $0x0
  pushl $109
8010750e:	6a 6d                	push   $0x6d
  jmp alltraps
80107510:	e9 56 f7 ff ff       	jmp    80106c6b <alltraps>

80107515 <vector110>:
.globl vector110
vector110:
  pushl $0
80107515:	6a 00                	push   $0x0
  pushl $110
80107517:	6a 6e                	push   $0x6e
  jmp alltraps
80107519:	e9 4d f7 ff ff       	jmp    80106c6b <alltraps>

8010751e <vector111>:
.globl vector111
vector111:
  pushl $0
8010751e:	6a 00                	push   $0x0
  pushl $111
80107520:	6a 6f                	push   $0x6f
  jmp alltraps
80107522:	e9 44 f7 ff ff       	jmp    80106c6b <alltraps>

80107527 <vector112>:
.globl vector112
vector112:
  pushl $0
80107527:	6a 00                	push   $0x0
  pushl $112
80107529:	6a 70                	push   $0x70
  jmp alltraps
8010752b:	e9 3b f7 ff ff       	jmp    80106c6b <alltraps>

80107530 <vector113>:
.globl vector113
vector113:
  pushl $0
80107530:	6a 00                	push   $0x0
  pushl $113
80107532:	6a 71                	push   $0x71
  jmp alltraps
80107534:	e9 32 f7 ff ff       	jmp    80106c6b <alltraps>

80107539 <vector114>:
.globl vector114
vector114:
  pushl $0
80107539:	6a 00                	push   $0x0
  pushl $114
8010753b:	6a 72                	push   $0x72
  jmp alltraps
8010753d:	e9 29 f7 ff ff       	jmp    80106c6b <alltraps>

80107542 <vector115>:
.globl vector115
vector115:
  pushl $0
80107542:	6a 00                	push   $0x0
  pushl $115
80107544:	6a 73                	push   $0x73
  jmp alltraps
80107546:	e9 20 f7 ff ff       	jmp    80106c6b <alltraps>

8010754b <vector116>:
.globl vector116
vector116:
  pushl $0
8010754b:	6a 00                	push   $0x0
  pushl $116
8010754d:	6a 74                	push   $0x74
  jmp alltraps
8010754f:	e9 17 f7 ff ff       	jmp    80106c6b <alltraps>

80107554 <vector117>:
.globl vector117
vector117:
  pushl $0
80107554:	6a 00                	push   $0x0
  pushl $117
80107556:	6a 75                	push   $0x75
  jmp alltraps
80107558:	e9 0e f7 ff ff       	jmp    80106c6b <alltraps>

8010755d <vector118>:
.globl vector118
vector118:
  pushl $0
8010755d:	6a 00                	push   $0x0
  pushl $118
8010755f:	6a 76                	push   $0x76
  jmp alltraps
80107561:	e9 05 f7 ff ff       	jmp    80106c6b <alltraps>

80107566 <vector119>:
.globl vector119
vector119:
  pushl $0
80107566:	6a 00                	push   $0x0
  pushl $119
80107568:	6a 77                	push   $0x77
  jmp alltraps
8010756a:	e9 fc f6 ff ff       	jmp    80106c6b <alltraps>

8010756f <vector120>:
.globl vector120
vector120:
  pushl $0
8010756f:	6a 00                	push   $0x0
  pushl $120
80107571:	6a 78                	push   $0x78
  jmp alltraps
80107573:	e9 f3 f6 ff ff       	jmp    80106c6b <alltraps>

80107578 <vector121>:
.globl vector121
vector121:
  pushl $0
80107578:	6a 00                	push   $0x0
  pushl $121
8010757a:	6a 79                	push   $0x79
  jmp alltraps
8010757c:	e9 ea f6 ff ff       	jmp    80106c6b <alltraps>

80107581 <vector122>:
.globl vector122
vector122:
  pushl $0
80107581:	6a 00                	push   $0x0
  pushl $122
80107583:	6a 7a                	push   $0x7a
  jmp alltraps
80107585:	e9 e1 f6 ff ff       	jmp    80106c6b <alltraps>

8010758a <vector123>:
.globl vector123
vector123:
  pushl $0
8010758a:	6a 00                	push   $0x0
  pushl $123
8010758c:	6a 7b                	push   $0x7b
  jmp alltraps
8010758e:	e9 d8 f6 ff ff       	jmp    80106c6b <alltraps>

80107593 <vector124>:
.globl vector124
vector124:
  pushl $0
80107593:	6a 00                	push   $0x0
  pushl $124
80107595:	6a 7c                	push   $0x7c
  jmp alltraps
80107597:	e9 cf f6 ff ff       	jmp    80106c6b <alltraps>

8010759c <vector125>:
.globl vector125
vector125:
  pushl $0
8010759c:	6a 00                	push   $0x0
  pushl $125
8010759e:	6a 7d                	push   $0x7d
  jmp alltraps
801075a0:	e9 c6 f6 ff ff       	jmp    80106c6b <alltraps>

801075a5 <vector126>:
.globl vector126
vector126:
  pushl $0
801075a5:	6a 00                	push   $0x0
  pushl $126
801075a7:	6a 7e                	push   $0x7e
  jmp alltraps
801075a9:	e9 bd f6 ff ff       	jmp    80106c6b <alltraps>

801075ae <vector127>:
.globl vector127
vector127:
  pushl $0
801075ae:	6a 00                	push   $0x0
  pushl $127
801075b0:	6a 7f                	push   $0x7f
  jmp alltraps
801075b2:	e9 b4 f6 ff ff       	jmp    80106c6b <alltraps>

801075b7 <vector128>:
.globl vector128
vector128:
  pushl $0
801075b7:	6a 00                	push   $0x0
  pushl $128
801075b9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801075be:	e9 a8 f6 ff ff       	jmp    80106c6b <alltraps>

801075c3 <vector129>:
.globl vector129
vector129:
  pushl $0
801075c3:	6a 00                	push   $0x0
  pushl $129
801075c5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801075ca:	e9 9c f6 ff ff       	jmp    80106c6b <alltraps>

801075cf <vector130>:
.globl vector130
vector130:
  pushl $0
801075cf:	6a 00                	push   $0x0
  pushl $130
801075d1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801075d6:	e9 90 f6 ff ff       	jmp    80106c6b <alltraps>

801075db <vector131>:
.globl vector131
vector131:
  pushl $0
801075db:	6a 00                	push   $0x0
  pushl $131
801075dd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801075e2:	e9 84 f6 ff ff       	jmp    80106c6b <alltraps>

801075e7 <vector132>:
.globl vector132
vector132:
  pushl $0
801075e7:	6a 00                	push   $0x0
  pushl $132
801075e9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801075ee:	e9 78 f6 ff ff       	jmp    80106c6b <alltraps>

801075f3 <vector133>:
.globl vector133
vector133:
  pushl $0
801075f3:	6a 00                	push   $0x0
  pushl $133
801075f5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801075fa:	e9 6c f6 ff ff       	jmp    80106c6b <alltraps>

801075ff <vector134>:
.globl vector134
vector134:
  pushl $0
801075ff:	6a 00                	push   $0x0
  pushl $134
80107601:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107606:	e9 60 f6 ff ff       	jmp    80106c6b <alltraps>

8010760b <vector135>:
.globl vector135
vector135:
  pushl $0
8010760b:	6a 00                	push   $0x0
  pushl $135
8010760d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107612:	e9 54 f6 ff ff       	jmp    80106c6b <alltraps>

80107617 <vector136>:
.globl vector136
vector136:
  pushl $0
80107617:	6a 00                	push   $0x0
  pushl $136
80107619:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010761e:	e9 48 f6 ff ff       	jmp    80106c6b <alltraps>

80107623 <vector137>:
.globl vector137
vector137:
  pushl $0
80107623:	6a 00                	push   $0x0
  pushl $137
80107625:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010762a:	e9 3c f6 ff ff       	jmp    80106c6b <alltraps>

8010762f <vector138>:
.globl vector138
vector138:
  pushl $0
8010762f:	6a 00                	push   $0x0
  pushl $138
80107631:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107636:	e9 30 f6 ff ff       	jmp    80106c6b <alltraps>

8010763b <vector139>:
.globl vector139
vector139:
  pushl $0
8010763b:	6a 00                	push   $0x0
  pushl $139
8010763d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80107642:	e9 24 f6 ff ff       	jmp    80106c6b <alltraps>

80107647 <vector140>:
.globl vector140
vector140:
  pushl $0
80107647:	6a 00                	push   $0x0
  pushl $140
80107649:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010764e:	e9 18 f6 ff ff       	jmp    80106c6b <alltraps>

80107653 <vector141>:
.globl vector141
vector141:
  pushl $0
80107653:	6a 00                	push   $0x0
  pushl $141
80107655:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010765a:	e9 0c f6 ff ff       	jmp    80106c6b <alltraps>

8010765f <vector142>:
.globl vector142
vector142:
  pushl $0
8010765f:	6a 00                	push   $0x0
  pushl $142
80107661:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80107666:	e9 00 f6 ff ff       	jmp    80106c6b <alltraps>

8010766b <vector143>:
.globl vector143
vector143:
  pushl $0
8010766b:	6a 00                	push   $0x0
  pushl $143
8010766d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80107672:	e9 f4 f5 ff ff       	jmp    80106c6b <alltraps>

80107677 <vector144>:
.globl vector144
vector144:
  pushl $0
80107677:	6a 00                	push   $0x0
  pushl $144
80107679:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010767e:	e9 e8 f5 ff ff       	jmp    80106c6b <alltraps>

80107683 <vector145>:
.globl vector145
vector145:
  pushl $0
80107683:	6a 00                	push   $0x0
  pushl $145
80107685:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010768a:	e9 dc f5 ff ff       	jmp    80106c6b <alltraps>

8010768f <vector146>:
.globl vector146
vector146:
  pushl $0
8010768f:	6a 00                	push   $0x0
  pushl $146
80107691:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107696:	e9 d0 f5 ff ff       	jmp    80106c6b <alltraps>

8010769b <vector147>:
.globl vector147
vector147:
  pushl $0
8010769b:	6a 00                	push   $0x0
  pushl $147
8010769d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801076a2:	e9 c4 f5 ff ff       	jmp    80106c6b <alltraps>

801076a7 <vector148>:
.globl vector148
vector148:
  pushl $0
801076a7:	6a 00                	push   $0x0
  pushl $148
801076a9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801076ae:	e9 b8 f5 ff ff       	jmp    80106c6b <alltraps>

801076b3 <vector149>:
.globl vector149
vector149:
  pushl $0
801076b3:	6a 00                	push   $0x0
  pushl $149
801076b5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801076ba:	e9 ac f5 ff ff       	jmp    80106c6b <alltraps>

801076bf <vector150>:
.globl vector150
vector150:
  pushl $0
801076bf:	6a 00                	push   $0x0
  pushl $150
801076c1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801076c6:	e9 a0 f5 ff ff       	jmp    80106c6b <alltraps>

801076cb <vector151>:
.globl vector151
vector151:
  pushl $0
801076cb:	6a 00                	push   $0x0
  pushl $151
801076cd:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801076d2:	e9 94 f5 ff ff       	jmp    80106c6b <alltraps>

801076d7 <vector152>:
.globl vector152
vector152:
  pushl $0
801076d7:	6a 00                	push   $0x0
  pushl $152
801076d9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801076de:	e9 88 f5 ff ff       	jmp    80106c6b <alltraps>

801076e3 <vector153>:
.globl vector153
vector153:
  pushl $0
801076e3:	6a 00                	push   $0x0
  pushl $153
801076e5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801076ea:	e9 7c f5 ff ff       	jmp    80106c6b <alltraps>

801076ef <vector154>:
.globl vector154
vector154:
  pushl $0
801076ef:	6a 00                	push   $0x0
  pushl $154
801076f1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801076f6:	e9 70 f5 ff ff       	jmp    80106c6b <alltraps>

801076fb <vector155>:
.globl vector155
vector155:
  pushl $0
801076fb:	6a 00                	push   $0x0
  pushl $155
801076fd:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107702:	e9 64 f5 ff ff       	jmp    80106c6b <alltraps>

80107707 <vector156>:
.globl vector156
vector156:
  pushl $0
80107707:	6a 00                	push   $0x0
  pushl $156
80107709:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010770e:	e9 58 f5 ff ff       	jmp    80106c6b <alltraps>

80107713 <vector157>:
.globl vector157
vector157:
  pushl $0
80107713:	6a 00                	push   $0x0
  pushl $157
80107715:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010771a:	e9 4c f5 ff ff       	jmp    80106c6b <alltraps>

8010771f <vector158>:
.globl vector158
vector158:
  pushl $0
8010771f:	6a 00                	push   $0x0
  pushl $158
80107721:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107726:	e9 40 f5 ff ff       	jmp    80106c6b <alltraps>

8010772b <vector159>:
.globl vector159
vector159:
  pushl $0
8010772b:	6a 00                	push   $0x0
  pushl $159
8010772d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80107732:	e9 34 f5 ff ff       	jmp    80106c6b <alltraps>

80107737 <vector160>:
.globl vector160
vector160:
  pushl $0
80107737:	6a 00                	push   $0x0
  pushl $160
80107739:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010773e:	e9 28 f5 ff ff       	jmp    80106c6b <alltraps>

80107743 <vector161>:
.globl vector161
vector161:
  pushl $0
80107743:	6a 00                	push   $0x0
  pushl $161
80107745:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010774a:	e9 1c f5 ff ff       	jmp    80106c6b <alltraps>

8010774f <vector162>:
.globl vector162
vector162:
  pushl $0
8010774f:	6a 00                	push   $0x0
  pushl $162
80107751:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80107756:	e9 10 f5 ff ff       	jmp    80106c6b <alltraps>

8010775b <vector163>:
.globl vector163
vector163:
  pushl $0
8010775b:	6a 00                	push   $0x0
  pushl $163
8010775d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80107762:	e9 04 f5 ff ff       	jmp    80106c6b <alltraps>

80107767 <vector164>:
.globl vector164
vector164:
  pushl $0
80107767:	6a 00                	push   $0x0
  pushl $164
80107769:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010776e:	e9 f8 f4 ff ff       	jmp    80106c6b <alltraps>

80107773 <vector165>:
.globl vector165
vector165:
  pushl $0
80107773:	6a 00                	push   $0x0
  pushl $165
80107775:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010777a:	e9 ec f4 ff ff       	jmp    80106c6b <alltraps>

8010777f <vector166>:
.globl vector166
vector166:
  pushl $0
8010777f:	6a 00                	push   $0x0
  pushl $166
80107781:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107786:	e9 e0 f4 ff ff       	jmp    80106c6b <alltraps>

8010778b <vector167>:
.globl vector167
vector167:
  pushl $0
8010778b:	6a 00                	push   $0x0
  pushl $167
8010778d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107792:	e9 d4 f4 ff ff       	jmp    80106c6b <alltraps>

80107797 <vector168>:
.globl vector168
vector168:
  pushl $0
80107797:	6a 00                	push   $0x0
  pushl $168
80107799:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010779e:	e9 c8 f4 ff ff       	jmp    80106c6b <alltraps>

801077a3 <vector169>:
.globl vector169
vector169:
  pushl $0
801077a3:	6a 00                	push   $0x0
  pushl $169
801077a5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801077aa:	e9 bc f4 ff ff       	jmp    80106c6b <alltraps>

801077af <vector170>:
.globl vector170
vector170:
  pushl $0
801077af:	6a 00                	push   $0x0
  pushl $170
801077b1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801077b6:	e9 b0 f4 ff ff       	jmp    80106c6b <alltraps>

801077bb <vector171>:
.globl vector171
vector171:
  pushl $0
801077bb:	6a 00                	push   $0x0
  pushl $171
801077bd:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801077c2:	e9 a4 f4 ff ff       	jmp    80106c6b <alltraps>

801077c7 <vector172>:
.globl vector172
vector172:
  pushl $0
801077c7:	6a 00                	push   $0x0
  pushl $172
801077c9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801077ce:	e9 98 f4 ff ff       	jmp    80106c6b <alltraps>

801077d3 <vector173>:
.globl vector173
vector173:
  pushl $0
801077d3:	6a 00                	push   $0x0
  pushl $173
801077d5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801077da:	e9 8c f4 ff ff       	jmp    80106c6b <alltraps>

801077df <vector174>:
.globl vector174
vector174:
  pushl $0
801077df:	6a 00                	push   $0x0
  pushl $174
801077e1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801077e6:	e9 80 f4 ff ff       	jmp    80106c6b <alltraps>

801077eb <vector175>:
.globl vector175
vector175:
  pushl $0
801077eb:	6a 00                	push   $0x0
  pushl $175
801077ed:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801077f2:	e9 74 f4 ff ff       	jmp    80106c6b <alltraps>

801077f7 <vector176>:
.globl vector176
vector176:
  pushl $0
801077f7:	6a 00                	push   $0x0
  pushl $176
801077f9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801077fe:	e9 68 f4 ff ff       	jmp    80106c6b <alltraps>

80107803 <vector177>:
.globl vector177
vector177:
  pushl $0
80107803:	6a 00                	push   $0x0
  pushl $177
80107805:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010780a:	e9 5c f4 ff ff       	jmp    80106c6b <alltraps>

8010780f <vector178>:
.globl vector178
vector178:
  pushl $0
8010780f:	6a 00                	push   $0x0
  pushl $178
80107811:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107816:	e9 50 f4 ff ff       	jmp    80106c6b <alltraps>

8010781b <vector179>:
.globl vector179
vector179:
  pushl $0
8010781b:	6a 00                	push   $0x0
  pushl $179
8010781d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107822:	e9 44 f4 ff ff       	jmp    80106c6b <alltraps>

80107827 <vector180>:
.globl vector180
vector180:
  pushl $0
80107827:	6a 00                	push   $0x0
  pushl $180
80107829:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010782e:	e9 38 f4 ff ff       	jmp    80106c6b <alltraps>

80107833 <vector181>:
.globl vector181
vector181:
  pushl $0
80107833:	6a 00                	push   $0x0
  pushl $181
80107835:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010783a:	e9 2c f4 ff ff       	jmp    80106c6b <alltraps>

8010783f <vector182>:
.globl vector182
vector182:
  pushl $0
8010783f:	6a 00                	push   $0x0
  pushl $182
80107841:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107846:	e9 20 f4 ff ff       	jmp    80106c6b <alltraps>

8010784b <vector183>:
.globl vector183
vector183:
  pushl $0
8010784b:	6a 00                	push   $0x0
  pushl $183
8010784d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107852:	e9 14 f4 ff ff       	jmp    80106c6b <alltraps>

80107857 <vector184>:
.globl vector184
vector184:
  pushl $0
80107857:	6a 00                	push   $0x0
  pushl $184
80107859:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010785e:	e9 08 f4 ff ff       	jmp    80106c6b <alltraps>

80107863 <vector185>:
.globl vector185
vector185:
  pushl $0
80107863:	6a 00                	push   $0x0
  pushl $185
80107865:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010786a:	e9 fc f3 ff ff       	jmp    80106c6b <alltraps>

8010786f <vector186>:
.globl vector186
vector186:
  pushl $0
8010786f:	6a 00                	push   $0x0
  pushl $186
80107871:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107876:	e9 f0 f3 ff ff       	jmp    80106c6b <alltraps>

8010787b <vector187>:
.globl vector187
vector187:
  pushl $0
8010787b:	6a 00                	push   $0x0
  pushl $187
8010787d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107882:	e9 e4 f3 ff ff       	jmp    80106c6b <alltraps>

80107887 <vector188>:
.globl vector188
vector188:
  pushl $0
80107887:	6a 00                	push   $0x0
  pushl $188
80107889:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010788e:	e9 d8 f3 ff ff       	jmp    80106c6b <alltraps>

80107893 <vector189>:
.globl vector189
vector189:
  pushl $0
80107893:	6a 00                	push   $0x0
  pushl $189
80107895:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010789a:	e9 cc f3 ff ff       	jmp    80106c6b <alltraps>

8010789f <vector190>:
.globl vector190
vector190:
  pushl $0
8010789f:	6a 00                	push   $0x0
  pushl $190
801078a1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801078a6:	e9 c0 f3 ff ff       	jmp    80106c6b <alltraps>

801078ab <vector191>:
.globl vector191
vector191:
  pushl $0
801078ab:	6a 00                	push   $0x0
  pushl $191
801078ad:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801078b2:	e9 b4 f3 ff ff       	jmp    80106c6b <alltraps>

801078b7 <vector192>:
.globl vector192
vector192:
  pushl $0
801078b7:	6a 00                	push   $0x0
  pushl $192
801078b9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801078be:	e9 a8 f3 ff ff       	jmp    80106c6b <alltraps>

801078c3 <vector193>:
.globl vector193
vector193:
  pushl $0
801078c3:	6a 00                	push   $0x0
  pushl $193
801078c5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801078ca:	e9 9c f3 ff ff       	jmp    80106c6b <alltraps>

801078cf <vector194>:
.globl vector194
vector194:
  pushl $0
801078cf:	6a 00                	push   $0x0
  pushl $194
801078d1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801078d6:	e9 90 f3 ff ff       	jmp    80106c6b <alltraps>

801078db <vector195>:
.globl vector195
vector195:
  pushl $0
801078db:	6a 00                	push   $0x0
  pushl $195
801078dd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801078e2:	e9 84 f3 ff ff       	jmp    80106c6b <alltraps>

801078e7 <vector196>:
.globl vector196
vector196:
  pushl $0
801078e7:	6a 00                	push   $0x0
  pushl $196
801078e9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801078ee:	e9 78 f3 ff ff       	jmp    80106c6b <alltraps>

801078f3 <vector197>:
.globl vector197
vector197:
  pushl $0
801078f3:	6a 00                	push   $0x0
  pushl $197
801078f5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801078fa:	e9 6c f3 ff ff       	jmp    80106c6b <alltraps>

801078ff <vector198>:
.globl vector198
vector198:
  pushl $0
801078ff:	6a 00                	push   $0x0
  pushl $198
80107901:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107906:	e9 60 f3 ff ff       	jmp    80106c6b <alltraps>

8010790b <vector199>:
.globl vector199
vector199:
  pushl $0
8010790b:	6a 00                	push   $0x0
  pushl $199
8010790d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107912:	e9 54 f3 ff ff       	jmp    80106c6b <alltraps>

80107917 <vector200>:
.globl vector200
vector200:
  pushl $0
80107917:	6a 00                	push   $0x0
  pushl $200
80107919:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010791e:	e9 48 f3 ff ff       	jmp    80106c6b <alltraps>

80107923 <vector201>:
.globl vector201
vector201:
  pushl $0
80107923:	6a 00                	push   $0x0
  pushl $201
80107925:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010792a:	e9 3c f3 ff ff       	jmp    80106c6b <alltraps>

8010792f <vector202>:
.globl vector202
vector202:
  pushl $0
8010792f:	6a 00                	push   $0x0
  pushl $202
80107931:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107936:	e9 30 f3 ff ff       	jmp    80106c6b <alltraps>

8010793b <vector203>:
.globl vector203
vector203:
  pushl $0
8010793b:	6a 00                	push   $0x0
  pushl $203
8010793d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107942:	e9 24 f3 ff ff       	jmp    80106c6b <alltraps>

80107947 <vector204>:
.globl vector204
vector204:
  pushl $0
80107947:	6a 00                	push   $0x0
  pushl $204
80107949:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010794e:	e9 18 f3 ff ff       	jmp    80106c6b <alltraps>

80107953 <vector205>:
.globl vector205
vector205:
  pushl $0
80107953:	6a 00                	push   $0x0
  pushl $205
80107955:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010795a:	e9 0c f3 ff ff       	jmp    80106c6b <alltraps>

8010795f <vector206>:
.globl vector206
vector206:
  pushl $0
8010795f:	6a 00                	push   $0x0
  pushl $206
80107961:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107966:	e9 00 f3 ff ff       	jmp    80106c6b <alltraps>

8010796b <vector207>:
.globl vector207
vector207:
  pushl $0
8010796b:	6a 00                	push   $0x0
  pushl $207
8010796d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107972:	e9 f4 f2 ff ff       	jmp    80106c6b <alltraps>

80107977 <vector208>:
.globl vector208
vector208:
  pushl $0
80107977:	6a 00                	push   $0x0
  pushl $208
80107979:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010797e:	e9 e8 f2 ff ff       	jmp    80106c6b <alltraps>

80107983 <vector209>:
.globl vector209
vector209:
  pushl $0
80107983:	6a 00                	push   $0x0
  pushl $209
80107985:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010798a:	e9 dc f2 ff ff       	jmp    80106c6b <alltraps>

8010798f <vector210>:
.globl vector210
vector210:
  pushl $0
8010798f:	6a 00                	push   $0x0
  pushl $210
80107991:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107996:	e9 d0 f2 ff ff       	jmp    80106c6b <alltraps>

8010799b <vector211>:
.globl vector211
vector211:
  pushl $0
8010799b:	6a 00                	push   $0x0
  pushl $211
8010799d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801079a2:	e9 c4 f2 ff ff       	jmp    80106c6b <alltraps>

801079a7 <vector212>:
.globl vector212
vector212:
  pushl $0
801079a7:	6a 00                	push   $0x0
  pushl $212
801079a9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801079ae:	e9 b8 f2 ff ff       	jmp    80106c6b <alltraps>

801079b3 <vector213>:
.globl vector213
vector213:
  pushl $0
801079b3:	6a 00                	push   $0x0
  pushl $213
801079b5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801079ba:	e9 ac f2 ff ff       	jmp    80106c6b <alltraps>

801079bf <vector214>:
.globl vector214
vector214:
  pushl $0
801079bf:	6a 00                	push   $0x0
  pushl $214
801079c1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801079c6:	e9 a0 f2 ff ff       	jmp    80106c6b <alltraps>

801079cb <vector215>:
.globl vector215
vector215:
  pushl $0
801079cb:	6a 00                	push   $0x0
  pushl $215
801079cd:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801079d2:	e9 94 f2 ff ff       	jmp    80106c6b <alltraps>

801079d7 <vector216>:
.globl vector216
vector216:
  pushl $0
801079d7:	6a 00                	push   $0x0
  pushl $216
801079d9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801079de:	e9 88 f2 ff ff       	jmp    80106c6b <alltraps>

801079e3 <vector217>:
.globl vector217
vector217:
  pushl $0
801079e3:	6a 00                	push   $0x0
  pushl $217
801079e5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801079ea:	e9 7c f2 ff ff       	jmp    80106c6b <alltraps>

801079ef <vector218>:
.globl vector218
vector218:
  pushl $0
801079ef:	6a 00                	push   $0x0
  pushl $218
801079f1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801079f6:	e9 70 f2 ff ff       	jmp    80106c6b <alltraps>

801079fb <vector219>:
.globl vector219
vector219:
  pushl $0
801079fb:	6a 00                	push   $0x0
  pushl $219
801079fd:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107a02:	e9 64 f2 ff ff       	jmp    80106c6b <alltraps>

80107a07 <vector220>:
.globl vector220
vector220:
  pushl $0
80107a07:	6a 00                	push   $0x0
  pushl $220
80107a09:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80107a0e:	e9 58 f2 ff ff       	jmp    80106c6b <alltraps>

80107a13 <vector221>:
.globl vector221
vector221:
  pushl $0
80107a13:	6a 00                	push   $0x0
  pushl $221
80107a15:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80107a1a:	e9 4c f2 ff ff       	jmp    80106c6b <alltraps>

80107a1f <vector222>:
.globl vector222
vector222:
  pushl $0
80107a1f:	6a 00                	push   $0x0
  pushl $222
80107a21:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107a26:	e9 40 f2 ff ff       	jmp    80106c6b <alltraps>

80107a2b <vector223>:
.globl vector223
vector223:
  pushl $0
80107a2b:	6a 00                	push   $0x0
  pushl $223
80107a2d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107a32:	e9 34 f2 ff ff       	jmp    80106c6b <alltraps>

80107a37 <vector224>:
.globl vector224
vector224:
  pushl $0
80107a37:	6a 00                	push   $0x0
  pushl $224
80107a39:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80107a3e:	e9 28 f2 ff ff       	jmp    80106c6b <alltraps>

80107a43 <vector225>:
.globl vector225
vector225:
  pushl $0
80107a43:	6a 00                	push   $0x0
  pushl $225
80107a45:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107a4a:	e9 1c f2 ff ff       	jmp    80106c6b <alltraps>

80107a4f <vector226>:
.globl vector226
vector226:
  pushl $0
80107a4f:	6a 00                	push   $0x0
  pushl $226
80107a51:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107a56:	e9 10 f2 ff ff       	jmp    80106c6b <alltraps>

80107a5b <vector227>:
.globl vector227
vector227:
  pushl $0
80107a5b:	6a 00                	push   $0x0
  pushl $227
80107a5d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107a62:	e9 04 f2 ff ff       	jmp    80106c6b <alltraps>

80107a67 <vector228>:
.globl vector228
vector228:
  pushl $0
80107a67:	6a 00                	push   $0x0
  pushl $228
80107a69:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80107a6e:	e9 f8 f1 ff ff       	jmp    80106c6b <alltraps>

80107a73 <vector229>:
.globl vector229
vector229:
  pushl $0
80107a73:	6a 00                	push   $0x0
  pushl $229
80107a75:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80107a7a:	e9 ec f1 ff ff       	jmp    80106c6b <alltraps>

80107a7f <vector230>:
.globl vector230
vector230:
  pushl $0
80107a7f:	6a 00                	push   $0x0
  pushl $230
80107a81:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107a86:	e9 e0 f1 ff ff       	jmp    80106c6b <alltraps>

80107a8b <vector231>:
.globl vector231
vector231:
  pushl $0
80107a8b:	6a 00                	push   $0x0
  pushl $231
80107a8d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107a92:	e9 d4 f1 ff ff       	jmp    80106c6b <alltraps>

80107a97 <vector232>:
.globl vector232
vector232:
  pushl $0
80107a97:	6a 00                	push   $0x0
  pushl $232
80107a99:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107a9e:	e9 c8 f1 ff ff       	jmp    80106c6b <alltraps>

80107aa3 <vector233>:
.globl vector233
vector233:
  pushl $0
80107aa3:	6a 00                	push   $0x0
  pushl $233
80107aa5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107aaa:	e9 bc f1 ff ff       	jmp    80106c6b <alltraps>

80107aaf <vector234>:
.globl vector234
vector234:
  pushl $0
80107aaf:	6a 00                	push   $0x0
  pushl $234
80107ab1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107ab6:	e9 b0 f1 ff ff       	jmp    80106c6b <alltraps>

80107abb <vector235>:
.globl vector235
vector235:
  pushl $0
80107abb:	6a 00                	push   $0x0
  pushl $235
80107abd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107ac2:	e9 a4 f1 ff ff       	jmp    80106c6b <alltraps>

80107ac7 <vector236>:
.globl vector236
vector236:
  pushl $0
80107ac7:	6a 00                	push   $0x0
  pushl $236
80107ac9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107ace:	e9 98 f1 ff ff       	jmp    80106c6b <alltraps>

80107ad3 <vector237>:
.globl vector237
vector237:
  pushl $0
80107ad3:	6a 00                	push   $0x0
  pushl $237
80107ad5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107ada:	e9 8c f1 ff ff       	jmp    80106c6b <alltraps>

80107adf <vector238>:
.globl vector238
vector238:
  pushl $0
80107adf:	6a 00                	push   $0x0
  pushl $238
80107ae1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107ae6:	e9 80 f1 ff ff       	jmp    80106c6b <alltraps>

80107aeb <vector239>:
.globl vector239
vector239:
  pushl $0
80107aeb:	6a 00                	push   $0x0
  pushl $239
80107aed:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107af2:	e9 74 f1 ff ff       	jmp    80106c6b <alltraps>

80107af7 <vector240>:
.globl vector240
vector240:
  pushl $0
80107af7:	6a 00                	push   $0x0
  pushl $240
80107af9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107afe:	e9 68 f1 ff ff       	jmp    80106c6b <alltraps>

80107b03 <vector241>:
.globl vector241
vector241:
  pushl $0
80107b03:	6a 00                	push   $0x0
  pushl $241
80107b05:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107b0a:	e9 5c f1 ff ff       	jmp    80106c6b <alltraps>

80107b0f <vector242>:
.globl vector242
vector242:
  pushl $0
80107b0f:	6a 00                	push   $0x0
  pushl $242
80107b11:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107b16:	e9 50 f1 ff ff       	jmp    80106c6b <alltraps>

80107b1b <vector243>:
.globl vector243
vector243:
  pushl $0
80107b1b:	6a 00                	push   $0x0
  pushl $243
80107b1d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107b22:	e9 44 f1 ff ff       	jmp    80106c6b <alltraps>

80107b27 <vector244>:
.globl vector244
vector244:
  pushl $0
80107b27:	6a 00                	push   $0x0
  pushl $244
80107b29:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107b2e:	e9 38 f1 ff ff       	jmp    80106c6b <alltraps>

80107b33 <vector245>:
.globl vector245
vector245:
  pushl $0
80107b33:	6a 00                	push   $0x0
  pushl $245
80107b35:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107b3a:	e9 2c f1 ff ff       	jmp    80106c6b <alltraps>

80107b3f <vector246>:
.globl vector246
vector246:
  pushl $0
80107b3f:	6a 00                	push   $0x0
  pushl $246
80107b41:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107b46:	e9 20 f1 ff ff       	jmp    80106c6b <alltraps>

80107b4b <vector247>:
.globl vector247
vector247:
  pushl $0
80107b4b:	6a 00                	push   $0x0
  pushl $247
80107b4d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107b52:	e9 14 f1 ff ff       	jmp    80106c6b <alltraps>

80107b57 <vector248>:
.globl vector248
vector248:
  pushl $0
80107b57:	6a 00                	push   $0x0
  pushl $248
80107b59:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107b5e:	e9 08 f1 ff ff       	jmp    80106c6b <alltraps>

80107b63 <vector249>:
.globl vector249
vector249:
  pushl $0
80107b63:	6a 00                	push   $0x0
  pushl $249
80107b65:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107b6a:	e9 fc f0 ff ff       	jmp    80106c6b <alltraps>

80107b6f <vector250>:
.globl vector250
vector250:
  pushl $0
80107b6f:	6a 00                	push   $0x0
  pushl $250
80107b71:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107b76:	e9 f0 f0 ff ff       	jmp    80106c6b <alltraps>

80107b7b <vector251>:
.globl vector251
vector251:
  pushl $0
80107b7b:	6a 00                	push   $0x0
  pushl $251
80107b7d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107b82:	e9 e4 f0 ff ff       	jmp    80106c6b <alltraps>

80107b87 <vector252>:
.globl vector252
vector252:
  pushl $0
80107b87:	6a 00                	push   $0x0
  pushl $252
80107b89:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107b8e:	e9 d8 f0 ff ff       	jmp    80106c6b <alltraps>

80107b93 <vector253>:
.globl vector253
vector253:
  pushl $0
80107b93:	6a 00                	push   $0x0
  pushl $253
80107b95:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107b9a:	e9 cc f0 ff ff       	jmp    80106c6b <alltraps>

80107b9f <vector254>:
.globl vector254
vector254:
  pushl $0
80107b9f:	6a 00                	push   $0x0
  pushl $254
80107ba1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107ba6:	e9 c0 f0 ff ff       	jmp    80106c6b <alltraps>

80107bab <vector255>:
.globl vector255
vector255:
  pushl $0
80107bab:	6a 00                	push   $0x0
  pushl $255
80107bad:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107bb2:	e9 b4 f0 ff ff       	jmp    80106c6b <alltraps>
80107bb7:	66 90                	xchg   %ax,%ax
80107bb9:	66 90                	xchg   %ax,%ax
80107bbb:	66 90                	xchg   %ax,%ax
80107bbd:	66 90                	xchg   %ax,%ax
80107bbf:	90                   	nop

80107bc0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107bc0:	55                   	push   %ebp
80107bc1:	89 e5                	mov    %esp,%ebp
80107bc3:	57                   	push   %edi
80107bc4:	56                   	push   %esi
80107bc5:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107bc6:	89 d3                	mov    %edx,%ebx
{
80107bc8:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
80107bca:	c1 eb 16             	shr    $0x16,%ebx
80107bcd:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80107bd0:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80107bd3:	8b 06                	mov    (%esi),%eax
80107bd5:	a8 01                	test   $0x1,%al
80107bd7:	74 27                	je     80107c00 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107bd9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107bde:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107be4:	c1 ef 0a             	shr    $0xa,%edi
}
80107be7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80107bea:	89 fa                	mov    %edi,%edx
80107bec:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107bf2:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80107bf5:	5b                   	pop    %ebx
80107bf6:	5e                   	pop    %esi
80107bf7:	5f                   	pop    %edi
80107bf8:	5d                   	pop    %ebp
80107bf9:	c3                   	ret    
80107bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107c00:	85 c9                	test   %ecx,%ecx
80107c02:	74 2c                	je     80107c30 <walkpgdir+0x70>
80107c04:	e8 e7 a8 ff ff       	call   801024f0 <kalloc>
80107c09:	85 c0                	test   %eax,%eax
80107c0b:	89 c3                	mov    %eax,%ebx
80107c0d:	74 21                	je     80107c30 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
80107c0f:	83 ec 04             	sub    $0x4,%esp
80107c12:	68 00 10 00 00       	push   $0x1000
80107c17:	6a 00                	push   $0x0
80107c19:	50                   	push   %eax
80107c1a:	e8 01 ce ff ff       	call   80104a20 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107c1f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107c25:	83 c4 10             	add    $0x10,%esp
80107c28:	83 c8 07             	or     $0x7,%eax
80107c2b:	89 06                	mov    %eax,(%esi)
80107c2d:	eb b5                	jmp    80107be4 <walkpgdir+0x24>
80107c2f:	90                   	nop
}
80107c30:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80107c33:	31 c0                	xor    %eax,%eax
}
80107c35:	5b                   	pop    %ebx
80107c36:	5e                   	pop    %esi
80107c37:	5f                   	pop    %edi
80107c38:	5d                   	pop    %ebp
80107c39:	c3                   	ret    
80107c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107c40 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107c40:	55                   	push   %ebp
80107c41:	89 e5                	mov    %esp,%ebp
80107c43:	57                   	push   %edi
80107c44:	56                   	push   %esi
80107c45:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107c46:	89 d3                	mov    %edx,%ebx
80107c48:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80107c4e:	83 ec 1c             	sub    $0x1c,%esp
80107c51:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107c54:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107c58:	8b 7d 08             	mov    0x8(%ebp),%edi
80107c5b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107c60:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80107c63:	8b 45 0c             	mov    0xc(%ebp),%eax
80107c66:	29 df                	sub    %ebx,%edi
80107c68:	83 c8 01             	or     $0x1,%eax
80107c6b:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107c6e:	eb 15                	jmp    80107c85 <mappages+0x45>
    if(*pte & PTE_P)
80107c70:	f6 00 01             	testb  $0x1,(%eax)
80107c73:	75 45                	jne    80107cba <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80107c75:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80107c78:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
80107c7b:	89 30                	mov    %esi,(%eax)
    if(a == last)
80107c7d:	74 31                	je     80107cb0 <mappages+0x70>
      break;
    a += PGSIZE;
80107c7f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107c85:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107c88:	b9 01 00 00 00       	mov    $0x1,%ecx
80107c8d:	89 da                	mov    %ebx,%edx
80107c8f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80107c92:	e8 29 ff ff ff       	call   80107bc0 <walkpgdir>
80107c97:	85 c0                	test   %eax,%eax
80107c99:	75 d5                	jne    80107c70 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80107c9b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107c9e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107ca3:	5b                   	pop    %ebx
80107ca4:	5e                   	pop    %esi
80107ca5:	5f                   	pop    %edi
80107ca6:	5d                   	pop    %ebp
80107ca7:	c3                   	ret    
80107ca8:	90                   	nop
80107ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107cb0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107cb3:	31 c0                	xor    %eax,%eax
}
80107cb5:	5b                   	pop    %ebx
80107cb6:	5e                   	pop    %esi
80107cb7:	5f                   	pop    %edi
80107cb8:	5d                   	pop    %ebp
80107cb9:	c3                   	ret    
      panic("remap");
80107cba:	83 ec 0c             	sub    $0xc,%esp
80107cbd:	68 54 8e 10 80       	push   $0x80108e54
80107cc2:	e8 c9 86 ff ff       	call   80100390 <panic>
80107cc7:	89 f6                	mov    %esi,%esi
80107cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107cd0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107cd0:	55                   	push   %ebp
80107cd1:	89 e5                	mov    %esp,%ebp
80107cd3:	57                   	push   %edi
80107cd4:	56                   	push   %esi
80107cd5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107cd6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107cdc:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
80107cde:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107ce4:	83 ec 1c             	sub    $0x1c,%esp
80107ce7:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107cea:	39 d3                	cmp    %edx,%ebx
80107cec:	73 66                	jae    80107d54 <deallocuvm.part.0+0x84>
80107cee:	89 d6                	mov    %edx,%esi
80107cf0:	eb 3d                	jmp    80107d2f <deallocuvm.part.0+0x5f>
80107cf2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80107cf8:	8b 10                	mov    (%eax),%edx
80107cfa:	f6 c2 01             	test   $0x1,%dl
80107cfd:	74 26                	je     80107d25 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80107cff:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107d05:	74 58                	je     80107d5f <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80107d07:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80107d0a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80107d10:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80107d13:	52                   	push   %edx
80107d14:	e8 27 a6 ff ff       	call   80102340 <kfree>
      *pte = 0;
80107d19:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107d1c:	83 c4 10             	add    $0x10,%esp
80107d1f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80107d25:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107d2b:	39 f3                	cmp    %esi,%ebx
80107d2d:	73 25                	jae    80107d54 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
80107d2f:	31 c9                	xor    %ecx,%ecx
80107d31:	89 da                	mov    %ebx,%edx
80107d33:	89 f8                	mov    %edi,%eax
80107d35:	e8 86 fe ff ff       	call   80107bc0 <walkpgdir>
    if(!pte)
80107d3a:	85 c0                	test   %eax,%eax
80107d3c:	75 ba                	jne    80107cf8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107d3e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80107d44:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107d4a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107d50:	39 f3                	cmp    %esi,%ebx
80107d52:	72 db                	jb     80107d2f <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
80107d54:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107d57:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107d5a:	5b                   	pop    %ebx
80107d5b:	5e                   	pop    %esi
80107d5c:	5f                   	pop    %edi
80107d5d:	5d                   	pop    %ebp
80107d5e:	c3                   	ret    
        panic("kfree");
80107d5f:	83 ec 0c             	sub    $0xc,%esp
80107d62:	68 66 87 10 80       	push   $0x80108766
80107d67:	e8 24 86 ff ff       	call   80100390 <panic>
80107d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107d70 <seginit>:
{
80107d70:	55                   	push   %ebp
80107d71:	89 e5                	mov    %esp,%ebp
80107d73:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107d76:	e8 75 ba ff ff       	call   801037f0 <cpuid>
80107d7b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80107d81:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107d86:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107d8a:	c7 80 b8 ad 14 80 ff 	movl   $0xffff,-0x7feb5248(%eax)
80107d91:	ff 00 00 
80107d94:	c7 80 bc ad 14 80 00 	movl   $0xcf9a00,-0x7feb5244(%eax)
80107d9b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107d9e:	c7 80 c0 ad 14 80 ff 	movl   $0xffff,-0x7feb5240(%eax)
80107da5:	ff 00 00 
80107da8:	c7 80 c4 ad 14 80 00 	movl   $0xcf9200,-0x7feb523c(%eax)
80107daf:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107db2:	c7 80 c8 ad 14 80 ff 	movl   $0xffff,-0x7feb5238(%eax)
80107db9:	ff 00 00 
80107dbc:	c7 80 cc ad 14 80 00 	movl   $0xcffa00,-0x7feb5234(%eax)
80107dc3:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107dc6:	c7 80 d0 ad 14 80 ff 	movl   $0xffff,-0x7feb5230(%eax)
80107dcd:	ff 00 00 
80107dd0:	c7 80 d4 ad 14 80 00 	movl   $0xcff200,-0x7feb522c(%eax)
80107dd7:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80107dda:	05 b0 ad 14 80       	add    $0x8014adb0,%eax
  pd[1] = (uint)p;
80107ddf:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107de3:	c1 e8 10             	shr    $0x10,%eax
80107de6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80107dea:	8d 45 f2             	lea    -0xe(%ebp),%eax
80107ded:	0f 01 10             	lgdtl  (%eax)
}
80107df0:	c9                   	leave  
80107df1:	c3                   	ret    
80107df2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107e00 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107e00:	a1 64 2f 15 80       	mov    0x80152f64,%eax
{
80107e05:	55                   	push   %ebp
80107e06:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107e08:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107e0d:	0f 22 d8             	mov    %eax,%cr3
}
80107e10:	5d                   	pop    %ebp
80107e11:	c3                   	ret    
80107e12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107e20 <switchuvm>:
{
80107e20:	55                   	push   %ebp
80107e21:	89 e5                	mov    %esp,%ebp
80107e23:	57                   	push   %edi
80107e24:	56                   	push   %esi
80107e25:	53                   	push   %ebx
80107e26:	83 ec 1c             	sub    $0x1c,%esp
80107e29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
80107e2c:	85 db                	test   %ebx,%ebx
80107e2e:	0f 84 cb 00 00 00    	je     80107eff <switchuvm+0xdf>
  if(p->kstack == 0)
80107e34:	8b 43 08             	mov    0x8(%ebx),%eax
80107e37:	85 c0                	test   %eax,%eax
80107e39:	0f 84 da 00 00 00    	je     80107f19 <switchuvm+0xf9>
  if(p->pgdir == 0)
80107e3f:	8b 43 04             	mov    0x4(%ebx),%eax
80107e42:	85 c0                	test   %eax,%eax
80107e44:	0f 84 c2 00 00 00    	je     80107f0c <switchuvm+0xec>
  pushcli();
80107e4a:	e8 f1 c9 ff ff       	call   80104840 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107e4f:	e8 1c b9 ff ff       	call   80103770 <mycpu>
80107e54:	89 c6                	mov    %eax,%esi
80107e56:	e8 15 b9 ff ff       	call   80103770 <mycpu>
80107e5b:	89 c7                	mov    %eax,%edi
80107e5d:	e8 0e b9 ff ff       	call   80103770 <mycpu>
80107e62:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107e65:	83 c7 08             	add    $0x8,%edi
80107e68:	e8 03 b9 ff ff       	call   80103770 <mycpu>
80107e6d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107e70:	83 c0 08             	add    $0x8,%eax
80107e73:	ba 67 00 00 00       	mov    $0x67,%edx
80107e78:	c1 e8 18             	shr    $0x18,%eax
80107e7b:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80107e82:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80107e89:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107e8f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107e94:	83 c1 08             	add    $0x8,%ecx
80107e97:	c1 e9 10             	shr    $0x10,%ecx
80107e9a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80107ea0:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107ea5:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107eac:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80107eb1:	e8 ba b8 ff ff       	call   80103770 <mycpu>
80107eb6:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107ebd:	e8 ae b8 ff ff       	call   80103770 <mycpu>
80107ec2:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107ec6:	8b 73 08             	mov    0x8(%ebx),%esi
80107ec9:	e8 a2 b8 ff ff       	call   80103770 <mycpu>
80107ece:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107ed4:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107ed7:	e8 94 b8 ff ff       	call   80103770 <mycpu>
80107edc:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107ee0:	b8 28 00 00 00       	mov    $0x28,%eax
80107ee5:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107ee8:	8b 43 04             	mov    0x4(%ebx),%eax
80107eeb:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107ef0:	0f 22 d8             	mov    %eax,%cr3
}
80107ef3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107ef6:	5b                   	pop    %ebx
80107ef7:	5e                   	pop    %esi
80107ef8:	5f                   	pop    %edi
80107ef9:	5d                   	pop    %ebp
  popcli();
80107efa:	e9 81 c9 ff ff       	jmp    80104880 <popcli>
    panic("switchuvm: no process");
80107eff:	83 ec 0c             	sub    $0xc,%esp
80107f02:	68 5a 8e 10 80       	push   $0x80108e5a
80107f07:	e8 84 84 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
80107f0c:	83 ec 0c             	sub    $0xc,%esp
80107f0f:	68 85 8e 10 80       	push   $0x80108e85
80107f14:	e8 77 84 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80107f19:	83 ec 0c             	sub    $0xc,%esp
80107f1c:	68 70 8e 10 80       	push   $0x80108e70
80107f21:	e8 6a 84 ff ff       	call   80100390 <panic>
80107f26:	8d 76 00             	lea    0x0(%esi),%esi
80107f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107f30 <inituvm>:
{
80107f30:	55                   	push   %ebp
80107f31:	89 e5                	mov    %esp,%ebp
80107f33:	57                   	push   %edi
80107f34:	56                   	push   %esi
80107f35:	53                   	push   %ebx
80107f36:	83 ec 1c             	sub    $0x1c,%esp
80107f39:	8b 75 10             	mov    0x10(%ebp),%esi
80107f3c:	8b 45 08             	mov    0x8(%ebp),%eax
80107f3f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80107f42:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80107f48:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107f4b:	77 49                	ja     80107f96 <inituvm+0x66>
  mem = kalloc();
80107f4d:	e8 9e a5 ff ff       	call   801024f0 <kalloc>
  memset(mem, 0, PGSIZE);
80107f52:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80107f55:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107f57:	68 00 10 00 00       	push   $0x1000
80107f5c:	6a 00                	push   $0x0
80107f5e:	50                   	push   %eax
80107f5f:	e8 bc ca ff ff       	call   80104a20 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107f64:	58                   	pop    %eax
80107f65:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107f6b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107f70:	5a                   	pop    %edx
80107f71:	6a 06                	push   $0x6
80107f73:	50                   	push   %eax
80107f74:	31 d2                	xor    %edx,%edx
80107f76:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107f79:	e8 c2 fc ff ff       	call   80107c40 <mappages>
  memmove(mem, init, sz);
80107f7e:	89 75 10             	mov    %esi,0x10(%ebp)
80107f81:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107f84:	83 c4 10             	add    $0x10,%esp
80107f87:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80107f8a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107f8d:	5b                   	pop    %ebx
80107f8e:	5e                   	pop    %esi
80107f8f:	5f                   	pop    %edi
80107f90:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107f91:	e9 3a cb ff ff       	jmp    80104ad0 <memmove>
    panic("inituvm: more than a page");
80107f96:	83 ec 0c             	sub    $0xc,%esp
80107f99:	68 99 8e 10 80       	push   $0x80108e99
80107f9e:	e8 ed 83 ff ff       	call   80100390 <panic>
80107fa3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107fb0 <loaduvm>:
{
80107fb0:	55                   	push   %ebp
80107fb1:	89 e5                	mov    %esp,%ebp
80107fb3:	57                   	push   %edi
80107fb4:	56                   	push   %esi
80107fb5:	53                   	push   %ebx
80107fb6:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80107fb9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107fc0:	0f 85 91 00 00 00    	jne    80108057 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80107fc6:	8b 75 18             	mov    0x18(%ebp),%esi
80107fc9:	31 db                	xor    %ebx,%ebx
80107fcb:	85 f6                	test   %esi,%esi
80107fcd:	75 1a                	jne    80107fe9 <loaduvm+0x39>
80107fcf:	eb 6f                	jmp    80108040 <loaduvm+0x90>
80107fd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107fd8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107fde:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80107fe4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80107fe7:	76 57                	jbe    80108040 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107fe9:	8b 55 0c             	mov    0xc(%ebp),%edx
80107fec:	8b 45 08             	mov    0x8(%ebp),%eax
80107fef:	31 c9                	xor    %ecx,%ecx
80107ff1:	01 da                	add    %ebx,%edx
80107ff3:	e8 c8 fb ff ff       	call   80107bc0 <walkpgdir>
80107ff8:	85 c0                	test   %eax,%eax
80107ffa:	74 4e                	je     8010804a <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80107ffc:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107ffe:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80108001:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80108006:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
8010800b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80108011:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80108014:	01 d9                	add    %ebx,%ecx
80108016:	05 00 00 00 80       	add    $0x80000000,%eax
8010801b:	57                   	push   %edi
8010801c:	51                   	push   %ecx
8010801d:	50                   	push   %eax
8010801e:	ff 75 10             	pushl  0x10(%ebp)
80108021:	e8 5a 99 ff ff       	call   80101980 <readi>
80108026:	83 c4 10             	add    $0x10,%esp
80108029:	39 f8                	cmp    %edi,%eax
8010802b:	74 ab                	je     80107fd8 <loaduvm+0x28>
}
8010802d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80108030:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80108035:	5b                   	pop    %ebx
80108036:	5e                   	pop    %esi
80108037:	5f                   	pop    %edi
80108038:	5d                   	pop    %ebp
80108039:	c3                   	ret    
8010803a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80108040:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80108043:	31 c0                	xor    %eax,%eax
}
80108045:	5b                   	pop    %ebx
80108046:	5e                   	pop    %esi
80108047:	5f                   	pop    %edi
80108048:	5d                   	pop    %ebp
80108049:	c3                   	ret    
      panic("loaduvm: address should exist");
8010804a:	83 ec 0c             	sub    $0xc,%esp
8010804d:	68 b3 8e 10 80       	push   $0x80108eb3
80108052:	e8 39 83 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80108057:	83 ec 0c             	sub    $0xc,%esp
8010805a:	68 54 8f 10 80       	push   $0x80108f54
8010805f:	e8 2c 83 ff ff       	call   80100390 <panic>
80108064:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010806a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80108070 <allocuvm>:
{
80108070:	55                   	push   %ebp
80108071:	89 e5                	mov    %esp,%ebp
80108073:	57                   	push   %edi
80108074:	56                   	push   %esi
80108075:	53                   	push   %ebx
80108076:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80108079:	8b 7d 10             	mov    0x10(%ebp),%edi
8010807c:	85 ff                	test   %edi,%edi
8010807e:	0f 88 8e 00 00 00    	js     80108112 <allocuvm+0xa2>
  if(newsz < oldsz)
80108084:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80108087:	0f 82 93 00 00 00    	jb     80108120 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
8010808d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108090:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80108096:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010809c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010809f:	0f 86 7e 00 00 00    	jbe    80108123 <allocuvm+0xb3>
801080a5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801080a8:	8b 7d 08             	mov    0x8(%ebp),%edi
801080ab:	eb 42                	jmp    801080ef <allocuvm+0x7f>
801080ad:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
801080b0:	83 ec 04             	sub    $0x4,%esp
801080b3:	68 00 10 00 00       	push   $0x1000
801080b8:	6a 00                	push   $0x0
801080ba:	50                   	push   %eax
801080bb:	e8 60 c9 ff ff       	call   80104a20 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801080c0:	58                   	pop    %eax
801080c1:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801080c7:	b9 00 10 00 00       	mov    $0x1000,%ecx
801080cc:	5a                   	pop    %edx
801080cd:	6a 06                	push   $0x6
801080cf:	50                   	push   %eax
801080d0:	89 da                	mov    %ebx,%edx
801080d2:	89 f8                	mov    %edi,%eax
801080d4:	e8 67 fb ff ff       	call   80107c40 <mappages>
801080d9:	83 c4 10             	add    $0x10,%esp
801080dc:	85 c0                	test   %eax,%eax
801080de:	78 50                	js     80108130 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
801080e0:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801080e6:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801080e9:	0f 86 81 00 00 00    	jbe    80108170 <allocuvm+0x100>
    mem = kalloc();
801080ef:	e8 fc a3 ff ff       	call   801024f0 <kalloc>
    if(mem == 0){
801080f4:	85 c0                	test   %eax,%eax
    mem = kalloc();
801080f6:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801080f8:	75 b6                	jne    801080b0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
801080fa:	83 ec 0c             	sub    $0xc,%esp
801080fd:	68 d1 8e 10 80       	push   $0x80108ed1
80108102:	e8 59 85 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80108107:	83 c4 10             	add    $0x10,%esp
8010810a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010810d:	39 45 10             	cmp    %eax,0x10(%ebp)
80108110:	77 6e                	ja     80108180 <allocuvm+0x110>
}
80108112:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80108115:	31 ff                	xor    %edi,%edi
}
80108117:	89 f8                	mov    %edi,%eax
80108119:	5b                   	pop    %ebx
8010811a:	5e                   	pop    %esi
8010811b:	5f                   	pop    %edi
8010811c:	5d                   	pop    %ebp
8010811d:	c3                   	ret    
8010811e:	66 90                	xchg   %ax,%ax
    return oldsz;
80108120:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80108123:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108126:	89 f8                	mov    %edi,%eax
80108128:	5b                   	pop    %ebx
80108129:	5e                   	pop    %esi
8010812a:	5f                   	pop    %edi
8010812b:	5d                   	pop    %ebp
8010812c:	c3                   	ret    
8010812d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80108130:	83 ec 0c             	sub    $0xc,%esp
80108133:	68 e9 8e 10 80       	push   $0x80108ee9
80108138:	e8 23 85 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
8010813d:	83 c4 10             	add    $0x10,%esp
80108140:	8b 45 0c             	mov    0xc(%ebp),%eax
80108143:	39 45 10             	cmp    %eax,0x10(%ebp)
80108146:	76 0d                	jbe    80108155 <allocuvm+0xe5>
80108148:	89 c1                	mov    %eax,%ecx
8010814a:	8b 55 10             	mov    0x10(%ebp),%edx
8010814d:	8b 45 08             	mov    0x8(%ebp),%eax
80108150:	e8 7b fb ff ff       	call   80107cd0 <deallocuvm.part.0>
      kfree(mem);
80108155:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80108158:	31 ff                	xor    %edi,%edi
      kfree(mem);
8010815a:	56                   	push   %esi
8010815b:	e8 e0 a1 ff ff       	call   80102340 <kfree>
      return 0;
80108160:	83 c4 10             	add    $0x10,%esp
}
80108163:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108166:	89 f8                	mov    %edi,%eax
80108168:	5b                   	pop    %ebx
80108169:	5e                   	pop    %esi
8010816a:	5f                   	pop    %edi
8010816b:	5d                   	pop    %ebp
8010816c:	c3                   	ret    
8010816d:	8d 76 00             	lea    0x0(%esi),%esi
80108170:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80108173:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108176:	5b                   	pop    %ebx
80108177:	89 f8                	mov    %edi,%eax
80108179:	5e                   	pop    %esi
8010817a:	5f                   	pop    %edi
8010817b:	5d                   	pop    %ebp
8010817c:	c3                   	ret    
8010817d:	8d 76 00             	lea    0x0(%esi),%esi
80108180:	89 c1                	mov    %eax,%ecx
80108182:	8b 55 10             	mov    0x10(%ebp),%edx
80108185:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80108188:	31 ff                	xor    %edi,%edi
8010818a:	e8 41 fb ff ff       	call   80107cd0 <deallocuvm.part.0>
8010818f:	eb 92                	jmp    80108123 <allocuvm+0xb3>
80108191:	eb 0d                	jmp    801081a0 <deallocuvm>
80108193:	90                   	nop
80108194:	90                   	nop
80108195:	90                   	nop
80108196:	90                   	nop
80108197:	90                   	nop
80108198:	90                   	nop
80108199:	90                   	nop
8010819a:	90                   	nop
8010819b:	90                   	nop
8010819c:	90                   	nop
8010819d:	90                   	nop
8010819e:	90                   	nop
8010819f:	90                   	nop

801081a0 <deallocuvm>:
{
801081a0:	55                   	push   %ebp
801081a1:	89 e5                	mov    %esp,%ebp
801081a3:	8b 55 0c             	mov    0xc(%ebp),%edx
801081a6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801081a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801081ac:	39 d1                	cmp    %edx,%ecx
801081ae:	73 10                	jae    801081c0 <deallocuvm+0x20>
}
801081b0:	5d                   	pop    %ebp
801081b1:	e9 1a fb ff ff       	jmp    80107cd0 <deallocuvm.part.0>
801081b6:	8d 76 00             	lea    0x0(%esi),%esi
801081b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801081c0:	89 d0                	mov    %edx,%eax
801081c2:	5d                   	pop    %ebp
801081c3:	c3                   	ret    
801081c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801081ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801081d0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801081d0:	55                   	push   %ebp
801081d1:	89 e5                	mov    %esp,%ebp
801081d3:	57                   	push   %edi
801081d4:	56                   	push   %esi
801081d5:	53                   	push   %ebx
801081d6:	83 ec 0c             	sub    $0xc,%esp
801081d9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801081dc:	85 f6                	test   %esi,%esi
801081de:	74 59                	je     80108239 <freevm+0x69>
801081e0:	31 c9                	xor    %ecx,%ecx
801081e2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801081e7:	89 f0                	mov    %esi,%eax
801081e9:	e8 e2 fa ff ff       	call   80107cd0 <deallocuvm.part.0>
801081ee:	89 f3                	mov    %esi,%ebx
801081f0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801081f6:	eb 0f                	jmp    80108207 <freevm+0x37>
801081f8:	90                   	nop
801081f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108200:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80108203:	39 fb                	cmp    %edi,%ebx
80108205:	74 23                	je     8010822a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80108207:	8b 03                	mov    (%ebx),%eax
80108209:	a8 01                	test   $0x1,%al
8010820b:	74 f3                	je     80108200 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010820d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80108212:	83 ec 0c             	sub    $0xc,%esp
80108215:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80108218:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010821d:	50                   	push   %eax
8010821e:	e8 1d a1 ff ff       	call   80102340 <kfree>
80108223:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80108226:	39 fb                	cmp    %edi,%ebx
80108228:	75 dd                	jne    80108207 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010822a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010822d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108230:	5b                   	pop    %ebx
80108231:	5e                   	pop    %esi
80108232:	5f                   	pop    %edi
80108233:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80108234:	e9 07 a1 ff ff       	jmp    80102340 <kfree>
    panic("freevm: no pgdir");
80108239:	83 ec 0c             	sub    $0xc,%esp
8010823c:	68 05 8f 10 80       	push   $0x80108f05
80108241:	e8 4a 81 ff ff       	call   80100390 <panic>
80108246:	8d 76 00             	lea    0x0(%esi),%esi
80108249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108250 <setupkvm>:
{
80108250:	55                   	push   %ebp
80108251:	89 e5                	mov    %esp,%ebp
80108253:	56                   	push   %esi
80108254:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80108255:	e8 96 a2 ff ff       	call   801024f0 <kalloc>
8010825a:	85 c0                	test   %eax,%eax
8010825c:	89 c6                	mov    %eax,%esi
8010825e:	74 42                	je     801082a2 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80108260:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108263:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80108268:	68 00 10 00 00       	push   $0x1000
8010826d:	6a 00                	push   $0x0
8010826f:	50                   	push   %eax
80108270:	e8 ab c7 ff ff       	call   80104a20 <memset>
80108275:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80108278:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010827b:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010827e:	83 ec 08             	sub    $0x8,%esp
80108281:	8b 13                	mov    (%ebx),%edx
80108283:	ff 73 0c             	pushl  0xc(%ebx)
80108286:	50                   	push   %eax
80108287:	29 c1                	sub    %eax,%ecx
80108289:	89 f0                	mov    %esi,%eax
8010828b:	e8 b0 f9 ff ff       	call   80107c40 <mappages>
80108290:	83 c4 10             	add    $0x10,%esp
80108293:	85 c0                	test   %eax,%eax
80108295:	78 19                	js     801082b0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108297:	83 c3 10             	add    $0x10,%ebx
8010829a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
801082a0:	75 d6                	jne    80108278 <setupkvm+0x28>
}
801082a2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801082a5:	89 f0                	mov    %esi,%eax
801082a7:	5b                   	pop    %ebx
801082a8:	5e                   	pop    %esi
801082a9:	5d                   	pop    %ebp
801082aa:	c3                   	ret    
801082ab:	90                   	nop
801082ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
801082b0:	83 ec 0c             	sub    $0xc,%esp
801082b3:	56                   	push   %esi
      return 0;
801082b4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
801082b6:	e8 15 ff ff ff       	call   801081d0 <freevm>
      return 0;
801082bb:	83 c4 10             	add    $0x10,%esp
}
801082be:	8d 65 f8             	lea    -0x8(%ebp),%esp
801082c1:	89 f0                	mov    %esi,%eax
801082c3:	5b                   	pop    %ebx
801082c4:	5e                   	pop    %esi
801082c5:	5d                   	pop    %ebp
801082c6:	c3                   	ret    
801082c7:	89 f6                	mov    %esi,%esi
801082c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801082d0 <kvmalloc>:
{
801082d0:	55                   	push   %ebp
801082d1:	89 e5                	mov    %esp,%ebp
801082d3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801082d6:	e8 75 ff ff ff       	call   80108250 <setupkvm>
801082db:	a3 64 2f 15 80       	mov    %eax,0x80152f64
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801082e0:	05 00 00 00 80       	add    $0x80000000,%eax
801082e5:	0f 22 d8             	mov    %eax,%cr3
}
801082e8:	c9                   	leave  
801082e9:	c3                   	ret    
801082ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801082f0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801082f0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801082f1:	31 c9                	xor    %ecx,%ecx
{
801082f3:	89 e5                	mov    %esp,%ebp
801082f5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
801082f8:	8b 55 0c             	mov    0xc(%ebp),%edx
801082fb:	8b 45 08             	mov    0x8(%ebp),%eax
801082fe:	e8 bd f8 ff ff       	call   80107bc0 <walkpgdir>
  if(pte == 0)
80108303:	85 c0                	test   %eax,%eax
80108305:	74 05                	je     8010830c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80108307:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010830a:	c9                   	leave  
8010830b:	c3                   	ret    
    panic("clearpteu");
8010830c:	83 ec 0c             	sub    $0xc,%esp
8010830f:	68 16 8f 10 80       	push   $0x80108f16
80108314:	e8 77 80 ff ff       	call   80100390 <panic>
80108319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108320 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80108320:	55                   	push   %ebp
80108321:	89 e5                	mov    %esp,%ebp
80108323:	57                   	push   %edi
80108324:	56                   	push   %esi
80108325:	53                   	push   %ebx
80108326:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80108329:	e8 22 ff ff ff       	call   80108250 <setupkvm>
8010832e:	85 c0                	test   %eax,%eax
80108330:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108333:	0f 84 9f 00 00 00    	je     801083d8 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108339:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010833c:	85 c9                	test   %ecx,%ecx
8010833e:	0f 84 94 00 00 00    	je     801083d8 <copyuvm+0xb8>
80108344:	31 ff                	xor    %edi,%edi
80108346:	eb 4a                	jmp    80108392 <copyuvm+0x72>
80108348:	90                   	nop
80108349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80108350:	83 ec 04             	sub    $0x4,%esp
80108353:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80108359:	68 00 10 00 00       	push   $0x1000
8010835e:	53                   	push   %ebx
8010835f:	50                   	push   %eax
80108360:	e8 6b c7 ff ff       	call   80104ad0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80108365:	58                   	pop    %eax
80108366:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
8010836c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80108371:	5a                   	pop    %edx
80108372:	ff 75 e4             	pushl  -0x1c(%ebp)
80108375:	50                   	push   %eax
80108376:	89 fa                	mov    %edi,%edx
80108378:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010837b:	e8 c0 f8 ff ff       	call   80107c40 <mappages>
80108380:	83 c4 10             	add    $0x10,%esp
80108383:	85 c0                	test   %eax,%eax
80108385:	78 61                	js     801083e8 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80108387:	81 c7 00 10 00 00    	add    $0x1000,%edi
8010838d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80108390:	76 46                	jbe    801083d8 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80108392:	8b 45 08             	mov    0x8(%ebp),%eax
80108395:	31 c9                	xor    %ecx,%ecx
80108397:	89 fa                	mov    %edi,%edx
80108399:	e8 22 f8 ff ff       	call   80107bc0 <walkpgdir>
8010839e:	85 c0                	test   %eax,%eax
801083a0:	74 61                	je     80108403 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
801083a2:	8b 00                	mov    (%eax),%eax
801083a4:	a8 01                	test   $0x1,%al
801083a6:	74 4e                	je     801083f6 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
801083a8:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
801083aa:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
801083af:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
801083b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
801083b8:	e8 33 a1 ff ff       	call   801024f0 <kalloc>
801083bd:	85 c0                	test   %eax,%eax
801083bf:	89 c6                	mov    %eax,%esi
801083c1:	75 8d                	jne    80108350 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
801083c3:	83 ec 0c             	sub    $0xc,%esp
801083c6:	ff 75 e0             	pushl  -0x20(%ebp)
801083c9:	e8 02 fe ff ff       	call   801081d0 <freevm>
  return 0;
801083ce:	83 c4 10             	add    $0x10,%esp
801083d1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
801083d8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801083db:	8d 65 f4             	lea    -0xc(%ebp),%esp
801083de:	5b                   	pop    %ebx
801083df:	5e                   	pop    %esi
801083e0:	5f                   	pop    %edi
801083e1:	5d                   	pop    %ebp
801083e2:	c3                   	ret    
801083e3:	90                   	nop
801083e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
801083e8:	83 ec 0c             	sub    $0xc,%esp
801083eb:	56                   	push   %esi
801083ec:	e8 4f 9f ff ff       	call   80102340 <kfree>
      goto bad;
801083f1:	83 c4 10             	add    $0x10,%esp
801083f4:	eb cd                	jmp    801083c3 <copyuvm+0xa3>
      panic("copyuvm: page not present");
801083f6:	83 ec 0c             	sub    $0xc,%esp
801083f9:	68 3a 8f 10 80       	push   $0x80108f3a
801083fe:	e8 8d 7f ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80108403:	83 ec 0c             	sub    $0xc,%esp
80108406:	68 20 8f 10 80       	push   $0x80108f20
8010840b:	e8 80 7f ff ff       	call   80100390 <panic>

80108410 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108410:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108411:	31 c9                	xor    %ecx,%ecx
{
80108413:	89 e5                	mov    %esp,%ebp
80108415:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80108418:	8b 55 0c             	mov    0xc(%ebp),%edx
8010841b:	8b 45 08             	mov    0x8(%ebp),%eax
8010841e:	e8 9d f7 ff ff       	call   80107bc0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80108423:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80108425:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80108426:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80108428:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
8010842d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80108430:	05 00 00 00 80       	add    $0x80000000,%eax
80108435:	83 fa 05             	cmp    $0x5,%edx
80108438:	ba 00 00 00 00       	mov    $0x0,%edx
8010843d:	0f 45 c2             	cmovne %edx,%eax
}
80108440:	c3                   	ret    
80108441:	eb 0d                	jmp    80108450 <copyout>
80108443:	90                   	nop
80108444:	90                   	nop
80108445:	90                   	nop
80108446:	90                   	nop
80108447:	90                   	nop
80108448:	90                   	nop
80108449:	90                   	nop
8010844a:	90                   	nop
8010844b:	90                   	nop
8010844c:	90                   	nop
8010844d:	90                   	nop
8010844e:	90                   	nop
8010844f:	90                   	nop

80108450 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108450:	55                   	push   %ebp
80108451:	89 e5                	mov    %esp,%ebp
80108453:	57                   	push   %edi
80108454:	56                   	push   %esi
80108455:	53                   	push   %ebx
80108456:	83 ec 1c             	sub    $0x1c,%esp
80108459:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010845c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010845f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80108462:	85 db                	test   %ebx,%ebx
80108464:	75 40                	jne    801084a6 <copyout+0x56>
80108466:	eb 70                	jmp    801084d8 <copyout+0x88>
80108468:	90                   	nop
80108469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80108470:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80108473:	89 f1                	mov    %esi,%ecx
80108475:	29 d1                	sub    %edx,%ecx
80108477:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010847d:	39 d9                	cmp    %ebx,%ecx
8010847f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80108482:	29 f2                	sub    %esi,%edx
80108484:	83 ec 04             	sub    $0x4,%esp
80108487:	01 d0                	add    %edx,%eax
80108489:	51                   	push   %ecx
8010848a:	57                   	push   %edi
8010848b:	50                   	push   %eax
8010848c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010848f:	e8 3c c6 ff ff       	call   80104ad0 <memmove>
    len -= n;
    buf += n;
80108494:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80108497:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
8010849a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
801084a0:	01 cf                	add    %ecx,%edi
  while(len > 0){
801084a2:	29 cb                	sub    %ecx,%ebx
801084a4:	74 32                	je     801084d8 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
801084a6:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801084a8:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
801084ab:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801084ae:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801084b4:	56                   	push   %esi
801084b5:	ff 75 08             	pushl  0x8(%ebp)
801084b8:	e8 53 ff ff ff       	call   80108410 <uva2ka>
    if(pa0 == 0)
801084bd:	83 c4 10             	add    $0x10,%esp
801084c0:	85 c0                	test   %eax,%eax
801084c2:	75 ac                	jne    80108470 <copyout+0x20>
  }
  return 0;
}
801084c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801084c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801084cc:	5b                   	pop    %ebx
801084cd:	5e                   	pop    %esi
801084ce:	5f                   	pop    %edi
801084cf:	5d                   	pop    %ebp
801084d0:	c3                   	ret    
801084d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801084d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801084db:	31 c0                	xor    %eax,%eax
}
801084dd:	5b                   	pop    %ebx
801084de:	5e                   	pop    %esi
801084df:	5f                   	pop    %edi
801084e0:	5d                   	pop    %ebp
801084e1:	c3                   	ret    
