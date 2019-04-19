
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
80100044:	bb f4 cd 10 80       	mov    $0x8010cdf4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 a0 7c 10 80       	push   $0x80107ca0
80100051:	68 c0 cd 10 80       	push   $0x8010cdc0
80100056:	e8 05 45 00 00       	call   80104560 <initlock>
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
80100092:	68 a7 7c 10 80       	push   $0x80107ca7
80100097:	50                   	push   %eax
80100098:	e8 93 43 00 00       	call   80104430 <initsleeplock>
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
801000e4:	e8 b7 45 00 00       	call   801046a0 <acquire>
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
80100162:	e8 f9 45 00 00       	call   80104760 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 fe 42 00 00       	call   80104470 <acquiresleep>
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
80100193:	68 ae 7c 10 80       	push   $0x80107cae
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
801001ae:	e8 5d 43 00 00       	call   80104510 <holdingsleep>
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
801001cc:	68 bf 7c 10 80       	push   $0x80107cbf
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
801001ef:	e8 1c 43 00 00       	call   80104510 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 cc 42 00 00       	call   801044d0 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 cd 10 80 	movl   $0x8010cdc0,(%esp)
8010020b:	e8 90 44 00 00       	call   801046a0 <acquire>
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
8010025c:	e9 ff 44 00 00       	jmp    80104760 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 c6 7c 10 80       	push   $0x80107cc6
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
8010028c:	e8 0f 44 00 00       	call   801046a0 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 40 1c 11 80    	mov    0x80111c40,%edx
801002a7:	39 15 44 1c 11 80    	cmp    %edx,0x80111c44
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
801002c0:	68 40 1c 11 80       	push   $0x80111c40
801002c5:	e8 96 3b 00 00       	call   80103e60 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 40 1c 11 80    	mov    0x80111c40,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 44 1c 11 80    	cmp    0x80111c44,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 20 35 00 00       	call   80103800 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 b5 10 80       	push   $0x8010b520
801002ef:	e8 6c 44 00 00       	call   80104760 <release>
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
80100313:	a3 40 1c 11 80       	mov    %eax,0x80111c40
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 c0 1b 11 80 	movsbl -0x7feee440(%eax),%eax
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
8010034d:	e8 0e 44 00 00       	call   80104760 <release>
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
80100372:	89 15 40 1c 11 80    	mov    %edx,0x80111c40
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
801003a9:	e8 a2 23 00 00       	call   80102750 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 cd 7c 10 80       	push   $0x80107ccd
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 ab 88 10 80 	movl   $0x801088ab,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 a3 41 00 00       	call   80104580 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 e1 7c 10 80       	push   $0x80107ce1
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
8010043a:	e8 61 64 00 00       	call   801068a0 <uartputc>
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
801004ec:	e8 af 63 00 00       	call   801068a0 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 a3 63 00 00       	call   801068a0 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 97 63 00 00       	call   801068a0 <uartputc>
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
80100524:	e8 37 43 00 00       	call   80104860 <memmove>
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
80100541:	e8 6a 42 00 00       	call   801047b0 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 e5 7c 10 80       	push   $0x80107ce5
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
801005b1:	0f b6 92 10 7d 10 80 	movzbl -0x7fef82f0(%edx),%edx
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
8010061b:	e8 80 40 00 00       	call   801046a0 <acquire>
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
80100647:	e8 14 41 00 00       	call   80104760 <release>
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
8010071f:	e8 3c 40 00 00       	call   80104760 <release>
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
801007d0:	ba f8 7c 10 80       	mov    $0x80107cf8,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 b5 10 80       	push   $0x8010b520
801007f0:	e8 ab 3e 00 00       	call   801046a0 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 ff 7c 10 80       	push   $0x80107cff
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
80100823:	e8 78 3e 00 00       	call   801046a0 <acquire>
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
80100851:	a1 48 1c 11 80       	mov    0x80111c48,%eax
80100856:	3b 05 44 1c 11 80    	cmp    0x80111c44,%eax
8010085c:	74 d2                	je     80100830 <consoleintr+0x20>
        input.e--;
8010085e:	83 e8 01             	sub    $0x1,%eax
80100861:	a3 48 1c 11 80       	mov    %eax,0x80111c48
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
80100888:	e8 d3 3e 00 00       	call   80104760 <release>
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
801008a9:	a1 48 1c 11 80       	mov    0x80111c48,%eax
801008ae:	89 c2                	mov    %eax,%edx
801008b0:	2b 15 40 1c 11 80    	sub    0x80111c40,%edx
801008b6:	83 fa 7f             	cmp    $0x7f,%edx
801008b9:	0f 87 71 ff ff ff    	ja     80100830 <consoleintr+0x20>
801008bf:	8d 50 01             	lea    0x1(%eax),%edx
801008c2:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801008c5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008c8:	89 15 48 1c 11 80    	mov    %edx,0x80111c48
        c = (c == '\r') ? '\n' : c;
801008ce:	0f 84 cc 00 00 00    	je     801009a0 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d4:	89 f9                	mov    %edi,%ecx
801008d6:	88 88 c0 1b 11 80    	mov    %cl,-0x7feee440(%eax)
        consputc(c);
801008dc:	89 f8                	mov    %edi,%eax
801008de:	e8 2d fb ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e3:	83 ff 0a             	cmp    $0xa,%edi
801008e6:	0f 84 c5 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008ec:	83 ff 04             	cmp    $0x4,%edi
801008ef:	0f 84 bc 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008f5:	a1 40 1c 11 80       	mov    0x80111c40,%eax
801008fa:	83 e8 80             	sub    $0xffffff80,%eax
801008fd:	39 05 48 1c 11 80    	cmp    %eax,0x80111c48
80100903:	0f 85 27 ff ff ff    	jne    80100830 <consoleintr+0x20>
          wakeup(&input.r);
80100909:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
8010090c:	a3 44 1c 11 80       	mov    %eax,0x80111c44
          wakeup(&input.r);
80100911:	68 40 1c 11 80       	push   $0x80111c40
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
80100938:	a1 48 1c 11 80       	mov    0x80111c48,%eax
8010093d:	39 05 44 1c 11 80    	cmp    %eax,0x80111c44
80100943:	75 2b                	jne    80100970 <consoleintr+0x160>
80100945:	e9 e6 fe ff ff       	jmp    80100830 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100950:	a3 48 1c 11 80       	mov    %eax,0x80111c48
        consputc(BACKSPACE);
80100955:	b8 00 01 00 00       	mov    $0x100,%eax
8010095a:	e8 b1 fa ff ff       	call   80100410 <consputc>
      while(input.e != input.w &&
8010095f:	a1 48 1c 11 80       	mov    0x80111c48,%eax
80100964:	3b 05 44 1c 11 80    	cmp    0x80111c44,%eax
8010096a:	0f 84 c0 fe ff ff    	je     80100830 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100970:	83 e8 01             	sub    $0x1,%eax
80100973:	89 c2                	mov    %eax,%edx
80100975:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100978:	80 ba c0 1b 11 80 0a 	cmpb   $0xa,-0x7feee440(%edx)
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
801009a0:	c6 80 c0 1b 11 80 0a 	movb   $0xa,-0x7feee440(%eax)
        consputc(c);
801009a7:	b8 0a 00 00 00       	mov    $0xa,%eax
801009ac:	e8 5f fa ff ff       	call   80100410 <consputc>
801009b1:	a1 48 1c 11 80       	mov    0x80111c48,%eax
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
801009c6:	68 08 7d 10 80       	push   $0x80107d08
801009cb:	68 20 b5 10 80       	push   $0x8010b520
801009d0:	e8 8b 3b 00 00       	call   80104560 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009d5:	58                   	pop    %eax
801009d6:	5a                   	pop    %edx
801009d7:	6a 00                	push   $0x0
801009d9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801009db:	c7 05 2c 29 11 80 00 	movl   $0x80100600,0x8011292c
801009e2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009e5:	c7 05 28 29 11 80 70 	movl   $0x80100270,0x80112928
801009ec:	02 10 80 
  cons.locking = 1;
801009ef:	c7 05 54 b5 10 80 01 	movl   $0x1,0x8010b554
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
80100a94:	e8 57 6f 00 00       	call   801079f0 <setupkvm>
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
80100af6:	e8 15 6d 00 00       	call   80107810 <allocuvm>
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
80100b28:	e8 23 6c 00 00       	call   80107750 <loaduvm>
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
80100b72:	e8 f9 6d 00 00       	call   80107970 <freevm>
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
80100baa:	e8 61 6c 00 00       	call   80107810 <allocuvm>
80100baf:	83 c4 10             	add    $0x10,%esp
80100bb2:	85 c0                	test   %eax,%eax
80100bb4:	89 c6                	mov    %eax,%esi
80100bb6:	75 3a                	jne    80100bf2 <exec+0x1e2>
    freevm(pgdir);
80100bb8:	83 ec 0c             	sub    $0xc,%esp
80100bbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bc1:	e8 aa 6d 00 00       	call   80107970 <freevm>
80100bc6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100bc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bce:	e9 a9 fe ff ff       	jmp    80100a7c <exec+0x6c>
    end_op();
80100bd3:	e8 58 20 00 00       	call   80102c30 <end_op>
    cprintf("exec: fail\n");
80100bd8:	83 ec 0c             	sub    $0xc,%esp
80100bdb:	68 21 7d 10 80       	push   $0x80107d21
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
80100c06:	e8 85 6e 00 00       	call   80107a90 <clearpteu>
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
80100c39:	e8 92 3d 00 00       	call   801049d0 <strlen>
80100c3e:	f7 d0                	not    %eax
80100c40:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c42:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c45:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c46:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c49:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4c:	e8 7f 3d 00 00       	call   801049d0 <strlen>
80100c51:	83 c0 01             	add    $0x1,%eax
80100c54:	50                   	push   %eax
80100c55:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c58:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c5b:	53                   	push   %ebx
80100c5c:	56                   	push   %esi
80100c5d:	e8 8e 6f 00 00       	call   80107bf0 <copyout>
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
80100cc7:	e8 24 6f 00 00       	call   80107bf0 <copyout>
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
80100d0c:	e8 7f 3c 00 00       	call   80104990 <safestrcpy>
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
80100d36:	e8 85 68 00 00       	call   801075c0 <switchuvm>
  freevm(oldpgdir);
80100d3b:	89 3c 24             	mov    %edi,(%esp)
80100d3e:	e8 2d 6c 00 00       	call   80107970 <freevm>
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
80100d66:	68 2d 7d 10 80       	push   $0x80107d2d
80100d6b:	68 60 1c 11 80       	push   $0x80111c60
80100d70:	e8 eb 37 00 00       	call   80104560 <initlock>
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
80100d84:	bb 94 1c 11 80       	mov    $0x80111c94,%ebx
{
80100d89:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100d8c:	68 60 1c 11 80       	push   $0x80111c60
80100d91:	e8 0a 39 00 00       	call   801046a0 <acquire>
80100d96:	83 c4 10             	add    $0x10,%esp
80100d99:	eb 10                	jmp    80100dab <filealloc+0x2b>
80100d9b:	90                   	nop
80100d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100da0:	83 c3 20             	add    $0x20,%ebx
80100da3:	81 fb 14 29 11 80    	cmp    $0x80112914,%ebx
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
80100dbc:	68 60 1c 11 80       	push   $0x80111c60
80100dc1:	e8 9a 39 00 00       	call   80104760 <release>
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
80100dd5:	68 60 1c 11 80       	push   $0x80111c60
80100dda:	e8 81 39 00 00       	call   80104760 <release>
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
80100dfa:	68 60 1c 11 80       	push   $0x80111c60
80100dff:	e8 9c 38 00 00       	call   801046a0 <acquire>
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
80100e17:	68 60 1c 11 80       	push   $0x80111c60
80100e1c:	e8 3f 39 00 00       	call   80104760 <release>
  return f;
}
80100e21:	89 d8                	mov    %ebx,%eax
80100e23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e26:	c9                   	leave  
80100e27:	c3                   	ret    
    panic("filedup");
80100e28:	83 ec 0c             	sub    $0xc,%esp
80100e2b:	68 34 7d 10 80       	push   $0x80107d34
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
80100e4c:	68 60 1c 11 80       	push   $0x80111c60
80100e51:	e8 4a 38 00 00       	call   801046a0 <acquire>
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
80100e6e:	c7 45 08 60 1c 11 80 	movl   $0x80111c60,0x8(%ebp)
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
80100e7c:	e9 df 38 00 00       	jmp    80104760 <release>
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
80100ea0:	68 60 1c 11 80       	push   $0x80111c60
  ff = *f;
80100ea5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100ea8:	e8 b3 38 00 00       	call   80104760 <release>
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
80100f02:	68 3c 7d 10 80       	push   $0x80107d3c
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
80100fe2:	68 46 7d 10 80       	push   $0x80107d46
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
801010f5:	68 4f 7d 10 80       	push   $0x80107d4f
801010fa:	e8 91 f2 ff ff       	call   80100390 <panic>
  panic("filewrite");
801010ff:	83 ec 0c             	sub    $0xc,%esp
80101102:	68 55 7d 10 80       	push   $0x80107d55
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
80101119:	8b 0d 80 29 11 80    	mov    0x80112980,%ecx
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
8010113c:	03 05 98 29 11 80    	add    0x80112998,%eax
80101142:	50                   	push   %eax
80101143:	ff 75 d8             	pushl  -0x28(%ebp)
80101146:	e8 85 ef ff ff       	call   801000d0 <bread>
8010114b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010114e:	a1 80 29 11 80       	mov    0x80112980,%eax
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
801011a9:	39 05 80 29 11 80    	cmp    %eax,0x80112980
801011af:	77 80                	ja     80101131 <balloc+0x21>
  }
  panic("balloc: out of blocks");
801011b1:	83 ec 0c             	sub    $0xc,%esp
801011b4:	68 5f 7d 10 80       	push   $0x80107d5f
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
801011f5:	e8 b6 35 00 00       	call   801047b0 <memset>
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
8010122a:	bb d4 29 11 80       	mov    $0x801129d4,%ebx
{
8010122f:	83 ec 28             	sub    $0x28,%esp
80101232:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101235:	68 a0 29 11 80       	push   $0x801129a0
8010123a:	e8 61 34 00 00       	call   801046a0 <acquire>
8010123f:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101242:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101245:	eb 17                	jmp    8010125e <iget+0x3e>
80101247:	89 f6                	mov    %esi,%esi
80101249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101250:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101256:	81 fb f4 45 11 80    	cmp    $0x801145f4,%ebx
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
80101278:	81 fb f4 45 11 80    	cmp    $0x801145f4,%ebx
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
8010129a:	68 a0 29 11 80       	push   $0x801129a0
8010129f:	e8 bc 34 00 00       	call   80104760 <release>

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
801012c5:	68 a0 29 11 80       	push   $0x801129a0
      ip->ref++;
801012ca:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801012cd:	e8 8e 34 00 00       	call   80104760 <release>
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
801012e2:	68 75 7d 10 80       	push   $0x80107d75
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
801013b7:	68 85 7d 10 80       	push   $0x80107d85
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
801013f1:	e8 6a 34 00 00       	call   80104860 <memmove>
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
8010141c:	68 80 29 11 80       	push   $0x80112980
80101421:	50                   	push   %eax
80101422:	e8 a9 ff ff ff       	call   801013d0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101427:	58                   	pop    %eax
80101428:	5a                   	pop    %edx
80101429:	89 da                	mov    %ebx,%edx
8010142b:	c1 ea 0c             	shr    $0xc,%edx
8010142e:	03 15 98 29 11 80    	add    0x80112998,%edx
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
80101484:	68 98 7d 10 80       	push   $0x80107d98
80101489:	e8 02 ef ff ff       	call   80100390 <panic>
8010148e:	66 90                	xchg   %ax,%ax

80101490 <iinit>:
{
80101490:	55                   	push   %ebp
80101491:	89 e5                	mov    %esp,%ebp
80101493:	53                   	push   %ebx
80101494:	bb e0 29 11 80       	mov    $0x801129e0,%ebx
80101499:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010149c:	68 ab 7d 10 80       	push   $0x80107dab
801014a1:	68 a0 29 11 80       	push   $0x801129a0
801014a6:	e8 b5 30 00 00       	call   80104560 <initlock>
801014ab:	83 c4 10             	add    $0x10,%esp
801014ae:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801014b0:	83 ec 08             	sub    $0x8,%esp
801014b3:	68 b2 7d 10 80       	push   $0x80107db2
801014b8:	53                   	push   %ebx
801014b9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014bf:	e8 6c 2f 00 00       	call   80104430 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014c4:	83 c4 10             	add    $0x10,%esp
801014c7:	81 fb 00 46 11 80    	cmp    $0x80114600,%ebx
801014cd:	75 e1                	jne    801014b0 <iinit+0x20>
  readsb(dev, &sb);
801014cf:	83 ec 08             	sub    $0x8,%esp
801014d2:	68 80 29 11 80       	push   $0x80112980
801014d7:	ff 75 08             	pushl  0x8(%ebp)
801014da:	e8 f1 fe ff ff       	call   801013d0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014df:	ff 35 98 29 11 80    	pushl  0x80112998
801014e5:	ff 35 94 29 11 80    	pushl  0x80112994
801014eb:	ff 35 90 29 11 80    	pushl  0x80112990
801014f1:	ff 35 8c 29 11 80    	pushl  0x8011298c
801014f7:	ff 35 88 29 11 80    	pushl  0x80112988
801014fd:	ff 35 84 29 11 80    	pushl  0x80112984
80101503:	ff 35 80 29 11 80    	pushl  0x80112980
80101509:	68 18 7e 10 80       	push   $0x80107e18
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
80101529:	83 3d 88 29 11 80 01 	cmpl   $0x1,0x80112988
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
8010155f:	39 1d 88 29 11 80    	cmp    %ebx,0x80112988
80101565:	76 69                	jbe    801015d0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101567:	89 d8                	mov    %ebx,%eax
80101569:	83 ec 08             	sub    $0x8,%esp
8010156c:	c1 e8 03             	shr    $0x3,%eax
8010156f:	03 05 94 29 11 80    	add    0x80112994,%eax
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
8010159e:	e8 0d 32 00 00       	call   801047b0 <memset>
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
801015d3:	68 b8 7d 10 80       	push   $0x80107db8
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
801015f4:	03 05 94 29 11 80    	add    0x80112994,%eax
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
80101641:	e8 1a 32 00 00       	call   80104860 <memmove>
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
8010166a:	68 a0 29 11 80       	push   $0x801129a0
8010166f:	e8 2c 30 00 00       	call   801046a0 <acquire>
  ip->ref++;
80101674:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101678:	c7 04 24 a0 29 11 80 	movl   $0x801129a0,(%esp)
8010167f:	e8 dc 30 00 00       	call   80104760 <release>
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
801016b2:	e8 b9 2d 00 00       	call   80104470 <acquiresleep>
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
801016d9:	03 05 94 29 11 80    	add    0x80112994,%eax
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
80101728:	e8 33 31 00 00       	call   80104860 <memmove>
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
8010174d:	68 d0 7d 10 80       	push   $0x80107dd0
80101752:	e8 39 ec ff ff       	call   80100390 <panic>
    panic("ilock");
80101757:	83 ec 0c             	sub    $0xc,%esp
8010175a:	68 ca 7d 10 80       	push   $0x80107dca
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
80101783:	e8 88 2d 00 00       	call   80104510 <holdingsleep>
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
8010179f:	e9 2c 2d 00 00       	jmp    801044d0 <releasesleep>
    panic("iunlock");
801017a4:	83 ec 0c             	sub    $0xc,%esp
801017a7:	68 df 7d 10 80       	push   $0x80107ddf
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
801017d0:	e8 9b 2c 00 00       	call   80104470 <acquiresleep>
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
801017ea:	e8 e1 2c 00 00       	call   801044d0 <releasesleep>
  acquire(&icache.lock);
801017ef:	c7 04 24 a0 29 11 80 	movl   $0x801129a0,(%esp)
801017f6:	e8 a5 2e 00 00       	call   801046a0 <acquire>
  ip->ref--;
801017fb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801017ff:	83 c4 10             	add    $0x10,%esp
80101802:	c7 45 08 a0 29 11 80 	movl   $0x801129a0,0x8(%ebp)
}
80101809:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010180c:	5b                   	pop    %ebx
8010180d:	5e                   	pop    %esi
8010180e:	5f                   	pop    %edi
8010180f:	5d                   	pop    %ebp
  release(&icache.lock);
80101810:	e9 4b 2f 00 00       	jmp    80104760 <release>
80101815:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101818:	83 ec 0c             	sub    $0xc,%esp
8010181b:	68 a0 29 11 80       	push   $0x801129a0
80101820:	e8 7b 2e 00 00       	call   801046a0 <acquire>
    int r = ip->ref;
80101825:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101828:	c7 04 24 a0 29 11 80 	movl   $0x801129a0,(%esp)
8010182f:	e8 2c 2f 00 00       	call   80104760 <release>
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
80101a17:	e8 44 2e 00 00       	call   80104860 <memmove>
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
80101a4a:	8b 04 c5 20 29 11 80 	mov    -0x7feed6e0(,%eax,8),%eax
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
80101b13:	e8 48 2d 00 00       	call   80104860 <memmove>
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
80101b5a:	8b 04 c5 24 29 11 80 	mov    -0x7feed6dc(,%eax,8),%eax
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
80101bae:	e8 1d 2d 00 00       	call   801048d0 <strncmp>
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
80101c0d:	e8 be 2c 00 00       	call   801048d0 <strncmp>
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
80101c52:	68 f9 7d 10 80       	push   $0x80107df9
80101c57:	e8 34 e7 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101c5c:	83 ec 0c             	sub    $0xc,%esp
80101c5f:	68 e7 7d 10 80       	push   $0x80107de7
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
80101c97:	68 a0 29 11 80       	push   $0x801129a0
80101c9c:	e8 ff 29 00 00       	call   801046a0 <acquire>
  ip->ref++;
80101ca1:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101ca5:	c7 04 24 a0 29 11 80 	movl   $0x801129a0,(%esp)
80101cac:	e8 af 2a 00 00       	call   80104760 <release>
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
80101d15:	e8 46 2b 00 00       	call   80104860 <memmove>
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
80101da8:	e8 b3 2a 00 00       	call   80104860 <memmove>
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
80101e9d:	e8 8e 2a 00 00       	call   80104930 <strncpy>
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
80101edb:	68 08 7e 10 80       	push   $0x80107e08
80101ee0:	e8 ab e4 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101ee5:	83 ec 0c             	sub    $0xc,%esp
80101ee8:	68 62 84 10 80       	push   $0x80108462
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
80101ffb:	68 74 7e 10 80       	push   $0x80107e74
80102000:	e8 8b e3 ff ff       	call   80100390 <panic>
    panic("idestart");
80102005:	83 ec 0c             	sub    $0xc,%esp
80102008:	68 6b 7e 10 80       	push   $0x80107e6b
8010200d:	e8 7e e3 ff ff       	call   80100390 <panic>
80102012:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102020 <ideinit>:
{
80102020:	55                   	push   %ebp
80102021:	89 e5                	mov    %esp,%ebp
80102023:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102026:	68 86 7e 10 80       	push   $0x80107e86
8010202b:	68 80 b5 10 80       	push   $0x8010b580
80102030:	e8 2b 25 00 00       	call   80104560 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102035:	58                   	pop    %eax
80102036:	a1 c0 4c 11 80       	mov    0x80114cc0,%eax
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
8010207a:	c7 05 60 b5 10 80 01 	movl   $0x1,0x8010b560
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
801020a9:	68 80 b5 10 80       	push   $0x8010b580
801020ae:	e8 ed 25 00 00       	call   801046a0 <acquire>

  if((b = idequeue) == 0){
801020b3:	8b 1d 64 b5 10 80    	mov    0x8010b564,%ebx
801020b9:	83 c4 10             	add    $0x10,%esp
801020bc:	85 db                	test   %ebx,%ebx
801020be:	74 67                	je     80102127 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801020c0:	8b 43 58             	mov    0x58(%ebx),%eax
801020c3:	a3 64 b5 10 80       	mov    %eax,0x8010b564

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
80102116:	a1 64 b5 10 80       	mov    0x8010b564,%eax
8010211b:	83 c4 10             	add    $0x10,%esp
8010211e:	85 c0                	test   %eax,%eax
80102120:	74 05                	je     80102127 <ideintr+0x87>
    idestart(idequeue);
80102122:	e8 19 fe ff ff       	call   80101f40 <idestart>
    release(&idelock);
80102127:	83 ec 0c             	sub    $0xc,%esp
8010212a:	68 80 b5 10 80       	push   $0x8010b580
8010212f:	e8 2c 26 00 00       	call   80104760 <release>

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
8010214e:	e8 bd 23 00 00       	call   80104510 <holdingsleep>
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
80102173:	a1 60 b5 10 80       	mov    0x8010b560,%eax
80102178:	85 c0                	test   %eax,%eax
8010217a:	0f 84 b1 00 00 00    	je     80102231 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102180:	83 ec 0c             	sub    $0xc,%esp
80102183:	68 80 b5 10 80       	push   $0x8010b580
80102188:	e8 13 25 00 00       	call   801046a0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010218d:	8b 15 64 b5 10 80    	mov    0x8010b564,%edx
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
801021b6:	39 1d 64 b5 10 80    	cmp    %ebx,0x8010b564
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
801021d3:	68 80 b5 10 80       	push   $0x8010b580
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
801021eb:	c7 45 08 80 b5 10 80 	movl   $0x8010b580,0x8(%ebp)
}
801021f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021f5:	c9                   	leave  
  release(&idelock);
801021f6:	e9 65 25 00 00       	jmp    80104760 <release>
801021fb:	90                   	nop
801021fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
80102200:	89 d8                	mov    %ebx,%eax
80102202:	e8 39 fd ff ff       	call   80101f40 <idestart>
80102207:	eb b5                	jmp    801021be <iderw+0x7e>
80102209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102210:	ba 64 b5 10 80       	mov    $0x8010b564,%edx
80102215:	eb 9d                	jmp    801021b4 <iderw+0x74>
    panic("iderw: nothing to do");
80102217:	83 ec 0c             	sub    $0xc,%esp
8010221a:	68 a0 7e 10 80       	push   $0x80107ea0
8010221f:	e8 6c e1 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102224:	83 ec 0c             	sub    $0xc,%esp
80102227:	68 8a 7e 10 80       	push   $0x80107e8a
8010222c:	e8 5f e1 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102231:	83 ec 0c             	sub    $0xc,%esp
80102234:	68 b5 7e 10 80       	push   $0x80107eb5
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
80102241:	c7 05 f4 45 11 80 00 	movl   $0xfec00000,0x801145f4
80102248:	00 c0 fe 
{
8010224b:	89 e5                	mov    %esp,%ebp
8010224d:	56                   	push   %esi
8010224e:	53                   	push   %ebx
  ioapic->reg = reg;
8010224f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102256:	00 00 00 
  return ioapic->data;
80102259:	a1 f4 45 11 80       	mov    0x801145f4,%eax
8010225e:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102261:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102267:	8b 0d f4 45 11 80    	mov    0x801145f4,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010226d:	0f b6 15 20 47 11 80 	movzbl 0x80114720,%edx
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
80102287:	68 d4 7e 10 80       	push   $0x80107ed4
8010228c:	e8 cf e3 ff ff       	call   80100660 <cprintf>
80102291:	8b 0d f4 45 11 80    	mov    0x801145f4,%ecx
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
801022b2:	8b 0d f4 45 11 80    	mov    0x801145f4,%ecx

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
801022d0:	8b 0d f4 45 11 80    	mov    0x801145f4,%ecx
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
801022f1:	8b 0d f4 45 11 80    	mov    0x801145f4,%ecx
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
80102305:	8b 0d f4 45 11 80    	mov    0x801145f4,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010230b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010230e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102311:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102314:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102316:	a1 f4 45 11 80       	mov    0x801145f4,%eax
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
80102342:	81 fb 68 c9 11 80    	cmp    $0x8011c968,%ebx
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
80102362:	e8 49 24 00 00       	call   801047b0 <memset>

  if(kmem.use_lock)
80102367:	8b 15 34 46 11 80    	mov    0x80114634,%edx
8010236d:	83 c4 10             	add    $0x10,%esp
80102370:	85 d2                	test   %edx,%edx
80102372:	75 2c                	jne    801023a0 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102374:	a1 38 46 11 80       	mov    0x80114638,%eax
80102379:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010237b:	a1 34 46 11 80       	mov    0x80114634,%eax
  kmem.freelist = r;
80102380:	89 1d 38 46 11 80    	mov    %ebx,0x80114638
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
80102390:	c7 45 08 00 46 11 80 	movl   $0x80114600,0x8(%ebp)
}
80102397:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010239a:	c9                   	leave  
    release(&kmem.lock);
8010239b:	e9 c0 23 00 00       	jmp    80104760 <release>
    acquire(&kmem.lock);
801023a0:	83 ec 0c             	sub    $0xc,%esp
801023a3:	68 00 46 11 80       	push   $0x80114600
801023a8:	e8 f3 22 00 00       	call   801046a0 <acquire>
801023ad:	83 c4 10             	add    $0x10,%esp
801023b0:	eb c2                	jmp    80102374 <kfree+0x44>
    panic("kfree");
801023b2:	83 ec 0c             	sub    $0xc,%esp
801023b5:	68 06 7f 10 80       	push   $0x80107f06
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
8010241b:	68 0c 7f 10 80       	push   $0x80107f0c
80102420:	68 00 46 11 80       	push   $0x80114600
80102425:	e8 36 21 00 00       	call   80104560 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010242a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010242d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102430:	c7 05 34 46 11 80 00 	movl   $0x0,0x80114634
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
801024c4:	c7 05 34 46 11 80 01 	movl   $0x1,0x80114634
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
801024e0:	a1 34 46 11 80       	mov    0x80114634,%eax
801024e5:	85 c0                	test   %eax,%eax
801024e7:	75 1f                	jne    80102508 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801024e9:	a1 38 46 11 80       	mov    0x80114638,%eax
  if(r)
801024ee:	85 c0                	test   %eax,%eax
801024f0:	74 0e                	je     80102500 <kalloc+0x20>
    kmem.freelist = r->next;
801024f2:	8b 10                	mov    (%eax),%edx
801024f4:	89 15 38 46 11 80    	mov    %edx,0x80114638
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
8010250e:	68 00 46 11 80       	push   $0x80114600
80102513:	e8 88 21 00 00       	call   801046a0 <acquire>
  r = kmem.freelist;
80102518:	a1 38 46 11 80       	mov    0x80114638,%eax
  if(r)
8010251d:	83 c4 10             	add    $0x10,%esp
80102520:	8b 15 34 46 11 80    	mov    0x80114634,%edx
80102526:	85 c0                	test   %eax,%eax
80102528:	74 08                	je     80102532 <kalloc+0x52>
    kmem.freelist = r->next;
8010252a:	8b 08                	mov    (%eax),%ecx
8010252c:	89 0d 38 46 11 80    	mov    %ecx,0x80114638
  if(kmem.use_lock)
80102532:	85 d2                	test   %edx,%edx
80102534:	74 16                	je     8010254c <kalloc+0x6c>
    release(&kmem.lock);
80102536:	83 ec 0c             	sub    $0xc,%esp
80102539:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010253c:	68 00 46 11 80       	push   $0x80114600
80102541:	e8 1a 22 00 00       	call   80104760 <release>
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
80102567:	8b 0d b4 b5 10 80    	mov    0x8010b5b4,%ecx

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
80102593:	0f b6 82 40 80 10 80 	movzbl -0x7fef7fc0(%edx),%eax
8010259a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
8010259c:	0f b6 82 40 7f 10 80 	movzbl -0x7fef80c0(%edx),%eax
801025a3:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801025a5:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
801025a7:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
  c = charcode[shift & (CTL | SHIFT)][data];
801025ad:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801025b0:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801025b3:	8b 04 85 20 7f 10 80 	mov    -0x7fef80e0(,%eax,4),%eax
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
801025d8:	0f b6 82 40 80 10 80 	movzbl -0x7fef7fc0(%edx),%eax
801025df:	83 c8 40             	or     $0x40,%eax
801025e2:	0f b6 c0             	movzbl %al,%eax
801025e5:	f7 d0                	not    %eax
801025e7:	21 c1                	and    %eax,%ecx
    return 0;
801025e9:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801025eb:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
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
801025fd:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
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
80102650:	a1 3c 46 11 80       	mov    0x8011463c,%eax
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
80102750:	8b 15 3c 46 11 80    	mov    0x8011463c,%edx
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
80102770:	a1 3c 46 11 80       	mov    0x8011463c,%eax
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
801027de:	a1 3c 46 11 80       	mov    0x8011463c,%eax
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
80102957:	e8 a4 1e 00 00       	call   80104800 <memcmp>
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
80102a20:	8b 0d 88 46 11 80    	mov    0x80114688,%ecx
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
80102a40:	a1 74 46 11 80       	mov    0x80114674,%eax
80102a45:	83 ec 08             	sub    $0x8,%esp
80102a48:	01 d8                	add    %ebx,%eax
80102a4a:	83 c0 01             	add    $0x1,%eax
80102a4d:	50                   	push   %eax
80102a4e:	ff 35 84 46 11 80    	pushl  0x80114684
80102a54:	e8 77 d6 ff ff       	call   801000d0 <bread>
80102a59:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a5b:	58                   	pop    %eax
80102a5c:	5a                   	pop    %edx
80102a5d:	ff 34 9d 8c 46 11 80 	pushl  -0x7feeb974(,%ebx,4)
80102a64:	ff 35 84 46 11 80    	pushl  0x80114684
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
80102a84:	e8 d7 1d 00 00       	call   80104860 <memmove>
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
80102aa4:	39 1d 88 46 11 80    	cmp    %ebx,0x80114688
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
80102ac8:	ff 35 74 46 11 80    	pushl  0x80114674
80102ace:	ff 35 84 46 11 80    	pushl  0x80114684
80102ad4:	e8 f7 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102ad9:	8b 1d 88 46 11 80    	mov    0x80114688,%ebx
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
80102af0:	8b 8a 8c 46 11 80    	mov    -0x7feeb974(%edx),%ecx
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
80102b2a:	68 40 81 10 80       	push   $0x80108140
80102b2f:	68 40 46 11 80       	push   $0x80114640
80102b34:	e8 27 1a 00 00       	call   80104560 <initlock>
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
80102b4c:	89 1d 84 46 11 80    	mov    %ebx,0x80114684
  log.size = sb.nlog;
80102b52:	89 15 78 46 11 80    	mov    %edx,0x80114678
  log.start = sb.logstart;
80102b58:	a3 74 46 11 80       	mov    %eax,0x80114674
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
80102b6d:	89 1d 88 46 11 80    	mov    %ebx,0x80114688
  for (i = 0; i < log.lh.n; i++) {
80102b73:	7e 1c                	jle    80102b91 <initlog+0x71>
80102b75:	c1 e3 02             	shl    $0x2,%ebx
80102b78:	31 d2                	xor    %edx,%edx
80102b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102b80:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102b84:	83 c2 04             	add    $0x4,%edx
80102b87:	89 8a 88 46 11 80    	mov    %ecx,-0x7feeb978(%edx)
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
80102b9f:	c7 05 88 46 11 80 00 	movl   $0x0,0x80114688
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
80102bc6:	68 40 46 11 80       	push   $0x80114640
80102bcb:	e8 d0 1a 00 00       	call   801046a0 <acquire>
80102bd0:	83 c4 10             	add    $0x10,%esp
80102bd3:	eb 18                	jmp    80102bed <begin_op+0x2d>
80102bd5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102bd8:	83 ec 08             	sub    $0x8,%esp
80102bdb:	68 40 46 11 80       	push   $0x80114640
80102be0:	68 40 46 11 80       	push   $0x80114640
80102be5:	e8 76 12 00 00       	call   80103e60 <sleep>
80102bea:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102bed:	a1 80 46 11 80       	mov    0x80114680,%eax
80102bf2:	85 c0                	test   %eax,%eax
80102bf4:	75 e2                	jne    80102bd8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102bf6:	a1 7c 46 11 80       	mov    0x8011467c,%eax
80102bfb:	8b 15 88 46 11 80    	mov    0x80114688,%edx
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
80102c12:	a3 7c 46 11 80       	mov    %eax,0x8011467c
      release(&log.lock);
80102c17:	68 40 46 11 80       	push   $0x80114640
80102c1c:	e8 3f 1b 00 00       	call   80104760 <release>
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
80102c39:	68 40 46 11 80       	push   $0x80114640
80102c3e:	e8 5d 1a 00 00       	call   801046a0 <acquire>
  log.outstanding -= 1;
80102c43:	a1 7c 46 11 80       	mov    0x8011467c,%eax
  if(log.committing)
80102c48:	8b 35 80 46 11 80    	mov    0x80114680,%esi
80102c4e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102c51:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102c54:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102c56:	89 1d 7c 46 11 80    	mov    %ebx,0x8011467c
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
80102c6d:	c7 05 80 46 11 80 01 	movl   $0x1,0x80114680
80102c74:	00 00 00 
  release(&log.lock);
80102c77:	68 40 46 11 80       	push   $0x80114640
80102c7c:	e8 df 1a 00 00       	call   80104760 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c81:	8b 0d 88 46 11 80    	mov    0x80114688,%ecx
80102c87:	83 c4 10             	add    $0x10,%esp
80102c8a:	85 c9                	test   %ecx,%ecx
80102c8c:	0f 8e 85 00 00 00    	jle    80102d17 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102c92:	a1 74 46 11 80       	mov    0x80114674,%eax
80102c97:	83 ec 08             	sub    $0x8,%esp
80102c9a:	01 d8                	add    %ebx,%eax
80102c9c:	83 c0 01             	add    $0x1,%eax
80102c9f:	50                   	push   %eax
80102ca0:	ff 35 84 46 11 80    	pushl  0x80114684
80102ca6:	e8 25 d4 ff ff       	call   801000d0 <bread>
80102cab:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102cad:	58                   	pop    %eax
80102cae:	5a                   	pop    %edx
80102caf:	ff 34 9d 8c 46 11 80 	pushl  -0x7feeb974(,%ebx,4)
80102cb6:	ff 35 84 46 11 80    	pushl  0x80114684
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
80102cd6:	e8 85 1b 00 00       	call   80104860 <memmove>
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
80102cf6:	3b 1d 88 46 11 80    	cmp    0x80114688,%ebx
80102cfc:	7c 94                	jl     80102c92 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102cfe:	e8 bd fd ff ff       	call   80102ac0 <write_head>
    install_trans(); // Now install writes to home locations
80102d03:	e8 18 fd ff ff       	call   80102a20 <install_trans>
    log.lh.n = 0;
80102d08:	c7 05 88 46 11 80 00 	movl   $0x0,0x80114688
80102d0f:	00 00 00 
    write_head();    // Erase the transaction from the log
80102d12:	e8 a9 fd ff ff       	call   80102ac0 <write_head>
    acquire(&log.lock);
80102d17:	83 ec 0c             	sub    $0xc,%esp
80102d1a:	68 40 46 11 80       	push   $0x80114640
80102d1f:	e8 7c 19 00 00       	call   801046a0 <acquire>
    wakeup(&log);
80102d24:	c7 04 24 40 46 11 80 	movl   $0x80114640,(%esp)
    log.committing = 0;
80102d2b:	c7 05 80 46 11 80 00 	movl   $0x0,0x80114680
80102d32:	00 00 00 
    wakeup(&log);
80102d35:	e8 e6 12 00 00       	call   80104020 <wakeup>
    release(&log.lock);
80102d3a:	c7 04 24 40 46 11 80 	movl   $0x80114640,(%esp)
80102d41:	e8 1a 1a 00 00       	call   80104760 <release>
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
80102d5b:	68 40 46 11 80       	push   $0x80114640
80102d60:	e8 bb 12 00 00       	call   80104020 <wakeup>
  release(&log.lock);
80102d65:	c7 04 24 40 46 11 80 	movl   $0x80114640,(%esp)
80102d6c:	e8 ef 19 00 00       	call   80104760 <release>
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
80102d7f:	68 44 81 10 80       	push   $0x80108144
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
80102d97:	8b 15 88 46 11 80    	mov    0x80114688,%edx
{
80102d9d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102da0:	83 fa 1d             	cmp    $0x1d,%edx
80102da3:	0f 8f 9d 00 00 00    	jg     80102e46 <log_write+0xb6>
80102da9:	a1 78 46 11 80       	mov    0x80114678,%eax
80102dae:	83 e8 01             	sub    $0x1,%eax
80102db1:	39 c2                	cmp    %eax,%edx
80102db3:	0f 8d 8d 00 00 00    	jge    80102e46 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102db9:	a1 7c 46 11 80       	mov    0x8011467c,%eax
80102dbe:	85 c0                	test   %eax,%eax
80102dc0:	0f 8e 8d 00 00 00    	jle    80102e53 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102dc6:	83 ec 0c             	sub    $0xc,%esp
80102dc9:	68 40 46 11 80       	push   $0x80114640
80102dce:	e8 cd 18 00 00       	call   801046a0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102dd3:	8b 0d 88 46 11 80    	mov    0x80114688,%ecx
80102dd9:	83 c4 10             	add    $0x10,%esp
80102ddc:	83 f9 00             	cmp    $0x0,%ecx
80102ddf:	7e 57                	jle    80102e38 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102de1:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102de4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102de6:	3b 15 8c 46 11 80    	cmp    0x8011468c,%edx
80102dec:	75 0b                	jne    80102df9 <log_write+0x69>
80102dee:	eb 38                	jmp    80102e28 <log_write+0x98>
80102df0:	39 14 85 8c 46 11 80 	cmp    %edx,-0x7feeb974(,%eax,4)
80102df7:	74 2f                	je     80102e28 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102df9:	83 c0 01             	add    $0x1,%eax
80102dfc:	39 c1                	cmp    %eax,%ecx
80102dfe:	75 f0                	jne    80102df0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102e00:	89 14 85 8c 46 11 80 	mov    %edx,-0x7feeb974(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102e07:	83 c0 01             	add    $0x1,%eax
80102e0a:	a3 88 46 11 80       	mov    %eax,0x80114688
  b->flags |= B_DIRTY; // prevent eviction
80102e0f:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102e12:	c7 45 08 40 46 11 80 	movl   $0x80114640,0x8(%ebp)
}
80102e19:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e1c:	c9                   	leave  
  release(&log.lock);
80102e1d:	e9 3e 19 00 00       	jmp    80104760 <release>
80102e22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102e28:	89 14 85 8c 46 11 80 	mov    %edx,-0x7feeb974(,%eax,4)
80102e2f:	eb de                	jmp    80102e0f <log_write+0x7f>
80102e31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e38:	8b 43 08             	mov    0x8(%ebx),%eax
80102e3b:	a3 8c 46 11 80       	mov    %eax,0x8011468c
  if (i == log.lh.n)
80102e40:	75 cd                	jne    80102e0f <log_write+0x7f>
80102e42:	31 c0                	xor    %eax,%eax
80102e44:	eb c1                	jmp    80102e07 <log_write+0x77>
    panic("too big a transaction");
80102e46:	83 ec 0c             	sub    $0xc,%esp
80102e49:	68 53 81 10 80       	push   $0x80108153
80102e4e:	e8 3d d5 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102e53:	83 ec 0c             	sub    $0xc,%esp
80102e56:	68 69 81 10 80       	push   $0x80108169
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
80102e78:	68 84 81 10 80       	push   $0x80108184
80102e7d:	e8 de d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102e82:	e8 29 36 00 00       	call   801064b0 <idtinit>
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
80102ea6:	e8 f5 46 00 00       	call   801075a0 <switchkvm>
  seginit();
80102eab:	e8 60 46 00 00       	call   80107510 <seginit>
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
80102ed7:	68 68 c9 11 80       	push   $0x8011c968
80102edc:	e8 2f f5 ff ff       	call   80102410 <kinit1>
  kvmalloc();      // kernel page table
80102ee1:	e8 8a 4b 00 00       	call   80107a70 <kvmalloc>
  mpinit();        // detect other processors
80102ee6:	e8 75 01 00 00       	call   80103060 <mpinit>
  lapicinit();     // interrupt controller
80102eeb:	e8 60 f7 ff ff       	call   80102650 <lapicinit>
  seginit();       // segment descriptors
80102ef0:	e8 1b 46 00 00       	call   80107510 <seginit>
  picinit();       // disable pic
80102ef5:	e8 46 03 00 00       	call   80103240 <picinit>
  ioapicinit();    // another interrupt controller
80102efa:	e8 41 f3 ff ff       	call   80102240 <ioapicinit>
  consoleinit();   // console hardware
80102eff:	e8 bc da ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80102f04:	e8 d7 38 00 00       	call   801067e0 <uartinit>
  pinit();         // process table
80102f09:	e8 32 08 00 00       	call   80103740 <pinit>
  tvinit();        // trap vectors
80102f0e:	e8 1d 35 00 00       	call   80106430 <tvinit>
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
80102f2a:	68 8c b4 10 80       	push   $0x8010b48c
80102f2f:	68 00 70 00 80       	push   $0x80007000
80102f34:	e8 27 19 00 00       	call   80104860 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102f39:	69 05 c0 4c 11 80 b0 	imul   $0xb0,0x80114cc0,%eax
80102f40:	00 00 00 
80102f43:	83 c4 10             	add    $0x10,%esp
80102f46:	05 40 47 11 80       	add    $0x80114740,%eax
80102f4b:	3d 40 47 11 80       	cmp    $0x80114740,%eax
80102f50:	76 71                	jbe    80102fc3 <main+0x103>
80102f52:	bb 40 47 11 80       	mov    $0x80114740,%ebx
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
80102f7d:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80102f84:	a0 10 00 
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
80102faa:	69 05 c0 4c 11 80 b0 	imul   $0xb0,0x80114cc0,%eax
80102fb1:	00 00 00 
80102fb4:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102fba:	05 40 47 11 80       	add    $0x80114740,%eax
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
8010300e:	68 98 81 10 80       	push   $0x80108198
80103013:	56                   	push   %esi
80103014:	e8 e7 17 00 00       	call   80104800 <memcmp>
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
801030cc:	68 b5 81 10 80       	push   $0x801081b5
801030d1:	56                   	push   %esi
801030d2:	e8 29 17 00 00       	call   80104800 <memcmp>
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
80103137:	a3 3c 46 11 80       	mov    %eax,0x8011463c
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
80103160:	ff 24 95 dc 81 10 80 	jmp    *-0x7fef7e24(,%edx,4)
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
801031a8:	8b 0d c0 4c 11 80    	mov    0x80114cc0,%ecx
801031ae:	83 f9 07             	cmp    $0x7,%ecx
801031b1:	7f 19                	jg     801031cc <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031b3:	0f b6 50 01          	movzbl 0x1(%eax),%edx
801031b7:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
801031bd:	83 c1 01             	add    $0x1,%ecx
801031c0:	89 0d c0 4c 11 80    	mov    %ecx,0x80114cc0
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031c6:	88 97 40 47 11 80    	mov    %dl,-0x7feeb8c0(%edi)
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
801031df:	88 15 20 47 11 80    	mov    %dl,0x80114720
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
80103213:	68 9d 81 10 80       	push   $0x8010819d
80103218:	e8 73 d1 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010321d:	83 ec 0c             	sub    $0xc,%esp
80103220:	68 bc 81 10 80       	push   $0x801081bc
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
8010331b:	68 f0 81 10 80       	push   $0x801081f0
80103320:	50                   	push   %eax
80103321:	e8 3a 12 00 00       	call   80104560 <initlock>
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
8010337f:	e8 1c 13 00 00       	call   801046a0 <acquire>
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
801033c4:	e9 97 13 00 00       	jmp    80104760 <release>
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
801033f4:	e8 67 13 00 00       	call   80104760 <release>
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
8010341d:	e8 7e 12 00 00       	call   801046a0 <acquire>
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
801034b4:	e8 a7 12 00 00       	call   80104760 <release>
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
8010350b:	e8 50 12 00 00       	call   80104760 <release>
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
80103530:	e8 6b 11 00 00       	call   801046a0 <acquire>
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
8010359e:	e8 bd 11 00 00       	call   80104760 <release>
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
801035ff:	e8 5c 11 00 00       	call   80104760 <release>
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
80103624:	bb 14 4d 11 80       	mov    $0x80114d14,%ebx
{
80103629:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010362c:	68 e0 4c 11 80       	push   $0x80114ce0
80103631:	e8 6a 10 00 00       	call   801046a0 <acquire>
80103636:	83 c4 10             	add    $0x10,%esp
80103639:	eb 13                	jmp    8010364e <allocproc+0x2e>
8010363b:	90                   	nop
8010363c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103640:	81 c3 d0 01 00 00    	add    $0x1d0,%ebx
80103646:	81 fb 14 c1 11 80    	cmp    $0x8011c114,%ebx
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
80103655:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
8010365a:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
8010365d:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103664:	8d 50 01             	lea    0x1(%eax),%edx
80103667:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
8010366a:	68 e0 4c 11 80       	push   $0x80114ce0
  p->pid = nextpid++;
8010366f:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
80103675:	e8 e6 10 00 00       	call   80104760 <release>

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
8010369a:	c7 40 14 22 64 10 80 	movl   $0x80106422,0x14(%eax)
  p->context = (struct context*)sp;
801036a1:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801036a4:	6a 14                	push   $0x14
801036a6:	6a 00                	push   $0x0
801036a8:	50                   	push   %eax
801036a9:	e8 02 11 00 00       	call   801047b0 <memset>
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
801036cd:	68 e0 4c 11 80       	push   $0x80114ce0
801036d2:	e8 89 10 00 00       	call   80104760 <release>
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
801036f6:	68 e0 4c 11 80       	push   $0x80114ce0
801036fb:	e8 60 10 00 00       	call   80104760 <release>

  if (first) {
80103700:	a1 00 b0 10 80       	mov    0x8010b000,%eax
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
80103713:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
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
80103746:	68 f5 81 10 80       	push   $0x801081f5
8010374b:	68 e0 4c 11 80       	push   $0x80114ce0
80103750:	e8 0b 0e 00 00       	call   80104560 <initlock>
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
80103771:	8b 35 c0 4c 11 80    	mov    0x80114cc0,%esi
80103777:	85 f6                	test   %esi,%esi
80103779:	7e 42                	jle    801037bd <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
8010377b:	0f b6 15 40 47 11 80 	movzbl 0x80114740,%edx
80103782:	39 d0                	cmp    %edx,%eax
80103784:	74 30                	je     801037b6 <mycpu+0x56>
80103786:	b9 f0 47 11 80       	mov    $0x801147f0,%ecx
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
801037aa:	05 40 47 11 80       	add    $0x80114740,%eax
}
801037af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801037b2:	5b                   	pop    %ebx
801037b3:	5e                   	pop    %esi
801037b4:	5d                   	pop    %ebp
801037b5:	c3                   	ret    
    if (cpus[i].apicid == apicid)
801037b6:	b8 40 47 11 80       	mov    $0x80114740,%eax
      return &cpus[i];
801037bb:	eb f2                	jmp    801037af <mycpu+0x4f>
  panic("unknown apicid\n");
801037bd:	83 ec 0c             	sub    $0xc,%esp
801037c0:	68 fc 81 10 80       	push   $0x801081fc
801037c5:	e8 c6 cb ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
801037ca:	83 ec 0c             	sub    $0xc,%esp
801037cd:	68 fc 82 10 80       	push   $0x801082fc
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
801037eb:	2d 40 47 11 80       	sub    $0x80114740,%eax
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
80103807:	e8 c4 0d 00 00       	call   801045d0 <pushcli>
  c = mycpu();
8010380c:	e8 4f ff ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103811:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103817:	e8 f4 0d 00 00       	call   80104610 <popcli>
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
8010383e:	a3 b8 b5 10 80       	mov    %eax,0x8010b5b8
  if((p->pgdir = setupkvm()) == 0)
80103843:	e8 a8 41 00 00       	call   801079f0 <setupkvm>
80103848:	85 c0                	test   %eax,%eax
8010384a:	89 43 04             	mov    %eax,0x4(%ebx)
8010384d:	0f 84 c3 00 00 00    	je     80103916 <userinit+0xe6>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103853:	83 ec 04             	sub    $0x4,%esp
80103856:	68 2c 00 00 00       	push   $0x2c
8010385b:	68 60 b4 10 80       	push   $0x8010b460
80103860:	50                   	push   %eax
80103861:	e8 6a 3e 00 00       	call   801076d0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103866:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103869:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010386f:	6a 4c                	push   $0x4c
80103871:	6a 00                	push   $0x0
80103873:	ff 73 18             	pushl  0x18(%ebx)
80103876:	e8 35 0f 00 00       	call   801047b0 <memset>
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
801038d2:	68 25 82 10 80       	push   $0x80108225
801038d7:	50                   	push   %eax
801038d8:	e8 b3 10 00 00       	call   80104990 <safestrcpy>
  p->cwd = namei("/");
801038dd:	c7 04 24 2e 82 10 80 	movl   $0x8010822e,(%esp)
801038e4:	e8 17 e6 ff ff       	call   80101f00 <namei>
801038e9:	89 83 b8 01 00 00    	mov    %eax,0x1b8(%ebx)
  acquire(&ptable.lock);
801038ef:	c7 04 24 e0 4c 11 80 	movl   $0x80114ce0,(%esp)
801038f6:	e8 a5 0d 00 00       	call   801046a0 <acquire>
  p->state = RUNNABLE;
801038fb:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103902:	c7 04 24 e0 4c 11 80 	movl   $0x80114ce0,(%esp)
80103909:	e8 52 0e 00 00       	call   80104760 <release>
}
8010390e:	83 c4 10             	add    $0x10,%esp
80103911:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103914:	c9                   	leave  
80103915:	c3                   	ret    
    panic("userinit: out of memory?");
80103916:	83 ec 0c             	sub    $0xc,%esp
80103919:	68 0c 82 10 80       	push   $0x8010820c
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
80103938:	e8 93 0c 00 00       	call   801045d0 <pushcli>
  c = mycpu();
8010393d:	e8 1e fe ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103942:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103948:	e8 c3 0c 00 00       	call   80104610 <popcli>
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
8010395c:	e8 5f 3c 00 00       	call   801075c0 <switchuvm>
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
8010397a:	e8 91 3e 00 00       	call   80107810 <allocuvm>
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
8010399a:	e8 a1 3f 00 00       	call   80107940 <deallocuvm>
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
801039b9:	e8 12 0c 00 00       	call   801045d0 <pushcli>
  c = mycpu();
801039be:	e8 9d fd ff ff       	call   80103760 <mycpu>
  p = c->proc;
801039c3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039c9:	e8 42 0c 00 00       	call   80104610 <popcli>
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
801039e8:	e8 d3 40 00 00       	call   80107ac0 <copyuvm>
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
80103a6d:	e8 1e 0f 00 00       	call   80104990 <safestrcpy>
  pid = np->pid;
80103a72:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103a75:	c7 04 24 e0 4c 11 80 	movl   $0x80114ce0,(%esp)
80103a7c:	e8 1f 0c 00 00       	call   801046a0 <acquire>
  np->state = RUNNABLE;
80103a81:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103a88:	c7 04 24 e0 4c 11 80 	movl   $0x80114ce0,(%esp)
80103a8f:	e8 cc 0c 00 00       	call   80104760 <release>
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
80103af4:	bb 14 4d 11 80       	mov    $0x80114d14,%ebx
    acquire(&ptable.lock);
80103af9:	68 e0 4c 11 80       	push   $0x80114ce0
80103afe:	e8 9d 0b 00 00       	call   801046a0 <acquire>
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
80103b20:	e8 9b 3a 00 00       	call   801075c0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103b25:	58                   	pop    %eax
80103b26:	5a                   	pop    %edx
80103b27:	ff 73 1c             	pushl  0x1c(%ebx)
80103b2a:	57                   	push   %edi
      p->state = RUNNING;
80103b2b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103b32:	e8 b4 0e 00 00       	call   801049eb <swtch>
      switchkvm();
80103b37:	e8 64 3a 00 00       	call   801075a0 <switchkvm>
      c->proc = 0;
80103b3c:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103b43:	00 00 00 
80103b46:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b49:	81 c3 d0 01 00 00    	add    $0x1d0,%ebx
80103b4f:	81 fb 14 c1 11 80    	cmp    $0x8011c114,%ebx
80103b55:	72 b9                	jb     80103b10 <scheduler+0x40>
    release(&ptable.lock);
80103b57:	83 ec 0c             	sub    $0xc,%esp
80103b5a:	68 e0 4c 11 80       	push   $0x80114ce0
80103b5f:	e8 fc 0b 00 00       	call   80104760 <release>
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
80103b93:	bb 14 4d 11 80       	mov    $0x80114d14,%ebx
    acquire(&ptable.lock);
80103b98:	68 e0 4c 11 80       	push   $0x80114ce0
80103b9d:	e8 fe 0a 00 00       	call   801046a0 <acquire>
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
80103bb8:	e8 03 3a 00 00       	call   801075c0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103bbd:	58                   	pop    %eax
80103bbe:	5a                   	pop    %edx
80103bbf:	ff 73 1c             	pushl  0x1c(%ebx)
80103bc2:	57                   	push   %edi
      p->state = RUNNING;
80103bc3:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103bca:	e8 1c 0e 00 00       	call   801049eb <swtch>
      switchkvm();
80103bcf:	e8 cc 39 00 00       	call   801075a0 <switchkvm>
      c->proc = 0;
80103bd4:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103bdb:	00 00 00 
80103bde:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103be1:	81 c3 d0 01 00 00    	add    $0x1d0,%ebx
80103be7:	81 fb 14 c1 11 80    	cmp    $0x8011c114,%ebx
80103bed:	72 b9                	jb     80103ba8 <scheduler2+0x38>
    release(&ptable.lock);
80103bef:	83 ec 0c             	sub    $0xc,%esp
80103bf2:	68 e0 4c 11 80       	push   $0x80114ce0
80103bf7:	e8 64 0b 00 00       	call   80104760 <release>
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
80103c15:	e8 b6 09 00 00       	call   801045d0 <pushcli>
  c = mycpu();
80103c1a:	e8 41 fb ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103c1f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c25:	e8 e6 09 00 00       	call   80104610 <popcli>
  if(!holding(&ptable.lock))
80103c2a:	83 ec 0c             	sub    $0xc,%esp
80103c2d:	68 e0 4c 11 80       	push   $0x80114ce0
80103c32:	e8 39 0a 00 00       	call   80104670 <holding>
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
80103c73:	e8 73 0d 00 00       	call   801049eb <swtch>
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
80103c90:	68 30 82 10 80       	push   $0x80108230
80103c95:	e8 f6 c6 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103c9a:	83 ec 0c             	sub    $0xc,%esp
80103c9d:	68 5c 82 10 80       	push   $0x8010825c
80103ca2:	e8 e9 c6 ff ff       	call   80100390 <panic>
    panic("sched running");
80103ca7:	83 ec 0c             	sub    $0xc,%esp
80103caa:	68 4e 82 10 80       	push   $0x8010824e
80103caf:	e8 dc c6 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103cb4:	83 ec 0c             	sub    $0xc,%esp
80103cb7:	68 42 82 10 80       	push   $0x80108242
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
80103cd9:	e8 f2 08 00 00       	call   801045d0 <pushcli>
  c = mycpu();
80103cde:	e8 7d fa ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103ce3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103ce9:	e8 22 09 00 00       	call   80104610 <popcli>
  if(curproc == initproc)
80103cee:	39 35 b8 b5 10 80    	cmp    %esi,0x8010b5b8
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
80103d49:	c7 04 24 e0 4c 11 80 	movl   $0x80114ce0,(%esp)
80103d50:	e8 4b 09 00 00       	call   801046a0 <acquire>
  wakeup1(curproc->parent);
80103d55:	8b 56 14             	mov    0x14(%esi),%edx
80103d58:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d5b:	b8 14 4d 11 80       	mov    $0x80114d14,%eax
80103d60:	eb 12                	jmp    80103d74 <exit+0xa4>
80103d62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103d68:	05 d0 01 00 00       	add    $0x1d0,%eax
80103d6d:	3d 14 c1 11 80       	cmp    $0x8011c114,%eax
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
80103d8b:	3d 14 c1 11 80       	cmp    $0x8011c114,%eax
80103d90:	72 e2                	jb     80103d74 <exit+0xa4>
      p->parent = initproc;
80103d92:	8b 0d b8 b5 10 80    	mov    0x8010b5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d98:	ba 14 4d 11 80       	mov    $0x80114d14,%edx
80103d9d:	eb 0f                	jmp    80103dae <exit+0xde>
80103d9f:	90                   	nop
80103da0:	81 c2 d0 01 00 00    	add    $0x1d0,%edx
80103da6:	81 fa 14 c1 11 80    	cmp    $0x8011c114,%edx
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
80103dbc:	b8 14 4d 11 80       	mov    $0x80114d14,%eax
80103dc1:	eb 11                	jmp    80103dd4 <exit+0x104>
80103dc3:	90                   	nop
80103dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103dc8:	05 d0 01 00 00       	add    $0x1d0,%eax
80103dcd:	3d 14 c1 11 80       	cmp    $0x8011c114,%eax
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
80103df7:	68 7d 82 10 80       	push   $0x8010827d
80103dfc:	e8 8f c5 ff ff       	call   80100390 <panic>
    panic("init exiting");
80103e01:	83 ec 0c             	sub    $0xc,%esp
80103e04:	68 70 82 10 80       	push   $0x80108270
80103e09:	e8 82 c5 ff ff       	call   80100390 <panic>
80103e0e:	66 90                	xchg   %ax,%ax

80103e10 <yield>:
{
80103e10:	55                   	push   %ebp
80103e11:	89 e5                	mov    %esp,%ebp
80103e13:	53                   	push   %ebx
80103e14:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103e17:	68 e0 4c 11 80       	push   $0x80114ce0
80103e1c:	e8 7f 08 00 00       	call   801046a0 <acquire>
  pushcli();
80103e21:	e8 aa 07 00 00       	call   801045d0 <pushcli>
  c = mycpu();
80103e26:	e8 35 f9 ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103e2b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e31:	e8 da 07 00 00       	call   80104610 <popcli>
  myproc()->state = RUNNABLE;
80103e36:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103e3d:	e8 ce fd ff ff       	call   80103c10 <sched>
  release(&ptable.lock);
80103e42:	c7 04 24 e0 4c 11 80 	movl   $0x80114ce0,(%esp)
80103e49:	e8 12 09 00 00       	call   80104760 <release>
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
80103e6f:	e8 5c 07 00 00       	call   801045d0 <pushcli>
  c = mycpu();
80103e74:	e8 e7 f8 ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103e79:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e7f:	e8 8c 07 00 00       	call   80104610 <popcli>
  if(p == 0)
80103e84:	85 db                	test   %ebx,%ebx
80103e86:	0f 84 87 00 00 00    	je     80103f13 <sleep+0xb3>
  if(lk == 0)
80103e8c:	85 f6                	test   %esi,%esi
80103e8e:	74 76                	je     80103f06 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103e90:	81 fe e0 4c 11 80    	cmp    $0x80114ce0,%esi
80103e96:	74 50                	je     80103ee8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103e98:	83 ec 0c             	sub    $0xc,%esp
80103e9b:	68 e0 4c 11 80       	push   $0x80114ce0
80103ea0:	e8 fb 07 00 00       	call   801046a0 <acquire>
    release(lk);
80103ea5:	89 34 24             	mov    %esi,(%esp)
80103ea8:	e8 b3 08 00 00       	call   80104760 <release>
  p->chan = chan;
80103ead:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103eb0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103eb7:	e8 54 fd ff ff       	call   80103c10 <sched>
  p->chan = 0;
80103ebc:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103ec3:	c7 04 24 e0 4c 11 80 	movl   $0x80114ce0,(%esp)
80103eca:	e8 91 08 00 00       	call   80104760 <release>
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
80103edc:	e9 bf 07 00 00       	jmp    801046a0 <acquire>
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
80103f09:	68 8f 82 10 80       	push   $0x8010828f
80103f0e:	e8 7d c4 ff ff       	call   80100390 <panic>
    panic("sleep");
80103f13:	83 ec 0c             	sub    $0xc,%esp
80103f16:	68 89 82 10 80       	push   $0x80108289
80103f1b:	e8 70 c4 ff ff       	call   80100390 <panic>

80103f20 <wait>:
{
80103f20:	55                   	push   %ebp
80103f21:	89 e5                	mov    %esp,%ebp
80103f23:	56                   	push   %esi
80103f24:	53                   	push   %ebx
  pushcli();
80103f25:	e8 a6 06 00 00       	call   801045d0 <pushcli>
  c = mycpu();
80103f2a:	e8 31 f8 ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103f2f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103f35:	e8 d6 06 00 00       	call   80104610 <popcli>
  acquire(&ptable.lock);
80103f3a:	83 ec 0c             	sub    $0xc,%esp
80103f3d:	68 e0 4c 11 80       	push   $0x80114ce0
80103f42:	e8 59 07 00 00       	call   801046a0 <acquire>
80103f47:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103f4a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f4c:	bb 14 4d 11 80       	mov    $0x80114d14,%ebx
80103f51:	eb 13                	jmp    80103f66 <wait+0x46>
80103f53:	90                   	nop
80103f54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f58:	81 c3 d0 01 00 00    	add    $0x1d0,%ebx
80103f5e:	81 fb 14 c1 11 80    	cmp    $0x8011c114,%ebx
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
80103f7c:	81 fb 14 c1 11 80    	cmp    $0x8011c114,%ebx
80103f82:	72 e2                	jb     80103f66 <wait+0x46>
    if(!havekids || curproc->killed){
80103f84:	85 c0                	test   %eax,%eax
80103f86:	74 79                	je     80104001 <wait+0xe1>
80103f88:	8b 46 24             	mov    0x24(%esi),%eax
80103f8b:	85 c0                	test   %eax,%eax
80103f8d:	75 72                	jne    80104001 <wait+0xe1>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103f8f:	83 ec 08             	sub    $0x8,%esp
80103f92:	68 e0 4c 11 80       	push   $0x80114ce0
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
80103fc1:	e8 aa 39 00 00       	call   80107970 <freevm>
        release(&ptable.lock);
80103fc6:	c7 04 24 e0 4c 11 80 	movl   $0x80114ce0,(%esp)
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
80103ff0:	e8 6b 07 00 00       	call   80104760 <release>
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
80104009:	68 e0 4c 11 80       	push   $0x80114ce0
8010400e:	e8 4d 07 00 00       	call   80104760 <release>
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
8010402a:	68 e0 4c 11 80       	push   $0x80114ce0
8010402f:	e8 6c 06 00 00       	call   801046a0 <acquire>
80104034:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104037:	b8 14 4d 11 80       	mov    $0x80114d14,%eax
8010403c:	eb 0e                	jmp    8010404c <wakeup+0x2c>
8010403e:	66 90                	xchg   %ax,%ax
80104040:	05 d0 01 00 00       	add    $0x1d0,%eax
80104045:	3d 14 c1 11 80       	cmp    $0x8011c114,%eax
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
80104063:	3d 14 c1 11 80       	cmp    $0x8011c114,%eax
80104068:	72 e2                	jb     8010404c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
8010406a:	c7 45 08 e0 4c 11 80 	movl   $0x80114ce0,0x8(%ebp)
}
80104071:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104074:	c9                   	leave  
  release(&ptable.lock);
80104075:	e9 e6 06 00 00       	jmp    80104760 <release>
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
8010408a:	68 e0 4c 11 80       	push   $0x80114ce0
8010408f:	e8 0c 06 00 00       	call   801046a0 <acquire>
80104094:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104097:	b8 14 4d 11 80       	mov    $0x80114d14,%eax
8010409c:	eb 0e                	jmp    801040ac <kill+0x2c>
8010409e:	66 90                	xchg   %ax,%ax
801040a0:	05 d0 01 00 00       	add    $0x1d0,%eax
801040a5:	3d 14 c1 11 80       	cmp    $0x8011c114,%eax
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
801040c8:	68 e0 4c 11 80       	push   $0x80114ce0
801040cd:	e8 8e 06 00 00       	call   80104760 <release>
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
801040e3:	68 e0 4c 11 80       	push   $0x80114ce0
801040e8:	e8 73 06 00 00       	call   80104760 <release>
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
80104109:	bb 14 4d 11 80       	mov    $0x80114d14,%ebx
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
8010411b:	68 ab 88 10 80       	push   $0x801088ab
80104120:	e8 3b c5 ff ff       	call   80100660 <cprintf>
80104125:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104128:	81 c3 d0 01 00 00    	add    $0x1d0,%ebx
8010412e:	81 fb 14 c1 11 80    	cmp    $0x8011c114,%ebx
80104134:	0f 83 96 00 00 00    	jae    801041d0 <procdump+0xd0>
    if(p->state == UNUSED)
8010413a:	8b 43 0c             	mov    0xc(%ebx),%eax
8010413d:	85 c0                	test   %eax,%eax
8010413f:	74 e7                	je     80104128 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104141:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104144:	ba a0 82 10 80       	mov    $0x801082a0,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104149:	77 11                	ja     8010415c <procdump+0x5c>
8010414b:	8b 14 85 24 83 10 80 	mov    -0x7fef7cdc(,%eax,4),%edx
      state = "???";
80104152:	b8 a0 82 10 80       	mov    $0x801082a0,%eax
80104157:	85 d2                	test   %edx,%edx
80104159:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010415c:	8d 83 bc 01 00 00    	lea    0x1bc(%ebx),%eax
80104162:	50                   	push   %eax
80104163:	52                   	push   %edx
80104164:	ff 73 10             	pushl  0x10(%ebx)
80104167:	68 a4 82 10 80       	push   $0x801082a4
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
8010418e:	e8 ed 03 00 00       	call   80104580 <getcallerpcs>
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
801041b1:	68 e1 7c 10 80       	push   $0x80107ce1
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
801041e3:	53                   	push   %ebx
801041e4:	bb d0 4e 11 80       	mov    $0x80114ed0,%ebx
801041e9:	83 ec 10             	sub    $0x10,%esp
    // struct proc *p;
  acquire(&ptable.lock);
801041ec:	68 e0 4c 11 80       	push   $0x80114ce0
801041f1:	e8 aa 04 00 00       	call   801046a0 <acquire>
801041f6:	83 c4 10             	add    $0x10,%esp
801041f9:	eb 13                	jmp    8010420e <running_procs+0x2e>
801041fb:	90                   	nop
801041fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104200:	81 c3 d0 01 00 00    	add    $0x1d0,%ebx
    for(int p = 0; p < NPROC; p++)
80104206:	81 fb d0 c2 11 80    	cmp    $0x8011c2d0,%ebx
8010420c:	74 3b                	je     80104249 <running_procs+0x69>

      // if(pr->pid==1||pr->pid==2){
      //   cprintf("%d state was %d \n",pr->pid,pr->state);
      // }

      if(pr->state != UNUSED)
8010420e:	8b 83 50 fe ff ff    	mov    -0x1b0(%ebx),%eax
80104214:	85 c0                	test   %eax,%eax
80104216:	74 e8                	je     80104200 <running_procs+0x20>
      {
        cprintf("pid:%d name:%s",pr->pid,pr->name);
80104218:	83 ec 04             	sub    $0x4,%esp
8010421b:	53                   	push   %ebx
8010421c:	ff b3 54 fe ff ff    	pushl  -0x1ac(%ebx)
80104222:	81 c3 d0 01 00 00    	add    $0x1d0,%ebx
80104228:	68 ad 82 10 80       	push   $0x801082ad
8010422d:	e8 2e c4 ff ff       	call   80100660 <cprintf>
        cprintf("\n");
80104232:	c7 04 24 ab 88 10 80 	movl   $0x801088ab,(%esp)
80104239:	e8 22 c4 ff ff       	call   80100660 <cprintf>
8010423e:	83 c4 10             	add    $0x10,%esp
    for(int p = 0; p < NPROC; p++)
80104241:	81 fb d0 c2 11 80    	cmp    $0x8011c2d0,%ebx
80104247:	75 c5                	jne    8010420e <running_procs+0x2e>
      }
    }
    release(&ptable.lock);
80104249:	83 ec 0c             	sub    $0xc,%esp
8010424c:	68 e0 4c 11 80       	push   $0x80114ce0
80104251:	e8 0a 05 00 00       	call   80104760 <release>
}
80104256:	83 c4 10             	add    $0x10,%esp
80104259:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010425c:	c9                   	leave  
8010425d:	c3                   	ret    
8010425e:	66 90                	xchg   %ax,%ax

80104260 <TransferMessage>:



void 
TransferMessage(int msg_no, char* msg)
{ 
80104260:	55                   	push   %ebp
80104261:	89 e5                	mov    %esp,%ebp
80104263:	83 ec 0c             	sub    $0xc,%esp
  int len = 8;
  copyFromSystemSpace(msg,messageBuffers[msg_no],len);          // message size is 8
80104266:	8b 45 08             	mov    0x8(%ebp),%eax
80104269:	6a 08                	push   $0x8
8010426b:	ff 34 85 e0 c5 10 80 	pushl  -0x7fef3a20(,%eax,4)
80104272:	ff 75 0c             	pushl  0xc(%ebp)
80104275:	e8 36 0c 00 00       	call   80104eb0 <copyFromSystemSpace>
  // freeMessageBuffer(msg_no);
}
8010427a:	83 c4 10             	add    $0x10,%esp
8010427d:	c9                   	leave  
8010427e:	c3                   	ret    
8010427f:	90                   	nop

80104280 <sys_send>:


// sys call for send message//
int
sys_send(int sender_pid, int rec_pid, void *msg)
{ 
80104280:	55                   	push   %ebp
80104281:	89 e5                	mov    %esp,%ebp
80104283:	53                   	push   %ebx
80104284:	83 ec 24             	sub    $0x24,%esp
  if(isTraceOn==1)
80104287:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
8010428e:	75 07                	jne    80104297 <sys_send+0x17>
  {num_calls[SYS_send] ++;}
80104290:	83 05 ac 1a 11 80 01 	addl   $0x1,0x80111aac

  argint(0,&sender_pid);
80104297:	8d 45 08             	lea    0x8(%ebp),%eax
8010429a:	83 ec 08             	sub    $0x8,%esp
8010429d:	50                   	push   %eax
8010429e:	6a 00                	push   $0x0
801042a0:	e8 0b 08 00 00       	call   80104ab0 <argint>
  argint(1,&rec_pid);
801042a5:	5a                   	pop    %edx
801042a6:	8d 45 0c             	lea    0xc(%ebp),%eax
801042a9:	59                   	pop    %ecx
801042aa:	50                   	push   %eax
801042ab:	6a 01                	push   $0x1
801042ad:	e8 fe 07 00 00       	call   80104ab0 <argint>
  char * str;
  argstr(2,&str);
801042b2:	5b                   	pop    %ebx
801042b3:	58                   	pop    %eax
801042b4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801042b7:	50                   	push   %eax
801042b8:	6a 02                	push   $0x2
801042ba:	e8 a1 08 00 00       	call   80104b60 <argstr>
  // int len = 8;       //fixed for now
  int msg_no = getMessageBuffer();
801042bf:	e8 1c 0c 00 00       	call   80104ee0 <getMessageBuffer>
  if(msg_no ==EndOfFreeList)
801042c4:	83 c4 10             	add    $0x10,%esp
801042c7:	39 05 38 84 10 80    	cmp    %eax,0x80108438
  int msg_no = getMessageBuffer();
801042cd:	89 c3                	mov    %eax,%ebx
  if(msg_no ==EndOfFreeList)
801042cf:	74 7f                	je     80104350 <sys_send+0xd0>
  cprintf("message buffers consumed\n");

  messageBuffers[msg_no] = (char *)kalloc();
801042d1:	e8 0a e2 ff ff       	call   801024e0 <kalloc>
  safestrcpy(messageBuffers[msg_no],str,8);
801042d6:	83 ec 04             	sub    $0x4,%esp
  messageBuffers[msg_no] = (char *)kalloc();
801042d9:	89 04 9d e0 c5 10 80 	mov    %eax,-0x7fef3a20(,%ebx,4)
  safestrcpy(messageBuffers[msg_no],str,8);
801042e0:	6a 08                	push   $0x8
801042e2:	ff 75 f4             	pushl  -0xc(%ebp)
801042e5:	50                   	push   %eax
801042e6:	e8 a5 06 00 00       	call   80104990 <safestrcpy>

  if( isWaitEmpty(wait_queue[rec_pid]) == 0 )          // some proc is waiting
801042eb:	58                   	pop    %eax
801042ec:	8b 45 0c             	mov    0xc(%ebp),%eax
801042ef:	ff 34 85 20 17 11 80 	pushl  -0x7feee8e0(,%eax,4)
801042f6:	e8 25 0a 00 00       	call   80104d20 <isWaitEmpty>
801042fb:	83 c4 10             	add    $0x10,%esp
801042fe:	85 c0                	test   %eax,%eax
80104300:	75 2a                	jne    8010432c <sys_send+0xac>
  {                                                    // amke that process runnable so that scheduler can run it 
    int pid = (waitdequeue(wait_queue[rec_pid])).pid;  // and it can recieve.
80104302:	8b 55 0c             	mov    0xc(%ebp),%edx
80104305:	8d 45 e0             	lea    -0x20(%ebp),%eax
80104308:	83 ec 08             	sub    $0x8,%esp
8010430b:	ff 34 95 20 17 11 80 	pushl  -0x7feee8e0(,%edx,4)
80104312:	50                   	push   %eax
80104313:	e8 68 0a 00 00       	call   80104d80 <waitdequeue>
    ptable.proc[pid].state = RUNNABLE;
80104318:	69 45 e0 d0 01 00 00 	imul   $0x1d0,-0x20(%ebp),%eax
8010431f:	83 c4 0c             	add    $0xc,%esp
80104322:	c7 80 20 4d 11 80 03 	movl   $0x3,-0x7feeb2e0(%eax)
80104329:	00 00 00 
  }

  enqueue(int_message_queue[rec_pid],msg_no);
8010432c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010432f:	83 ec 08             	sub    $0x8,%esp
80104332:	53                   	push   %ebx
80104333:	ff 34 85 c0 1a 11 80 	pushl  -0x7feee540(,%eax,4)
8010433a:	e8 c1 0a 00 00       	call   80104e00 <enqueue>

  return 1;
}
8010433f:	b8 01 00 00 00       	mov    $0x1,%eax
80104344:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104347:	c9                   	leave  
80104348:	c3                   	ret    
80104349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  cprintf("message buffers consumed\n");
80104350:	83 ec 0c             	sub    $0xc,%esp
80104353:	68 bc 82 10 80       	push   $0x801082bc
80104358:	e8 03 c3 ff ff       	call   80100660 <cprintf>
8010435d:	83 c4 10             	add    $0x10,%esp
80104360:	e9 6c ff ff ff       	jmp    801042d1 <sys_send+0x51>
80104365:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104370 <sys_recv>:


int
sys_recv(void *msg)
{ 
80104370:	55                   	push   %ebp
80104371:	89 e5                	mov    %esp,%ebp
80104373:	53                   	push   %ebx
80104374:	83 ec 14             	sub    $0x14,%esp

  if(isTraceOn==1)
80104377:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
8010437e:	75 07                	jne    80104387 <sys_recv+0x17>
  {num_calls[SYS_recv] ++;}
80104380:	83 05 b0 1a 11 80 01 	addl   $0x1,0x80111ab0

  char* str;
  argstr(0,&str);
80104387:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010438a:	83 ec 08             	sub    $0x8,%esp
8010438d:	50                   	push   %eax
8010438e:	6a 00                	push   $0x0
80104390:	e8 cb 07 00 00       	call   80104b60 <argstr>
  pushcli();
80104395:	e8 36 02 00 00       	call   801045d0 <pushcli>
  c = mycpu();
8010439a:	e8 c1 f3 ff ff       	call   80103760 <mycpu>
  p = c->proc;
8010439f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801043a5:	e8 66 02 00 00       	call   80104610 <popcli>
  struct proc *curproc = myproc();
  if(isEmpty(int_message_queue[curproc->pid]) == 1)
801043aa:	58                   	pop    %eax
801043ab:	8b 43 10             	mov    0x10(%ebx),%eax
801043ae:	ff 34 85 c0 1a 11 80 	pushl  -0x7feee540(,%eax,4)
801043b5:	e8 26 0a 00 00       	call   80104de0 <isEmpty>
801043ba:	83 c4 10             	add    $0x10,%esp
801043bd:	83 f8 01             	cmp    $0x1,%eax
801043c0:	74 36                	je     801043f8 <sys_recv+0x88>
    item.buffer = str;                            // block the current item
    waitenqueue(wait_queue[curproc->pid],item);   // and put in wait queue.
    sched();                                     // call the scheduler (non-blocking)
  }
  else{
  int msg_no= dequeue(int_message_queue[curproc->pid]);  
801043c2:	8b 43 10             	mov    0x10(%ebx),%eax
801043c5:	83 ec 0c             	sub    $0xc,%esp
801043c8:	ff 34 85 c0 1a 11 80 	pushl  -0x7feee540(,%eax,4)
801043cf:	e8 5c 0a 00 00       	call   80104e30 <dequeue>
  safestrcpy(str,messageBuffers[msg_no],8);            // if there is message in the message queue then recieve it
801043d4:	83 c4 0c             	add    $0xc,%esp
801043d7:	6a 08                	push   $0x8
801043d9:	ff 34 85 e0 c5 10 80 	pushl  -0x7fef3a20(,%eax,4)
801043e0:	ff 75 f4             	pushl  -0xc(%ebp)
801043e3:	e8 a8 05 00 00       	call   80104990 <safestrcpy>
801043e8:	83 c4 10             	add    $0x10,%esp
  }
  return 1;
}
801043eb:	b8 01 00 00 00       	mov    $0x1,%eax
801043f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043f3:	c9                   	leave  
801043f4:	c3                   	ret    
801043f5:	8d 76 00             	lea    0x0(%esi),%esi
    item.pid = curproc->pid;
801043f8:	8b 4b 10             	mov    0x10(%ebx),%ecx
    item.buffer = str;                            // block the current item
801043fb:	8b 55 f4             	mov    -0xc(%ebp),%edx
    waitenqueue(wait_queue[curproc->pid],item);   // and put in wait queue.
801043fe:	83 ec 04             	sub    $0x4,%esp
    curproc->state = SLEEPING;                    // block the current process
80104401:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
    waitenqueue(wait_queue[curproc->pid],item);   // and put in wait queue.
80104408:	52                   	push   %edx
80104409:	51                   	push   %ecx
8010440a:	ff 34 8d 20 17 11 80 	pushl  -0x7feee8e0(,%ecx,4)
80104411:	e8 2a 09 00 00       	call   80104d40 <waitenqueue>
    sched();                                     // call the scheduler (non-blocking)
80104416:	e8 f5 f7 ff ff       	call   80103c10 <sched>
8010441b:	83 c4 10             	add    $0x10,%esp
}
8010441e:	b8 01 00 00 00       	mov    $0x1,%eax
80104423:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104426:	c9                   	leave  
80104427:	c3                   	ret    
80104428:	66 90                	xchg   %ax,%ax
8010442a:	66 90                	xchg   %ax,%ax
8010442c:	66 90                	xchg   %ax,%ax
8010442e:	66 90                	xchg   %ax,%ax

80104430 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104430:	55                   	push   %ebp
80104431:	89 e5                	mov    %esp,%ebp
80104433:	53                   	push   %ebx
80104434:	83 ec 0c             	sub    $0xc,%esp
80104437:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010443a:	68 3c 83 10 80       	push   $0x8010833c
8010443f:	8d 43 04             	lea    0x4(%ebx),%eax
80104442:	50                   	push   %eax
80104443:	e8 18 01 00 00       	call   80104560 <initlock>
  lk->name = name;
80104448:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010444b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104451:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104454:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010445b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010445e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104461:	c9                   	leave  
80104462:	c3                   	ret    
80104463:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104470 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104470:	55                   	push   %ebp
80104471:	89 e5                	mov    %esp,%ebp
80104473:	56                   	push   %esi
80104474:	53                   	push   %ebx
80104475:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104478:	83 ec 0c             	sub    $0xc,%esp
8010447b:	8d 73 04             	lea    0x4(%ebx),%esi
8010447e:	56                   	push   %esi
8010447f:	e8 1c 02 00 00       	call   801046a0 <acquire>
  while (lk->locked) {
80104484:	8b 13                	mov    (%ebx),%edx
80104486:	83 c4 10             	add    $0x10,%esp
80104489:	85 d2                	test   %edx,%edx
8010448b:	74 16                	je     801044a3 <acquiresleep+0x33>
8010448d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104490:	83 ec 08             	sub    $0x8,%esp
80104493:	56                   	push   %esi
80104494:	53                   	push   %ebx
80104495:	e8 c6 f9 ff ff       	call   80103e60 <sleep>
  while (lk->locked) {
8010449a:	8b 03                	mov    (%ebx),%eax
8010449c:	83 c4 10             	add    $0x10,%esp
8010449f:	85 c0                	test   %eax,%eax
801044a1:	75 ed                	jne    80104490 <acquiresleep+0x20>
  }
  lk->locked = 1;
801044a3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801044a9:	e8 52 f3 ff ff       	call   80103800 <myproc>
801044ae:	8b 40 10             	mov    0x10(%eax),%eax
801044b1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801044b4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801044b7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801044ba:	5b                   	pop    %ebx
801044bb:	5e                   	pop    %esi
801044bc:	5d                   	pop    %ebp
  release(&lk->lk);
801044bd:	e9 9e 02 00 00       	jmp    80104760 <release>
801044c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801044d0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	56                   	push   %esi
801044d4:	53                   	push   %ebx
801044d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801044d8:	83 ec 0c             	sub    $0xc,%esp
801044db:	8d 73 04             	lea    0x4(%ebx),%esi
801044de:	56                   	push   %esi
801044df:	e8 bc 01 00 00       	call   801046a0 <acquire>
  lk->locked = 0;
801044e4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801044ea:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801044f1:	89 1c 24             	mov    %ebx,(%esp)
801044f4:	e8 27 fb ff ff       	call   80104020 <wakeup>
  release(&lk->lk);
801044f9:	89 75 08             	mov    %esi,0x8(%ebp)
801044fc:	83 c4 10             	add    $0x10,%esp
}
801044ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104502:	5b                   	pop    %ebx
80104503:	5e                   	pop    %esi
80104504:	5d                   	pop    %ebp
  release(&lk->lk);
80104505:	e9 56 02 00 00       	jmp    80104760 <release>
8010450a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104510 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104510:	55                   	push   %ebp
80104511:	89 e5                	mov    %esp,%ebp
80104513:	57                   	push   %edi
80104514:	56                   	push   %esi
80104515:	53                   	push   %ebx
80104516:	31 ff                	xor    %edi,%edi
80104518:	83 ec 18             	sub    $0x18,%esp
8010451b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010451e:	8d 73 04             	lea    0x4(%ebx),%esi
80104521:	56                   	push   %esi
80104522:	e8 79 01 00 00       	call   801046a0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104527:	8b 03                	mov    (%ebx),%eax
80104529:	83 c4 10             	add    $0x10,%esp
8010452c:	85 c0                	test   %eax,%eax
8010452e:	74 13                	je     80104543 <holdingsleep+0x33>
80104530:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104533:	e8 c8 f2 ff ff       	call   80103800 <myproc>
80104538:	39 58 10             	cmp    %ebx,0x10(%eax)
8010453b:	0f 94 c0             	sete   %al
8010453e:	0f b6 c0             	movzbl %al,%eax
80104541:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104543:	83 ec 0c             	sub    $0xc,%esp
80104546:	56                   	push   %esi
80104547:	e8 14 02 00 00       	call   80104760 <release>
  return r;
}
8010454c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010454f:	89 f8                	mov    %edi,%eax
80104551:	5b                   	pop    %ebx
80104552:	5e                   	pop    %esi
80104553:	5f                   	pop    %edi
80104554:	5d                   	pop    %ebp
80104555:	c3                   	ret    
80104556:	66 90                	xchg   %ax,%ax
80104558:	66 90                	xchg   %ax,%ax
8010455a:	66 90                	xchg   %ax,%ax
8010455c:	66 90                	xchg   %ax,%ax
8010455e:	66 90                	xchg   %ax,%ax

80104560 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104560:	55                   	push   %ebp
80104561:	89 e5                	mov    %esp,%ebp
80104563:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104566:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104569:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010456f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104572:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104579:	5d                   	pop    %ebp
8010457a:	c3                   	ret    
8010457b:	90                   	nop
8010457c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104580 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104580:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104581:	31 d2                	xor    %edx,%edx
{
80104583:	89 e5                	mov    %esp,%ebp
80104585:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104586:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104589:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010458c:	83 e8 08             	sub    $0x8,%eax
8010458f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104590:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104596:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010459c:	77 1a                	ja     801045b8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010459e:	8b 58 04             	mov    0x4(%eax),%ebx
801045a1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801045a4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801045a7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801045a9:	83 fa 0a             	cmp    $0xa,%edx
801045ac:	75 e2                	jne    80104590 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801045ae:	5b                   	pop    %ebx
801045af:	5d                   	pop    %ebp
801045b0:	c3                   	ret    
801045b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045b8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801045bb:	83 c1 28             	add    $0x28,%ecx
801045be:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
801045c0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801045c6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801045c9:	39 c1                	cmp    %eax,%ecx
801045cb:	75 f3                	jne    801045c0 <getcallerpcs+0x40>
}
801045cd:	5b                   	pop    %ebx
801045ce:	5d                   	pop    %ebp
801045cf:	c3                   	ret    

801045d0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801045d0:	55                   	push   %ebp
801045d1:	89 e5                	mov    %esp,%ebp
801045d3:	53                   	push   %ebx
801045d4:	83 ec 04             	sub    $0x4,%esp
801045d7:	9c                   	pushf  
801045d8:	5b                   	pop    %ebx
  asm volatile("cli");
801045d9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801045da:	e8 81 f1 ff ff       	call   80103760 <mycpu>
801045df:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801045e5:	85 c0                	test   %eax,%eax
801045e7:	75 11                	jne    801045fa <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801045e9:	81 e3 00 02 00 00    	and    $0x200,%ebx
801045ef:	e8 6c f1 ff ff       	call   80103760 <mycpu>
801045f4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801045fa:	e8 61 f1 ff ff       	call   80103760 <mycpu>
801045ff:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104606:	83 c4 04             	add    $0x4,%esp
80104609:	5b                   	pop    %ebx
8010460a:	5d                   	pop    %ebp
8010460b:	c3                   	ret    
8010460c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104610 <popcli>:

void
popcli(void)
{
80104610:	55                   	push   %ebp
80104611:	89 e5                	mov    %esp,%ebp
80104613:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104616:	9c                   	pushf  
80104617:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104618:	f6 c4 02             	test   $0x2,%ah
8010461b:	75 35                	jne    80104652 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010461d:	e8 3e f1 ff ff       	call   80103760 <mycpu>
80104622:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104629:	78 34                	js     8010465f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010462b:	e8 30 f1 ff ff       	call   80103760 <mycpu>
80104630:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104636:	85 d2                	test   %edx,%edx
80104638:	74 06                	je     80104640 <popcli+0x30>
    sti();
}
8010463a:	c9                   	leave  
8010463b:	c3                   	ret    
8010463c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104640:	e8 1b f1 ff ff       	call   80103760 <mycpu>
80104645:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010464b:	85 c0                	test   %eax,%eax
8010464d:	74 eb                	je     8010463a <popcli+0x2a>
  asm volatile("sti");
8010464f:	fb                   	sti    
}
80104650:	c9                   	leave  
80104651:	c3                   	ret    
    panic("popcli - interruptible");
80104652:	83 ec 0c             	sub    $0xc,%esp
80104655:	68 47 83 10 80       	push   $0x80108347
8010465a:	e8 31 bd ff ff       	call   80100390 <panic>
    panic("popcli");
8010465f:	83 ec 0c             	sub    $0xc,%esp
80104662:	68 5e 83 10 80       	push   $0x8010835e
80104667:	e8 24 bd ff ff       	call   80100390 <panic>
8010466c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104670 <holding>:
{
80104670:	55                   	push   %ebp
80104671:	89 e5                	mov    %esp,%ebp
80104673:	56                   	push   %esi
80104674:	53                   	push   %ebx
80104675:	8b 75 08             	mov    0x8(%ebp),%esi
80104678:	31 db                	xor    %ebx,%ebx
  pushcli();
8010467a:	e8 51 ff ff ff       	call   801045d0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010467f:	8b 06                	mov    (%esi),%eax
80104681:	85 c0                	test   %eax,%eax
80104683:	74 10                	je     80104695 <holding+0x25>
80104685:	8b 5e 08             	mov    0x8(%esi),%ebx
80104688:	e8 d3 f0 ff ff       	call   80103760 <mycpu>
8010468d:	39 c3                	cmp    %eax,%ebx
8010468f:	0f 94 c3             	sete   %bl
80104692:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104695:	e8 76 ff ff ff       	call   80104610 <popcli>
}
8010469a:	89 d8                	mov    %ebx,%eax
8010469c:	5b                   	pop    %ebx
8010469d:	5e                   	pop    %esi
8010469e:	5d                   	pop    %ebp
8010469f:	c3                   	ret    

801046a0 <acquire>:
{
801046a0:	55                   	push   %ebp
801046a1:	89 e5                	mov    %esp,%ebp
801046a3:	56                   	push   %esi
801046a4:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
801046a5:	e8 26 ff ff ff       	call   801045d0 <pushcli>
  if(holding(lk))
801046aa:	8b 5d 08             	mov    0x8(%ebp),%ebx
801046ad:	83 ec 0c             	sub    $0xc,%esp
801046b0:	53                   	push   %ebx
801046b1:	e8 ba ff ff ff       	call   80104670 <holding>
801046b6:	83 c4 10             	add    $0x10,%esp
801046b9:	85 c0                	test   %eax,%eax
801046bb:	0f 85 83 00 00 00    	jne    80104744 <acquire+0xa4>
801046c1:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
801046c3:	ba 01 00 00 00       	mov    $0x1,%edx
801046c8:	eb 09                	jmp    801046d3 <acquire+0x33>
801046ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801046d0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801046d3:	89 d0                	mov    %edx,%eax
801046d5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
801046d8:	85 c0                	test   %eax,%eax
801046da:	75 f4                	jne    801046d0 <acquire+0x30>
  __sync_synchronize();
801046dc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801046e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801046e4:	e8 77 f0 ff ff       	call   80103760 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801046e9:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
801046ec:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
801046ef:	89 e8                	mov    %ebp,%eax
801046f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801046f8:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
801046fe:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104704:	77 1a                	ja     80104720 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104706:	8b 48 04             	mov    0x4(%eax),%ecx
80104709:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
8010470c:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
8010470f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104711:	83 fe 0a             	cmp    $0xa,%esi
80104714:	75 e2                	jne    801046f8 <acquire+0x58>
}
80104716:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104719:	5b                   	pop    %ebx
8010471a:	5e                   	pop    %esi
8010471b:	5d                   	pop    %ebp
8010471c:	c3                   	ret    
8010471d:	8d 76 00             	lea    0x0(%esi),%esi
80104720:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104723:	83 c2 28             	add    $0x28,%edx
80104726:	8d 76 00             	lea    0x0(%esi),%esi
80104729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104730:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104736:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104739:	39 d0                	cmp    %edx,%eax
8010473b:	75 f3                	jne    80104730 <acquire+0x90>
}
8010473d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104740:	5b                   	pop    %ebx
80104741:	5e                   	pop    %esi
80104742:	5d                   	pop    %ebp
80104743:	c3                   	ret    
    panic("acquire");
80104744:	83 ec 0c             	sub    $0xc,%esp
80104747:	68 65 83 10 80       	push   $0x80108365
8010474c:	e8 3f bc ff ff       	call   80100390 <panic>
80104751:	eb 0d                	jmp    80104760 <release>
80104753:	90                   	nop
80104754:	90                   	nop
80104755:	90                   	nop
80104756:	90                   	nop
80104757:	90                   	nop
80104758:	90                   	nop
80104759:	90                   	nop
8010475a:	90                   	nop
8010475b:	90                   	nop
8010475c:	90                   	nop
8010475d:	90                   	nop
8010475e:	90                   	nop
8010475f:	90                   	nop

80104760 <release>:
{
80104760:	55                   	push   %ebp
80104761:	89 e5                	mov    %esp,%ebp
80104763:	53                   	push   %ebx
80104764:	83 ec 10             	sub    $0x10,%esp
80104767:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010476a:	53                   	push   %ebx
8010476b:	e8 00 ff ff ff       	call   80104670 <holding>
80104770:	83 c4 10             	add    $0x10,%esp
80104773:	85 c0                	test   %eax,%eax
80104775:	74 22                	je     80104799 <release+0x39>
  lk->pcs[0] = 0;
80104777:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010477e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104785:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010478a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104790:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104793:	c9                   	leave  
  popcli();
80104794:	e9 77 fe ff ff       	jmp    80104610 <popcli>
    panic("release");
80104799:	83 ec 0c             	sub    $0xc,%esp
8010479c:	68 6d 83 10 80       	push   $0x8010836d
801047a1:	e8 ea bb ff ff       	call   80100390 <panic>
801047a6:	66 90                	xchg   %ax,%ax
801047a8:	66 90                	xchg   %ax,%ax
801047aa:	66 90                	xchg   %ax,%ax
801047ac:	66 90                	xchg   %ax,%ax
801047ae:	66 90                	xchg   %ax,%ax

801047b0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801047b0:	55                   	push   %ebp
801047b1:	89 e5                	mov    %esp,%ebp
801047b3:	57                   	push   %edi
801047b4:	53                   	push   %ebx
801047b5:	8b 55 08             	mov    0x8(%ebp),%edx
801047b8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801047bb:	f6 c2 03             	test   $0x3,%dl
801047be:	75 05                	jne    801047c5 <memset+0x15>
801047c0:	f6 c1 03             	test   $0x3,%cl
801047c3:	74 13                	je     801047d8 <memset+0x28>
  asm volatile("cld; rep stosb" :
801047c5:	89 d7                	mov    %edx,%edi
801047c7:	8b 45 0c             	mov    0xc(%ebp),%eax
801047ca:	fc                   	cld    
801047cb:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801047cd:	5b                   	pop    %ebx
801047ce:	89 d0                	mov    %edx,%eax
801047d0:	5f                   	pop    %edi
801047d1:	5d                   	pop    %ebp
801047d2:	c3                   	ret    
801047d3:	90                   	nop
801047d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
801047d8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801047dc:	c1 e9 02             	shr    $0x2,%ecx
801047df:	89 f8                	mov    %edi,%eax
801047e1:	89 fb                	mov    %edi,%ebx
801047e3:	c1 e0 18             	shl    $0x18,%eax
801047e6:	c1 e3 10             	shl    $0x10,%ebx
801047e9:	09 d8                	or     %ebx,%eax
801047eb:	09 f8                	or     %edi,%eax
801047ed:	c1 e7 08             	shl    $0x8,%edi
801047f0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
801047f2:	89 d7                	mov    %edx,%edi
801047f4:	fc                   	cld    
801047f5:	f3 ab                	rep stos %eax,%es:(%edi)
}
801047f7:	5b                   	pop    %ebx
801047f8:	89 d0                	mov    %edx,%eax
801047fa:	5f                   	pop    %edi
801047fb:	5d                   	pop    %ebp
801047fc:	c3                   	ret    
801047fd:	8d 76 00             	lea    0x0(%esi),%esi

80104800 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104800:	55                   	push   %ebp
80104801:	89 e5                	mov    %esp,%ebp
80104803:	57                   	push   %edi
80104804:	56                   	push   %esi
80104805:	53                   	push   %ebx
80104806:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104809:	8b 75 08             	mov    0x8(%ebp),%esi
8010480c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010480f:	85 db                	test   %ebx,%ebx
80104811:	74 29                	je     8010483c <memcmp+0x3c>
    if(*s1 != *s2)
80104813:	0f b6 16             	movzbl (%esi),%edx
80104816:	0f b6 0f             	movzbl (%edi),%ecx
80104819:	38 d1                	cmp    %dl,%cl
8010481b:	75 2b                	jne    80104848 <memcmp+0x48>
8010481d:	b8 01 00 00 00       	mov    $0x1,%eax
80104822:	eb 14                	jmp    80104838 <memcmp+0x38>
80104824:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104828:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
8010482c:	83 c0 01             	add    $0x1,%eax
8010482f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104834:	38 ca                	cmp    %cl,%dl
80104836:	75 10                	jne    80104848 <memcmp+0x48>
  while(n-- > 0){
80104838:	39 d8                	cmp    %ebx,%eax
8010483a:	75 ec                	jne    80104828 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010483c:	5b                   	pop    %ebx
  return 0;
8010483d:	31 c0                	xor    %eax,%eax
}
8010483f:	5e                   	pop    %esi
80104840:	5f                   	pop    %edi
80104841:	5d                   	pop    %ebp
80104842:	c3                   	ret    
80104843:	90                   	nop
80104844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104848:	0f b6 c2             	movzbl %dl,%eax
}
8010484b:	5b                   	pop    %ebx
      return *s1 - *s2;
8010484c:	29 c8                	sub    %ecx,%eax
}
8010484e:	5e                   	pop    %esi
8010484f:	5f                   	pop    %edi
80104850:	5d                   	pop    %ebp
80104851:	c3                   	ret    
80104852:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104860 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104860:	55                   	push   %ebp
80104861:	89 e5                	mov    %esp,%ebp
80104863:	56                   	push   %esi
80104864:	53                   	push   %ebx
80104865:	8b 45 08             	mov    0x8(%ebp),%eax
80104868:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010486b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010486e:	39 c3                	cmp    %eax,%ebx
80104870:	73 26                	jae    80104898 <memmove+0x38>
80104872:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104875:	39 c8                	cmp    %ecx,%eax
80104877:	73 1f                	jae    80104898 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104879:	85 f6                	test   %esi,%esi
8010487b:	8d 56 ff             	lea    -0x1(%esi),%edx
8010487e:	74 0f                	je     8010488f <memmove+0x2f>
      *--d = *--s;
80104880:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104884:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104887:	83 ea 01             	sub    $0x1,%edx
8010488a:	83 fa ff             	cmp    $0xffffffff,%edx
8010488d:	75 f1                	jne    80104880 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010488f:	5b                   	pop    %ebx
80104890:	5e                   	pop    %esi
80104891:	5d                   	pop    %ebp
80104892:	c3                   	ret    
80104893:	90                   	nop
80104894:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104898:	31 d2                	xor    %edx,%edx
8010489a:	85 f6                	test   %esi,%esi
8010489c:	74 f1                	je     8010488f <memmove+0x2f>
8010489e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
801048a0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801048a4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801048a7:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
801048aa:	39 d6                	cmp    %edx,%esi
801048ac:	75 f2                	jne    801048a0 <memmove+0x40>
}
801048ae:	5b                   	pop    %ebx
801048af:	5e                   	pop    %esi
801048b0:	5d                   	pop    %ebp
801048b1:	c3                   	ret    
801048b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048c0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801048c0:	55                   	push   %ebp
801048c1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
801048c3:	5d                   	pop    %ebp
  return memmove(dst, src, n);
801048c4:	eb 9a                	jmp    80104860 <memmove>
801048c6:	8d 76 00             	lea    0x0(%esi),%esi
801048c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048d0 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
801048d0:	55                   	push   %ebp
801048d1:	89 e5                	mov    %esp,%ebp
801048d3:	57                   	push   %edi
801048d4:	56                   	push   %esi
801048d5:	8b 7d 10             	mov    0x10(%ebp),%edi
801048d8:	53                   	push   %ebx
801048d9:	8b 4d 08             	mov    0x8(%ebp),%ecx
801048dc:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
801048df:	85 ff                	test   %edi,%edi
801048e1:	74 2f                	je     80104912 <strncmp+0x42>
801048e3:	0f b6 01             	movzbl (%ecx),%eax
801048e6:	0f b6 1e             	movzbl (%esi),%ebx
801048e9:	84 c0                	test   %al,%al
801048eb:	74 37                	je     80104924 <strncmp+0x54>
801048ed:	38 c3                	cmp    %al,%bl
801048ef:	75 33                	jne    80104924 <strncmp+0x54>
801048f1:	01 f7                	add    %esi,%edi
801048f3:	eb 13                	jmp    80104908 <strncmp+0x38>
801048f5:	8d 76 00             	lea    0x0(%esi),%esi
801048f8:	0f b6 01             	movzbl (%ecx),%eax
801048fb:	84 c0                	test   %al,%al
801048fd:	74 21                	je     80104920 <strncmp+0x50>
801048ff:	0f b6 1a             	movzbl (%edx),%ebx
80104902:	89 d6                	mov    %edx,%esi
80104904:	38 d8                	cmp    %bl,%al
80104906:	75 1c                	jne    80104924 <strncmp+0x54>
    n--, p++, q++;
80104908:	8d 56 01             	lea    0x1(%esi),%edx
8010490b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
8010490e:	39 fa                	cmp    %edi,%edx
80104910:	75 e6                	jne    801048f8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104912:	5b                   	pop    %ebx
    return 0;
80104913:	31 c0                	xor    %eax,%eax
}
80104915:	5e                   	pop    %esi
80104916:	5f                   	pop    %edi
80104917:	5d                   	pop    %ebp
80104918:	c3                   	ret    
80104919:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104920:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104924:	29 d8                	sub    %ebx,%eax
}
80104926:	5b                   	pop    %ebx
80104927:	5e                   	pop    %esi
80104928:	5f                   	pop    %edi
80104929:	5d                   	pop    %ebp
8010492a:	c3                   	ret    
8010492b:	90                   	nop
8010492c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104930 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104930:	55                   	push   %ebp
80104931:	89 e5                	mov    %esp,%ebp
80104933:	56                   	push   %esi
80104934:	53                   	push   %ebx
80104935:	8b 45 08             	mov    0x8(%ebp),%eax
80104938:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010493b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010493e:	89 c2                	mov    %eax,%edx
80104940:	eb 19                	jmp    8010495b <strncpy+0x2b>
80104942:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104948:	83 c3 01             	add    $0x1,%ebx
8010494b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010494f:	83 c2 01             	add    $0x1,%edx
80104952:	84 c9                	test   %cl,%cl
80104954:	88 4a ff             	mov    %cl,-0x1(%edx)
80104957:	74 09                	je     80104962 <strncpy+0x32>
80104959:	89 f1                	mov    %esi,%ecx
8010495b:	85 c9                	test   %ecx,%ecx
8010495d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104960:	7f e6                	jg     80104948 <strncpy+0x18>
    ;
  while(n-- > 0)
80104962:	31 c9                	xor    %ecx,%ecx
80104964:	85 f6                	test   %esi,%esi
80104966:	7e 17                	jle    8010497f <strncpy+0x4f>
80104968:	90                   	nop
80104969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104970:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104974:	89 f3                	mov    %esi,%ebx
80104976:	83 c1 01             	add    $0x1,%ecx
80104979:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
8010497b:	85 db                	test   %ebx,%ebx
8010497d:	7f f1                	jg     80104970 <strncpy+0x40>
  return os;
}
8010497f:	5b                   	pop    %ebx
80104980:	5e                   	pop    %esi
80104981:	5d                   	pop    %ebp
80104982:	c3                   	ret    
80104983:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104990 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104990:	55                   	push   %ebp
80104991:	89 e5                	mov    %esp,%ebp
80104993:	56                   	push   %esi
80104994:	53                   	push   %ebx
80104995:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104998:	8b 45 08             	mov    0x8(%ebp),%eax
8010499b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010499e:	85 c9                	test   %ecx,%ecx
801049a0:	7e 26                	jle    801049c8 <safestrcpy+0x38>
801049a2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
801049a6:	89 c1                	mov    %eax,%ecx
801049a8:	eb 17                	jmp    801049c1 <safestrcpy+0x31>
801049aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801049b0:	83 c2 01             	add    $0x1,%edx
801049b3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
801049b7:	83 c1 01             	add    $0x1,%ecx
801049ba:	84 db                	test   %bl,%bl
801049bc:	88 59 ff             	mov    %bl,-0x1(%ecx)
801049bf:	74 04                	je     801049c5 <safestrcpy+0x35>
801049c1:	39 f2                	cmp    %esi,%edx
801049c3:	75 eb                	jne    801049b0 <safestrcpy+0x20>
    ;
  *s = 0;
801049c5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
801049c8:	5b                   	pop    %ebx
801049c9:	5e                   	pop    %esi
801049ca:	5d                   	pop    %ebp
801049cb:	c3                   	ret    
801049cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801049d0 <strlen>:

int
strlen(const char *s)
{
801049d0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
801049d1:	31 c0                	xor    %eax,%eax
{
801049d3:	89 e5                	mov    %esp,%ebp
801049d5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
801049d8:	80 3a 00             	cmpb   $0x0,(%edx)
801049db:	74 0c                	je     801049e9 <strlen+0x19>
801049dd:	8d 76 00             	lea    0x0(%esi),%esi
801049e0:	83 c0 01             	add    $0x1,%eax
801049e3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801049e7:	75 f7                	jne    801049e0 <strlen+0x10>
    ;
  return n;
}
801049e9:	5d                   	pop    %ebp
801049ea:	c3                   	ret    

801049eb <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
801049eb:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801049ef:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
801049f3:	55                   	push   %ebp
  pushl %ebx
801049f4:	53                   	push   %ebx
  pushl %esi
801049f5:	56                   	push   %esi
  pushl %edi
801049f6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801049f7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801049f9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
801049fb:	5f                   	pop    %edi
  popl %esi
801049fc:	5e                   	pop    %esi
  popl %ebx
801049fd:	5b                   	pop    %ebx
  popl %ebp
801049fe:	5d                   	pop    %ebp
  ret
801049ff:	c3                   	ret    

80104a00 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104a00:	55                   	push   %ebp
80104a01:	89 e5                	mov    %esp,%ebp
80104a03:	53                   	push   %ebx
80104a04:	83 ec 04             	sub    $0x4,%esp
80104a07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104a0a:	e8 f1 ed ff ff       	call   80103800 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104a0f:	8b 00                	mov    (%eax),%eax
80104a11:	39 d8                	cmp    %ebx,%eax
80104a13:	76 1b                	jbe    80104a30 <fetchint+0x30>
80104a15:	8d 53 04             	lea    0x4(%ebx),%edx
80104a18:	39 d0                	cmp    %edx,%eax
80104a1a:	72 14                	jb     80104a30 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104a1c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a1f:	8b 13                	mov    (%ebx),%edx
80104a21:	89 10                	mov    %edx,(%eax)
  return 0;
80104a23:	31 c0                	xor    %eax,%eax
}
80104a25:	83 c4 04             	add    $0x4,%esp
80104a28:	5b                   	pop    %ebx
80104a29:	5d                   	pop    %ebp
80104a2a:	c3                   	ret    
80104a2b:	90                   	nop
80104a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104a30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a35:	eb ee                	jmp    80104a25 <fetchint+0x25>
80104a37:	89 f6                	mov    %esi,%esi
80104a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a40 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104a40:	55                   	push   %ebp
80104a41:	89 e5                	mov    %esp,%ebp
80104a43:	53                   	push   %ebx
80104a44:	83 ec 04             	sub    $0x4,%esp
80104a47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104a4a:	e8 b1 ed ff ff       	call   80103800 <myproc>

  if(addr >= curproc->sz)
80104a4f:	39 18                	cmp    %ebx,(%eax)
80104a51:	76 29                	jbe    80104a7c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104a53:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104a56:	89 da                	mov    %ebx,%edx
80104a58:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80104a5a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80104a5c:	39 c3                	cmp    %eax,%ebx
80104a5e:	73 1c                	jae    80104a7c <fetchstr+0x3c>
    if(*s == 0)
80104a60:	80 3b 00             	cmpb   $0x0,(%ebx)
80104a63:	75 10                	jne    80104a75 <fetchstr+0x35>
80104a65:	eb 39                	jmp    80104aa0 <fetchstr+0x60>
80104a67:	89 f6                	mov    %esi,%esi
80104a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104a70:	80 3a 00             	cmpb   $0x0,(%edx)
80104a73:	74 1b                	je     80104a90 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80104a75:	83 c2 01             	add    $0x1,%edx
80104a78:	39 d0                	cmp    %edx,%eax
80104a7a:	77 f4                	ja     80104a70 <fetchstr+0x30>
    return -1;
80104a7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80104a81:	83 c4 04             	add    $0x4,%esp
80104a84:	5b                   	pop    %ebx
80104a85:	5d                   	pop    %ebp
80104a86:	c3                   	ret    
80104a87:	89 f6                	mov    %esi,%esi
80104a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104a90:	83 c4 04             	add    $0x4,%esp
80104a93:	89 d0                	mov    %edx,%eax
80104a95:	29 d8                	sub    %ebx,%eax
80104a97:	5b                   	pop    %ebx
80104a98:	5d                   	pop    %ebp
80104a99:	c3                   	ret    
80104a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80104aa0:	31 c0                	xor    %eax,%eax
      return s - *pp;
80104aa2:	eb dd                	jmp    80104a81 <fetchstr+0x41>
80104aa4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104aaa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104ab0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104ab0:	55                   	push   %ebp
80104ab1:	89 e5                	mov    %esp,%ebp
80104ab3:	56                   	push   %esi
80104ab4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104ab5:	e8 46 ed ff ff       	call   80103800 <myproc>
80104aba:	8b 40 18             	mov    0x18(%eax),%eax
80104abd:	8b 55 08             	mov    0x8(%ebp),%edx
80104ac0:	8b 40 44             	mov    0x44(%eax),%eax
80104ac3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104ac6:	e8 35 ed ff ff       	call   80103800 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104acb:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104acd:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104ad0:	39 c6                	cmp    %eax,%esi
80104ad2:	73 1c                	jae    80104af0 <argint+0x40>
80104ad4:	8d 53 08             	lea    0x8(%ebx),%edx
80104ad7:	39 d0                	cmp    %edx,%eax
80104ad9:	72 15                	jb     80104af0 <argint+0x40>
  *ip = *(int*)(addr);
80104adb:	8b 45 0c             	mov    0xc(%ebp),%eax
80104ade:	8b 53 04             	mov    0x4(%ebx),%edx
80104ae1:	89 10                	mov    %edx,(%eax)
  return 0;
80104ae3:	31 c0                	xor    %eax,%eax
}
80104ae5:	5b                   	pop    %ebx
80104ae6:	5e                   	pop    %esi
80104ae7:	5d                   	pop    %ebp
80104ae8:	c3                   	ret    
80104ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104af0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104af5:	eb ee                	jmp    80104ae5 <argint+0x35>
80104af7:	89 f6                	mov    %esi,%esi
80104af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b00 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104b00:	55                   	push   %ebp
80104b01:	89 e5                	mov    %esp,%ebp
80104b03:	56                   	push   %esi
80104b04:	53                   	push   %ebx
80104b05:	83 ec 10             	sub    $0x10,%esp
80104b08:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104b0b:	e8 f0 ec ff ff       	call   80103800 <myproc>
80104b10:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104b12:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b15:	83 ec 08             	sub    $0x8,%esp
80104b18:	50                   	push   %eax
80104b19:	ff 75 08             	pushl  0x8(%ebp)
80104b1c:	e8 8f ff ff ff       	call   80104ab0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104b21:	83 c4 10             	add    $0x10,%esp
80104b24:	85 c0                	test   %eax,%eax
80104b26:	78 28                	js     80104b50 <argptr+0x50>
80104b28:	85 db                	test   %ebx,%ebx
80104b2a:	78 24                	js     80104b50 <argptr+0x50>
80104b2c:	8b 16                	mov    (%esi),%edx
80104b2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b31:	39 c2                	cmp    %eax,%edx
80104b33:	76 1b                	jbe    80104b50 <argptr+0x50>
80104b35:	01 c3                	add    %eax,%ebx
80104b37:	39 da                	cmp    %ebx,%edx
80104b39:	72 15                	jb     80104b50 <argptr+0x50>
    return -1;
  *pp = (char*)i;
80104b3b:	8b 55 0c             	mov    0xc(%ebp),%edx
80104b3e:	89 02                	mov    %eax,(%edx)
  return 0;
80104b40:	31 c0                	xor    %eax,%eax
}
80104b42:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b45:	5b                   	pop    %ebx
80104b46:	5e                   	pop    %esi
80104b47:	5d                   	pop    %ebp
80104b48:	c3                   	ret    
80104b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104b50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104b55:	eb eb                	jmp    80104b42 <argptr+0x42>
80104b57:	89 f6                	mov    %esi,%esi
80104b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b60 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104b60:	55                   	push   %ebp
80104b61:	89 e5                	mov    %esp,%ebp
80104b63:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104b66:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b69:	50                   	push   %eax
80104b6a:	ff 75 08             	pushl  0x8(%ebp)
80104b6d:	e8 3e ff ff ff       	call   80104ab0 <argint>
80104b72:	83 c4 10             	add    $0x10,%esp
80104b75:	85 c0                	test   %eax,%eax
80104b77:	78 17                	js     80104b90 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104b79:	83 ec 08             	sub    $0x8,%esp
80104b7c:	ff 75 0c             	pushl  0xc(%ebp)
80104b7f:	ff 75 f4             	pushl  -0xc(%ebp)
80104b82:	e8 b9 fe ff ff       	call   80104a40 <fetchstr>
80104b87:	83 c4 10             	add    $0x10,%esp
}
80104b8a:	c9                   	leave  
80104b8b:	c3                   	ret    
80104b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104b90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104b95:	c9                   	leave  
80104b96:	c3                   	ret    
80104b97:	89 f6                	mov    %esi,%esi
80104b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ba0 <createIntQueue>:
//     mq->array = kalloc(); 
//     return mq; 
// }

struct intMessageQueue* createIntQueue(unsigned capacity) 
{ 
80104ba0:	55                   	push   %ebp
80104ba1:	89 e5                	mov    %esp,%ebp
80104ba3:	53                   	push   %ebx
80104ba4:	83 ec 04             	sub    $0x4,%esp
    struct intMessageQueue* mq = (struct intMessageQueue*) kalloc(); 
80104ba7:	e8 34 d9 ff ff       	call   801024e0 <kalloc>
80104bac:	89 c3                	mov    %eax,%ebx
    mq->capacity = capacity; 
80104bae:	8b 45 08             	mov    0x8(%ebp),%eax
    mq->front =0;
80104bb1:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
    mq->size = 0;  
80104bb7:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    mq->last = -1;  // This is important, see the enqueue 
80104bbe:	c7 43 04 ff ff ff ff 	movl   $0xffffffff,0x4(%ebx)
    mq->capacity = capacity; 
80104bc5:	89 43 0c             	mov    %eax,0xc(%ebx)
    mq->arr = (int*) kalloc(); 
80104bc8:	e8 13 d9 ff ff       	call   801024e0 <kalloc>
80104bcd:	89 43 10             	mov    %eax,0x10(%ebx)
    return mq; 
}
80104bd0:	83 c4 04             	add    $0x4,%esp
80104bd3:	89 d8                	mov    %ebx,%eax
80104bd5:	5b                   	pop    %ebx
80104bd6:	5d                   	pop    %ebp
80104bd7:	c3                   	ret    
80104bd8:	90                   	nop
80104bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104be0 <createWaitQueue>:

struct waitQueue* createWaitQueue(unsigned capacity) 
{ 
80104be0:	55                   	push   %ebp
80104be1:	89 e5                	mov    %esp,%ebp
80104be3:	53                   	push   %ebx
80104be4:	83 ec 04             	sub    $0x4,%esp
    struct waitQueue* mq = (struct waitQueue*) kalloc(); 
80104be7:	e8 f4 d8 ff ff       	call   801024e0 <kalloc>
80104bec:	89 c3                	mov    %eax,%ebx
    mq->capacity = capacity; 
80104bee:	8b 45 08             	mov    0x8(%ebp),%eax
    mq->front = 0;
80104bf1:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
    mq->size = 0;  
80104bf7:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    mq->last = -1;  // This is important, see the enqueue 
80104bfe:	c7 43 04 ff ff ff ff 	movl   $0xffffffff,0x4(%ebx)
    mq->capacity = capacity; 
80104c05:	89 43 0c             	mov    %eax,0xc(%ebx)
    mq->array = (struct waitQueueItem*) kalloc(); 
80104c08:	e8 d3 d8 ff ff       	call   801024e0 <kalloc>
80104c0d:	89 43 10             	mov    %eax,0x10(%ebx)
    return mq; 
}
80104c10:	83 c4 04             	add    $0x4,%esp
80104c13:	89 d8                	mov    %ebx,%eax
80104c15:	5b                   	pop    %ebx
80104c16:	5d                   	pop    %ebp
80104c17:	c3                   	ret    
80104c18:	90                   	nop
80104c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104c20 <init_queues>:


void
init_queues(void)
{ 
80104c20:	55                   	push   %ebp
80104c21:	89 e5                	mov    %esp,%ebp
80104c23:	53                   	push   %ebx
80104c24:	31 db                	xor    %ebx,%ebx
80104c26:	83 ec 04             	sub    $0x4,%esp
80104c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  unsigned capacity = 50;             // capacity of one message quque
  for(int p = 0; p < NPROC; p++){
    // message_quque[p] = createQueue(capacity);
    int_message_queue[p] = createIntQueue(capacity);
80104c30:	83 ec 0c             	sub    $0xc,%esp
80104c33:	83 c3 04             	add    $0x4,%ebx
80104c36:	6a 32                	push   $0x32
80104c38:	e8 63 ff ff ff       	call   80104ba0 <createIntQueue>
    wait_queue[p] = createWaitQueue(capacity);
80104c3d:	c7 04 24 32 00 00 00 	movl   $0x32,(%esp)
    int_message_queue[p] = createIntQueue(capacity);
80104c44:	89 83 bc 1a 11 80    	mov    %eax,-0x7feee544(%ebx)
    wait_queue[p] = createWaitQueue(capacity);
80104c4a:	e8 91 ff ff ff       	call   80104be0 <createWaitQueue>
80104c4f:	89 83 1c 17 11 80    	mov    %eax,-0x7feee8e4(%ebx)
  for(int p = 0; p < NPROC; p++){
80104c55:	83 c4 10             	add    $0x10,%esp
80104c58:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
80104c5e:	75 d0                	jne    80104c30 <init_queues+0x10>
  }
}
80104c60:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c63:	c9                   	leave  
80104c64:	c3                   	ret    
80104c65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c70 <syscall>:
{	
80104c70:	55                   	push   %ebp
80104c71:	89 e5                	mov    %esp,%ebp
80104c73:	53                   	push   %ebx
80104c74:	83 ec 04             	sub    $0x4,%esp
  if(syscallhappened==0){
80104c77:	a1 bc b5 10 80       	mov    0x8010b5bc,%eax
80104c7c:	85 c0                	test   %eax,%eax
80104c7e:	74 60                	je     80104ce0 <syscall+0x70>
  struct proc *curproc = myproc();
80104c80:	e8 7b eb ff ff       	call   80103800 <myproc>
80104c85:	89 c3                	mov    %eax,%ebx
  num = curproc->tf->eax;
80104c87:	8b 40 18             	mov    0x18(%eax),%eax
80104c8a:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104c8d:	8d 50 ff             	lea    -0x1(%eax),%edx
80104c90:	83 fa 1c             	cmp    $0x1c,%edx
80104c93:	77 1b                	ja     80104cb0 <syscall+0x40>
80104c95:	8b 14 85 c0 83 10 80 	mov    -0x7fef7c40(,%eax,4),%edx
80104c9c:	85 d2                	test   %edx,%edx
80104c9e:	74 10                	je     80104cb0 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104ca0:	ff d2                	call   *%edx
80104ca2:	8b 53 18             	mov    0x18(%ebx),%edx
80104ca5:	89 42 1c             	mov    %eax,0x1c(%edx)
}
80104ca8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104cab:	c9                   	leave  
80104cac:	c3                   	ret    
80104cad:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104cb0:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104cb1:	8d 83 bc 01 00 00    	lea    0x1bc(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104cb7:	50                   	push   %eax
80104cb8:	ff 73 10             	pushl  0x10(%ebx)
80104cbb:	68 75 83 10 80       	push   $0x80108375
80104cc0:	e8 9b b9 ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
80104cc5:	8b 43 18             	mov    0x18(%ebx),%eax
80104cc8:	83 c4 10             	add    $0x10,%esp
80104ccb:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104cd2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104cd5:	c9                   	leave  
80104cd6:	c3                   	ret    
80104cd7:	89 f6                	mov    %esi,%esi
80104cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  	init_queues();
80104ce0:	e8 3b ff ff ff       	call   80104c20 <init_queues>
  	syscallhappened=1;
80104ce5:	c7 05 bc b5 10 80 01 	movl   $0x1,0x8010b5bc
80104cec:	00 00 00 
80104cef:	eb 8f                	jmp    80104c80 <syscall+0x10>
80104cf1:	eb 0d                	jmp    80104d00 <isWaitFull>
80104cf3:	90                   	nop
80104cf4:	90                   	nop
80104cf5:	90                   	nop
80104cf6:	90                   	nop
80104cf7:	90                   	nop
80104cf8:	90                   	nop
80104cf9:	90                   	nop
80104cfa:	90                   	nop
80104cfb:	90                   	nop
80104cfc:	90                   	nop
80104cfd:	90                   	nop
80104cfe:	90                   	nop
80104cff:	90                   	nop

80104d00 <isWaitFull>:
//     return item; 
// }


int isWaitFull(struct waitQueue* mq) 
{  
80104d00:	55                   	push   %ebp
80104d01:	89 e5                	mov    %esp,%ebp
80104d03:	8b 45 08             	mov    0x8(%ebp),%eax
	if(mq->size == mq->capacity)
	return 1;
	else return 0;  
} 
80104d06:	5d                   	pop    %ebp
	if(mq->size == mq->capacity)
80104d07:	8b 50 0c             	mov    0xc(%eax),%edx
80104d0a:	39 50 08             	cmp    %edx,0x8(%eax)
80104d0d:	0f 94 c0             	sete   %al
80104d10:	0f b6 c0             	movzbl %al,%eax
} 
80104d13:	c3                   	ret    
80104d14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104d20 <isWaitEmpty>:
  

int isWaitEmpty(struct waitQueue* mq) 
{  
80104d20:	55                   	push   %ebp
80104d21:	89 e5                	mov    %esp,%ebp
	if(mq->size == 0)
80104d23:	8b 45 08             	mov    0x8(%ebp),%eax
	return 1;
	else return 0; 
} 
80104d26:	5d                   	pop    %ebp
	if(mq->size == 0)
80104d27:	8b 40 08             	mov    0x8(%eax),%eax
80104d2a:	85 c0                	test   %eax,%eax
80104d2c:	0f 94 c0             	sete   %al
80104d2f:	0f b6 c0             	movzbl %al,%eax
} 
80104d32:	c3                   	ret    
80104d33:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d40 <waitenqueue>:
  

void waitenqueue(struct waitQueue* mq, struct waitQueueItem item) 
{ 
80104d40:	55                   	push   %ebp
80104d41:	89 e5                	mov    %esp,%ebp
80104d43:	56                   	push   %esi
80104d44:	53                   	push   %ebx
80104d45:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(mq->size == mq->capacity)
80104d48:	8b 41 0c             	mov    0xc(%ecx),%eax
80104d4b:	39 41 08             	cmp    %eax,0x8(%ecx)
80104d4e:	74 1d                	je     80104d6d <waitenqueue+0x2d>
    if (isWaitFull(mq)) 
        return; 
    mq->last = mq->last + 1; 
80104d50:	8b 41 04             	mov    0x4(%ecx),%eax
    mq->array[mq->last] = item; 
80104d53:	8b 71 10             	mov    0x10(%ecx),%esi
80104d56:	8b 55 10             	mov    0x10(%ebp),%edx
    mq->last = mq->last + 1; 
80104d59:	8d 58 01             	lea    0x1(%eax),%ebx
    mq->array[mq->last] = item; 
80104d5c:	8b 45 0c             	mov    0xc(%ebp),%eax
    mq->last = mq->last + 1; 
80104d5f:	89 59 04             	mov    %ebx,0x4(%ecx)
    mq->array[mq->last] = item; 
80104d62:	89 54 de 04          	mov    %edx,0x4(%esi,%ebx,8)
80104d66:	89 04 de             	mov    %eax,(%esi,%ebx,8)
    mq->size = mq->size + 1; 
80104d69:	83 41 08 01          	addl   $0x1,0x8(%ecx)
    // printf("%d enqueued to queue\n", item); 
}
80104d6d:	5b                   	pop    %ebx
80104d6e:	5e                   	pop    %esi
80104d6f:	5d                   	pop    %ebp
80104d70:	c3                   	ret    
80104d71:	eb 0d                	jmp    80104d80 <waitdequeue>
80104d73:	90                   	nop
80104d74:	90                   	nop
80104d75:	90                   	nop
80104d76:	90                   	nop
80104d77:	90                   	nop
80104d78:	90                   	nop
80104d79:	90                   	nop
80104d7a:	90                   	nop
80104d7b:	90                   	nop
80104d7c:	90                   	nop
80104d7d:	90                   	nop
80104d7e:	90                   	nop
80104d7f:	90                   	nop

80104d80 <waitdequeue>:

struct waitQueueItem waitdequeue(struct waitQueue* mq)                // ALWAYS CHECK IF EMPTY BEFORE USING DEQUEUE
{   
80104d80:	55                   	push   %ebp
80104d81:	89 e5                	mov    %esp,%ebp
80104d83:	56                   	push   %esi
80104d84:	53                   	push   %ebx
80104d85:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104d88:	8b 5d 08             	mov    0x8(%ebp),%ebx

    // if (isEmpty(mq)) 
    //     return;  
    struct waitQueueItem item = mq->array[mq->front]; 
80104d8b:	8b 01                	mov    (%ecx),%eax
80104d8d:	8b 51 10             	mov    0x10(%ecx),%edx
80104d90:	8d 14 c2             	lea    (%edx,%eax,8),%edx
    mq->front = (mq->front + 1)%mq->capacity; 
80104d93:	83 c0 01             	add    $0x1,%eax
    struct waitQueueItem item = mq->array[mq->front]; 
80104d96:	8b 32                	mov    (%edx),%esi
80104d98:	89 33                	mov    %esi,(%ebx)
80104d9a:	8b 72 04             	mov    0x4(%edx),%esi
    mq->front = (mq->front + 1)%mq->capacity; 
80104d9d:	31 d2                	xor    %edx,%edx
80104d9f:	f7 71 0c             	divl   0xc(%ecx)
    mq->size = mq->size - 1; 
80104da2:	83 69 08 01          	subl   $0x1,0x8(%ecx)
    return item; 
}
80104da6:	89 d8                	mov    %ebx,%eax
    struct waitQueueItem item = mq->array[mq->front]; 
80104da8:	89 73 04             	mov    %esi,0x4(%ebx)
    mq->front = (mq->front + 1)%mq->capacity; 
80104dab:	89 11                	mov    %edx,(%ecx)
}
80104dad:	5b                   	pop    %ebx
80104dae:	5e                   	pop    %esi
80104daf:	5d                   	pop    %ebp
80104db0:	c2 04 00             	ret    $0x4
80104db3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104dc0 <isFull>:


/////////////////////////////////////////////////////////

int isFull(struct intMessageQueue* mq) 
{  if(mq->size == mq->capacity)
80104dc0:	55                   	push   %ebp
80104dc1:	89 e5                	mov    %esp,%ebp
80104dc3:	8b 45 08             	mov    0x8(%ebp),%eax
	return 1;
	else return 0;  
} 
80104dc6:	5d                   	pop    %ebp
{  if(mq->size == mq->capacity)
80104dc7:	8b 50 0c             	mov    0xc(%eax),%edx
80104dca:	39 50 08             	cmp    %edx,0x8(%eax)
80104dcd:	0f 94 c0             	sete   %al
80104dd0:	0f b6 c0             	movzbl %al,%eax
} 
80104dd3:	c3                   	ret    
80104dd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104dda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104de0 <isEmpty>:
  

int isEmpty(struct intMessageQueue* mq) 
{  
80104de0:	55                   	push   %ebp
80104de1:	89 e5                	mov    %esp,%ebp
	if(mq->size == 0)
80104de3:	8b 45 08             	mov    0x8(%ebp),%eax
	return 1;
	else return 0; 
} 
80104de6:	5d                   	pop    %ebp
	if(mq->size == 0)
80104de7:	8b 40 08             	mov    0x8(%eax),%eax
80104dea:	85 c0                	test   %eax,%eax
80104dec:	0f 94 c0             	sete   %al
80104def:	0f b6 c0             	movzbl %al,%eax
} 
80104df2:	c3                   	ret    
80104df3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e00 <enqueue>:
  

void enqueue(struct intMessageQueue* mq, int item) 
{ 
80104e00:	55                   	push   %ebp
80104e01:	89 e5                	mov    %esp,%ebp
80104e03:	53                   	push   %ebx
80104e04:	8b 4d 08             	mov    0x8(%ebp),%ecx
{  if(mq->size == mq->capacity)
80104e07:	8b 59 0c             	mov    0xc(%ecx),%ebx
80104e0a:	39 59 08             	cmp    %ebx,0x8(%ecx)
80104e0d:	74 1a                	je     80104e29 <enqueue+0x29>
    if (isFull(mq)) 
        return; 
    mq->last = (mq->last + 1)%mq->capacity; 
80104e0f:	8b 41 04             	mov    0x4(%ecx),%eax
80104e12:	31 d2                	xor    %edx,%edx
80104e14:	83 c0 01             	add    $0x1,%eax
80104e17:	f7 f3                	div    %ebx
    mq->arr[mq->last] = item; 
80104e19:	8b 41 10             	mov    0x10(%ecx),%eax
80104e1c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    mq->last = (mq->last + 1)%mq->capacity; 
80104e1f:	89 51 04             	mov    %edx,0x4(%ecx)
    mq->arr[mq->last] = item; 
80104e22:	89 1c 90             	mov    %ebx,(%eax,%edx,4)
    mq->size = mq->size + 1; 
80104e25:	83 41 08 01          	addl   $0x1,0x8(%ecx)
    // printf("%d enqueued to queue\n", item); 
}
80104e29:	5b                   	pop    %ebx
80104e2a:	5d                   	pop    %ebp
80104e2b:	c3                   	ret    
80104e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104e30 <dequeue>:

int dequeue(struct intMessageQueue* mq)                // ALWAYS CHECK IF EMPTY BEFORE USING DEQUEUE
{   
80104e30:	55                   	push   %ebp
80104e31:	89 e5                	mov    %esp,%ebp
80104e33:	56                   	push   %esi
80104e34:	53                   	push   %ebx
80104e35:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(mq->size == 0)
80104e38:	8b 59 08             	mov    0x8(%ecx),%ebx
80104e3b:	85 db                	test   %ebx,%ebx
80104e3d:	74 21                	je     80104e60 <dequeue+0x30>

    if (isEmpty(mq)) 
        {cprintf("dequeue from EMPTY\n");return -3;}  
    int item = mq->arr[mq->front]; 
80104e3f:	8b 01                	mov    (%ecx),%eax
80104e41:	8b 51 10             	mov    0x10(%ecx),%edx
    mq->front = (mq->front + 1)%mq->capacity; 
    mq->size = mq->size - 1; 
80104e44:	83 eb 01             	sub    $0x1,%ebx
    int item = mq->arr[mq->front]; 
80104e47:	8b 34 82             	mov    (%edx,%eax,4),%esi
    mq->front = (mq->front + 1)%mq->capacity; 
80104e4a:	83 c0 01             	add    $0x1,%eax
80104e4d:	31 d2                	xor    %edx,%edx
80104e4f:	f7 71 0c             	divl   0xc(%ecx)
    mq->size = mq->size - 1; 
80104e52:	89 59 08             	mov    %ebx,0x8(%ecx)
    mq->front = (mq->front + 1)%mq->capacity; 
80104e55:	89 11                	mov    %edx,(%ecx)
    return item; 
}
80104e57:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e5a:	89 f0                	mov    %esi,%eax
80104e5c:	5b                   	pop    %ebx
80104e5d:	5e                   	pop    %esi
80104e5e:	5d                   	pop    %ebp
80104e5f:	c3                   	ret    
        {cprintf("dequeue from EMPTY\n");return -3;}  
80104e60:	83 ec 0c             	sub    $0xc,%esp
80104e63:	be fd ff ff ff       	mov    $0xfffffffd,%esi
80104e68:	68 91 83 10 80       	push   $0x80108391
80104e6d:	e8 ee b7 ff ff       	call   80100660 <cprintf>
80104e72:	83 c4 10             	add    $0x10,%esp
80104e75:	eb e0                	jmp    80104e57 <dequeue+0x27>
80104e77:	89 f6                	mov    %esi,%esi
80104e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e80 <copyToSystemSpace>:
/////////// COPY TO SYSTEM SPACE AND COPY FROM SYSTEM SPACE///////
*/

void
copyToSystemSpace(char *from,char *to, int len)
{
80104e80:	55                   	push   %ebp
80104e81:	89 e5                	mov    %esp,%ebp
80104e83:	56                   	push   %esi
80104e84:	53                   	push   %ebx
80104e85:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104e88:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104e8b:	8b 75 0c             	mov    0xc(%ebp),%esi
	// from = P2V(from);
	while(len-->0){
80104e8e:	85 c9                	test   %ecx,%ecx
80104e90:	7e 14                	jle    80104ea6 <copyToSystemSpace+0x26>
80104e92:	31 c0                	xor    %eax,%eax
80104e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		*to++= *from++;
80104e98:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
80104e9c:	88 14 06             	mov    %dl,(%esi,%eax,1)
80104e9f:	83 c0 01             	add    $0x1,%eax
	while(len-->0){
80104ea2:	39 c1                	cmp    %eax,%ecx
80104ea4:	75 f2                	jne    80104e98 <copyToSystemSpace+0x18>
		// to++;
		// from++;
	}
}
80104ea6:	5b                   	pop    %ebx
80104ea7:	5e                   	pop    %esi
80104ea8:	5d                   	pop    %ebp
80104ea9:	c3                   	ret    
80104eaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104eb0 <copyFromSystemSpace>:

void
copyFromSystemSpace(char *to,char *from, int len)
{
80104eb0:	55                   	push   %ebp
80104eb1:	89 e5                	mov    %esp,%ebp
80104eb3:	56                   	push   %esi
80104eb4:	53                   	push   %ebx
80104eb5:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104eb8:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104ebb:	8b 75 0c             	mov    0xc(%ebp),%esi
	// to = P2V(to);
	while(len-->0){
80104ebe:	85 c9                	test   %ecx,%ecx
80104ec0:	7e 14                	jle    80104ed6 <copyFromSystemSpace+0x26>
80104ec2:	31 c0                	xor    %eax,%eax
80104ec4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		*to++= *from++;
80104ec8:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80104ecc:	88 14 03             	mov    %dl,(%ebx,%eax,1)
80104ecf:	83 c0 01             	add    $0x1,%eax
	while(len-->0){
80104ed2:	39 c1                	cmp    %eax,%ecx
80104ed4:	75 f2                	jne    80104ec8 <copyFromSystemSpace+0x18>
		// to++;
		// from++;
	}
}
80104ed6:	5b                   	pop    %ebx
80104ed7:	5e                   	pop    %esi
80104ed8:	5d                   	pop    %ebp
80104ed9:	c3                   	ret    
80104eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ee0 <getMessageBuffer>:
	// if(msg_no != EndOfFreeList){
	// 	free_message_buffer = messageBuffers[msg_no][0];
	// }
	// return msg_no;

	lastBufferUsed++;
80104ee0:	a1 c0 b5 10 80       	mov    0x8010b5c0,%eax
{
80104ee5:	55                   	push   %ebp
80104ee6:	89 e5                	mov    %esp,%ebp
	int m = lastBufferUsed;
	lastBufferUsed++;
80104ee8:	8d 50 02             	lea    0x2(%eax),%edx
	lastBufferUsed++;
80104eeb:	83 c0 01             	add    $0x1,%eax

	return m;

}
80104eee:	5d                   	pop    %ebp
	lastBufferUsed++;
80104eef:	89 15 c0 b5 10 80    	mov    %edx,0x8010b5c0
}
80104ef5:	c3                   	ret    
80104ef6:	8d 76 00             	lea    0x0(%esi),%esi
80104ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f00 <freeMessageBuffer>:

void 
freeMessageBuffer(int msg_no)
{
80104f00:	55                   	push   %ebp
	messageBuffers[msg_no][0]= free_message_buffer;
80104f01:	8b 0d 20 1a 11 80    	mov    0x80111a20,%ecx
{
80104f07:	89 e5                	mov    %esp,%ebp
80104f09:	8b 45 08             	mov    0x8(%ebp),%eax
	messageBuffers[msg_no][0]= free_message_buffer;
80104f0c:	8b 14 85 e0 c5 10 80 	mov    -0x7fef3a20(,%eax,4),%edx
80104f13:	88 0a                	mov    %cl,(%edx)
	free_message_buffer = msg_no;
80104f15:	a3 20 1a 11 80       	mov    %eax,0x80111a20
}
80104f1a:	5d                   	pop    %ebp
80104f1b:	c3                   	ret    
80104f1c:	66 90                	xchg   %ax,%ax
80104f1e:	66 90                	xchg   %ax,%ax

80104f20 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104f20:	55                   	push   %ebp
80104f21:	89 e5                	mov    %esp,%ebp
80104f23:	57                   	push   %edi
80104f24:	56                   	push   %esi
80104f25:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104f26:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80104f29:	83 ec 44             	sub    $0x44,%esp
80104f2c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104f2f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104f32:	56                   	push   %esi
80104f33:	50                   	push   %eax
{
80104f34:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104f37:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104f3a:	e8 e1 cf ff ff       	call   80101f20 <nameiparent>
80104f3f:	83 c4 10             	add    $0x10,%esp
80104f42:	85 c0                	test   %eax,%eax
80104f44:	0f 84 46 01 00 00    	je     80105090 <create+0x170>
    return 0;
  ilock(dp);
80104f4a:	83 ec 0c             	sub    $0xc,%esp
80104f4d:	89 c3                	mov    %eax,%ebx
80104f4f:	50                   	push   %eax
80104f50:	e8 3b c7 ff ff       	call   80101690 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104f55:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104f58:	83 c4 0c             	add    $0xc,%esp
80104f5b:	50                   	push   %eax
80104f5c:	56                   	push   %esi
80104f5d:	53                   	push   %ebx
80104f5e:	e8 5d cc ff ff       	call   80101bc0 <dirlookup>
80104f63:	83 c4 10             	add    $0x10,%esp
80104f66:	85 c0                	test   %eax,%eax
80104f68:	89 c7                	mov    %eax,%edi
80104f6a:	74 34                	je     80104fa0 <create+0x80>
    iunlockput(dp);
80104f6c:	83 ec 0c             	sub    $0xc,%esp
80104f6f:	53                   	push   %ebx
80104f70:	e8 ab c9 ff ff       	call   80101920 <iunlockput>
    ilock(ip);
80104f75:	89 3c 24             	mov    %edi,(%esp)
80104f78:	e8 13 c7 ff ff       	call   80101690 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104f7d:	83 c4 10             	add    $0x10,%esp
80104f80:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104f85:	0f 85 95 00 00 00    	jne    80105020 <create+0x100>
80104f8b:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104f90:	0f 85 8a 00 00 00    	jne    80105020 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104f96:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f99:	89 f8                	mov    %edi,%eax
80104f9b:	5b                   	pop    %ebx
80104f9c:	5e                   	pop    %esi
80104f9d:	5f                   	pop    %edi
80104f9e:	5d                   	pop    %ebp
80104f9f:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80104fa0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104fa4:	83 ec 08             	sub    $0x8,%esp
80104fa7:	50                   	push   %eax
80104fa8:	ff 33                	pushl  (%ebx)
80104faa:	e8 71 c5 ff ff       	call   80101520 <ialloc>
80104faf:	83 c4 10             	add    $0x10,%esp
80104fb2:	85 c0                	test   %eax,%eax
80104fb4:	89 c7                	mov    %eax,%edi
80104fb6:	0f 84 e8 00 00 00    	je     801050a4 <create+0x184>
  ilock(ip);
80104fbc:	83 ec 0c             	sub    $0xc,%esp
80104fbf:	50                   	push   %eax
80104fc0:	e8 cb c6 ff ff       	call   80101690 <ilock>
  ip->major = major;
80104fc5:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104fc9:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104fcd:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104fd1:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104fd5:	b8 01 00 00 00       	mov    $0x1,%eax
80104fda:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104fde:	89 3c 24             	mov    %edi,(%esp)
80104fe1:	e8 fa c5 ff ff       	call   801015e0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104fe6:	83 c4 10             	add    $0x10,%esp
80104fe9:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104fee:	74 50                	je     80105040 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104ff0:	83 ec 04             	sub    $0x4,%esp
80104ff3:	ff 77 04             	pushl  0x4(%edi)
80104ff6:	56                   	push   %esi
80104ff7:	53                   	push   %ebx
80104ff8:	e8 43 ce ff ff       	call   80101e40 <dirlink>
80104ffd:	83 c4 10             	add    $0x10,%esp
80105000:	85 c0                	test   %eax,%eax
80105002:	0f 88 8f 00 00 00    	js     80105097 <create+0x177>
  iunlockput(dp);
80105008:	83 ec 0c             	sub    $0xc,%esp
8010500b:	53                   	push   %ebx
8010500c:	e8 0f c9 ff ff       	call   80101920 <iunlockput>
  return ip;
80105011:	83 c4 10             	add    $0x10,%esp
}
80105014:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105017:	89 f8                	mov    %edi,%eax
80105019:	5b                   	pop    %ebx
8010501a:	5e                   	pop    %esi
8010501b:	5f                   	pop    %edi
8010501c:	5d                   	pop    %ebp
8010501d:	c3                   	ret    
8010501e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105020:	83 ec 0c             	sub    $0xc,%esp
80105023:	57                   	push   %edi
    return 0;
80105024:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80105026:	e8 f5 c8 ff ff       	call   80101920 <iunlockput>
    return 0;
8010502b:	83 c4 10             	add    $0x10,%esp
}
8010502e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105031:	89 f8                	mov    %edi,%eax
80105033:	5b                   	pop    %ebx
80105034:	5e                   	pop    %esi
80105035:	5f                   	pop    %edi
80105036:	5d                   	pop    %ebp
80105037:	c3                   	ret    
80105038:	90                   	nop
80105039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80105040:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105045:	83 ec 0c             	sub    $0xc,%esp
80105048:	53                   	push   %ebx
80105049:	e8 92 c5 ff ff       	call   801015e0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010504e:	83 c4 0c             	add    $0xc,%esp
80105051:	ff 77 04             	pushl  0x4(%edi)
80105054:	68 58 84 10 80       	push   $0x80108458
80105059:	57                   	push   %edi
8010505a:	e8 e1 cd ff ff       	call   80101e40 <dirlink>
8010505f:	83 c4 10             	add    $0x10,%esp
80105062:	85 c0                	test   %eax,%eax
80105064:	78 1c                	js     80105082 <create+0x162>
80105066:	83 ec 04             	sub    $0x4,%esp
80105069:	ff 73 04             	pushl  0x4(%ebx)
8010506c:	68 57 84 10 80       	push   $0x80108457
80105071:	57                   	push   %edi
80105072:	e8 c9 cd ff ff       	call   80101e40 <dirlink>
80105077:	83 c4 10             	add    $0x10,%esp
8010507a:	85 c0                	test   %eax,%eax
8010507c:	0f 89 6e ff ff ff    	jns    80104ff0 <create+0xd0>
      panic("create dots");
80105082:	83 ec 0c             	sub    $0xc,%esp
80105085:	68 4b 84 10 80       	push   $0x8010844b
8010508a:	e8 01 b3 ff ff       	call   80100390 <panic>
8010508f:	90                   	nop
    return 0;
80105090:	31 ff                	xor    %edi,%edi
80105092:	e9 ff fe ff ff       	jmp    80104f96 <create+0x76>
    panic("create: dirlink");
80105097:	83 ec 0c             	sub    $0xc,%esp
8010509a:	68 5a 84 10 80       	push   $0x8010845a
8010509f:	e8 ec b2 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
801050a4:	83 ec 0c             	sub    $0xc,%esp
801050a7:	68 3c 84 10 80       	push   $0x8010843c
801050ac:	e8 df b2 ff ff       	call   80100390 <panic>
801050b1:	eb 0d                	jmp    801050c0 <argfd.constprop.0>
801050b3:	90                   	nop
801050b4:	90                   	nop
801050b5:	90                   	nop
801050b6:	90                   	nop
801050b7:	90                   	nop
801050b8:	90                   	nop
801050b9:	90                   	nop
801050ba:	90                   	nop
801050bb:	90                   	nop
801050bc:	90                   	nop
801050bd:	90                   	nop
801050be:	90                   	nop
801050bf:	90                   	nop

801050c0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
801050c0:	55                   	push   %ebp
801050c1:	89 e5                	mov    %esp,%ebp
801050c3:	56                   	push   %esi
801050c4:	53                   	push   %ebx
801050c5:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
801050c7:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
801050ca:	89 d6                	mov    %edx,%esi
801050cc:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801050cf:	50                   	push   %eax
801050d0:	6a 00                	push   $0x0
801050d2:	e8 d9 f9 ff ff       	call   80104ab0 <argint>
801050d7:	83 c4 10             	add    $0x10,%esp
801050da:	85 c0                	test   %eax,%eax
801050dc:	78 2a                	js     80105108 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801050de:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
801050e2:	77 24                	ja     80105108 <argfd.constprop.0+0x48>
801050e4:	e8 17 e7 ff ff       	call   80103800 <myproc>
801050e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801050ec:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
801050f0:	85 c0                	test   %eax,%eax
801050f2:	74 14                	je     80105108 <argfd.constprop.0+0x48>
  if(pfd)
801050f4:	85 db                	test   %ebx,%ebx
801050f6:	74 02                	je     801050fa <argfd.constprop.0+0x3a>
    *pfd = fd;
801050f8:	89 13                	mov    %edx,(%ebx)
    *pf = f;
801050fa:	89 06                	mov    %eax,(%esi)
  return 0;
801050fc:	31 c0                	xor    %eax,%eax
}
801050fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105101:	5b                   	pop    %ebx
80105102:	5e                   	pop    %esi
80105103:	5d                   	pop    %ebp
80105104:	c3                   	ret    
80105105:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105108:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010510d:	eb ef                	jmp    801050fe <argfd.constprop.0+0x3e>
8010510f:	90                   	nop

80105110 <sys_dup>:
{ if(isTraceOn==1)
80105110:	55                   	push   %ebp
80105111:	89 e5                	mov    %esp,%ebp
80105113:	56                   	push   %esi
80105114:	53                   	push   %ebx
80105115:	83 ec 10             	sub    $0x10,%esp
80105118:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
8010511f:	75 07                	jne    80105128 <sys_dup+0x18>
  {num_calls[SYS_dup] ++;}
80105121:	83 05 68 1a 11 80 01 	addl   $0x1,0x80111a68
  if(argfd(0, 0, &f) < 0)
80105128:	8d 55 f4             	lea    -0xc(%ebp),%edx
8010512b:	31 c0                	xor    %eax,%eax
8010512d:	e8 8e ff ff ff       	call   801050c0 <argfd.constprop.0>
80105132:	85 c0                	test   %eax,%eax
80105134:	78 42                	js     80105178 <sys_dup+0x68>
  if((fd=fdalloc(f)) < 0)
80105136:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105139:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010513b:	e8 c0 e6 ff ff       	call   80103800 <myproc>
80105140:	eb 0e                	jmp    80105150 <sys_dup+0x40>
80105142:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105148:	83 c3 01             	add    $0x1,%ebx
8010514b:	83 fb 64             	cmp    $0x64,%ebx
8010514e:	74 28                	je     80105178 <sys_dup+0x68>
    if(curproc->ofile[fd] == 0){
80105150:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105154:	85 d2                	test   %edx,%edx
80105156:	75 f0                	jne    80105148 <sys_dup+0x38>
      curproc->ofile[fd] = f;
80105158:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
8010515c:	83 ec 0c             	sub    $0xc,%esp
8010515f:	ff 75 f4             	pushl  -0xc(%ebp)
80105162:	e8 89 bc ff ff       	call   80100df0 <filedup>
  return fd;
80105167:	83 c4 10             	add    $0x10,%esp
}
8010516a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010516d:	89 d8                	mov    %ebx,%eax
8010516f:	5b                   	pop    %ebx
80105170:	5e                   	pop    %esi
80105171:	5d                   	pop    %ebp
80105172:	c3                   	ret    
80105173:	90                   	nop
80105174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105178:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
8010517b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105180:	89 d8                	mov    %ebx,%eax
80105182:	5b                   	pop    %ebx
80105183:	5e                   	pop    %esi
80105184:	5d                   	pop    %ebp
80105185:	c3                   	ret    
80105186:	8d 76 00             	lea    0x0(%esi),%esi
80105189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105190 <sys_read>:
{ if(isTraceOn==1)
80105190:	55                   	push   %ebp
80105191:	89 e5                	mov    %esp,%ebp
80105193:	83 ec 18             	sub    $0x18,%esp
80105196:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
8010519d:	75 07                	jne    801051a6 <sys_read+0x16>
  {num_calls[SYS_read] ++;}
8010519f:	83 05 54 1a 11 80 01 	addl   $0x1,0x80111a54
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801051a6:	8d 55 ec             	lea    -0x14(%ebp),%edx
801051a9:	31 c0                	xor    %eax,%eax
801051ab:	e8 10 ff ff ff       	call   801050c0 <argfd.constprop.0>
801051b0:	85 c0                	test   %eax,%eax
801051b2:	78 4c                	js     80105200 <sys_read+0x70>
801051b4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801051b7:	83 ec 08             	sub    $0x8,%esp
801051ba:	50                   	push   %eax
801051bb:	6a 02                	push   $0x2
801051bd:	e8 ee f8 ff ff       	call   80104ab0 <argint>
801051c2:	83 c4 10             	add    $0x10,%esp
801051c5:	85 c0                	test   %eax,%eax
801051c7:	78 37                	js     80105200 <sys_read+0x70>
801051c9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801051cc:	83 ec 04             	sub    $0x4,%esp
801051cf:	ff 75 f0             	pushl  -0x10(%ebp)
801051d2:	50                   	push   %eax
801051d3:	6a 01                	push   $0x1
801051d5:	e8 26 f9 ff ff       	call   80104b00 <argptr>
801051da:	83 c4 10             	add    $0x10,%esp
801051dd:	85 c0                	test   %eax,%eax
801051df:	78 1f                	js     80105200 <sys_read+0x70>
  return fileread(f, p, n);
801051e1:	83 ec 04             	sub    $0x4,%esp
801051e4:	ff 75 f0             	pushl  -0x10(%ebp)
801051e7:	ff 75 f4             	pushl  -0xc(%ebp)
801051ea:	ff 75 ec             	pushl  -0x14(%ebp)
801051ed:	e8 6e bd ff ff       	call   80100f60 <fileread>
801051f2:	83 c4 10             	add    $0x10,%esp
}
801051f5:	c9                   	leave  
801051f6:	c3                   	ret    
801051f7:	89 f6                	mov    %esi,%esi
801051f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105200:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105205:	c9                   	leave  
80105206:	c3                   	ret    
80105207:	89 f6                	mov    %esi,%esi
80105209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105210 <sys_write>:
{ if(isTraceOn==1)
80105210:	55                   	push   %ebp
80105211:	89 e5                	mov    %esp,%ebp
80105213:	83 ec 18             	sub    $0x18,%esp
80105216:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
8010521d:	75 07                	jne    80105226 <sys_write+0x16>
  {num_calls[SYS_write] ++;}
8010521f:	83 05 80 1a 11 80 01 	addl   $0x1,0x80111a80
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105226:	8d 55 ec             	lea    -0x14(%ebp),%edx
80105229:	31 c0                	xor    %eax,%eax
8010522b:	e8 90 fe ff ff       	call   801050c0 <argfd.constprop.0>
80105230:	85 c0                	test   %eax,%eax
80105232:	78 4c                	js     80105280 <sys_write+0x70>
80105234:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105237:	83 ec 08             	sub    $0x8,%esp
8010523a:	50                   	push   %eax
8010523b:	6a 02                	push   $0x2
8010523d:	e8 6e f8 ff ff       	call   80104ab0 <argint>
80105242:	83 c4 10             	add    $0x10,%esp
80105245:	85 c0                	test   %eax,%eax
80105247:	78 37                	js     80105280 <sys_write+0x70>
80105249:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010524c:	83 ec 04             	sub    $0x4,%esp
8010524f:	ff 75 f0             	pushl  -0x10(%ebp)
80105252:	50                   	push   %eax
80105253:	6a 01                	push   $0x1
80105255:	e8 a6 f8 ff ff       	call   80104b00 <argptr>
8010525a:	83 c4 10             	add    $0x10,%esp
8010525d:	85 c0                	test   %eax,%eax
8010525f:	78 1f                	js     80105280 <sys_write+0x70>
  return filewrite(f, p, n);
80105261:	83 ec 04             	sub    $0x4,%esp
80105264:	ff 75 f0             	pushl  -0x10(%ebp)
80105267:	ff 75 f4             	pushl  -0xc(%ebp)
8010526a:	ff 75 ec             	pushl  -0x14(%ebp)
8010526d:	e8 7e bd ff ff       	call   80100ff0 <filewrite>
80105272:	83 c4 10             	add    $0x10,%esp
}
80105275:	c9                   	leave  
80105276:	c3                   	ret    
80105277:	89 f6                	mov    %esi,%esi
80105279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105280:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105285:	c9                   	leave  
80105286:	c3                   	ret    
80105287:	89 f6                	mov    %esi,%esi
80105289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105290 <sys_close>:
{ if(isTraceOn==1)
80105290:	55                   	push   %ebp
80105291:	89 e5                	mov    %esp,%ebp
80105293:	83 ec 18             	sub    $0x18,%esp
80105296:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
8010529d:	75 07                	jne    801052a6 <sys_close+0x16>
  {num_calls[SYS_close] ++;}
8010529f:	83 05 94 1a 11 80 01 	addl   $0x1,0x80111a94
  if(argfd(0, &fd, &f) < 0)
801052a6:	8d 55 f4             	lea    -0xc(%ebp),%edx
801052a9:	8d 45 f0             	lea    -0x10(%ebp),%eax
801052ac:	e8 0f fe ff ff       	call   801050c0 <argfd.constprop.0>
801052b1:	85 c0                	test   %eax,%eax
801052b3:	78 2b                	js     801052e0 <sys_close+0x50>
  myproc()->ofile[fd] = 0;
801052b5:	e8 46 e5 ff ff       	call   80103800 <myproc>
801052ba:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
801052bd:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
801052c0:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
801052c7:	00 
  fileclose(f);
801052c8:	ff 75 f4             	pushl  -0xc(%ebp)
801052cb:	e8 70 bb ff ff       	call   80100e40 <fileclose>
  return 0;
801052d0:	83 c4 10             	add    $0x10,%esp
801052d3:	31 c0                	xor    %eax,%eax
}
801052d5:	c9                   	leave  
801052d6:	c3                   	ret    
801052d7:	89 f6                	mov    %esi,%esi
801052d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801052e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801052e5:	c9                   	leave  
801052e6:	c3                   	ret    
801052e7:	89 f6                	mov    %esi,%esi
801052e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801052f0 <sys_fstat>:
{ if(isTraceOn==1)
801052f0:	55                   	push   %ebp
801052f1:	89 e5                	mov    %esp,%ebp
801052f3:	83 ec 18             	sub    $0x18,%esp
801052f6:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
801052fd:	75 07                	jne    80105306 <sys_fstat+0x16>
  {num_calls[SYS_fstat] ++;}
801052ff:	83 05 60 1a 11 80 01 	addl   $0x1,0x80111a60
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105306:	8d 55 f0             	lea    -0x10(%ebp),%edx
80105309:	31 c0                	xor    %eax,%eax
8010530b:	e8 b0 fd ff ff       	call   801050c0 <argfd.constprop.0>
80105310:	85 c0                	test   %eax,%eax
80105312:	78 2c                	js     80105340 <sys_fstat+0x50>
80105314:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105317:	83 ec 04             	sub    $0x4,%esp
8010531a:	6a 14                	push   $0x14
8010531c:	50                   	push   %eax
8010531d:	6a 01                	push   $0x1
8010531f:	e8 dc f7 ff ff       	call   80104b00 <argptr>
80105324:	83 c4 10             	add    $0x10,%esp
80105327:	85 c0                	test   %eax,%eax
80105329:	78 15                	js     80105340 <sys_fstat+0x50>
  return filestat(f, st);
8010532b:	83 ec 08             	sub    $0x8,%esp
8010532e:	ff 75 f4             	pushl  -0xc(%ebp)
80105331:	ff 75 f0             	pushl  -0x10(%ebp)
80105334:	e8 d7 bb ff ff       	call   80100f10 <filestat>
80105339:	83 c4 10             	add    $0x10,%esp
}
8010533c:	c9                   	leave  
8010533d:	c3                   	ret    
8010533e:	66 90                	xchg   %ax,%ax
    return -1;
80105340:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105345:	c9                   	leave  
80105346:	c3                   	ret    
80105347:	89 f6                	mov    %esi,%esi
80105349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105350 <sys_link>:
{ 
80105350:	55                   	push   %ebp
80105351:	89 e5                	mov    %esp,%ebp
80105353:	57                   	push   %edi
80105354:	56                   	push   %esi
80105355:	53                   	push   %ebx
80105356:	83 ec 2c             	sub    $0x2c,%esp
  if(isTraceOn==1)
80105359:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
80105360:	75 07                	jne    80105369 <sys_link+0x19>
  {num_calls[SYS_link] ++;}
80105362:	83 05 8c 1a 11 80 01 	addl   $0x1,0x80111a8c
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105369:	8d 45 d4             	lea    -0x2c(%ebp),%eax
8010536c:	83 ec 08             	sub    $0x8,%esp
8010536f:	50                   	push   %eax
80105370:	6a 00                	push   $0x0
80105372:	e8 e9 f7 ff ff       	call   80104b60 <argstr>
80105377:	83 c4 10             	add    $0x10,%esp
8010537a:	85 c0                	test   %eax,%eax
8010537c:	0f 88 f8 00 00 00    	js     8010547a <sys_link+0x12a>
80105382:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105385:	83 ec 08             	sub    $0x8,%esp
80105388:	50                   	push   %eax
80105389:	6a 01                	push   $0x1
8010538b:	e8 d0 f7 ff ff       	call   80104b60 <argstr>
80105390:	83 c4 10             	add    $0x10,%esp
80105393:	85 c0                	test   %eax,%eax
80105395:	0f 88 df 00 00 00    	js     8010547a <sys_link+0x12a>
  begin_op();
8010539b:	e8 20 d8 ff ff       	call   80102bc0 <begin_op>
  if((ip = namei(old)) == 0){
801053a0:	83 ec 0c             	sub    $0xc,%esp
801053a3:	ff 75 d4             	pushl  -0x2c(%ebp)
801053a6:	e8 55 cb ff ff       	call   80101f00 <namei>
801053ab:	83 c4 10             	add    $0x10,%esp
801053ae:	85 c0                	test   %eax,%eax
801053b0:	89 c3                	mov    %eax,%ebx
801053b2:	0f 84 e7 00 00 00    	je     8010549f <sys_link+0x14f>
  ilock(ip);
801053b8:	83 ec 0c             	sub    $0xc,%esp
801053bb:	50                   	push   %eax
801053bc:	e8 cf c2 ff ff       	call   80101690 <ilock>
  if(ip->type == T_DIR){
801053c1:	83 c4 10             	add    $0x10,%esp
801053c4:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801053c9:	0f 84 b8 00 00 00    	je     80105487 <sys_link+0x137>
  ip->nlink++;
801053cf:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
801053d4:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
801053d7:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801053da:	53                   	push   %ebx
801053db:	e8 00 c2 ff ff       	call   801015e0 <iupdate>
  iunlock(ip);
801053e0:	89 1c 24             	mov    %ebx,(%esp)
801053e3:	e8 88 c3 ff ff       	call   80101770 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
801053e8:	58                   	pop    %eax
801053e9:	5a                   	pop    %edx
801053ea:	57                   	push   %edi
801053eb:	ff 75 d0             	pushl  -0x30(%ebp)
801053ee:	e8 2d cb ff ff       	call   80101f20 <nameiparent>
801053f3:	83 c4 10             	add    $0x10,%esp
801053f6:	85 c0                	test   %eax,%eax
801053f8:	89 c6                	mov    %eax,%esi
801053fa:	74 58                	je     80105454 <sys_link+0x104>
  ilock(dp);
801053fc:	83 ec 0c             	sub    $0xc,%esp
801053ff:	50                   	push   %eax
80105400:	e8 8b c2 ff ff       	call   80101690 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105405:	83 c4 10             	add    $0x10,%esp
80105408:	8b 03                	mov    (%ebx),%eax
8010540a:	39 06                	cmp    %eax,(%esi)
8010540c:	75 3a                	jne    80105448 <sys_link+0xf8>
8010540e:	83 ec 04             	sub    $0x4,%esp
80105411:	ff 73 04             	pushl  0x4(%ebx)
80105414:	57                   	push   %edi
80105415:	56                   	push   %esi
80105416:	e8 25 ca ff ff       	call   80101e40 <dirlink>
8010541b:	83 c4 10             	add    $0x10,%esp
8010541e:	85 c0                	test   %eax,%eax
80105420:	78 26                	js     80105448 <sys_link+0xf8>
  iunlockput(dp);
80105422:	83 ec 0c             	sub    $0xc,%esp
80105425:	56                   	push   %esi
80105426:	e8 f5 c4 ff ff       	call   80101920 <iunlockput>
  iput(ip);
8010542b:	89 1c 24             	mov    %ebx,(%esp)
8010542e:	e8 8d c3 ff ff       	call   801017c0 <iput>
  end_op();
80105433:	e8 f8 d7 ff ff       	call   80102c30 <end_op>
  return 0;
80105438:	83 c4 10             	add    $0x10,%esp
8010543b:	31 c0                	xor    %eax,%eax
}
8010543d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105440:	5b                   	pop    %ebx
80105441:	5e                   	pop    %esi
80105442:	5f                   	pop    %edi
80105443:	5d                   	pop    %ebp
80105444:	c3                   	ret    
80105445:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(dp);
80105448:	83 ec 0c             	sub    $0xc,%esp
8010544b:	56                   	push   %esi
8010544c:	e8 cf c4 ff ff       	call   80101920 <iunlockput>
    goto bad;
80105451:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105454:	83 ec 0c             	sub    $0xc,%esp
80105457:	53                   	push   %ebx
80105458:	e8 33 c2 ff ff       	call   80101690 <ilock>
  ip->nlink--;
8010545d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105462:	89 1c 24             	mov    %ebx,(%esp)
80105465:	e8 76 c1 ff ff       	call   801015e0 <iupdate>
  iunlockput(ip);
8010546a:	89 1c 24             	mov    %ebx,(%esp)
8010546d:	e8 ae c4 ff ff       	call   80101920 <iunlockput>
  end_op();
80105472:	e8 b9 d7 ff ff       	call   80102c30 <end_op>
  return -1;
80105477:	83 c4 10             	add    $0x10,%esp
}
8010547a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010547d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105482:	5b                   	pop    %ebx
80105483:	5e                   	pop    %esi
80105484:	5f                   	pop    %edi
80105485:	5d                   	pop    %ebp
80105486:	c3                   	ret    
    iunlockput(ip);
80105487:	83 ec 0c             	sub    $0xc,%esp
8010548a:	53                   	push   %ebx
8010548b:	e8 90 c4 ff ff       	call   80101920 <iunlockput>
    end_op();
80105490:	e8 9b d7 ff ff       	call   80102c30 <end_op>
    return -1;
80105495:	83 c4 10             	add    $0x10,%esp
80105498:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010549d:	eb 9e                	jmp    8010543d <sys_link+0xed>
    end_op();
8010549f:	e8 8c d7 ff ff       	call   80102c30 <end_op>
    return -1;
801054a4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054a9:	eb 92                	jmp    8010543d <sys_link+0xed>
801054ab:	90                   	nop
801054ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054b0 <sys_unlink>:
{ if(isTraceOn==1)
801054b0:	55                   	push   %ebp
801054b1:	89 e5                	mov    %esp,%ebp
801054b3:	57                   	push   %edi
801054b4:	56                   	push   %esi
801054b5:	53                   	push   %ebx
801054b6:	83 ec 3c             	sub    $0x3c,%esp
801054b9:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
801054c0:	75 07                	jne    801054c9 <sys_unlink+0x19>
  {num_calls[SYS_unlink] ++;}
801054c2:	83 05 88 1a 11 80 01 	addl   $0x1,0x80111a88
  if(argstr(0, &path) < 0)
801054c9:	8d 45 c0             	lea    -0x40(%ebp),%eax
801054cc:	83 ec 08             	sub    $0x8,%esp
801054cf:	50                   	push   %eax
801054d0:	6a 00                	push   $0x0
801054d2:	e8 89 f6 ff ff       	call   80104b60 <argstr>
801054d7:	83 c4 10             	add    $0x10,%esp
801054da:	85 c0                	test   %eax,%eax
801054dc:	0f 88 74 01 00 00    	js     80105656 <sys_unlink+0x1a6>
  if((dp = nameiparent(path, name)) == 0){
801054e2:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
801054e5:	e8 d6 d6 ff ff       	call   80102bc0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801054ea:	83 ec 08             	sub    $0x8,%esp
801054ed:	53                   	push   %ebx
801054ee:	ff 75 c0             	pushl  -0x40(%ebp)
801054f1:	e8 2a ca ff ff       	call   80101f20 <nameiparent>
801054f6:	83 c4 10             	add    $0x10,%esp
801054f9:	85 c0                	test   %eax,%eax
801054fb:	89 c6                	mov    %eax,%esi
801054fd:	0f 84 5d 01 00 00    	je     80105660 <sys_unlink+0x1b0>
  ilock(dp);
80105503:	83 ec 0c             	sub    $0xc,%esp
80105506:	50                   	push   %eax
80105507:	e8 84 c1 ff ff       	call   80101690 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010550c:	58                   	pop    %eax
8010550d:	5a                   	pop    %edx
8010550e:	68 58 84 10 80       	push   $0x80108458
80105513:	53                   	push   %ebx
80105514:	e8 87 c6 ff ff       	call   80101ba0 <namecmp>
80105519:	83 c4 10             	add    $0x10,%esp
8010551c:	85 c0                	test   %eax,%eax
8010551e:	0f 84 00 01 00 00    	je     80105624 <sys_unlink+0x174>
80105524:	83 ec 08             	sub    $0x8,%esp
80105527:	68 57 84 10 80       	push   $0x80108457
8010552c:	53                   	push   %ebx
8010552d:	e8 6e c6 ff ff       	call   80101ba0 <namecmp>
80105532:	83 c4 10             	add    $0x10,%esp
80105535:	85 c0                	test   %eax,%eax
80105537:	0f 84 e7 00 00 00    	je     80105624 <sys_unlink+0x174>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010553d:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105540:	83 ec 04             	sub    $0x4,%esp
80105543:	50                   	push   %eax
80105544:	53                   	push   %ebx
80105545:	56                   	push   %esi
80105546:	e8 75 c6 ff ff       	call   80101bc0 <dirlookup>
8010554b:	83 c4 10             	add    $0x10,%esp
8010554e:	85 c0                	test   %eax,%eax
80105550:	89 c3                	mov    %eax,%ebx
80105552:	0f 84 cc 00 00 00    	je     80105624 <sys_unlink+0x174>
  ilock(ip);
80105558:	83 ec 0c             	sub    $0xc,%esp
8010555b:	50                   	push   %eax
8010555c:	e8 2f c1 ff ff       	call   80101690 <ilock>
  if(ip->nlink < 1)
80105561:	83 c4 10             	add    $0x10,%esp
80105564:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105569:	0f 8e 0d 01 00 00    	jle    8010567c <sys_unlink+0x1cc>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010556f:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105574:	74 6a                	je     801055e0 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
80105576:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105579:	83 ec 04             	sub    $0x4,%esp
8010557c:	6a 10                	push   $0x10
8010557e:	6a 00                	push   $0x0
80105580:	50                   	push   %eax
80105581:	e8 2a f2 ff ff       	call   801047b0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105586:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105589:	6a 10                	push   $0x10
8010558b:	ff 75 c4             	pushl  -0x3c(%ebp)
8010558e:	50                   	push   %eax
8010558f:	56                   	push   %esi
80105590:	e8 db c4 ff ff       	call   80101a70 <writei>
80105595:	83 c4 20             	add    $0x20,%esp
80105598:	83 f8 10             	cmp    $0x10,%eax
8010559b:	0f 85 e8 00 00 00    	jne    80105689 <sys_unlink+0x1d9>
  if(ip->type == T_DIR){
801055a1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801055a6:	0f 84 94 00 00 00    	je     80105640 <sys_unlink+0x190>
  iunlockput(dp);
801055ac:	83 ec 0c             	sub    $0xc,%esp
801055af:	56                   	push   %esi
801055b0:	e8 6b c3 ff ff       	call   80101920 <iunlockput>
  ip->nlink--;
801055b5:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801055ba:	89 1c 24             	mov    %ebx,(%esp)
801055bd:	e8 1e c0 ff ff       	call   801015e0 <iupdate>
  iunlockput(ip);
801055c2:	89 1c 24             	mov    %ebx,(%esp)
801055c5:	e8 56 c3 ff ff       	call   80101920 <iunlockput>
  end_op();
801055ca:	e8 61 d6 ff ff       	call   80102c30 <end_op>
  return 0;
801055cf:	83 c4 10             	add    $0x10,%esp
801055d2:	31 c0                	xor    %eax,%eax
}
801055d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055d7:	5b                   	pop    %ebx
801055d8:	5e                   	pop    %esi
801055d9:	5f                   	pop    %edi
801055da:	5d                   	pop    %ebp
801055db:	c3                   	ret    
801055dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801055e0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801055e4:	76 90                	jbe    80105576 <sys_unlink+0xc6>
801055e6:	bf 20 00 00 00       	mov    $0x20,%edi
801055eb:	eb 0f                	jmp    801055fc <sys_unlink+0x14c>
801055ed:	8d 76 00             	lea    0x0(%esi),%esi
801055f0:	83 c7 10             	add    $0x10,%edi
801055f3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801055f6:	0f 83 7a ff ff ff    	jae    80105576 <sys_unlink+0xc6>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801055fc:	8d 45 d8             	lea    -0x28(%ebp),%eax
801055ff:	6a 10                	push   $0x10
80105601:	57                   	push   %edi
80105602:	50                   	push   %eax
80105603:	53                   	push   %ebx
80105604:	e8 67 c3 ff ff       	call   80101970 <readi>
80105609:	83 c4 10             	add    $0x10,%esp
8010560c:	83 f8 10             	cmp    $0x10,%eax
8010560f:	75 5e                	jne    8010566f <sys_unlink+0x1bf>
    if(de.inum != 0)
80105611:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105616:	74 d8                	je     801055f0 <sys_unlink+0x140>
    iunlockput(ip);
80105618:	83 ec 0c             	sub    $0xc,%esp
8010561b:	53                   	push   %ebx
8010561c:	e8 ff c2 ff ff       	call   80101920 <iunlockput>
    goto bad;
80105621:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80105624:	83 ec 0c             	sub    $0xc,%esp
80105627:	56                   	push   %esi
80105628:	e8 f3 c2 ff ff       	call   80101920 <iunlockput>
  end_op();
8010562d:	e8 fe d5 ff ff       	call   80102c30 <end_op>
  return -1;
80105632:	83 c4 10             	add    $0x10,%esp
80105635:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010563a:	eb 98                	jmp    801055d4 <sys_unlink+0x124>
8010563c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80105640:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105645:	83 ec 0c             	sub    $0xc,%esp
80105648:	56                   	push   %esi
80105649:	e8 92 bf ff ff       	call   801015e0 <iupdate>
8010564e:	83 c4 10             	add    $0x10,%esp
80105651:	e9 56 ff ff ff       	jmp    801055ac <sys_unlink+0xfc>
    return -1;
80105656:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010565b:	e9 74 ff ff ff       	jmp    801055d4 <sys_unlink+0x124>
    end_op();
80105660:	e8 cb d5 ff ff       	call   80102c30 <end_op>
    return -1;
80105665:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010566a:	e9 65 ff ff ff       	jmp    801055d4 <sys_unlink+0x124>
      panic("isdirempty: readi");
8010566f:	83 ec 0c             	sub    $0xc,%esp
80105672:	68 7c 84 10 80       	push   $0x8010847c
80105677:	e8 14 ad ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
8010567c:	83 ec 0c             	sub    $0xc,%esp
8010567f:	68 6a 84 10 80       	push   $0x8010846a
80105684:	e8 07 ad ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105689:	83 ec 0c             	sub    $0xc,%esp
8010568c:	68 8e 84 10 80       	push   $0x8010848e
80105691:	e8 fa ac ff ff       	call   80100390 <panic>
80105696:	8d 76 00             	lea    0x0(%esi),%esi
80105699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801056a0 <sys_open>:

int
sys_open(void)
{ if(isTraceOn==1)
801056a0:	55                   	push   %ebp
801056a1:	89 e5                	mov    %esp,%ebp
801056a3:	57                   	push   %edi
801056a4:	56                   	push   %esi
801056a5:	53                   	push   %ebx
801056a6:	83 ec 1c             	sub    $0x1c,%esp
801056a9:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
801056b0:	75 07                	jne    801056b9 <sys_open+0x19>
  {num_calls[SYS_open] ++;}
801056b2:	83 05 7c 1a 11 80 01 	addl   $0x1,0x80111a7c
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801056b9:	8d 45 e0             	lea    -0x20(%ebp),%eax
801056bc:	83 ec 08             	sub    $0x8,%esp
801056bf:	50                   	push   %eax
801056c0:	6a 00                	push   $0x0
801056c2:	e8 99 f4 ff ff       	call   80104b60 <argstr>
801056c7:	83 c4 10             	add    $0x10,%esp
801056ca:	85 c0                	test   %eax,%eax
801056cc:	0f 88 22 01 00 00    	js     801057f4 <sys_open+0x154>
801056d2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801056d5:	83 ec 08             	sub    $0x8,%esp
801056d8:	50                   	push   %eax
801056d9:	6a 01                	push   $0x1
801056db:	e8 d0 f3 ff ff       	call   80104ab0 <argint>
801056e0:	83 c4 10             	add    $0x10,%esp
801056e3:	85 c0                	test   %eax,%eax
801056e5:	0f 88 09 01 00 00    	js     801057f4 <sys_open+0x154>
    return -1;

  begin_op();
801056eb:	e8 d0 d4 ff ff       	call   80102bc0 <begin_op>

  if(omode & O_CREATE){
801056f0:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801056f4:	0f 85 ae 00 00 00    	jne    801057a8 <sys_open+0x108>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801056fa:	83 ec 0c             	sub    $0xc,%esp
801056fd:	ff 75 e0             	pushl  -0x20(%ebp)
80105700:	e8 fb c7 ff ff       	call   80101f00 <namei>
80105705:	83 c4 10             	add    $0x10,%esp
80105708:	85 c0                	test   %eax,%eax
8010570a:	89 c6                	mov    %eax,%esi
8010570c:	0f 84 b7 00 00 00    	je     801057c9 <sys_open+0x129>
      end_op();
      return -1;
    }
    ilock(ip);
80105712:	83 ec 0c             	sub    $0xc,%esp
80105715:	50                   	push   %eax
80105716:	e8 75 bf ff ff       	call   80101690 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
8010571b:	83 c4 10             	add    $0x10,%esp
8010571e:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105723:	0f 84 af 00 00 00    	je     801057d8 <sys_open+0x138>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105729:	e8 52 b6 ff ff       	call   80100d80 <filealloc>
8010572e:	85 c0                	test   %eax,%eax
80105730:	89 c7                	mov    %eax,%edi
80105732:	0f 84 ab 00 00 00    	je     801057e3 <sys_open+0x143>
  struct proc *curproc = myproc();
80105738:	e8 c3 e0 ff ff       	call   80103800 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010573d:	31 db                	xor    %ebx,%ebx
8010573f:	eb 13                	jmp    80105754 <sys_open+0xb4>
80105741:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105748:	83 c3 01             	add    $0x1,%ebx
8010574b:	83 fb 64             	cmp    $0x64,%ebx
8010574e:	0f 84 ac 00 00 00    	je     80105800 <sys_open+0x160>
    if(curproc->ofile[fd] == 0){
80105754:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105758:	85 d2                	test   %edx,%edx
8010575a:	75 ec                	jne    80105748 <sys_open+0xa8>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
8010575c:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
8010575f:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105763:	56                   	push   %esi
80105764:	e8 07 c0 ff ff       	call   80101770 <iunlock>
  end_op();
80105769:	e8 c2 d4 ff ff       	call   80102c30 <end_op>

  f->type = FD_INODE;
8010576e:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105774:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105777:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
8010577a:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
8010577d:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105784:	89 d0                	mov    %edx,%eax
80105786:	f7 d0                	not    %eax
80105788:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010578b:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
8010578e:	88 47 08             	mov    %al,0x8(%edi)
  f->path = path;
80105791:	8b 45 e0             	mov    -0x20(%ebp),%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105794:	0f 95 47 09          	setne  0x9(%edi)
  f->path = path;
80105798:	89 47 1c             	mov    %eax,0x1c(%edi)
  return fd;
}
8010579b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010579e:	89 d8                	mov    %ebx,%eax
801057a0:	5b                   	pop    %ebx
801057a1:	5e                   	pop    %esi
801057a2:	5f                   	pop    %edi
801057a3:	5d                   	pop    %ebp
801057a4:	c3                   	ret    
801057a5:	8d 76 00             	lea    0x0(%esi),%esi
    ip = create(path, T_FILE, 0, 0);
801057a8:	83 ec 0c             	sub    $0xc,%esp
801057ab:	8b 45 e0             	mov    -0x20(%ebp),%eax
801057ae:	31 c9                	xor    %ecx,%ecx
801057b0:	6a 00                	push   $0x0
801057b2:	ba 02 00 00 00       	mov    $0x2,%edx
801057b7:	e8 64 f7 ff ff       	call   80104f20 <create>
    if(ip == 0){
801057bc:	83 c4 10             	add    $0x10,%esp
801057bf:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
801057c1:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801057c3:	0f 85 60 ff ff ff    	jne    80105729 <sys_open+0x89>
      end_op();
801057c9:	e8 62 d4 ff ff       	call   80102c30 <end_op>
      return -1;
801057ce:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801057d3:	eb c6                	jmp    8010579b <sys_open+0xfb>
801057d5:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
801057d8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801057db:	85 c9                	test   %ecx,%ecx
801057dd:	0f 84 46 ff ff ff    	je     80105729 <sys_open+0x89>
    iunlockput(ip);
801057e3:	83 ec 0c             	sub    $0xc,%esp
801057e6:	56                   	push   %esi
801057e7:	e8 34 c1 ff ff       	call   80101920 <iunlockput>
    end_op();
801057ec:	e8 3f d4 ff ff       	call   80102c30 <end_op>
    return -1;
801057f1:	83 c4 10             	add    $0x10,%esp
801057f4:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801057f9:	eb a0                	jmp    8010579b <sys_open+0xfb>
801057fb:	90                   	nop
801057fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105800:	83 ec 0c             	sub    $0xc,%esp
80105803:	57                   	push   %edi
80105804:	e8 37 b6 ff ff       	call   80100e40 <fileclose>
80105809:	83 c4 10             	add    $0x10,%esp
8010580c:	eb d5                	jmp    801057e3 <sys_open+0x143>
8010580e:	66 90                	xchg   %ax,%ax

80105810 <my_itoa>:

// new code
// a file is already present, we have to just make a copy and open the new file.

char* my_itoa(int i, char* b){
80105810:	55                   	push   %ebp
    char const digit[] = "0123456789";
80105811:	b8 38 39 00 00       	mov    $0x3938,%eax
char* my_itoa(int i, char* b){
80105816:	89 e5                	mov    %esp,%ebp
80105818:	57                   	push   %edi
80105819:	56                   	push   %esi
8010581a:	53                   	push   %ebx
    //     i *= -1;
    // }
    int n = i;
    do{
        ++p;
        n = n/10;
8010581b:	bf 67 66 66 66       	mov    $0x66666667,%edi
char* my_itoa(int i, char* b){
80105820:	83 ec 10             	sub    $0x10,%esp
80105823:	8b 4d 08             	mov    0x8(%ebp),%ecx
    char* p = b;
80105826:	8b 75 0c             	mov    0xc(%ebp),%esi
    char const digit[] = "0123456789";
80105829:	c7 45 e9 30 31 32 33 	movl   $0x33323130,-0x17(%ebp)
80105830:	c7 45 ed 34 35 36 37 	movl   $0x37363534,-0x13(%ebp)
80105837:	66 89 45 f1          	mov    %ax,-0xf(%ebp)
8010583b:	c6 45 f3 00          	movb   $0x0,-0xd(%ebp)
    int n = i;
8010583f:	89 cb                	mov    %ecx,%ebx
80105841:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        n = n/10;
80105848:	89 d8                	mov    %ebx,%eax
8010584a:	c1 fb 1f             	sar    $0x1f,%ebx
        ++p;
8010584d:	83 c6 01             	add    $0x1,%esi
        n = n/10;
80105850:	f7 ef                	imul   %edi
80105852:	c1 fa 02             	sar    $0x2,%edx
    }while(n);
80105855:	29 da                	sub    %ebx,%edx
80105857:	89 d3                	mov    %edx,%ebx
80105859:	75 ed                	jne    80105848 <my_itoa+0x38>
    *p = '\0';
8010585b:	c6 06 00             	movb   $0x0,(%esi)
    do{
        *--p = digit[i%10];
8010585e:	bb 67 66 66 66       	mov    $0x66666667,%ebx
80105863:	90                   	nop
80105864:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105868:	89 c8                	mov    %ecx,%eax
8010586a:	83 ee 01             	sub    $0x1,%esi
8010586d:	f7 eb                	imul   %ebx
8010586f:	89 c8                	mov    %ecx,%eax
80105871:	c1 f8 1f             	sar    $0x1f,%eax
80105874:	c1 fa 02             	sar    $0x2,%edx
80105877:	29 c2                	sub    %eax,%edx
80105879:	8d 04 92             	lea    (%edx,%edx,4),%eax
8010587c:	01 c0                	add    %eax,%eax
8010587e:	29 c1                	sub    %eax,%ecx
        i = i/10;
    }while(i);
80105880:	85 d2                	test   %edx,%edx
        *--p = digit[i%10];
80105882:	0f b6 44 0d e9       	movzbl -0x17(%ebp,%ecx,1),%eax
        i = i/10;
80105887:	89 d1                	mov    %edx,%ecx
        *--p = digit[i%10];
80105889:	88 06                	mov    %al,(%esi)
    }while(i);
8010588b:	75 db                	jne    80105868 <my_itoa+0x58>
    return b;
}
8010588d:	8b 45 0c             	mov    0xc(%ebp),%eax
80105890:	83 c4 10             	add    $0x10,%esp
80105893:	5b                   	pop    %ebx
80105894:	5e                   	pop    %esi
80105895:	5f                   	pop    %edi
80105896:	5d                   	pop    %ebp
80105897:	c3                   	ret    
80105898:	90                   	nop
80105899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801058a0 <strcat>:

char* strcat(char* s1, const char* s2)
{
801058a0:	55                   	push   %ebp
801058a1:	89 e5                	mov    %esp,%ebp
801058a3:	53                   	push   %ebx
801058a4:	8b 45 08             	mov    0x8(%ebp),%eax
801058a7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char* b = s1;

  while (*s1) ++s1;
801058aa:	80 38 00             	cmpb   $0x0,(%eax)
801058ad:	89 c2                	mov    %eax,%edx
801058af:	74 28                	je     801058d9 <strcat+0x39>
801058b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801058b8:	83 c2 01             	add    $0x1,%edx
801058bb:	80 3a 00             	cmpb   $0x0,(%edx)
801058be:	75 f8                	jne    801058b8 <strcat+0x18>
  while (*s2) *s1++ = *s2++;
801058c0:	0f b6 0b             	movzbl (%ebx),%ecx
801058c3:	84 c9                	test   %cl,%cl
801058c5:	74 19                	je     801058e0 <strcat+0x40>
801058c7:	89 f6                	mov    %esi,%esi
801058c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801058d0:	83 c2 01             	add    $0x1,%edx
801058d3:	83 c3 01             	add    $0x1,%ebx
801058d6:	88 4a ff             	mov    %cl,-0x1(%edx)
801058d9:	0f b6 0b             	movzbl (%ebx),%ecx
801058dc:	84 c9                	test   %cl,%cl
801058de:	75 f0                	jne    801058d0 <strcat+0x30>
  *s1 = 0;
801058e0:	c6 02 00             	movb   $0x0,(%edx)

  return b;
}
801058e3:	5b                   	pop    %ebx
801058e4:	5d                   	pop    %ebp
801058e5:	c3                   	ret    
801058e6:	8d 76 00             	lea    0x0(%esi),%esi
801058e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058f0 <sys_newopen>:

char *buf;

int
sys_newopen(void)
{ 
801058f0:	55                   	push   %ebp
801058f1:	89 e5                	mov    %esp,%ebp
801058f3:	57                   	push   %edi
801058f4:	56                   	push   %esi
801058f5:	53                   	push   %ebx
801058f6:	83 ec 3c             	sub    $0x3c,%esp
  if(isTraceOn==1)
801058f9:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
80105900:	75 07                	jne    80105909 <sys_newopen+0x19>
  {num_calls[SYS_open] ++;}
80105902:	83 05 7c 1a 11 80 01 	addl   $0x1,0x80111a7c
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105909:	8d 45 d4             	lea    -0x2c(%ebp),%eax
8010590c:	83 ec 08             	sub    $0x8,%esp
8010590f:	50                   	push   %eax
80105910:	6a 00                	push   $0x0
80105912:	e8 49 f2 ff ff       	call   80104b60 <argstr>
80105917:	83 c4 10             	add    $0x10,%esp
8010591a:	85 c0                	test   %eax,%eax
8010591c:	0f 88 03 03 00 00    	js     80105c25 <sys_newopen+0x335>
80105922:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105925:	83 ec 08             	sub    $0x8,%esp
80105928:	50                   	push   %eax
80105929:	6a 01                	push   $0x1
8010592b:	e8 80 f1 ff ff       	call   80104ab0 <argint>
80105930:	83 c4 10             	add    $0x10,%esp
80105933:	85 c0                	test   %eax,%eax
80105935:	0f 88 ea 02 00 00    	js     80105c25 <sys_newopen+0x335>
    return -1;

  begin_op();
8010593b:	e8 80 d2 ff ff       	call   80102bc0 <begin_op>

  if(omode & O_CREATE){
80105940:	f6 45 d9 02          	testb  $0x2,-0x27(%ebp)
80105944:	0f 85 5e 02 00 00    	jne    80105ba8 <sys_newopen+0x2b8>
      end_op();
      return -1;
    }
  } 
  else {
    if((ip = namei(path)) == 0){
8010594a:	83 ec 0c             	sub    $0xc,%esp
8010594d:	ff 75 d4             	pushl  -0x2c(%ebp)
80105950:	e8 ab c5 ff ff       	call   80101f00 <namei>
80105955:	83 c4 10             	add    $0x10,%esp
80105958:	85 c0                	test   %eax,%eax
8010595a:	89 c3                	mov    %eax,%ebx
8010595c:	0f 84 67 02 00 00    	je     80105bc9 <sys_newopen+0x2d9>
      end_op();
      return -1;
    }
    ilock(ip);
80105962:	83 ec 0c             	sub    $0xc,%esp
80105965:	50                   	push   %eax
80105966:	e8 25 bd ff ff       	call   80101690 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
8010596b:	83 c4 10             	add    $0x10,%esp
8010596e:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105973:	0f 84 5f 02 00 00    	je     80105bd8 <sys_newopen+0x2e8>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105979:	e8 02 b4 ff ff       	call   80100d80 <filealloc>
8010597e:	85 c0                	test   %eax,%eax
80105980:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80105983:	0f 84 5a 02 00 00    	je     80105be3 <sys_newopen+0x2f3>
  struct proc *curproc = myproc();
80105989:	e8 72 de ff ff       	call   80103800 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010598e:	31 d2                	xor    %edx,%edx
80105990:	eb 12                	jmp    801059a4 <sys_newopen+0xb4>
80105992:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105998:	83 c2 01             	add    $0x1,%edx
8010599b:	83 fa 64             	cmp    $0x64,%edx
8010599e:	0f 84 8c 02 00 00    	je     80105c30 <sys_newopen+0x340>
    if(curproc->ofile[fd] == 0){
801059a4:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801059a8:	85 f6                	test   %esi,%esi
801059aa:	75 ec                	jne    80105998 <sys_newopen+0xa8>
      curproc->ofile[fd] = f;
801059ac:	8b 7d c4             	mov    -0x3c(%ebp),%edi
801059af:	8d 4a 08             	lea    0x8(%edx),%ecx
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801059b2:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801059b5:	89 4d bc             	mov    %ecx,-0x44(%ebp)
801059b8:	89 7c 88 08          	mov    %edi,0x8(%eax,%ecx,4)
  iunlock(ip);
801059bc:	53                   	push   %ebx
801059bd:	e8 ae bd ff ff       	call   80101770 <iunlock>
  end_op();
801059c2:	e8 69 d2 ff ff       	call   80102c30 <end_op>

  f->type = FD_INODE;
801059c7:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801059cd:	8b 55 d8             	mov    -0x28(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801059d0:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801059d3:	89 5f 10             	mov    %ebx,0x10(%edi)
  f->off = 0;
801059d6:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801059dd:	89 d0                	mov    %edx,%eax
801059df:	f7 d0                	not    %eax
801059e1:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801059e4:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801059e7:	88 47 08             	mov    %al,0x8(%edi)
  f->path = path;
801059ea:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801059ed:	0f 95 47 09          	setne  0x9(%edi)
  f->path = path;
801059f1:	89 47 1c             	mov    %eax,0x1c(%edi)
  // return fd;

  // fd has the original file
  struct proc *curproc = myproc();
801059f4:	e8 07 de ff ff       	call   80103800 <myproc>
  struct file *f2;
  int fd2;
  int ind = curproc->cid;
801059f9:	8b 98 cc 01 00 00    	mov    0x1cc(%eax),%ebx

  char *sind = (char *)kalloc();
801059ff:	e8 dc ca ff ff       	call   801024e0 <kalloc>
    char const digit[] = "0123456789";
80105a04:	b9 38 39 00 00       	mov    $0x3938,%ecx
  char *sind = (char *)kalloc();
80105a09:	89 c7                	mov    %eax,%edi
    char const digit[] = "0123456789";
80105a0b:	c7 45 dd 30 31 32 33 	movl   $0x33323130,-0x23(%ebp)
80105a12:	66 89 4d e5          	mov    %cx,-0x1b(%ebp)
80105a16:	c7 45 e1 34 35 36 37 	movl   $0x37363534,-0x1f(%ebp)
    int n = i;
80105a1d:	89 d9                	mov    %ebx,%ecx
    char const digit[] = "0123456789";
80105a1f:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
  char *sind = (char *)kalloc();
80105a23:	89 c6                	mov    %eax,%esi
80105a25:	8d 76 00             	lea    0x0(%esi),%esi
        n = n/10;
80105a28:	b8 67 66 66 66       	mov    $0x66666667,%eax
        ++p;
80105a2d:	83 c6 01             	add    $0x1,%esi
        n = n/10;
80105a30:	f7 e9                	imul   %ecx
80105a32:	c1 f9 1f             	sar    $0x1f,%ecx
80105a35:	c1 fa 02             	sar    $0x2,%edx
    }while(n);
80105a38:	29 ca                	sub    %ecx,%edx
80105a3a:	89 d1                	mov    %edx,%ecx
80105a3c:	75 ea                	jne    80105a28 <sys_newopen+0x138>
    *p = '\0';
80105a3e:	c6 06 00             	movb   $0x0,(%esi)
        *--p = digit[i%10];
80105a41:	b9 67 66 66 66       	mov    $0x66666667,%ecx
80105a46:	8d 76 00             	lea    0x0(%esi),%esi
80105a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105a50:	89 d8                	mov    %ebx,%eax
80105a52:	83 ee 01             	sub    $0x1,%esi
80105a55:	f7 e9                	imul   %ecx
80105a57:	89 d8                	mov    %ebx,%eax
80105a59:	c1 f8 1f             	sar    $0x1f,%eax
80105a5c:	c1 fa 02             	sar    $0x2,%edx
80105a5f:	29 c2                	sub    %eax,%edx
80105a61:	8d 04 92             	lea    (%edx,%edx,4),%eax
80105a64:	01 c0                	add    %eax,%eax
80105a66:	29 c3                	sub    %eax,%ebx
    }while(i);
80105a68:	85 d2                	test   %edx,%edx
        *--p = digit[i%10];
80105a6a:	0f b6 44 1d dd       	movzbl -0x23(%ebp,%ebx,1),%eax
        i = i/10;
80105a6f:	89 d3                	mov    %edx,%ebx
        *--p = digit[i%10];
80105a71:	88 06                	mov    %al,(%esi)
    }while(i);
80105a73:	75 db                	jne    80105a50 <sys_newopen+0x160>
  // strncpy(sind,my_itoa(ind,sind),);
  sind = my_itoa(ind,sind);
  char *path2 = strcat(path,sind);
80105a75:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  while (*s1) ++s1;
80105a78:	80 38 00             	cmpb   $0x0,(%eax)
  char *path2 = strcat(path,sind);
80105a7b:	89 45 c0             	mov    %eax,-0x40(%ebp)
  while (*s1) ++s1;
80105a7e:	0f 84 7c 01 00 00    	je     80105c00 <sys_newopen+0x310>
80105a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a88:	83 c0 01             	add    $0x1,%eax
80105a8b:	80 38 00             	cmpb   $0x0,(%eax)
80105a8e:	75 f8                	jne    80105a88 <sys_newopen+0x198>
  while (*s2) *s1++ = *s2++;
80105a90:	0f b6 17             	movzbl (%edi),%edx
80105a93:	84 d2                	test   %dl,%dl
80105a95:	74 19                	je     80105ab0 <sys_newopen+0x1c0>
80105a97:	89 f6                	mov    %esi,%esi
80105a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105aa0:	83 c0 01             	add    $0x1,%eax
80105aa3:	83 c7 01             	add    $0x1,%edi
80105aa6:	88 50 ff             	mov    %dl,-0x1(%eax)
80105aa9:	0f b6 17             	movzbl (%edi),%edx
80105aac:	84 d2                	test   %dl,%dl
80105aae:	75 f0                	jne    80105aa0 <sys_newopen+0x1b0>
  *s1 = 0;
80105ab0:	c6 00 00             	movb   $0x0,(%eax)
  struct inode *ip2;

  begin_op();
80105ab3:	e8 08 d1 ff ff       	call   80102bc0 <begin_op>
  ip2 = create(path2, T_FILE, 0, 0);
80105ab8:	83 ec 0c             	sub    $0xc,%esp
80105abb:	8b 45 c0             	mov    -0x40(%ebp),%eax
80105abe:	31 c9                	xor    %ecx,%ecx
80105ac0:	6a 00                	push   $0x0
80105ac2:	ba 02 00 00 00       	mov    $0x2,%edx
80105ac7:	e8 54 f4 ff ff       	call   80104f20 <create>
  if(ip2 == 0){
80105acc:	83 c4 10             	add    $0x10,%esp
80105acf:	85 c0                	test   %eax,%eax
  ip2 = create(path2, T_FILE, 0, 0);
80105ad1:	89 c7                	mov    %eax,%edi
  if(ip2 == 0){
80105ad3:	0f 84 f0 00 00 00    	je     80105bc9 <sys_newopen+0x2d9>
    end_op();
    return -1;
  }

  if((f2 = filealloc()) == 0 || (fd2 = fdalloc(f2)) < 0){
80105ad9:	e8 a2 b2 ff ff       	call   80100d80 <filealloc>
80105ade:	85 c0                	test   %eax,%eax
80105ae0:	89 c6                	mov    %eax,%esi
80105ae2:	0f 84 2c 01 00 00    	je     80105c14 <sys_newopen+0x324>
  struct proc *curproc = myproc();
80105ae8:	e8 13 dd ff ff       	call   80103800 <myproc>
80105aed:	eb 0d                	jmp    80105afc <sys_newopen+0x20c>
80105aef:	90                   	nop
  for(fd = 0; fd < NOFILE; fd++){
80105af0:	83 c3 01             	add    $0x1,%ebx
80105af3:	83 fb 64             	cmp    $0x64,%ebx
80105af6:	0f 84 0c 01 00 00    	je     80105c08 <sys_newopen+0x318>
    if(curproc->ofile[fd] == 0){
80105afc:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105b00:	85 d2                	test   %edx,%edx
80105b02:	75 ec                	jne    80105af0 <sys_newopen+0x200>
      fileclose(f2);
    iunlockput(ip2);
    end_op();
    return -1;
  }
  iunlock(ip2);
80105b04:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105b07:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  iunlock(ip2);
80105b0b:	57                   	push   %edi
80105b0c:	e8 5f bc ff ff       	call   80101770 <iunlock>
  end_op();
80105b11:	e8 1a d1 ff ff       	call   80102c30 <end_op>

  f2->type = FD_INODE;
80105b16:	c7 06 02 00 00 00    	movl   $0x2,(%esi)
  f2->ip = ip2;
  f2->off = 0;
  f2->readable = !(omode & O_WRONLY);
80105b1c:	8b 55 d8             	mov    -0x28(%ebp),%edx
  f2->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105b1f:	83 c4 10             	add    $0x10,%esp
  f2->ip = ip2;
80105b22:	89 7e 10             	mov    %edi,0x10(%esi)
  f2->off = 0;
80105b25:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
80105b2c:	8b 7d c4             	mov    -0x3c(%ebp),%edi
  f2->readable = !(omode & O_WRONLY);
80105b2f:	89 d0                	mov    %edx,%eax
80105b31:	f7 d0                	not    %eax
80105b33:	83 e0 01             	and    $0x1,%eax
  f2->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105b36:	83 e2 03             	and    $0x3,%edx
  f2->readable = !(omode & O_WRONLY);
80105b39:	88 46 08             	mov    %al,0x8(%esi)
  f2->path = path2;
80105b3c:	8b 45 c0             	mov    -0x40(%ebp),%eax
  f2->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105b3f:	0f 95 46 09          	setne  0x9(%esi)
  f2->path = path2;
80105b43:	89 46 1c             	mov    %eax,0x1c(%esi)

  int n;

  while( (n = fileread(f, buf, 1)) > 0 ){
80105b46:	eb 1c                	jmp    80105b64 <sys_newopen+0x274>
80105b48:	90                   	nop
80105b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    filewrite(f2,buf,1);
80105b50:	83 ec 04             	sub    $0x4,%esp
80105b53:	6a 01                	push   $0x1
80105b55:	ff 35 14 c1 11 80    	pushl  0x8011c114
80105b5b:	56                   	push   %esi
80105b5c:	e8 8f b4 ff ff       	call   80100ff0 <filewrite>
80105b61:	83 c4 10             	add    $0x10,%esp
  while( (n = fileread(f, buf, 1)) > 0 ){
80105b64:	83 ec 04             	sub    $0x4,%esp
80105b67:	6a 01                	push   $0x1
80105b69:	ff 35 14 c1 11 80    	pushl  0x8011c114
80105b6f:	57                   	push   %edi
80105b70:	e8 eb b3 ff ff       	call   80100f60 <fileread>
80105b75:	83 c4 10             	add    $0x10,%esp
80105b78:	85 c0                	test   %eax,%eax
80105b7a:	7f d4                	jg     80105b50 <sys_newopen+0x260>
  }

  myproc()->ofile[fd] = 0;
80105b7c:	e8 7f dc ff ff       	call   80103800 <myproc>
80105b81:	8b 75 bc             	mov    -0x44(%ebp),%esi
  fileclose(f);
80105b84:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105b87:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105b8e:	00 
  fileclose(f);
80105b8f:	ff 75 c4             	pushl  -0x3c(%ebp)
80105b92:	e8 a9 b2 ff ff       	call   80100e40 <fileclose>

  return fd2;  
80105b97:	83 c4 10             	add    $0x10,%esp
}
80105b9a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b9d:	89 d8                	mov    %ebx,%eax
80105b9f:	5b                   	pop    %ebx
80105ba0:	5e                   	pop    %esi
80105ba1:	5f                   	pop    %edi
80105ba2:	5d                   	pop    %ebp
80105ba3:	c3                   	ret    
80105ba4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105ba8:	83 ec 0c             	sub    $0xc,%esp
80105bab:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80105bae:	31 c9                	xor    %ecx,%ecx
80105bb0:	6a 00                	push   $0x0
80105bb2:	ba 02 00 00 00       	mov    $0x2,%edx
80105bb7:	e8 64 f3 ff ff       	call   80104f20 <create>
    if(ip == 0){
80105bbc:	83 c4 10             	add    $0x10,%esp
80105bbf:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105bc1:	89 c3                	mov    %eax,%ebx
    if(ip == 0){
80105bc3:	0f 85 b0 fd ff ff    	jne    80105979 <sys_newopen+0x89>
      end_op();
80105bc9:	e8 62 d0 ff ff       	call   80102c30 <end_op>
      return -1;
80105bce:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105bd3:	eb c5                	jmp    80105b9a <sys_newopen+0x2aa>
80105bd5:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105bd8:	8b 7d d8             	mov    -0x28(%ebp),%edi
80105bdb:	85 ff                	test   %edi,%edi
80105bdd:	0f 84 96 fd ff ff    	je     80105979 <sys_newopen+0x89>
    iunlockput(ip);
80105be3:	83 ec 0c             	sub    $0xc,%esp
80105be6:	53                   	push   %ebx
    return -1;
80105be7:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    iunlockput(ip);
80105bec:	e8 2f bd ff ff       	call   80101920 <iunlockput>
    end_op();
80105bf1:	e8 3a d0 ff ff       	call   80102c30 <end_op>
    return -1;
80105bf6:	83 c4 10             	add    $0x10,%esp
80105bf9:	eb 9f                	jmp    80105b9a <sys_newopen+0x2aa>
80105bfb:	90                   	nop
80105bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while (*s1) ++s1;
80105c00:	8b 45 c0             	mov    -0x40(%ebp),%eax
80105c03:	e9 a1 fe ff ff       	jmp    80105aa9 <sys_newopen+0x1b9>
      fileclose(f2);
80105c08:	83 ec 0c             	sub    $0xc,%esp
80105c0b:	56                   	push   %esi
80105c0c:	e8 2f b2 ff ff       	call   80100e40 <fileclose>
80105c11:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip2);
80105c14:	83 ec 0c             	sub    $0xc,%esp
80105c17:	57                   	push   %edi
80105c18:	e8 03 bd ff ff       	call   80101920 <iunlockput>
    end_op();
80105c1d:	e8 0e d0 ff ff       	call   80102c30 <end_op>
    return -1;
80105c22:	83 c4 10             	add    $0x10,%esp
80105c25:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105c2a:	e9 6b ff ff ff       	jmp    80105b9a <sys_newopen+0x2aa>
80105c2f:	90                   	nop
      fileclose(f);
80105c30:	83 ec 0c             	sub    $0xc,%esp
80105c33:	ff 75 c4             	pushl  -0x3c(%ebp)
80105c36:	e8 05 b2 ff ff       	call   80100e40 <fileclose>
80105c3b:	83 c4 10             	add    $0x10,%esp
80105c3e:	eb a3                	jmp    80105be3 <sys_newopen+0x2f3>

80105c40 <sys_mkdir>:
// end  new code


int
sys_mkdir(void)
{ if(isTraceOn==1)
80105c40:	55                   	push   %ebp
80105c41:	89 e5                	mov    %esp,%ebp
80105c43:	83 ec 18             	sub    $0x18,%esp
80105c46:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
80105c4d:	75 07                	jne    80105c56 <sys_mkdir+0x16>
  {num_calls[SYS_mkdir] ++;}
80105c4f:	83 05 90 1a 11 80 01 	addl   $0x1,0x80111a90
  char *path;
  struct inode *ip;

  begin_op();
80105c56:	e8 65 cf ff ff       	call   80102bc0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105c5b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105c5e:	83 ec 08             	sub    $0x8,%esp
80105c61:	50                   	push   %eax
80105c62:	6a 00                	push   $0x0
80105c64:	e8 f7 ee ff ff       	call   80104b60 <argstr>
80105c69:	83 c4 10             	add    $0x10,%esp
80105c6c:	85 c0                	test   %eax,%eax
80105c6e:	78 30                	js     80105ca0 <sys_mkdir+0x60>
80105c70:	83 ec 0c             	sub    $0xc,%esp
80105c73:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c76:	31 c9                	xor    %ecx,%ecx
80105c78:	6a 00                	push   $0x0
80105c7a:	ba 01 00 00 00       	mov    $0x1,%edx
80105c7f:	e8 9c f2 ff ff       	call   80104f20 <create>
80105c84:	83 c4 10             	add    $0x10,%esp
80105c87:	85 c0                	test   %eax,%eax
80105c89:	74 15                	je     80105ca0 <sys_mkdir+0x60>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105c8b:	83 ec 0c             	sub    $0xc,%esp
80105c8e:	50                   	push   %eax
80105c8f:	e8 8c bc ff ff       	call   80101920 <iunlockput>
  end_op();
80105c94:	e8 97 cf ff ff       	call   80102c30 <end_op>
  return 0;
80105c99:	83 c4 10             	add    $0x10,%esp
80105c9c:	31 c0                	xor    %eax,%eax
}
80105c9e:	c9                   	leave  
80105c9f:	c3                   	ret    
    end_op();
80105ca0:	e8 8b cf ff ff       	call   80102c30 <end_op>
    return -1;
80105ca5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105caa:	c9                   	leave  
80105cab:	c3                   	ret    
80105cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105cb0 <sys_mknod>:

int
sys_mknod(void)
{ if(isTraceOn==1)
80105cb0:	55                   	push   %ebp
80105cb1:	89 e5                	mov    %esp,%ebp
80105cb3:	83 ec 18             	sub    $0x18,%esp
80105cb6:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
80105cbd:	75 07                	jne    80105cc6 <sys_mknod+0x16>
  {num_calls[SYS_mknod] ++;}
80105cbf:	83 05 84 1a 11 80 01 	addl   $0x1,0x80111a84
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105cc6:	e8 f5 ce ff ff       	call   80102bc0 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105ccb:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105cce:	83 ec 08             	sub    $0x8,%esp
80105cd1:	50                   	push   %eax
80105cd2:	6a 00                	push   $0x0
80105cd4:	e8 87 ee ff ff       	call   80104b60 <argstr>
80105cd9:	83 c4 10             	add    $0x10,%esp
80105cdc:	85 c0                	test   %eax,%eax
80105cde:	78 60                	js     80105d40 <sys_mknod+0x90>
     argint(1, &major) < 0 ||
80105ce0:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105ce3:	83 ec 08             	sub    $0x8,%esp
80105ce6:	50                   	push   %eax
80105ce7:	6a 01                	push   $0x1
80105ce9:	e8 c2 ed ff ff       	call   80104ab0 <argint>
  if((argstr(0, &path)) < 0 ||
80105cee:	83 c4 10             	add    $0x10,%esp
80105cf1:	85 c0                	test   %eax,%eax
80105cf3:	78 4b                	js     80105d40 <sys_mknod+0x90>
     argint(2, &minor) < 0 ||
80105cf5:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105cf8:	83 ec 08             	sub    $0x8,%esp
80105cfb:	50                   	push   %eax
80105cfc:	6a 02                	push   $0x2
80105cfe:	e8 ad ed ff ff       	call   80104ab0 <argint>
     argint(1, &major) < 0 ||
80105d03:	83 c4 10             	add    $0x10,%esp
80105d06:	85 c0                	test   %eax,%eax
80105d08:	78 36                	js     80105d40 <sys_mknod+0x90>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105d0a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
80105d0e:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80105d11:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80105d15:	ba 03 00 00 00       	mov    $0x3,%edx
80105d1a:	50                   	push   %eax
80105d1b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105d1e:	e8 fd f1 ff ff       	call   80104f20 <create>
80105d23:	83 c4 10             	add    $0x10,%esp
80105d26:	85 c0                	test   %eax,%eax
80105d28:	74 16                	je     80105d40 <sys_mknod+0x90>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105d2a:	83 ec 0c             	sub    $0xc,%esp
80105d2d:	50                   	push   %eax
80105d2e:	e8 ed bb ff ff       	call   80101920 <iunlockput>
  end_op();
80105d33:	e8 f8 ce ff ff       	call   80102c30 <end_op>
  return 0;
80105d38:	83 c4 10             	add    $0x10,%esp
80105d3b:	31 c0                	xor    %eax,%eax
}
80105d3d:	c9                   	leave  
80105d3e:	c3                   	ret    
80105d3f:	90                   	nop
    end_op();
80105d40:	e8 eb ce ff ff       	call   80102c30 <end_op>
    return -1;
80105d45:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d4a:	c9                   	leave  
80105d4b:	c3                   	ret    
80105d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d50 <sys_chdir>:

int
sys_chdir(void)
{ if(isTraceOn==1)
80105d50:	55                   	push   %ebp
80105d51:	89 e5                	mov    %esp,%ebp
80105d53:	56                   	push   %esi
80105d54:	53                   	push   %ebx
80105d55:	83 ec 10             	sub    $0x10,%esp
80105d58:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
80105d5f:	75 07                	jne    80105d68 <sys_chdir+0x18>
  {num_calls[SYS_chdir] ++;}
80105d61:	83 05 64 1a 11 80 01 	addl   $0x1,0x80111a64
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105d68:	e8 93 da ff ff       	call   80103800 <myproc>
80105d6d:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105d6f:	e8 4c ce ff ff       	call   80102bc0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105d74:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d77:	83 ec 08             	sub    $0x8,%esp
80105d7a:	50                   	push   %eax
80105d7b:	6a 00                	push   $0x0
80105d7d:	e8 de ed ff ff       	call   80104b60 <argstr>
80105d82:	83 c4 10             	add    $0x10,%esp
80105d85:	85 c0                	test   %eax,%eax
80105d87:	78 77                	js     80105e00 <sys_chdir+0xb0>
80105d89:	83 ec 0c             	sub    $0xc,%esp
80105d8c:	ff 75 f4             	pushl  -0xc(%ebp)
80105d8f:	e8 6c c1 ff ff       	call   80101f00 <namei>
80105d94:	83 c4 10             	add    $0x10,%esp
80105d97:	85 c0                	test   %eax,%eax
80105d99:	89 c3                	mov    %eax,%ebx
80105d9b:	74 63                	je     80105e00 <sys_chdir+0xb0>
    end_op();
    return -1;
  }
  ilock(ip);
80105d9d:	83 ec 0c             	sub    $0xc,%esp
80105da0:	50                   	push   %eax
80105da1:	e8 ea b8 ff ff       	call   80101690 <ilock>
  if(ip->type != T_DIR){
80105da6:	83 c4 10             	add    $0x10,%esp
80105da9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105dae:	75 30                	jne    80105de0 <sys_chdir+0x90>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105db0:	83 ec 0c             	sub    $0xc,%esp
80105db3:	53                   	push   %ebx
80105db4:	e8 b7 b9 ff ff       	call   80101770 <iunlock>
  iput(curproc->cwd);
80105db9:	58                   	pop    %eax
80105dba:	ff b6 b8 01 00 00    	pushl  0x1b8(%esi)
80105dc0:	e8 fb b9 ff ff       	call   801017c0 <iput>
  end_op();
80105dc5:	e8 66 ce ff ff       	call   80102c30 <end_op>
  curproc->cwd = ip;
80105dca:	89 9e b8 01 00 00    	mov    %ebx,0x1b8(%esi)
  return 0;
80105dd0:	83 c4 10             	add    $0x10,%esp
80105dd3:	31 c0                	xor    %eax,%eax
}
80105dd5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105dd8:	5b                   	pop    %ebx
80105dd9:	5e                   	pop    %esi
80105dda:	5d                   	pop    %ebp
80105ddb:	c3                   	ret    
80105ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
80105de0:	83 ec 0c             	sub    $0xc,%esp
80105de3:	53                   	push   %ebx
80105de4:	e8 37 bb ff ff       	call   80101920 <iunlockput>
    end_op();
80105de9:	e8 42 ce ff ff       	call   80102c30 <end_op>
    return -1;
80105dee:	83 c4 10             	add    $0x10,%esp
80105df1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105df6:	eb dd                	jmp    80105dd5 <sys_chdir+0x85>
80105df8:	90                   	nop
80105df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105e00:	e8 2b ce ff ff       	call   80102c30 <end_op>
    return -1;
80105e05:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e0a:	eb c9                	jmp    80105dd5 <sys_chdir+0x85>
80105e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105e10 <sys_exec>:

int
sys_exec(void)
{ if(isTraceOn==1)
80105e10:	55                   	push   %ebp
80105e11:	89 e5                	mov    %esp,%ebp
80105e13:	57                   	push   %edi
80105e14:	56                   	push   %esi
80105e15:	53                   	push   %ebx
80105e16:	81 ec 9c 00 00 00    	sub    $0x9c,%esp
80105e1c:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
80105e23:	75 07                	jne    80105e2c <sys_exec+0x1c>
  {num_calls[SYS_exec] ++;}
80105e25:	83 05 5c 1a 11 80 01 	addl   $0x1,0x80111a5c
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105e2c:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80105e32:	83 ec 08             	sub    $0x8,%esp
80105e35:	50                   	push   %eax
80105e36:	6a 00                	push   $0x0
80105e38:	e8 23 ed ff ff       	call   80104b60 <argstr>
80105e3d:	83 c4 10             	add    $0x10,%esp
80105e40:	85 c0                	test   %eax,%eax
80105e42:	0f 88 8c 00 00 00    	js     80105ed4 <sys_exec+0xc4>
80105e48:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105e4e:	83 ec 08             	sub    $0x8,%esp
80105e51:	50                   	push   %eax
80105e52:	6a 01                	push   $0x1
80105e54:	e8 57 ec ff ff       	call   80104ab0 <argint>
80105e59:	83 c4 10             	add    $0x10,%esp
80105e5c:	85 c0                	test   %eax,%eax
80105e5e:	78 74                	js     80105ed4 <sys_exec+0xc4>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105e60:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105e66:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105e69:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105e6b:	68 80 00 00 00       	push   $0x80
80105e70:	6a 00                	push   $0x0
80105e72:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105e78:	50                   	push   %eax
80105e79:	e8 32 e9 ff ff       	call   801047b0 <memset>
80105e7e:	83 c4 10             	add    $0x10,%esp
80105e81:	eb 31                	jmp    80105eb4 <sys_exec+0xa4>
80105e83:	90                   	nop
80105e84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80105e88:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105e8e:	85 c0                	test   %eax,%eax
80105e90:	74 56                	je     80105ee8 <sys_exec+0xd8>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105e92:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105e98:	83 ec 08             	sub    $0x8,%esp
80105e9b:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105e9e:	52                   	push   %edx
80105e9f:	50                   	push   %eax
80105ea0:	e8 9b eb ff ff       	call   80104a40 <fetchstr>
80105ea5:	83 c4 10             	add    $0x10,%esp
80105ea8:	85 c0                	test   %eax,%eax
80105eaa:	78 28                	js     80105ed4 <sys_exec+0xc4>
  for(i=0;; i++){
80105eac:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105eaf:	83 fb 20             	cmp    $0x20,%ebx
80105eb2:	74 20                	je     80105ed4 <sys_exec+0xc4>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105eb4:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105eba:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105ec1:	83 ec 08             	sub    $0x8,%esp
80105ec4:	57                   	push   %edi
80105ec5:	01 f0                	add    %esi,%eax
80105ec7:	50                   	push   %eax
80105ec8:	e8 33 eb ff ff       	call   80104a00 <fetchint>
80105ecd:	83 c4 10             	add    $0x10,%esp
80105ed0:	85 c0                	test   %eax,%eax
80105ed2:	79 b4                	jns    80105e88 <sys_exec+0x78>
      return -1;
  }
  return exec(path, argv);
}
80105ed4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105ed7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105edc:	5b                   	pop    %ebx
80105edd:	5e                   	pop    %esi
80105ede:	5f                   	pop    %edi
80105edf:	5d                   	pop    %ebp
80105ee0:	c3                   	ret    
80105ee1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105ee8:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105eee:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105ef1:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105ef8:	00 00 00 00 
  return exec(path, argv);
80105efc:	50                   	push   %eax
80105efd:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105f03:	e8 08 ab ff ff       	call   80100a10 <exec>
80105f08:	83 c4 10             	add    $0x10,%esp
}
80105f0b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f0e:	5b                   	pop    %ebx
80105f0f:	5e                   	pop    %esi
80105f10:	5f                   	pop    %edi
80105f11:	5d                   	pop    %ebp
80105f12:	c3                   	ret    
80105f13:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105f20 <sys_pipe>:

int
sys_pipe(void)
{ if(isTraceOn==1)
80105f20:	55                   	push   %ebp
80105f21:	89 e5                	mov    %esp,%ebp
80105f23:	57                   	push   %edi
80105f24:	56                   	push   %esi
80105f25:	53                   	push   %ebx
80105f26:	83 ec 1c             	sub    $0x1c,%esp
80105f29:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
80105f30:	75 07                	jne    80105f39 <sys_pipe+0x19>
  {num_calls[SYS_pipe] ++;}
80105f32:	83 05 50 1a 11 80 01 	addl   $0x1,0x80111a50
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105f39:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105f3c:	83 ec 04             	sub    $0x4,%esp
80105f3f:	6a 08                	push   $0x8
80105f41:	50                   	push   %eax
80105f42:	6a 00                	push   $0x0
80105f44:	e8 b7 eb ff ff       	call   80104b00 <argptr>
80105f49:	83 c4 10             	add    $0x10,%esp
80105f4c:	85 c0                	test   %eax,%eax
80105f4e:	0f 88 a3 00 00 00    	js     80105ff7 <sys_pipe+0xd7>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105f54:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105f57:	83 ec 08             	sub    $0x8,%esp
80105f5a:	50                   	push   %eax
80105f5b:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105f5e:	50                   	push   %eax
80105f5f:	e8 fc d2 ff ff       	call   80103260 <pipealloc>
80105f64:	83 c4 10             	add    $0x10,%esp
80105f67:	85 c0                	test   %eax,%eax
80105f69:	0f 88 88 00 00 00    	js     80105ff7 <sys_pipe+0xd7>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105f6f:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105f72:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105f74:	e8 87 d8 ff ff       	call   80103800 <myproc>
80105f79:	eb 0d                	jmp    80105f88 <sys_pipe+0x68>
80105f7b:	90                   	nop
80105f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105f80:	83 c3 01             	add    $0x1,%ebx
80105f83:	83 fb 64             	cmp    $0x64,%ebx
80105f86:	74 58                	je     80105fe0 <sys_pipe+0xc0>
    if(curproc->ofile[fd] == 0){
80105f88:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105f8c:	85 f6                	test   %esi,%esi
80105f8e:	75 f0                	jne    80105f80 <sys_pipe+0x60>
      curproc->ofile[fd] = f;
80105f90:	8d 73 08             	lea    0x8(%ebx),%esi
80105f93:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105f97:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105f9a:	e8 61 d8 ff ff       	call   80103800 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105f9f:	31 d2                	xor    %edx,%edx
80105fa1:	eb 0d                	jmp    80105fb0 <sys_pipe+0x90>
80105fa3:	90                   	nop
80105fa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105fa8:	83 c2 01             	add    $0x1,%edx
80105fab:	83 fa 64             	cmp    $0x64,%edx
80105fae:	74 21                	je     80105fd1 <sys_pipe+0xb1>
    if(curproc->ofile[fd] == 0){
80105fb0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105fb4:	85 c9                	test   %ecx,%ecx
80105fb6:	75 f0                	jne    80105fa8 <sys_pipe+0x88>
      curproc->ofile[fd] = f;
80105fb8:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105fbc:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105fbf:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105fc1:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105fc4:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105fc7:	31 c0                	xor    %eax,%eax
}
80105fc9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105fcc:	5b                   	pop    %ebx
80105fcd:	5e                   	pop    %esi
80105fce:	5f                   	pop    %edi
80105fcf:	5d                   	pop    %ebp
80105fd0:	c3                   	ret    
      myproc()->ofile[fd0] = 0;
80105fd1:	e8 2a d8 ff ff       	call   80103800 <myproc>
80105fd6:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105fdd:	00 
80105fde:	66 90                	xchg   %ax,%ax
    fileclose(rf);
80105fe0:	83 ec 0c             	sub    $0xc,%esp
80105fe3:	ff 75 e0             	pushl  -0x20(%ebp)
80105fe6:	e8 55 ae ff ff       	call   80100e40 <fileclose>
    fileclose(wf);
80105feb:	58                   	pop    %eax
80105fec:	ff 75 e4             	pushl  -0x1c(%ebp)
80105fef:	e8 4c ae ff ff       	call   80100e40 <fileclose>
    return -1;
80105ff4:	83 c4 10             	add    $0x10,%esp
80105ff7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ffc:	eb cb                	jmp    80105fc9 <sys_pipe+0xa9>
80105ffe:	66 90                	xchg   %ax,%ax

80106000 <sys_fork>:

// #include "queues.h"

int
sys_fork(void)
{ if(isTraceOn==1)
80106000:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
80106007:	55                   	push   %ebp
80106008:	89 e5                	mov    %esp,%ebp
8010600a:	75 07                	jne    80106013 <sys_fork+0x13>
  {num_calls[SYS_fork] ++;}
8010600c:	83 05 44 1a 11 80 01 	addl   $0x1,0x80111a44
  return fork();
}
80106013:	5d                   	pop    %ebp
  return fork();
80106014:	e9 97 d9 ff ff       	jmp    801039b0 <fork>
80106019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106020 <sys_exit>:

int
sys_exit(void)
{ if(isTraceOn==1)
80106020:	55                   	push   %ebp
80106021:	89 e5                	mov    %esp,%ebp
80106023:	83 ec 08             	sub    $0x8,%esp
80106026:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
8010602d:	75 07                	jne    80106036 <sys_exit+0x16>
  {num_calls[SYS_exit] ++;}
8010602f:	83 05 48 1a 11 80 01 	addl   $0x1,0x80111a48
  exit();
80106036:	e8 95 dc ff ff       	call   80103cd0 <exit>
  return 0;  // not reached
}
8010603b:	31 c0                	xor    %eax,%eax
8010603d:	c9                   	leave  
8010603e:	c3                   	ret    
8010603f:	90                   	nop

80106040 <sys_wait>:

int
sys_wait(void)
{ if(isTraceOn==1)
80106040:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
80106047:	55                   	push   %ebp
80106048:	89 e5                	mov    %esp,%ebp
8010604a:	75 07                	jne    80106053 <sys_wait+0x13>
  {num_calls[SYS_wait] ++;}
8010604c:	83 05 4c 1a 11 80 01 	addl   $0x1,0x80111a4c
  return wait();
}
80106053:	5d                   	pop    %ebp
  return wait();
80106054:	e9 c7 de ff ff       	jmp    80103f20 <wait>
80106059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106060 <sys_kill>:

int
sys_kill(void)
{ if(isTraceOn==1)
80106060:	55                   	push   %ebp
80106061:	89 e5                	mov    %esp,%ebp
80106063:	83 ec 18             	sub    $0x18,%esp
80106066:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
8010606d:	75 07                	jne    80106076 <sys_kill+0x16>
  {num_calls[SYS_kill] ++;}
8010606f:	83 05 58 1a 11 80 01 	addl   $0x1,0x80111a58
  int pid;

  if(argint(0, &pid) < 0)
80106076:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106079:	83 ec 08             	sub    $0x8,%esp
8010607c:	50                   	push   %eax
8010607d:	6a 00                	push   $0x0
8010607f:	e8 2c ea ff ff       	call   80104ab0 <argint>
80106084:	83 c4 10             	add    $0x10,%esp
80106087:	85 c0                	test   %eax,%eax
80106089:	78 15                	js     801060a0 <sys_kill+0x40>
    return -1;
  return kill(pid);
8010608b:	83 ec 0c             	sub    $0xc,%esp
8010608e:	ff 75 f4             	pushl  -0xc(%ebp)
80106091:	e8 ea df ff ff       	call   80104080 <kill>
80106096:	83 c4 10             	add    $0x10,%esp
}
80106099:	c9                   	leave  
8010609a:	c3                   	ret    
8010609b:	90                   	nop
8010609c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801060a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801060a5:	c9                   	leave  
801060a6:	c3                   	ret    
801060a7:	89 f6                	mov    %esi,%esi
801060a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801060b0 <sys_getpid>:

int
sys_getpid(void)
{ if(isTraceOn==1)
801060b0:	55                   	push   %ebp
801060b1:	89 e5                	mov    %esp,%ebp
801060b3:	83 ec 08             	sub    $0x8,%esp
801060b6:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
801060bd:	75 07                	jne    801060c6 <sys_getpid+0x16>
  {num_calls[SYS_getpid] ++;}
801060bf:	83 05 6c 1a 11 80 01 	addl   $0x1,0x80111a6c
  return myproc()->pid;
801060c6:	e8 35 d7 ff ff       	call   80103800 <myproc>
801060cb:	8b 40 10             	mov    0x10(%eax),%eax
}
801060ce:	c9                   	leave  
801060cf:	c3                   	ret    

801060d0 <sys_sbrk>:

int
sys_sbrk(void)
{ if(isTraceOn==1)
801060d0:	55                   	push   %ebp
801060d1:	89 e5                	mov    %esp,%ebp
801060d3:	53                   	push   %ebx
801060d4:	83 ec 14             	sub    $0x14,%esp
801060d7:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
801060de:	75 07                	jne    801060e7 <sys_sbrk+0x17>
  {num_calls[SYS_sbrk] ++;}
801060e0:	83 05 70 1a 11 80 01 	addl   $0x1,0x80111a70
  int addr;
  int n;

  if(argint(0, &n) < 0)
801060e7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801060ea:	83 ec 08             	sub    $0x8,%esp
801060ed:	50                   	push   %eax
801060ee:	6a 00                	push   $0x0
801060f0:	e8 bb e9 ff ff       	call   80104ab0 <argint>
801060f5:	83 c4 10             	add    $0x10,%esp
801060f8:	85 c0                	test   %eax,%eax
801060fa:	78 24                	js     80106120 <sys_sbrk+0x50>
    return -1;
  addr = myproc()->sz;
801060fc:	e8 ff d6 ff ff       	call   80103800 <myproc>
  if(growproc(n) < 0)
80106101:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80106104:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106106:	ff 75 f4             	pushl  -0xc(%ebp)
80106109:	e8 22 d8 ff ff       	call   80103930 <growproc>
8010610e:	83 c4 10             	add    $0x10,%esp
80106111:	85 c0                	test   %eax,%eax
80106113:	78 0b                	js     80106120 <sys_sbrk+0x50>
    return -1;
  return addr;
}
80106115:	89 d8                	mov    %ebx,%eax
80106117:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010611a:	c9                   	leave  
8010611b:	c3                   	ret    
8010611c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106120:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106125:	eb ee                	jmp    80106115 <sys_sbrk+0x45>
80106127:	89 f6                	mov    %esi,%esi
80106129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106130 <sys_sleep>:

int
sys_sleep(void)
{ if(isTraceOn==1)
80106130:	55                   	push   %ebp
80106131:	89 e5                	mov    %esp,%ebp
80106133:	53                   	push   %ebx
80106134:	83 ec 14             	sub    $0x14,%esp
80106137:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
8010613e:	75 07                	jne    80106147 <sys_sleep+0x17>
  {num_calls[SYS_sleep] ++;}
80106140:	83 05 74 1a 11 80 01 	addl   $0x1,0x80111a74
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106147:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010614a:	83 ec 08             	sub    $0x8,%esp
8010614d:	50                   	push   %eax
8010614e:	6a 00                	push   $0x0
80106150:	e8 5b e9 ff ff       	call   80104ab0 <argint>
80106155:	83 c4 10             	add    $0x10,%esp
80106158:	85 c0                	test   %eax,%eax
8010615a:	0f 88 87 00 00 00    	js     801061e7 <sys_sleep+0xb7>
    return -1;
  acquire(&tickslock);
80106160:	83 ec 0c             	sub    $0xc,%esp
80106163:	68 20 c1 11 80       	push   $0x8011c120
80106168:	e8 33 e5 ff ff       	call   801046a0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010616d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106170:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80106173:	8b 1d 60 c9 11 80    	mov    0x8011c960,%ebx
  while(ticks - ticks0 < n){
80106179:	85 d2                	test   %edx,%edx
8010617b:	75 24                	jne    801061a1 <sys_sleep+0x71>
8010617d:	eb 51                	jmp    801061d0 <sys_sleep+0xa0>
8010617f:	90                   	nop
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106180:	83 ec 08             	sub    $0x8,%esp
80106183:	68 20 c1 11 80       	push   $0x8011c120
80106188:	68 60 c9 11 80       	push   $0x8011c960
8010618d:	e8 ce dc ff ff       	call   80103e60 <sleep>
  while(ticks - ticks0 < n){
80106192:	a1 60 c9 11 80       	mov    0x8011c960,%eax
80106197:	83 c4 10             	add    $0x10,%esp
8010619a:	29 d8                	sub    %ebx,%eax
8010619c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010619f:	73 2f                	jae    801061d0 <sys_sleep+0xa0>
    if(myproc()->killed){
801061a1:	e8 5a d6 ff ff       	call   80103800 <myproc>
801061a6:	8b 40 24             	mov    0x24(%eax),%eax
801061a9:	85 c0                	test   %eax,%eax
801061ab:	74 d3                	je     80106180 <sys_sleep+0x50>
      release(&tickslock);
801061ad:	83 ec 0c             	sub    $0xc,%esp
801061b0:	68 20 c1 11 80       	push   $0x8011c120
801061b5:	e8 a6 e5 ff ff       	call   80104760 <release>
      return -1;
801061ba:	83 c4 10             	add    $0x10,%esp
801061bd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
801061c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801061c5:	c9                   	leave  
801061c6:	c3                   	ret    
801061c7:	89 f6                	mov    %esi,%esi
801061c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
801061d0:	83 ec 0c             	sub    $0xc,%esp
801061d3:	68 20 c1 11 80       	push   $0x8011c120
801061d8:	e8 83 e5 ff ff       	call   80104760 <release>
  return 0;
801061dd:	83 c4 10             	add    $0x10,%esp
801061e0:	31 c0                	xor    %eax,%eax
}
801061e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801061e5:	c9                   	leave  
801061e6:	c3                   	ret    
    return -1;
801061e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061ec:	eb f4                	jmp    801061e2 <sys_sleep+0xb2>
801061ee:	66 90                	xchg   %ax,%ax

801061f0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{ if(isTraceOn==1)
801061f0:	55                   	push   %ebp
801061f1:	89 e5                	mov    %esp,%ebp
801061f3:	53                   	push   %ebx
801061f4:	83 ec 04             	sub    $0x4,%esp
801061f7:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
801061fe:	75 07                	jne    80106207 <sys_uptime+0x17>
  {num_calls[SYS_uptime] ++;}
80106200:	83 05 78 1a 11 80 01 	addl   $0x1,0x80111a78
  uint xticks;

  acquire(&tickslock);
80106207:	83 ec 0c             	sub    $0xc,%esp
8010620a:	68 20 c1 11 80       	push   $0x8011c120
8010620f:	e8 8c e4 ff ff       	call   801046a0 <acquire>
  xticks = ticks;
80106214:	8b 1d 60 c9 11 80    	mov    0x8011c960,%ebx
  release(&tickslock);
8010621a:	c7 04 24 20 c1 11 80 	movl   $0x8011c120,(%esp)
80106221:	e8 3a e5 ff ff       	call   80104760 <release>
  return xticks;
}
80106226:	89 d8                	mov    %ebx,%eax
80106228:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010622b:	c9                   	leave  
8010622c:	c3                   	ret    
8010622d:	8d 76 00             	lea    0x0(%esi),%esi

80106230 <sys_halt>:

int
sys_halt(void)
{ if(isTraceOn==1)
80106230:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
80106237:	55                   	push   %ebp
80106238:	89 e5                	mov    %esp,%ebp
8010623a:	75 07                	jne    80106243 <sys_halt+0x13>
  {num_calls[SYS_halt] ++;}
8010623c:	83 05 98 1a 11 80 01 	addl   $0x1,0x80111a98
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106243:	31 c0                	xor    %eax,%eax
80106245:	ba f4 00 00 00       	mov    $0xf4,%edx
8010624a:	ee                   	out    %al,(%dx)
  outb(0xf4, 0x00);
  return 0;
}
8010624b:	31 c0                	xor    %eax,%eax
8010624d:	5d                   	pop    %ebp
8010624e:	c3                   	ret    
8010624f:	90                   	nop

80106250 <sys_toggle>:

int
sys_toggle(void)
{ 
  if(isTraceOn==0)
80106250:	a1 18 17 11 80       	mov    0x80111718,%eax
{ 
80106255:	55                   	push   %ebp
80106256:	89 e5                	mov    %esp,%ebp
  if(isTraceOn==0)
80106258:	85 c0                	test   %eax,%eax
8010625a:	75 2c                	jne    80106288 <sys_toggle+0x38>
    {
      isTraceOn=1;
8010625c:	c7 05 18 17 11 80 01 	movl   $0x1,0x80111718
80106263:	00 00 00 
80106266:	b8 40 1a 11 80       	mov    $0x80111a40,%eax
8010626b:	90                   	nop
8010626c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(int i =0;i<NELEM(num_calls);i++){num_calls[i]=0;}
80106270:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80106276:	83 c0 04             	add    $0x4,%eax
80106279:	3d b8 1a 11 80       	cmp    $0x80111ab8,%eax
8010627e:	75 f0                	jne    80106270 <sys_toggle+0x20>
  {
    isTraceOn=0;
    return 0;
  }
  return 0;
}
80106280:	31 c0                	xor    %eax,%eax
80106282:	5d                   	pop    %ebp
80106283:	c3                   	ret    
80106284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(isTraceOn==1)
80106288:	83 f8 01             	cmp    $0x1,%eax
8010628b:	75 f3                	jne    80106280 <sys_toggle+0x30>
}
8010628d:	31 c0                	xor    %eax,%eax
    isTraceOn=0;
8010628f:	c7 05 18 17 11 80 00 	movl   $0x0,0x80111718
80106296:	00 00 00 
}
80106299:	5d                   	pop    %ebp
8010629a:	c3                   	ret    
8010629b:	90                   	nop
8010629c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801062a0 <sys_print_count>:

int 
sys_print_count(void)
{ 
801062a0:	55                   	push   %ebp
801062a1:	89 e5                	mov    %esp,%ebp
801062a3:	57                   	push   %edi
801062a4:	56                   	push   %esi
801062a5:	53                   	push   %ebx
801062a6:	81 ec ec 00 00 00    	sub    $0xec,%esp
  if(isTraceOn==1)
801062ac:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
801062b3:	75 07                	jne    801062bc <sys_print_count+0x1c>
  {num_calls[SYS_print_count] ++;}
801062b5:	83 05 a0 1a 11 80 01 	addl   $0x1,0x80111aa0

  const int sorted_syscalls_int[]={SYS_add , SYS_chdir , SYS_close , SYS_dup , SYS_exec , SYS_exit , SYS_fork , SYS_fstat , SYS_getpid , SYS_kill , SYS_link ,
801062bc:	8d 9d 10 ff ff ff    	lea    -0xf0(%ebp),%ebx
801062c2:	be e0 85 10 80       	mov    $0x801085e0,%esi
801062c7:	b9 1b 00 00 00       	mov    $0x1b,%ecx
801062cc:	89 df                	mov    %ebx,%edi
801062ce:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  SYS_mkdir , SYS_mknod , SYS_open , SYS_pipe , SYS_print_count , SYS_ps , SYS_read ,SYS_recv, SYS_sbrk ,SYS_send, SYS_sleep , SYS_toggle , SYS_unlink , SYS_uptime , SYS_wait , SYS_write };


const char* sorted_syscalls_str[]={"sys_add ", "sys_chdir ", "sys_close ", "sys_dup ", "sys_exec ", "sys_exit ", "sys_fork ", "sys_fstat ", "sys_getpid ", "sys_kill ", "sys_link ",
801062d0:	be 60 86 10 80       	mov    $0x80108660,%esi
801062d5:	b9 1b 00 00 00       	mov    $0x1b,%ecx
801062da:	8d bd 7c ff ff ff    	lea    -0x84(%ebp),%edi
801062e0:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  "sys_mkdir ", "sys_mknod ", "sys_open ", "sys_pipe ", "sys_print_count ", "sys_ps ", "sys_read ","sys_recv", "sys_sbrk ","sys_send", "sys_sleep ", "sys_toggle ", "sys_unlink ", "sys_uptime ", "sys_wait ", "sys_write "};

  for(int i =0;i<27;i++)
801062e2:	31 f6                	xor    %esi,%esi
801062e4:	eb 12                	jmp    801062f8 <sys_print_count+0x58>
801062e6:	8d 76 00             	lea    0x0(%esi),%esi
801062e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801062f0:	83 c6 01             	add    $0x1,%esi
801062f3:	83 fe 1b             	cmp    $0x1b,%esi
801062f6:	74 2e                	je     80106326 <sys_print_count+0x86>
    { if(num_calls[sorted_syscalls_int[i]]!=0)
801062f8:	8b 04 b3             	mov    (%ebx,%esi,4),%eax
801062fb:	8b 04 85 40 1a 11 80 	mov    -0x7feee5c0(,%eax,4),%eax
80106302:	85 c0                	test   %eax,%eax
80106304:	74 ea                	je     801062f0 <sys_print_count+0x50>
      cprintf("%s%d\n", sorted_syscalls_str[i], num_calls[sorted_syscalls_int[i]] );
80106306:	83 ec 04             	sub    $0x4,%esp
80106309:	50                   	push   %eax
8010630a:	ff b4 b5 7c ff ff ff 	pushl  -0x84(%ebp,%esi,4)
  for(int i =0;i<27;i++)
80106311:	83 c6 01             	add    $0x1,%esi
      cprintf("%s%d\n", sorted_syscalls_str[i], num_calls[sorted_syscalls_int[i]] );
80106314:	68 9d 84 10 80       	push   $0x8010849d
80106319:	e8 42 a3 ff ff       	call   80100660 <cprintf>
8010631e:	83 c4 10             	add    $0x10,%esp
  for(int i =0;i<27;i++)
80106321:	83 fe 1b             	cmp    $0x1b,%esi
80106324:	75 d2                	jne    801062f8 <sys_print_count+0x58>
    }
    return 0;
}
80106326:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106329:	31 c0                	xor    %eax,%eax
8010632b:	5b                   	pop    %ebx
8010632c:	5e                   	pop    %esi
8010632d:	5f                   	pop    %edi
8010632e:	5d                   	pop    %ebp
8010632f:	c3                   	ret    

80106330 <sys_add>:

int 
sys_add(int a ,int b)
{ if(isTraceOn==1)
80106330:	55                   	push   %ebp
80106331:	89 e5                	mov    %esp,%ebp
80106333:	83 ec 08             	sub    $0x8,%esp
80106336:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
8010633d:	75 07                	jne    80106346 <sys_add+0x16>
  {num_calls[SYS_add] ++;}
8010633f:	83 05 a4 1a 11 80 01 	addl   $0x1,0x80111aa4
  // cprintf("sum is calculated\n");
  argint(0,&a);
80106346:	8d 45 08             	lea    0x8(%ebp),%eax
80106349:	83 ec 08             	sub    $0x8,%esp
8010634c:	50                   	push   %eax
8010634d:	6a 00                	push   $0x0
8010634f:	e8 5c e7 ff ff       	call   80104ab0 <argint>
  argint(1,&b);
80106354:	58                   	pop    %eax
80106355:	8d 45 0c             	lea    0xc(%ebp),%eax
80106358:	5a                   	pop    %edx
80106359:	50                   	push   %eax
8010635a:	6a 01                	push   $0x1
8010635c:	e8 4f e7 ff ff       	call   80104ab0 <argint>

  // cprintf("sum is, %d \n", a+b);

  return a+b;
80106361:	8b 45 0c             	mov    0xc(%ebp),%eax
80106364:	03 45 08             	add    0x8(%ebp),%eax
}
80106367:	c9                   	leave  
80106368:	c3                   	ret    
80106369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106370 <sys_ps>:


int
sys_ps(void)
{   if(isTraceOn==1)
80106370:	55                   	push   %ebp
80106371:	89 e5                	mov    %esp,%ebp
80106373:	83 ec 08             	sub    $0x8,%esp
80106376:	83 3d 18 17 11 80 01 	cmpl   $0x1,0x80111718
8010637d:	75 07                	jne    80106386 <sys_ps+0x16>
  {num_calls[SYS_ps] ++;}
8010637f:	83 05 a8 1a 11 80 01 	addl   $0x1,0x80111aa8
    running_procs();
80106386:	e8 55 de ff ff       	call   801041e0 <running_procs>
    //   {
    //     cprintf("pid:%d name:%s",p->pid,p->name)
    //     cprintf("\n");
    //   }
    return 0;
}
8010638b:	31 c0                	xor    %eax,%eax
8010638d:	c9                   	leave  
8010638e:	c3                   	ret    
8010638f:	90                   	nop

80106390 <sys_create_container>:

int
sys_create_container(int cid){
80106390:	55                   	push   %ebp
80106391:	89 e5                	mov    %esp,%ebp
80106393:	83 ec 10             	sub    $0x10,%esp
  argint(0,&cid);
80106396:	8d 45 08             	lea    0x8(%ebp),%eax
80106399:	50                   	push   %eax
8010639a:	6a 00                	push   $0x0
8010639c:	e8 0f e7 ff ff       	call   80104ab0 <argint>
  cprintf("%d\n",cid);
801063a1:	58                   	pop    %eax
801063a2:	5a                   	pop    %edx
801063a3:	ff 75 08             	pushl  0x8(%ebp)
801063a6:	68 94 81 10 80       	push   $0x80108194
801063ab:	e8 b0 a2 ff ff       	call   80100660 <cprintf>
  return cid;
}
801063b0:	8b 45 08             	mov    0x8(%ebp),%eax
801063b3:	c9                   	leave  
801063b4:	c3                   	ret    
801063b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801063b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801063c0 <sys_destroy_container>:

int
sys_destroy_container(int cid){
801063c0:	55                   	push   %ebp
801063c1:	89 e5                	mov    %esp,%ebp
801063c3:	83 ec 10             	sub    $0x10,%esp
  argint(0,&cid);
801063c6:	8d 45 08             	lea    0x8(%ebp),%eax
801063c9:	50                   	push   %eax
801063ca:	6a 00                	push   $0x0
801063cc:	e8 df e6 ff ff       	call   80104ab0 <argint>
  return 1;
}
801063d1:	b8 01 00 00 00       	mov    $0x1,%eax
801063d6:	c9                   	leave  
801063d7:	c3                   	ret    
801063d8:	90                   	nop
801063d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801063e0 <sys_join_container>:
801063e0:	55                   	push   %ebp
801063e1:	89 e5                	mov    %esp,%ebp
801063e3:	83 ec 20             	sub    $0x20,%esp
801063e6:	8b 45 08             	mov    0x8(%ebp),%eax
801063e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801063ec:	8d 45 f4             	lea    -0xc(%ebp),%eax
801063ef:	50                   	push   %eax
801063f0:	6a 00                	push   $0x0
801063f2:	e8 b9 e6 ff ff       	call   80104ab0 <argint>
801063f7:	b8 01 00 00 00       	mov    $0x1,%eax
801063fc:	c9                   	leave  
801063fd:	c3                   	ret    
801063fe:	66 90                	xchg   %ax,%ax

80106400 <sys_leave_container>:
  argint(0,&cid);
  return 1;
}

int
sys_leave_container(void){
80106400:	55                   	push   %ebp
  
  return 1;
}
80106401:	b8 01 00 00 00       	mov    $0x1,%eax
sys_leave_container(void){
80106406:	89 e5                	mov    %esp,%ebp
}
80106408:	5d                   	pop    %ebp
80106409:	c3                   	ret    

8010640a <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
8010640a:	1e                   	push   %ds
  pushl %es
8010640b:	06                   	push   %es
  pushl %fs
8010640c:	0f a0                	push   %fs
  pushl %gs
8010640e:	0f a8                	push   %gs
  pushal
80106410:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106411:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106415:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106417:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106419:	54                   	push   %esp
  call trap
8010641a:	e8 c1 00 00 00       	call   801064e0 <trap>
  addl $4, %esp
8010641f:	83 c4 04             	add    $0x4,%esp

80106422 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106422:	61                   	popa   
  popl %gs
80106423:	0f a9                	pop    %gs
  popl %fs
80106425:	0f a1                	pop    %fs
  popl %es
80106427:	07                   	pop    %es
  popl %ds
80106428:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106429:	83 c4 08             	add    $0x8,%esp
  iret
8010642c:	cf                   	iret   
8010642d:	66 90                	xchg   %ax,%ax
8010642f:	90                   	nop

80106430 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106430:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106431:	31 c0                	xor    %eax,%eax
{
80106433:	89 e5                	mov    %esp,%ebp
80106435:	83 ec 08             	sub    $0x8,%esp
80106438:	90                   	nop
80106439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106440:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80106447:	c7 04 c5 62 c1 11 80 	movl   $0x8e000008,-0x7fee3e9e(,%eax,8)
8010644e:	08 00 00 8e 
80106452:	66 89 14 c5 60 c1 11 	mov    %dx,-0x7fee3ea0(,%eax,8)
80106459:	80 
8010645a:	c1 ea 10             	shr    $0x10,%edx
8010645d:	66 89 14 c5 66 c1 11 	mov    %dx,-0x7fee3e9a(,%eax,8)
80106464:	80 
  for(i = 0; i < 256; i++)
80106465:	83 c0 01             	add    $0x1,%eax
80106468:	3d 00 01 00 00       	cmp    $0x100,%eax
8010646d:	75 d1                	jne    80106440 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010646f:	a1 08 b1 10 80       	mov    0x8010b108,%eax

  initlock(&tickslock, "time");
80106474:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106477:	c7 05 62 c3 11 80 08 	movl   $0xef000008,0x8011c362
8010647e:	00 00 ef 
  initlock(&tickslock, "time");
80106481:	68 cc 86 10 80       	push   $0x801086cc
80106486:	68 20 c1 11 80       	push   $0x8011c120
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010648b:	66 a3 60 c3 11 80    	mov    %ax,0x8011c360
80106491:	c1 e8 10             	shr    $0x10,%eax
80106494:	66 a3 66 c3 11 80    	mov    %ax,0x8011c366
  initlock(&tickslock, "time");
8010649a:	e8 c1 e0 ff ff       	call   80104560 <initlock>
}
8010649f:	83 c4 10             	add    $0x10,%esp
801064a2:	c9                   	leave  
801064a3:	c3                   	ret    
801064a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801064aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801064b0 <idtinit>:

void
idtinit(void)
{
801064b0:	55                   	push   %ebp
  pd[0] = size-1;
801064b1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801064b6:	89 e5                	mov    %esp,%ebp
801064b8:	83 ec 10             	sub    $0x10,%esp
801064bb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801064bf:	b8 60 c1 11 80       	mov    $0x8011c160,%eax
801064c4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801064c8:	c1 e8 10             	shr    $0x10,%eax
801064cb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801064cf:	8d 45 fa             	lea    -0x6(%ebp),%eax
801064d2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801064d5:	c9                   	leave  
801064d6:	c3                   	ret    
801064d7:	89 f6                	mov    %esi,%esi
801064d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801064e0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801064e0:	55                   	push   %ebp
801064e1:	89 e5                	mov    %esp,%ebp
801064e3:	57                   	push   %edi
801064e4:	56                   	push   %esi
801064e5:	53                   	push   %ebx
801064e6:	83 ec 1c             	sub    $0x1c,%esp
801064e9:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
801064ec:	8b 47 30             	mov    0x30(%edi),%eax
801064ef:	83 f8 40             	cmp    $0x40,%eax
801064f2:	0f 84 f0 00 00 00    	je     801065e8 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801064f8:	83 e8 20             	sub    $0x20,%eax
801064fb:	83 f8 1f             	cmp    $0x1f,%eax
801064fe:	77 10                	ja     80106510 <trap+0x30>
80106500:	ff 24 85 74 87 10 80 	jmp    *-0x7fef788c(,%eax,4)
80106507:	89 f6                	mov    %esi,%esi
80106509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80106510:	e8 eb d2 ff ff       	call   80103800 <myproc>
80106515:	85 c0                	test   %eax,%eax
80106517:	8b 5f 38             	mov    0x38(%edi),%ebx
8010651a:	0f 84 14 02 00 00    	je     80106734 <trap+0x254>
80106520:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80106524:	0f 84 0a 02 00 00    	je     80106734 <trap+0x254>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010652a:	0f 20 d1             	mov    %cr2,%ecx
8010652d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106530:	e8 ab d2 ff ff       	call   801037e0 <cpuid>
80106535:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106538:	8b 47 34             	mov    0x34(%edi),%eax
8010653b:	8b 77 30             	mov    0x30(%edi),%esi
8010653e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106541:	e8 ba d2 ff ff       	call   80103800 <myproc>
80106546:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106549:	e8 b2 d2 ff ff       	call   80103800 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010654e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106551:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106554:	51                   	push   %ecx
80106555:	53                   	push   %ebx
80106556:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80106557:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010655a:	ff 75 e4             	pushl  -0x1c(%ebp)
8010655d:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
8010655e:	81 c2 bc 01 00 00    	add    $0x1bc,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106564:	52                   	push   %edx
80106565:	ff 70 10             	pushl  0x10(%eax)
80106568:	68 30 87 10 80       	push   $0x80108730
8010656d:	e8 ee a0 ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80106572:	83 c4 20             	add    $0x20,%esp
80106575:	e8 86 d2 ff ff       	call   80103800 <myproc>
8010657a:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106581:	e8 7a d2 ff ff       	call   80103800 <myproc>
80106586:	85 c0                	test   %eax,%eax
80106588:	74 1d                	je     801065a7 <trap+0xc7>
8010658a:	e8 71 d2 ff ff       	call   80103800 <myproc>
8010658f:	8b 50 24             	mov    0x24(%eax),%edx
80106592:	85 d2                	test   %edx,%edx
80106594:	74 11                	je     801065a7 <trap+0xc7>
80106596:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
8010659a:	83 e0 03             	and    $0x3,%eax
8010659d:	66 83 f8 03          	cmp    $0x3,%ax
801065a1:	0f 84 49 01 00 00    	je     801066f0 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801065a7:	e8 54 d2 ff ff       	call   80103800 <myproc>
801065ac:	85 c0                	test   %eax,%eax
801065ae:	74 0b                	je     801065bb <trap+0xdb>
801065b0:	e8 4b d2 ff ff       	call   80103800 <myproc>
801065b5:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801065b9:	74 65                	je     80106620 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801065bb:	e8 40 d2 ff ff       	call   80103800 <myproc>
801065c0:	85 c0                	test   %eax,%eax
801065c2:	74 19                	je     801065dd <trap+0xfd>
801065c4:	e8 37 d2 ff ff       	call   80103800 <myproc>
801065c9:	8b 40 24             	mov    0x24(%eax),%eax
801065cc:	85 c0                	test   %eax,%eax
801065ce:	74 0d                	je     801065dd <trap+0xfd>
801065d0:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801065d4:	83 e0 03             	and    $0x3,%eax
801065d7:	66 83 f8 03          	cmp    $0x3,%ax
801065db:	74 34                	je     80106611 <trap+0x131>
    exit();
}
801065dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801065e0:	5b                   	pop    %ebx
801065e1:	5e                   	pop    %esi
801065e2:	5f                   	pop    %edi
801065e3:	5d                   	pop    %ebp
801065e4:	c3                   	ret    
801065e5:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc()->killed)
801065e8:	e8 13 d2 ff ff       	call   80103800 <myproc>
801065ed:	8b 58 24             	mov    0x24(%eax),%ebx
801065f0:	85 db                	test   %ebx,%ebx
801065f2:	0f 85 e8 00 00 00    	jne    801066e0 <trap+0x200>
    myproc()->tf = tf;
801065f8:	e8 03 d2 ff ff       	call   80103800 <myproc>
801065fd:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80106600:	e8 6b e6 ff ff       	call   80104c70 <syscall>
    if(myproc()->killed)
80106605:	e8 f6 d1 ff ff       	call   80103800 <myproc>
8010660a:	8b 48 24             	mov    0x24(%eax),%ecx
8010660d:	85 c9                	test   %ecx,%ecx
8010660f:	74 cc                	je     801065dd <trap+0xfd>
}
80106611:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106614:	5b                   	pop    %ebx
80106615:	5e                   	pop    %esi
80106616:	5f                   	pop    %edi
80106617:	5d                   	pop    %ebp
      exit();
80106618:	e9 b3 d6 ff ff       	jmp    80103cd0 <exit>
8010661d:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80106620:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80106624:	75 95                	jne    801065bb <trap+0xdb>
    yield();
80106626:	e8 e5 d7 ff ff       	call   80103e10 <yield>
8010662b:	eb 8e                	jmp    801065bb <trap+0xdb>
8010662d:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80106630:	e8 ab d1 ff ff       	call   801037e0 <cpuid>
80106635:	85 c0                	test   %eax,%eax
80106637:	0f 84 c3 00 00 00    	je     80106700 <trap+0x220>
    lapiceoi();
8010663d:	e8 2e c1 ff ff       	call   80102770 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106642:	e8 b9 d1 ff ff       	call   80103800 <myproc>
80106647:	85 c0                	test   %eax,%eax
80106649:	0f 85 3b ff ff ff    	jne    8010658a <trap+0xaa>
8010664f:	e9 53 ff ff ff       	jmp    801065a7 <trap+0xc7>
80106654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106658:	e8 d3 bf ff ff       	call   80102630 <kbdintr>
    lapiceoi();
8010665d:	e8 0e c1 ff ff       	call   80102770 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106662:	e8 99 d1 ff ff       	call   80103800 <myproc>
80106667:	85 c0                	test   %eax,%eax
80106669:	0f 85 1b ff ff ff    	jne    8010658a <trap+0xaa>
8010666f:	e9 33 ff ff ff       	jmp    801065a7 <trap+0xc7>
80106674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106678:	e8 53 02 00 00       	call   801068d0 <uartintr>
    lapiceoi();
8010667d:	e8 ee c0 ff ff       	call   80102770 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106682:	e8 79 d1 ff ff       	call   80103800 <myproc>
80106687:	85 c0                	test   %eax,%eax
80106689:	0f 85 fb fe ff ff    	jne    8010658a <trap+0xaa>
8010668f:	e9 13 ff ff ff       	jmp    801065a7 <trap+0xc7>
80106694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106698:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
8010669c:	8b 77 38             	mov    0x38(%edi),%esi
8010669f:	e8 3c d1 ff ff       	call   801037e0 <cpuid>
801066a4:	56                   	push   %esi
801066a5:	53                   	push   %ebx
801066a6:	50                   	push   %eax
801066a7:	68 d8 86 10 80       	push   $0x801086d8
801066ac:	e8 af 9f ff ff       	call   80100660 <cprintf>
    lapiceoi();
801066b1:	e8 ba c0 ff ff       	call   80102770 <lapiceoi>
    break;
801066b6:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801066b9:	e8 42 d1 ff ff       	call   80103800 <myproc>
801066be:	85 c0                	test   %eax,%eax
801066c0:	0f 85 c4 fe ff ff    	jne    8010658a <trap+0xaa>
801066c6:	e9 dc fe ff ff       	jmp    801065a7 <trap+0xc7>
801066cb:	90                   	nop
801066cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
801066d0:	e8 cb b9 ff ff       	call   801020a0 <ideintr>
801066d5:	e9 63 ff ff ff       	jmp    8010663d <trap+0x15d>
801066da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
801066e0:	e8 eb d5 ff ff       	call   80103cd0 <exit>
801066e5:	e9 0e ff ff ff       	jmp    801065f8 <trap+0x118>
801066ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
801066f0:	e8 db d5 ff ff       	call   80103cd0 <exit>
801066f5:	e9 ad fe ff ff       	jmp    801065a7 <trap+0xc7>
801066fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80106700:	83 ec 0c             	sub    $0xc,%esp
80106703:	68 20 c1 11 80       	push   $0x8011c120
80106708:	e8 93 df ff ff       	call   801046a0 <acquire>
      wakeup(&ticks);
8010670d:	c7 04 24 60 c9 11 80 	movl   $0x8011c960,(%esp)
      ticks++;
80106714:	83 05 60 c9 11 80 01 	addl   $0x1,0x8011c960
      wakeup(&ticks);
8010671b:	e8 00 d9 ff ff       	call   80104020 <wakeup>
      release(&tickslock);
80106720:	c7 04 24 20 c1 11 80 	movl   $0x8011c120,(%esp)
80106727:	e8 34 e0 ff ff       	call   80104760 <release>
8010672c:	83 c4 10             	add    $0x10,%esp
8010672f:	e9 09 ff ff ff       	jmp    8010663d <trap+0x15d>
80106734:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106737:	e8 a4 d0 ff ff       	call   801037e0 <cpuid>
8010673c:	83 ec 0c             	sub    $0xc,%esp
8010673f:	56                   	push   %esi
80106740:	53                   	push   %ebx
80106741:	50                   	push   %eax
80106742:	ff 77 30             	pushl  0x30(%edi)
80106745:	68 fc 86 10 80       	push   $0x801086fc
8010674a:	e8 11 9f ff ff       	call   80100660 <cprintf>
      panic("trap");
8010674f:	83 c4 14             	add    $0x14,%esp
80106752:	68 d1 86 10 80       	push   $0x801086d1
80106757:	e8 34 9c ff ff       	call   80100390 <panic>
8010675c:	66 90                	xchg   %ax,%ax
8010675e:	66 90                	xchg   %ax,%ax

80106760 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106760:	a1 c4 b5 10 80       	mov    0x8010b5c4,%eax
{
80106765:	55                   	push   %ebp
80106766:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106768:	85 c0                	test   %eax,%eax
8010676a:	74 1c                	je     80106788 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010676c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106771:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106772:	a8 01                	test   $0x1,%al
80106774:	74 12                	je     80106788 <uartgetc+0x28>
80106776:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010677b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010677c:	0f b6 c0             	movzbl %al,%eax
}
8010677f:	5d                   	pop    %ebp
80106780:	c3                   	ret    
80106781:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106788:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010678d:	5d                   	pop    %ebp
8010678e:	c3                   	ret    
8010678f:	90                   	nop

80106790 <uartputc.part.0>:
uartputc(int c)
80106790:	55                   	push   %ebp
80106791:	89 e5                	mov    %esp,%ebp
80106793:	57                   	push   %edi
80106794:	56                   	push   %esi
80106795:	53                   	push   %ebx
80106796:	89 c7                	mov    %eax,%edi
80106798:	bb 80 00 00 00       	mov    $0x80,%ebx
8010679d:	be fd 03 00 00       	mov    $0x3fd,%esi
801067a2:	83 ec 0c             	sub    $0xc,%esp
801067a5:	eb 1b                	jmp    801067c2 <uartputc.part.0+0x32>
801067a7:	89 f6                	mov    %esi,%esi
801067a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
801067b0:	83 ec 0c             	sub    $0xc,%esp
801067b3:	6a 0a                	push   $0xa
801067b5:	e8 d6 bf ff ff       	call   80102790 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801067ba:	83 c4 10             	add    $0x10,%esp
801067bd:	83 eb 01             	sub    $0x1,%ebx
801067c0:	74 07                	je     801067c9 <uartputc.part.0+0x39>
801067c2:	89 f2                	mov    %esi,%edx
801067c4:	ec                   	in     (%dx),%al
801067c5:	a8 20                	test   $0x20,%al
801067c7:	74 e7                	je     801067b0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801067c9:	ba f8 03 00 00       	mov    $0x3f8,%edx
801067ce:	89 f8                	mov    %edi,%eax
801067d0:	ee                   	out    %al,(%dx)
}
801067d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801067d4:	5b                   	pop    %ebx
801067d5:	5e                   	pop    %esi
801067d6:	5f                   	pop    %edi
801067d7:	5d                   	pop    %ebp
801067d8:	c3                   	ret    
801067d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801067e0 <uartinit>:
{
801067e0:	55                   	push   %ebp
801067e1:	31 c9                	xor    %ecx,%ecx
801067e3:	89 c8                	mov    %ecx,%eax
801067e5:	89 e5                	mov    %esp,%ebp
801067e7:	57                   	push   %edi
801067e8:	56                   	push   %esi
801067e9:	53                   	push   %ebx
801067ea:	bb fa 03 00 00       	mov    $0x3fa,%ebx
801067ef:	89 da                	mov    %ebx,%edx
801067f1:	83 ec 0c             	sub    $0xc,%esp
801067f4:	ee                   	out    %al,(%dx)
801067f5:	bf fb 03 00 00       	mov    $0x3fb,%edi
801067fa:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801067ff:	89 fa                	mov    %edi,%edx
80106801:	ee                   	out    %al,(%dx)
80106802:	b8 0c 00 00 00       	mov    $0xc,%eax
80106807:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010680c:	ee                   	out    %al,(%dx)
8010680d:	be f9 03 00 00       	mov    $0x3f9,%esi
80106812:	89 c8                	mov    %ecx,%eax
80106814:	89 f2                	mov    %esi,%edx
80106816:	ee                   	out    %al,(%dx)
80106817:	b8 03 00 00 00       	mov    $0x3,%eax
8010681c:	89 fa                	mov    %edi,%edx
8010681e:	ee                   	out    %al,(%dx)
8010681f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106824:	89 c8                	mov    %ecx,%eax
80106826:	ee                   	out    %al,(%dx)
80106827:	b8 01 00 00 00       	mov    $0x1,%eax
8010682c:	89 f2                	mov    %esi,%edx
8010682e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010682f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106834:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106835:	3c ff                	cmp    $0xff,%al
80106837:	74 5a                	je     80106893 <uartinit+0xb3>
  uart = 1;
80106839:	c7 05 c4 b5 10 80 01 	movl   $0x1,0x8010b5c4
80106840:	00 00 00 
80106843:	89 da                	mov    %ebx,%edx
80106845:	ec                   	in     (%dx),%al
80106846:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010684b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
8010684c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
8010684f:	bb f4 87 10 80       	mov    $0x801087f4,%ebx
  ioapicenable(IRQ_COM1, 0);
80106854:	6a 00                	push   $0x0
80106856:	6a 04                	push   $0x4
80106858:	e8 93 ba ff ff       	call   801022f0 <ioapicenable>
8010685d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106860:	b8 78 00 00 00       	mov    $0x78,%eax
80106865:	eb 13                	jmp    8010687a <uartinit+0x9a>
80106867:	89 f6                	mov    %esi,%esi
80106869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106870:	83 c3 01             	add    $0x1,%ebx
80106873:	0f be 03             	movsbl (%ebx),%eax
80106876:	84 c0                	test   %al,%al
80106878:	74 19                	je     80106893 <uartinit+0xb3>
  if(!uart)
8010687a:	8b 15 c4 b5 10 80    	mov    0x8010b5c4,%edx
80106880:	85 d2                	test   %edx,%edx
80106882:	74 ec                	je     80106870 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80106884:	83 c3 01             	add    $0x1,%ebx
80106887:	e8 04 ff ff ff       	call   80106790 <uartputc.part.0>
8010688c:	0f be 03             	movsbl (%ebx),%eax
8010688f:	84 c0                	test   %al,%al
80106891:	75 e7                	jne    8010687a <uartinit+0x9a>
}
80106893:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106896:	5b                   	pop    %ebx
80106897:	5e                   	pop    %esi
80106898:	5f                   	pop    %edi
80106899:	5d                   	pop    %ebp
8010689a:	c3                   	ret    
8010689b:	90                   	nop
8010689c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801068a0 <uartputc>:
  if(!uart)
801068a0:	8b 15 c4 b5 10 80    	mov    0x8010b5c4,%edx
{
801068a6:	55                   	push   %ebp
801068a7:	89 e5                	mov    %esp,%ebp
  if(!uart)
801068a9:	85 d2                	test   %edx,%edx
{
801068ab:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
801068ae:	74 10                	je     801068c0 <uartputc+0x20>
}
801068b0:	5d                   	pop    %ebp
801068b1:	e9 da fe ff ff       	jmp    80106790 <uartputc.part.0>
801068b6:	8d 76 00             	lea    0x0(%esi),%esi
801068b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801068c0:	5d                   	pop    %ebp
801068c1:	c3                   	ret    
801068c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801068d0 <uartintr>:

void
uartintr(void)
{
801068d0:	55                   	push   %ebp
801068d1:	89 e5                	mov    %esp,%ebp
801068d3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801068d6:	68 60 67 10 80       	push   $0x80106760
801068db:	e8 30 9f ff ff       	call   80100810 <consoleintr>
}
801068e0:	83 c4 10             	add    $0x10,%esp
801068e3:	c9                   	leave  
801068e4:	c3                   	ret    

801068e5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801068e5:	6a 00                	push   $0x0
  pushl $0
801068e7:	6a 00                	push   $0x0
  jmp alltraps
801068e9:	e9 1c fb ff ff       	jmp    8010640a <alltraps>

801068ee <vector1>:
.globl vector1
vector1:
  pushl $0
801068ee:	6a 00                	push   $0x0
  pushl $1
801068f0:	6a 01                	push   $0x1
  jmp alltraps
801068f2:	e9 13 fb ff ff       	jmp    8010640a <alltraps>

801068f7 <vector2>:
.globl vector2
vector2:
  pushl $0
801068f7:	6a 00                	push   $0x0
  pushl $2
801068f9:	6a 02                	push   $0x2
  jmp alltraps
801068fb:	e9 0a fb ff ff       	jmp    8010640a <alltraps>

80106900 <vector3>:
.globl vector3
vector3:
  pushl $0
80106900:	6a 00                	push   $0x0
  pushl $3
80106902:	6a 03                	push   $0x3
  jmp alltraps
80106904:	e9 01 fb ff ff       	jmp    8010640a <alltraps>

80106909 <vector4>:
.globl vector4
vector4:
  pushl $0
80106909:	6a 00                	push   $0x0
  pushl $4
8010690b:	6a 04                	push   $0x4
  jmp alltraps
8010690d:	e9 f8 fa ff ff       	jmp    8010640a <alltraps>

80106912 <vector5>:
.globl vector5
vector5:
  pushl $0
80106912:	6a 00                	push   $0x0
  pushl $5
80106914:	6a 05                	push   $0x5
  jmp alltraps
80106916:	e9 ef fa ff ff       	jmp    8010640a <alltraps>

8010691b <vector6>:
.globl vector6
vector6:
  pushl $0
8010691b:	6a 00                	push   $0x0
  pushl $6
8010691d:	6a 06                	push   $0x6
  jmp alltraps
8010691f:	e9 e6 fa ff ff       	jmp    8010640a <alltraps>

80106924 <vector7>:
.globl vector7
vector7:
  pushl $0
80106924:	6a 00                	push   $0x0
  pushl $7
80106926:	6a 07                	push   $0x7
  jmp alltraps
80106928:	e9 dd fa ff ff       	jmp    8010640a <alltraps>

8010692d <vector8>:
.globl vector8
vector8:
  pushl $8
8010692d:	6a 08                	push   $0x8
  jmp alltraps
8010692f:	e9 d6 fa ff ff       	jmp    8010640a <alltraps>

80106934 <vector9>:
.globl vector9
vector9:
  pushl $0
80106934:	6a 00                	push   $0x0
  pushl $9
80106936:	6a 09                	push   $0x9
  jmp alltraps
80106938:	e9 cd fa ff ff       	jmp    8010640a <alltraps>

8010693d <vector10>:
.globl vector10
vector10:
  pushl $10
8010693d:	6a 0a                	push   $0xa
  jmp alltraps
8010693f:	e9 c6 fa ff ff       	jmp    8010640a <alltraps>

80106944 <vector11>:
.globl vector11
vector11:
  pushl $11
80106944:	6a 0b                	push   $0xb
  jmp alltraps
80106946:	e9 bf fa ff ff       	jmp    8010640a <alltraps>

8010694b <vector12>:
.globl vector12
vector12:
  pushl $12
8010694b:	6a 0c                	push   $0xc
  jmp alltraps
8010694d:	e9 b8 fa ff ff       	jmp    8010640a <alltraps>

80106952 <vector13>:
.globl vector13
vector13:
  pushl $13
80106952:	6a 0d                	push   $0xd
  jmp alltraps
80106954:	e9 b1 fa ff ff       	jmp    8010640a <alltraps>

80106959 <vector14>:
.globl vector14
vector14:
  pushl $14
80106959:	6a 0e                	push   $0xe
  jmp alltraps
8010695b:	e9 aa fa ff ff       	jmp    8010640a <alltraps>

80106960 <vector15>:
.globl vector15
vector15:
  pushl $0
80106960:	6a 00                	push   $0x0
  pushl $15
80106962:	6a 0f                	push   $0xf
  jmp alltraps
80106964:	e9 a1 fa ff ff       	jmp    8010640a <alltraps>

80106969 <vector16>:
.globl vector16
vector16:
  pushl $0
80106969:	6a 00                	push   $0x0
  pushl $16
8010696b:	6a 10                	push   $0x10
  jmp alltraps
8010696d:	e9 98 fa ff ff       	jmp    8010640a <alltraps>

80106972 <vector17>:
.globl vector17
vector17:
  pushl $17
80106972:	6a 11                	push   $0x11
  jmp alltraps
80106974:	e9 91 fa ff ff       	jmp    8010640a <alltraps>

80106979 <vector18>:
.globl vector18
vector18:
  pushl $0
80106979:	6a 00                	push   $0x0
  pushl $18
8010697b:	6a 12                	push   $0x12
  jmp alltraps
8010697d:	e9 88 fa ff ff       	jmp    8010640a <alltraps>

80106982 <vector19>:
.globl vector19
vector19:
  pushl $0
80106982:	6a 00                	push   $0x0
  pushl $19
80106984:	6a 13                	push   $0x13
  jmp alltraps
80106986:	e9 7f fa ff ff       	jmp    8010640a <alltraps>

8010698b <vector20>:
.globl vector20
vector20:
  pushl $0
8010698b:	6a 00                	push   $0x0
  pushl $20
8010698d:	6a 14                	push   $0x14
  jmp alltraps
8010698f:	e9 76 fa ff ff       	jmp    8010640a <alltraps>

80106994 <vector21>:
.globl vector21
vector21:
  pushl $0
80106994:	6a 00                	push   $0x0
  pushl $21
80106996:	6a 15                	push   $0x15
  jmp alltraps
80106998:	e9 6d fa ff ff       	jmp    8010640a <alltraps>

8010699d <vector22>:
.globl vector22
vector22:
  pushl $0
8010699d:	6a 00                	push   $0x0
  pushl $22
8010699f:	6a 16                	push   $0x16
  jmp alltraps
801069a1:	e9 64 fa ff ff       	jmp    8010640a <alltraps>

801069a6 <vector23>:
.globl vector23
vector23:
  pushl $0
801069a6:	6a 00                	push   $0x0
  pushl $23
801069a8:	6a 17                	push   $0x17
  jmp alltraps
801069aa:	e9 5b fa ff ff       	jmp    8010640a <alltraps>

801069af <vector24>:
.globl vector24
vector24:
  pushl $0
801069af:	6a 00                	push   $0x0
  pushl $24
801069b1:	6a 18                	push   $0x18
  jmp alltraps
801069b3:	e9 52 fa ff ff       	jmp    8010640a <alltraps>

801069b8 <vector25>:
.globl vector25
vector25:
  pushl $0
801069b8:	6a 00                	push   $0x0
  pushl $25
801069ba:	6a 19                	push   $0x19
  jmp alltraps
801069bc:	e9 49 fa ff ff       	jmp    8010640a <alltraps>

801069c1 <vector26>:
.globl vector26
vector26:
  pushl $0
801069c1:	6a 00                	push   $0x0
  pushl $26
801069c3:	6a 1a                	push   $0x1a
  jmp alltraps
801069c5:	e9 40 fa ff ff       	jmp    8010640a <alltraps>

801069ca <vector27>:
.globl vector27
vector27:
  pushl $0
801069ca:	6a 00                	push   $0x0
  pushl $27
801069cc:	6a 1b                	push   $0x1b
  jmp alltraps
801069ce:	e9 37 fa ff ff       	jmp    8010640a <alltraps>

801069d3 <vector28>:
.globl vector28
vector28:
  pushl $0
801069d3:	6a 00                	push   $0x0
  pushl $28
801069d5:	6a 1c                	push   $0x1c
  jmp alltraps
801069d7:	e9 2e fa ff ff       	jmp    8010640a <alltraps>

801069dc <vector29>:
.globl vector29
vector29:
  pushl $0
801069dc:	6a 00                	push   $0x0
  pushl $29
801069de:	6a 1d                	push   $0x1d
  jmp alltraps
801069e0:	e9 25 fa ff ff       	jmp    8010640a <alltraps>

801069e5 <vector30>:
.globl vector30
vector30:
  pushl $0
801069e5:	6a 00                	push   $0x0
  pushl $30
801069e7:	6a 1e                	push   $0x1e
  jmp alltraps
801069e9:	e9 1c fa ff ff       	jmp    8010640a <alltraps>

801069ee <vector31>:
.globl vector31
vector31:
  pushl $0
801069ee:	6a 00                	push   $0x0
  pushl $31
801069f0:	6a 1f                	push   $0x1f
  jmp alltraps
801069f2:	e9 13 fa ff ff       	jmp    8010640a <alltraps>

801069f7 <vector32>:
.globl vector32
vector32:
  pushl $0
801069f7:	6a 00                	push   $0x0
  pushl $32
801069f9:	6a 20                	push   $0x20
  jmp alltraps
801069fb:	e9 0a fa ff ff       	jmp    8010640a <alltraps>

80106a00 <vector33>:
.globl vector33
vector33:
  pushl $0
80106a00:	6a 00                	push   $0x0
  pushl $33
80106a02:	6a 21                	push   $0x21
  jmp alltraps
80106a04:	e9 01 fa ff ff       	jmp    8010640a <alltraps>

80106a09 <vector34>:
.globl vector34
vector34:
  pushl $0
80106a09:	6a 00                	push   $0x0
  pushl $34
80106a0b:	6a 22                	push   $0x22
  jmp alltraps
80106a0d:	e9 f8 f9 ff ff       	jmp    8010640a <alltraps>

80106a12 <vector35>:
.globl vector35
vector35:
  pushl $0
80106a12:	6a 00                	push   $0x0
  pushl $35
80106a14:	6a 23                	push   $0x23
  jmp alltraps
80106a16:	e9 ef f9 ff ff       	jmp    8010640a <alltraps>

80106a1b <vector36>:
.globl vector36
vector36:
  pushl $0
80106a1b:	6a 00                	push   $0x0
  pushl $36
80106a1d:	6a 24                	push   $0x24
  jmp alltraps
80106a1f:	e9 e6 f9 ff ff       	jmp    8010640a <alltraps>

80106a24 <vector37>:
.globl vector37
vector37:
  pushl $0
80106a24:	6a 00                	push   $0x0
  pushl $37
80106a26:	6a 25                	push   $0x25
  jmp alltraps
80106a28:	e9 dd f9 ff ff       	jmp    8010640a <alltraps>

80106a2d <vector38>:
.globl vector38
vector38:
  pushl $0
80106a2d:	6a 00                	push   $0x0
  pushl $38
80106a2f:	6a 26                	push   $0x26
  jmp alltraps
80106a31:	e9 d4 f9 ff ff       	jmp    8010640a <alltraps>

80106a36 <vector39>:
.globl vector39
vector39:
  pushl $0
80106a36:	6a 00                	push   $0x0
  pushl $39
80106a38:	6a 27                	push   $0x27
  jmp alltraps
80106a3a:	e9 cb f9 ff ff       	jmp    8010640a <alltraps>

80106a3f <vector40>:
.globl vector40
vector40:
  pushl $0
80106a3f:	6a 00                	push   $0x0
  pushl $40
80106a41:	6a 28                	push   $0x28
  jmp alltraps
80106a43:	e9 c2 f9 ff ff       	jmp    8010640a <alltraps>

80106a48 <vector41>:
.globl vector41
vector41:
  pushl $0
80106a48:	6a 00                	push   $0x0
  pushl $41
80106a4a:	6a 29                	push   $0x29
  jmp alltraps
80106a4c:	e9 b9 f9 ff ff       	jmp    8010640a <alltraps>

80106a51 <vector42>:
.globl vector42
vector42:
  pushl $0
80106a51:	6a 00                	push   $0x0
  pushl $42
80106a53:	6a 2a                	push   $0x2a
  jmp alltraps
80106a55:	e9 b0 f9 ff ff       	jmp    8010640a <alltraps>

80106a5a <vector43>:
.globl vector43
vector43:
  pushl $0
80106a5a:	6a 00                	push   $0x0
  pushl $43
80106a5c:	6a 2b                	push   $0x2b
  jmp alltraps
80106a5e:	e9 a7 f9 ff ff       	jmp    8010640a <alltraps>

80106a63 <vector44>:
.globl vector44
vector44:
  pushl $0
80106a63:	6a 00                	push   $0x0
  pushl $44
80106a65:	6a 2c                	push   $0x2c
  jmp alltraps
80106a67:	e9 9e f9 ff ff       	jmp    8010640a <alltraps>

80106a6c <vector45>:
.globl vector45
vector45:
  pushl $0
80106a6c:	6a 00                	push   $0x0
  pushl $45
80106a6e:	6a 2d                	push   $0x2d
  jmp alltraps
80106a70:	e9 95 f9 ff ff       	jmp    8010640a <alltraps>

80106a75 <vector46>:
.globl vector46
vector46:
  pushl $0
80106a75:	6a 00                	push   $0x0
  pushl $46
80106a77:	6a 2e                	push   $0x2e
  jmp alltraps
80106a79:	e9 8c f9 ff ff       	jmp    8010640a <alltraps>

80106a7e <vector47>:
.globl vector47
vector47:
  pushl $0
80106a7e:	6a 00                	push   $0x0
  pushl $47
80106a80:	6a 2f                	push   $0x2f
  jmp alltraps
80106a82:	e9 83 f9 ff ff       	jmp    8010640a <alltraps>

80106a87 <vector48>:
.globl vector48
vector48:
  pushl $0
80106a87:	6a 00                	push   $0x0
  pushl $48
80106a89:	6a 30                	push   $0x30
  jmp alltraps
80106a8b:	e9 7a f9 ff ff       	jmp    8010640a <alltraps>

80106a90 <vector49>:
.globl vector49
vector49:
  pushl $0
80106a90:	6a 00                	push   $0x0
  pushl $49
80106a92:	6a 31                	push   $0x31
  jmp alltraps
80106a94:	e9 71 f9 ff ff       	jmp    8010640a <alltraps>

80106a99 <vector50>:
.globl vector50
vector50:
  pushl $0
80106a99:	6a 00                	push   $0x0
  pushl $50
80106a9b:	6a 32                	push   $0x32
  jmp alltraps
80106a9d:	e9 68 f9 ff ff       	jmp    8010640a <alltraps>

80106aa2 <vector51>:
.globl vector51
vector51:
  pushl $0
80106aa2:	6a 00                	push   $0x0
  pushl $51
80106aa4:	6a 33                	push   $0x33
  jmp alltraps
80106aa6:	e9 5f f9 ff ff       	jmp    8010640a <alltraps>

80106aab <vector52>:
.globl vector52
vector52:
  pushl $0
80106aab:	6a 00                	push   $0x0
  pushl $52
80106aad:	6a 34                	push   $0x34
  jmp alltraps
80106aaf:	e9 56 f9 ff ff       	jmp    8010640a <alltraps>

80106ab4 <vector53>:
.globl vector53
vector53:
  pushl $0
80106ab4:	6a 00                	push   $0x0
  pushl $53
80106ab6:	6a 35                	push   $0x35
  jmp alltraps
80106ab8:	e9 4d f9 ff ff       	jmp    8010640a <alltraps>

80106abd <vector54>:
.globl vector54
vector54:
  pushl $0
80106abd:	6a 00                	push   $0x0
  pushl $54
80106abf:	6a 36                	push   $0x36
  jmp alltraps
80106ac1:	e9 44 f9 ff ff       	jmp    8010640a <alltraps>

80106ac6 <vector55>:
.globl vector55
vector55:
  pushl $0
80106ac6:	6a 00                	push   $0x0
  pushl $55
80106ac8:	6a 37                	push   $0x37
  jmp alltraps
80106aca:	e9 3b f9 ff ff       	jmp    8010640a <alltraps>

80106acf <vector56>:
.globl vector56
vector56:
  pushl $0
80106acf:	6a 00                	push   $0x0
  pushl $56
80106ad1:	6a 38                	push   $0x38
  jmp alltraps
80106ad3:	e9 32 f9 ff ff       	jmp    8010640a <alltraps>

80106ad8 <vector57>:
.globl vector57
vector57:
  pushl $0
80106ad8:	6a 00                	push   $0x0
  pushl $57
80106ada:	6a 39                	push   $0x39
  jmp alltraps
80106adc:	e9 29 f9 ff ff       	jmp    8010640a <alltraps>

80106ae1 <vector58>:
.globl vector58
vector58:
  pushl $0
80106ae1:	6a 00                	push   $0x0
  pushl $58
80106ae3:	6a 3a                	push   $0x3a
  jmp alltraps
80106ae5:	e9 20 f9 ff ff       	jmp    8010640a <alltraps>

80106aea <vector59>:
.globl vector59
vector59:
  pushl $0
80106aea:	6a 00                	push   $0x0
  pushl $59
80106aec:	6a 3b                	push   $0x3b
  jmp alltraps
80106aee:	e9 17 f9 ff ff       	jmp    8010640a <alltraps>

80106af3 <vector60>:
.globl vector60
vector60:
  pushl $0
80106af3:	6a 00                	push   $0x0
  pushl $60
80106af5:	6a 3c                	push   $0x3c
  jmp alltraps
80106af7:	e9 0e f9 ff ff       	jmp    8010640a <alltraps>

80106afc <vector61>:
.globl vector61
vector61:
  pushl $0
80106afc:	6a 00                	push   $0x0
  pushl $61
80106afe:	6a 3d                	push   $0x3d
  jmp alltraps
80106b00:	e9 05 f9 ff ff       	jmp    8010640a <alltraps>

80106b05 <vector62>:
.globl vector62
vector62:
  pushl $0
80106b05:	6a 00                	push   $0x0
  pushl $62
80106b07:	6a 3e                	push   $0x3e
  jmp alltraps
80106b09:	e9 fc f8 ff ff       	jmp    8010640a <alltraps>

80106b0e <vector63>:
.globl vector63
vector63:
  pushl $0
80106b0e:	6a 00                	push   $0x0
  pushl $63
80106b10:	6a 3f                	push   $0x3f
  jmp alltraps
80106b12:	e9 f3 f8 ff ff       	jmp    8010640a <alltraps>

80106b17 <vector64>:
.globl vector64
vector64:
  pushl $0
80106b17:	6a 00                	push   $0x0
  pushl $64
80106b19:	6a 40                	push   $0x40
  jmp alltraps
80106b1b:	e9 ea f8 ff ff       	jmp    8010640a <alltraps>

80106b20 <vector65>:
.globl vector65
vector65:
  pushl $0
80106b20:	6a 00                	push   $0x0
  pushl $65
80106b22:	6a 41                	push   $0x41
  jmp alltraps
80106b24:	e9 e1 f8 ff ff       	jmp    8010640a <alltraps>

80106b29 <vector66>:
.globl vector66
vector66:
  pushl $0
80106b29:	6a 00                	push   $0x0
  pushl $66
80106b2b:	6a 42                	push   $0x42
  jmp alltraps
80106b2d:	e9 d8 f8 ff ff       	jmp    8010640a <alltraps>

80106b32 <vector67>:
.globl vector67
vector67:
  pushl $0
80106b32:	6a 00                	push   $0x0
  pushl $67
80106b34:	6a 43                	push   $0x43
  jmp alltraps
80106b36:	e9 cf f8 ff ff       	jmp    8010640a <alltraps>

80106b3b <vector68>:
.globl vector68
vector68:
  pushl $0
80106b3b:	6a 00                	push   $0x0
  pushl $68
80106b3d:	6a 44                	push   $0x44
  jmp alltraps
80106b3f:	e9 c6 f8 ff ff       	jmp    8010640a <alltraps>

80106b44 <vector69>:
.globl vector69
vector69:
  pushl $0
80106b44:	6a 00                	push   $0x0
  pushl $69
80106b46:	6a 45                	push   $0x45
  jmp alltraps
80106b48:	e9 bd f8 ff ff       	jmp    8010640a <alltraps>

80106b4d <vector70>:
.globl vector70
vector70:
  pushl $0
80106b4d:	6a 00                	push   $0x0
  pushl $70
80106b4f:	6a 46                	push   $0x46
  jmp alltraps
80106b51:	e9 b4 f8 ff ff       	jmp    8010640a <alltraps>

80106b56 <vector71>:
.globl vector71
vector71:
  pushl $0
80106b56:	6a 00                	push   $0x0
  pushl $71
80106b58:	6a 47                	push   $0x47
  jmp alltraps
80106b5a:	e9 ab f8 ff ff       	jmp    8010640a <alltraps>

80106b5f <vector72>:
.globl vector72
vector72:
  pushl $0
80106b5f:	6a 00                	push   $0x0
  pushl $72
80106b61:	6a 48                	push   $0x48
  jmp alltraps
80106b63:	e9 a2 f8 ff ff       	jmp    8010640a <alltraps>

80106b68 <vector73>:
.globl vector73
vector73:
  pushl $0
80106b68:	6a 00                	push   $0x0
  pushl $73
80106b6a:	6a 49                	push   $0x49
  jmp alltraps
80106b6c:	e9 99 f8 ff ff       	jmp    8010640a <alltraps>

80106b71 <vector74>:
.globl vector74
vector74:
  pushl $0
80106b71:	6a 00                	push   $0x0
  pushl $74
80106b73:	6a 4a                	push   $0x4a
  jmp alltraps
80106b75:	e9 90 f8 ff ff       	jmp    8010640a <alltraps>

80106b7a <vector75>:
.globl vector75
vector75:
  pushl $0
80106b7a:	6a 00                	push   $0x0
  pushl $75
80106b7c:	6a 4b                	push   $0x4b
  jmp alltraps
80106b7e:	e9 87 f8 ff ff       	jmp    8010640a <alltraps>

80106b83 <vector76>:
.globl vector76
vector76:
  pushl $0
80106b83:	6a 00                	push   $0x0
  pushl $76
80106b85:	6a 4c                	push   $0x4c
  jmp alltraps
80106b87:	e9 7e f8 ff ff       	jmp    8010640a <alltraps>

80106b8c <vector77>:
.globl vector77
vector77:
  pushl $0
80106b8c:	6a 00                	push   $0x0
  pushl $77
80106b8e:	6a 4d                	push   $0x4d
  jmp alltraps
80106b90:	e9 75 f8 ff ff       	jmp    8010640a <alltraps>

80106b95 <vector78>:
.globl vector78
vector78:
  pushl $0
80106b95:	6a 00                	push   $0x0
  pushl $78
80106b97:	6a 4e                	push   $0x4e
  jmp alltraps
80106b99:	e9 6c f8 ff ff       	jmp    8010640a <alltraps>

80106b9e <vector79>:
.globl vector79
vector79:
  pushl $0
80106b9e:	6a 00                	push   $0x0
  pushl $79
80106ba0:	6a 4f                	push   $0x4f
  jmp alltraps
80106ba2:	e9 63 f8 ff ff       	jmp    8010640a <alltraps>

80106ba7 <vector80>:
.globl vector80
vector80:
  pushl $0
80106ba7:	6a 00                	push   $0x0
  pushl $80
80106ba9:	6a 50                	push   $0x50
  jmp alltraps
80106bab:	e9 5a f8 ff ff       	jmp    8010640a <alltraps>

80106bb0 <vector81>:
.globl vector81
vector81:
  pushl $0
80106bb0:	6a 00                	push   $0x0
  pushl $81
80106bb2:	6a 51                	push   $0x51
  jmp alltraps
80106bb4:	e9 51 f8 ff ff       	jmp    8010640a <alltraps>

80106bb9 <vector82>:
.globl vector82
vector82:
  pushl $0
80106bb9:	6a 00                	push   $0x0
  pushl $82
80106bbb:	6a 52                	push   $0x52
  jmp alltraps
80106bbd:	e9 48 f8 ff ff       	jmp    8010640a <alltraps>

80106bc2 <vector83>:
.globl vector83
vector83:
  pushl $0
80106bc2:	6a 00                	push   $0x0
  pushl $83
80106bc4:	6a 53                	push   $0x53
  jmp alltraps
80106bc6:	e9 3f f8 ff ff       	jmp    8010640a <alltraps>

80106bcb <vector84>:
.globl vector84
vector84:
  pushl $0
80106bcb:	6a 00                	push   $0x0
  pushl $84
80106bcd:	6a 54                	push   $0x54
  jmp alltraps
80106bcf:	e9 36 f8 ff ff       	jmp    8010640a <alltraps>

80106bd4 <vector85>:
.globl vector85
vector85:
  pushl $0
80106bd4:	6a 00                	push   $0x0
  pushl $85
80106bd6:	6a 55                	push   $0x55
  jmp alltraps
80106bd8:	e9 2d f8 ff ff       	jmp    8010640a <alltraps>

80106bdd <vector86>:
.globl vector86
vector86:
  pushl $0
80106bdd:	6a 00                	push   $0x0
  pushl $86
80106bdf:	6a 56                	push   $0x56
  jmp alltraps
80106be1:	e9 24 f8 ff ff       	jmp    8010640a <alltraps>

80106be6 <vector87>:
.globl vector87
vector87:
  pushl $0
80106be6:	6a 00                	push   $0x0
  pushl $87
80106be8:	6a 57                	push   $0x57
  jmp alltraps
80106bea:	e9 1b f8 ff ff       	jmp    8010640a <alltraps>

80106bef <vector88>:
.globl vector88
vector88:
  pushl $0
80106bef:	6a 00                	push   $0x0
  pushl $88
80106bf1:	6a 58                	push   $0x58
  jmp alltraps
80106bf3:	e9 12 f8 ff ff       	jmp    8010640a <alltraps>

80106bf8 <vector89>:
.globl vector89
vector89:
  pushl $0
80106bf8:	6a 00                	push   $0x0
  pushl $89
80106bfa:	6a 59                	push   $0x59
  jmp alltraps
80106bfc:	e9 09 f8 ff ff       	jmp    8010640a <alltraps>

80106c01 <vector90>:
.globl vector90
vector90:
  pushl $0
80106c01:	6a 00                	push   $0x0
  pushl $90
80106c03:	6a 5a                	push   $0x5a
  jmp alltraps
80106c05:	e9 00 f8 ff ff       	jmp    8010640a <alltraps>

80106c0a <vector91>:
.globl vector91
vector91:
  pushl $0
80106c0a:	6a 00                	push   $0x0
  pushl $91
80106c0c:	6a 5b                	push   $0x5b
  jmp alltraps
80106c0e:	e9 f7 f7 ff ff       	jmp    8010640a <alltraps>

80106c13 <vector92>:
.globl vector92
vector92:
  pushl $0
80106c13:	6a 00                	push   $0x0
  pushl $92
80106c15:	6a 5c                	push   $0x5c
  jmp alltraps
80106c17:	e9 ee f7 ff ff       	jmp    8010640a <alltraps>

80106c1c <vector93>:
.globl vector93
vector93:
  pushl $0
80106c1c:	6a 00                	push   $0x0
  pushl $93
80106c1e:	6a 5d                	push   $0x5d
  jmp alltraps
80106c20:	e9 e5 f7 ff ff       	jmp    8010640a <alltraps>

80106c25 <vector94>:
.globl vector94
vector94:
  pushl $0
80106c25:	6a 00                	push   $0x0
  pushl $94
80106c27:	6a 5e                	push   $0x5e
  jmp alltraps
80106c29:	e9 dc f7 ff ff       	jmp    8010640a <alltraps>

80106c2e <vector95>:
.globl vector95
vector95:
  pushl $0
80106c2e:	6a 00                	push   $0x0
  pushl $95
80106c30:	6a 5f                	push   $0x5f
  jmp alltraps
80106c32:	e9 d3 f7 ff ff       	jmp    8010640a <alltraps>

80106c37 <vector96>:
.globl vector96
vector96:
  pushl $0
80106c37:	6a 00                	push   $0x0
  pushl $96
80106c39:	6a 60                	push   $0x60
  jmp alltraps
80106c3b:	e9 ca f7 ff ff       	jmp    8010640a <alltraps>

80106c40 <vector97>:
.globl vector97
vector97:
  pushl $0
80106c40:	6a 00                	push   $0x0
  pushl $97
80106c42:	6a 61                	push   $0x61
  jmp alltraps
80106c44:	e9 c1 f7 ff ff       	jmp    8010640a <alltraps>

80106c49 <vector98>:
.globl vector98
vector98:
  pushl $0
80106c49:	6a 00                	push   $0x0
  pushl $98
80106c4b:	6a 62                	push   $0x62
  jmp alltraps
80106c4d:	e9 b8 f7 ff ff       	jmp    8010640a <alltraps>

80106c52 <vector99>:
.globl vector99
vector99:
  pushl $0
80106c52:	6a 00                	push   $0x0
  pushl $99
80106c54:	6a 63                	push   $0x63
  jmp alltraps
80106c56:	e9 af f7 ff ff       	jmp    8010640a <alltraps>

80106c5b <vector100>:
.globl vector100
vector100:
  pushl $0
80106c5b:	6a 00                	push   $0x0
  pushl $100
80106c5d:	6a 64                	push   $0x64
  jmp alltraps
80106c5f:	e9 a6 f7 ff ff       	jmp    8010640a <alltraps>

80106c64 <vector101>:
.globl vector101
vector101:
  pushl $0
80106c64:	6a 00                	push   $0x0
  pushl $101
80106c66:	6a 65                	push   $0x65
  jmp alltraps
80106c68:	e9 9d f7 ff ff       	jmp    8010640a <alltraps>

80106c6d <vector102>:
.globl vector102
vector102:
  pushl $0
80106c6d:	6a 00                	push   $0x0
  pushl $102
80106c6f:	6a 66                	push   $0x66
  jmp alltraps
80106c71:	e9 94 f7 ff ff       	jmp    8010640a <alltraps>

80106c76 <vector103>:
.globl vector103
vector103:
  pushl $0
80106c76:	6a 00                	push   $0x0
  pushl $103
80106c78:	6a 67                	push   $0x67
  jmp alltraps
80106c7a:	e9 8b f7 ff ff       	jmp    8010640a <alltraps>

80106c7f <vector104>:
.globl vector104
vector104:
  pushl $0
80106c7f:	6a 00                	push   $0x0
  pushl $104
80106c81:	6a 68                	push   $0x68
  jmp alltraps
80106c83:	e9 82 f7 ff ff       	jmp    8010640a <alltraps>

80106c88 <vector105>:
.globl vector105
vector105:
  pushl $0
80106c88:	6a 00                	push   $0x0
  pushl $105
80106c8a:	6a 69                	push   $0x69
  jmp alltraps
80106c8c:	e9 79 f7 ff ff       	jmp    8010640a <alltraps>

80106c91 <vector106>:
.globl vector106
vector106:
  pushl $0
80106c91:	6a 00                	push   $0x0
  pushl $106
80106c93:	6a 6a                	push   $0x6a
  jmp alltraps
80106c95:	e9 70 f7 ff ff       	jmp    8010640a <alltraps>

80106c9a <vector107>:
.globl vector107
vector107:
  pushl $0
80106c9a:	6a 00                	push   $0x0
  pushl $107
80106c9c:	6a 6b                	push   $0x6b
  jmp alltraps
80106c9e:	e9 67 f7 ff ff       	jmp    8010640a <alltraps>

80106ca3 <vector108>:
.globl vector108
vector108:
  pushl $0
80106ca3:	6a 00                	push   $0x0
  pushl $108
80106ca5:	6a 6c                	push   $0x6c
  jmp alltraps
80106ca7:	e9 5e f7 ff ff       	jmp    8010640a <alltraps>

80106cac <vector109>:
.globl vector109
vector109:
  pushl $0
80106cac:	6a 00                	push   $0x0
  pushl $109
80106cae:	6a 6d                	push   $0x6d
  jmp alltraps
80106cb0:	e9 55 f7 ff ff       	jmp    8010640a <alltraps>

80106cb5 <vector110>:
.globl vector110
vector110:
  pushl $0
80106cb5:	6a 00                	push   $0x0
  pushl $110
80106cb7:	6a 6e                	push   $0x6e
  jmp alltraps
80106cb9:	e9 4c f7 ff ff       	jmp    8010640a <alltraps>

80106cbe <vector111>:
.globl vector111
vector111:
  pushl $0
80106cbe:	6a 00                	push   $0x0
  pushl $111
80106cc0:	6a 6f                	push   $0x6f
  jmp alltraps
80106cc2:	e9 43 f7 ff ff       	jmp    8010640a <alltraps>

80106cc7 <vector112>:
.globl vector112
vector112:
  pushl $0
80106cc7:	6a 00                	push   $0x0
  pushl $112
80106cc9:	6a 70                	push   $0x70
  jmp alltraps
80106ccb:	e9 3a f7 ff ff       	jmp    8010640a <alltraps>

80106cd0 <vector113>:
.globl vector113
vector113:
  pushl $0
80106cd0:	6a 00                	push   $0x0
  pushl $113
80106cd2:	6a 71                	push   $0x71
  jmp alltraps
80106cd4:	e9 31 f7 ff ff       	jmp    8010640a <alltraps>

80106cd9 <vector114>:
.globl vector114
vector114:
  pushl $0
80106cd9:	6a 00                	push   $0x0
  pushl $114
80106cdb:	6a 72                	push   $0x72
  jmp alltraps
80106cdd:	e9 28 f7 ff ff       	jmp    8010640a <alltraps>

80106ce2 <vector115>:
.globl vector115
vector115:
  pushl $0
80106ce2:	6a 00                	push   $0x0
  pushl $115
80106ce4:	6a 73                	push   $0x73
  jmp alltraps
80106ce6:	e9 1f f7 ff ff       	jmp    8010640a <alltraps>

80106ceb <vector116>:
.globl vector116
vector116:
  pushl $0
80106ceb:	6a 00                	push   $0x0
  pushl $116
80106ced:	6a 74                	push   $0x74
  jmp alltraps
80106cef:	e9 16 f7 ff ff       	jmp    8010640a <alltraps>

80106cf4 <vector117>:
.globl vector117
vector117:
  pushl $0
80106cf4:	6a 00                	push   $0x0
  pushl $117
80106cf6:	6a 75                	push   $0x75
  jmp alltraps
80106cf8:	e9 0d f7 ff ff       	jmp    8010640a <alltraps>

80106cfd <vector118>:
.globl vector118
vector118:
  pushl $0
80106cfd:	6a 00                	push   $0x0
  pushl $118
80106cff:	6a 76                	push   $0x76
  jmp alltraps
80106d01:	e9 04 f7 ff ff       	jmp    8010640a <alltraps>

80106d06 <vector119>:
.globl vector119
vector119:
  pushl $0
80106d06:	6a 00                	push   $0x0
  pushl $119
80106d08:	6a 77                	push   $0x77
  jmp alltraps
80106d0a:	e9 fb f6 ff ff       	jmp    8010640a <alltraps>

80106d0f <vector120>:
.globl vector120
vector120:
  pushl $0
80106d0f:	6a 00                	push   $0x0
  pushl $120
80106d11:	6a 78                	push   $0x78
  jmp alltraps
80106d13:	e9 f2 f6 ff ff       	jmp    8010640a <alltraps>

80106d18 <vector121>:
.globl vector121
vector121:
  pushl $0
80106d18:	6a 00                	push   $0x0
  pushl $121
80106d1a:	6a 79                	push   $0x79
  jmp alltraps
80106d1c:	e9 e9 f6 ff ff       	jmp    8010640a <alltraps>

80106d21 <vector122>:
.globl vector122
vector122:
  pushl $0
80106d21:	6a 00                	push   $0x0
  pushl $122
80106d23:	6a 7a                	push   $0x7a
  jmp alltraps
80106d25:	e9 e0 f6 ff ff       	jmp    8010640a <alltraps>

80106d2a <vector123>:
.globl vector123
vector123:
  pushl $0
80106d2a:	6a 00                	push   $0x0
  pushl $123
80106d2c:	6a 7b                	push   $0x7b
  jmp alltraps
80106d2e:	e9 d7 f6 ff ff       	jmp    8010640a <alltraps>

80106d33 <vector124>:
.globl vector124
vector124:
  pushl $0
80106d33:	6a 00                	push   $0x0
  pushl $124
80106d35:	6a 7c                	push   $0x7c
  jmp alltraps
80106d37:	e9 ce f6 ff ff       	jmp    8010640a <alltraps>

80106d3c <vector125>:
.globl vector125
vector125:
  pushl $0
80106d3c:	6a 00                	push   $0x0
  pushl $125
80106d3e:	6a 7d                	push   $0x7d
  jmp alltraps
80106d40:	e9 c5 f6 ff ff       	jmp    8010640a <alltraps>

80106d45 <vector126>:
.globl vector126
vector126:
  pushl $0
80106d45:	6a 00                	push   $0x0
  pushl $126
80106d47:	6a 7e                	push   $0x7e
  jmp alltraps
80106d49:	e9 bc f6 ff ff       	jmp    8010640a <alltraps>

80106d4e <vector127>:
.globl vector127
vector127:
  pushl $0
80106d4e:	6a 00                	push   $0x0
  pushl $127
80106d50:	6a 7f                	push   $0x7f
  jmp alltraps
80106d52:	e9 b3 f6 ff ff       	jmp    8010640a <alltraps>

80106d57 <vector128>:
.globl vector128
vector128:
  pushl $0
80106d57:	6a 00                	push   $0x0
  pushl $128
80106d59:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106d5e:	e9 a7 f6 ff ff       	jmp    8010640a <alltraps>

80106d63 <vector129>:
.globl vector129
vector129:
  pushl $0
80106d63:	6a 00                	push   $0x0
  pushl $129
80106d65:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106d6a:	e9 9b f6 ff ff       	jmp    8010640a <alltraps>

80106d6f <vector130>:
.globl vector130
vector130:
  pushl $0
80106d6f:	6a 00                	push   $0x0
  pushl $130
80106d71:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106d76:	e9 8f f6 ff ff       	jmp    8010640a <alltraps>

80106d7b <vector131>:
.globl vector131
vector131:
  pushl $0
80106d7b:	6a 00                	push   $0x0
  pushl $131
80106d7d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106d82:	e9 83 f6 ff ff       	jmp    8010640a <alltraps>

80106d87 <vector132>:
.globl vector132
vector132:
  pushl $0
80106d87:	6a 00                	push   $0x0
  pushl $132
80106d89:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106d8e:	e9 77 f6 ff ff       	jmp    8010640a <alltraps>

80106d93 <vector133>:
.globl vector133
vector133:
  pushl $0
80106d93:	6a 00                	push   $0x0
  pushl $133
80106d95:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106d9a:	e9 6b f6 ff ff       	jmp    8010640a <alltraps>

80106d9f <vector134>:
.globl vector134
vector134:
  pushl $0
80106d9f:	6a 00                	push   $0x0
  pushl $134
80106da1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106da6:	e9 5f f6 ff ff       	jmp    8010640a <alltraps>

80106dab <vector135>:
.globl vector135
vector135:
  pushl $0
80106dab:	6a 00                	push   $0x0
  pushl $135
80106dad:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106db2:	e9 53 f6 ff ff       	jmp    8010640a <alltraps>

80106db7 <vector136>:
.globl vector136
vector136:
  pushl $0
80106db7:	6a 00                	push   $0x0
  pushl $136
80106db9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106dbe:	e9 47 f6 ff ff       	jmp    8010640a <alltraps>

80106dc3 <vector137>:
.globl vector137
vector137:
  pushl $0
80106dc3:	6a 00                	push   $0x0
  pushl $137
80106dc5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106dca:	e9 3b f6 ff ff       	jmp    8010640a <alltraps>

80106dcf <vector138>:
.globl vector138
vector138:
  pushl $0
80106dcf:	6a 00                	push   $0x0
  pushl $138
80106dd1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106dd6:	e9 2f f6 ff ff       	jmp    8010640a <alltraps>

80106ddb <vector139>:
.globl vector139
vector139:
  pushl $0
80106ddb:	6a 00                	push   $0x0
  pushl $139
80106ddd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106de2:	e9 23 f6 ff ff       	jmp    8010640a <alltraps>

80106de7 <vector140>:
.globl vector140
vector140:
  pushl $0
80106de7:	6a 00                	push   $0x0
  pushl $140
80106de9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106dee:	e9 17 f6 ff ff       	jmp    8010640a <alltraps>

80106df3 <vector141>:
.globl vector141
vector141:
  pushl $0
80106df3:	6a 00                	push   $0x0
  pushl $141
80106df5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106dfa:	e9 0b f6 ff ff       	jmp    8010640a <alltraps>

80106dff <vector142>:
.globl vector142
vector142:
  pushl $0
80106dff:	6a 00                	push   $0x0
  pushl $142
80106e01:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106e06:	e9 ff f5 ff ff       	jmp    8010640a <alltraps>

80106e0b <vector143>:
.globl vector143
vector143:
  pushl $0
80106e0b:	6a 00                	push   $0x0
  pushl $143
80106e0d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106e12:	e9 f3 f5 ff ff       	jmp    8010640a <alltraps>

80106e17 <vector144>:
.globl vector144
vector144:
  pushl $0
80106e17:	6a 00                	push   $0x0
  pushl $144
80106e19:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106e1e:	e9 e7 f5 ff ff       	jmp    8010640a <alltraps>

80106e23 <vector145>:
.globl vector145
vector145:
  pushl $0
80106e23:	6a 00                	push   $0x0
  pushl $145
80106e25:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106e2a:	e9 db f5 ff ff       	jmp    8010640a <alltraps>

80106e2f <vector146>:
.globl vector146
vector146:
  pushl $0
80106e2f:	6a 00                	push   $0x0
  pushl $146
80106e31:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106e36:	e9 cf f5 ff ff       	jmp    8010640a <alltraps>

80106e3b <vector147>:
.globl vector147
vector147:
  pushl $0
80106e3b:	6a 00                	push   $0x0
  pushl $147
80106e3d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106e42:	e9 c3 f5 ff ff       	jmp    8010640a <alltraps>

80106e47 <vector148>:
.globl vector148
vector148:
  pushl $0
80106e47:	6a 00                	push   $0x0
  pushl $148
80106e49:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106e4e:	e9 b7 f5 ff ff       	jmp    8010640a <alltraps>

80106e53 <vector149>:
.globl vector149
vector149:
  pushl $0
80106e53:	6a 00                	push   $0x0
  pushl $149
80106e55:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106e5a:	e9 ab f5 ff ff       	jmp    8010640a <alltraps>

80106e5f <vector150>:
.globl vector150
vector150:
  pushl $0
80106e5f:	6a 00                	push   $0x0
  pushl $150
80106e61:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106e66:	e9 9f f5 ff ff       	jmp    8010640a <alltraps>

80106e6b <vector151>:
.globl vector151
vector151:
  pushl $0
80106e6b:	6a 00                	push   $0x0
  pushl $151
80106e6d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106e72:	e9 93 f5 ff ff       	jmp    8010640a <alltraps>

80106e77 <vector152>:
.globl vector152
vector152:
  pushl $0
80106e77:	6a 00                	push   $0x0
  pushl $152
80106e79:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106e7e:	e9 87 f5 ff ff       	jmp    8010640a <alltraps>

80106e83 <vector153>:
.globl vector153
vector153:
  pushl $0
80106e83:	6a 00                	push   $0x0
  pushl $153
80106e85:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106e8a:	e9 7b f5 ff ff       	jmp    8010640a <alltraps>

80106e8f <vector154>:
.globl vector154
vector154:
  pushl $0
80106e8f:	6a 00                	push   $0x0
  pushl $154
80106e91:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106e96:	e9 6f f5 ff ff       	jmp    8010640a <alltraps>

80106e9b <vector155>:
.globl vector155
vector155:
  pushl $0
80106e9b:	6a 00                	push   $0x0
  pushl $155
80106e9d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106ea2:	e9 63 f5 ff ff       	jmp    8010640a <alltraps>

80106ea7 <vector156>:
.globl vector156
vector156:
  pushl $0
80106ea7:	6a 00                	push   $0x0
  pushl $156
80106ea9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106eae:	e9 57 f5 ff ff       	jmp    8010640a <alltraps>

80106eb3 <vector157>:
.globl vector157
vector157:
  pushl $0
80106eb3:	6a 00                	push   $0x0
  pushl $157
80106eb5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106eba:	e9 4b f5 ff ff       	jmp    8010640a <alltraps>

80106ebf <vector158>:
.globl vector158
vector158:
  pushl $0
80106ebf:	6a 00                	push   $0x0
  pushl $158
80106ec1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106ec6:	e9 3f f5 ff ff       	jmp    8010640a <alltraps>

80106ecb <vector159>:
.globl vector159
vector159:
  pushl $0
80106ecb:	6a 00                	push   $0x0
  pushl $159
80106ecd:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106ed2:	e9 33 f5 ff ff       	jmp    8010640a <alltraps>

80106ed7 <vector160>:
.globl vector160
vector160:
  pushl $0
80106ed7:	6a 00                	push   $0x0
  pushl $160
80106ed9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106ede:	e9 27 f5 ff ff       	jmp    8010640a <alltraps>

80106ee3 <vector161>:
.globl vector161
vector161:
  pushl $0
80106ee3:	6a 00                	push   $0x0
  pushl $161
80106ee5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106eea:	e9 1b f5 ff ff       	jmp    8010640a <alltraps>

80106eef <vector162>:
.globl vector162
vector162:
  pushl $0
80106eef:	6a 00                	push   $0x0
  pushl $162
80106ef1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106ef6:	e9 0f f5 ff ff       	jmp    8010640a <alltraps>

80106efb <vector163>:
.globl vector163
vector163:
  pushl $0
80106efb:	6a 00                	push   $0x0
  pushl $163
80106efd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106f02:	e9 03 f5 ff ff       	jmp    8010640a <alltraps>

80106f07 <vector164>:
.globl vector164
vector164:
  pushl $0
80106f07:	6a 00                	push   $0x0
  pushl $164
80106f09:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106f0e:	e9 f7 f4 ff ff       	jmp    8010640a <alltraps>

80106f13 <vector165>:
.globl vector165
vector165:
  pushl $0
80106f13:	6a 00                	push   $0x0
  pushl $165
80106f15:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106f1a:	e9 eb f4 ff ff       	jmp    8010640a <alltraps>

80106f1f <vector166>:
.globl vector166
vector166:
  pushl $0
80106f1f:	6a 00                	push   $0x0
  pushl $166
80106f21:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106f26:	e9 df f4 ff ff       	jmp    8010640a <alltraps>

80106f2b <vector167>:
.globl vector167
vector167:
  pushl $0
80106f2b:	6a 00                	push   $0x0
  pushl $167
80106f2d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106f32:	e9 d3 f4 ff ff       	jmp    8010640a <alltraps>

80106f37 <vector168>:
.globl vector168
vector168:
  pushl $0
80106f37:	6a 00                	push   $0x0
  pushl $168
80106f39:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106f3e:	e9 c7 f4 ff ff       	jmp    8010640a <alltraps>

80106f43 <vector169>:
.globl vector169
vector169:
  pushl $0
80106f43:	6a 00                	push   $0x0
  pushl $169
80106f45:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106f4a:	e9 bb f4 ff ff       	jmp    8010640a <alltraps>

80106f4f <vector170>:
.globl vector170
vector170:
  pushl $0
80106f4f:	6a 00                	push   $0x0
  pushl $170
80106f51:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106f56:	e9 af f4 ff ff       	jmp    8010640a <alltraps>

80106f5b <vector171>:
.globl vector171
vector171:
  pushl $0
80106f5b:	6a 00                	push   $0x0
  pushl $171
80106f5d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106f62:	e9 a3 f4 ff ff       	jmp    8010640a <alltraps>

80106f67 <vector172>:
.globl vector172
vector172:
  pushl $0
80106f67:	6a 00                	push   $0x0
  pushl $172
80106f69:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106f6e:	e9 97 f4 ff ff       	jmp    8010640a <alltraps>

80106f73 <vector173>:
.globl vector173
vector173:
  pushl $0
80106f73:	6a 00                	push   $0x0
  pushl $173
80106f75:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106f7a:	e9 8b f4 ff ff       	jmp    8010640a <alltraps>

80106f7f <vector174>:
.globl vector174
vector174:
  pushl $0
80106f7f:	6a 00                	push   $0x0
  pushl $174
80106f81:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106f86:	e9 7f f4 ff ff       	jmp    8010640a <alltraps>

80106f8b <vector175>:
.globl vector175
vector175:
  pushl $0
80106f8b:	6a 00                	push   $0x0
  pushl $175
80106f8d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106f92:	e9 73 f4 ff ff       	jmp    8010640a <alltraps>

80106f97 <vector176>:
.globl vector176
vector176:
  pushl $0
80106f97:	6a 00                	push   $0x0
  pushl $176
80106f99:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106f9e:	e9 67 f4 ff ff       	jmp    8010640a <alltraps>

80106fa3 <vector177>:
.globl vector177
vector177:
  pushl $0
80106fa3:	6a 00                	push   $0x0
  pushl $177
80106fa5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106faa:	e9 5b f4 ff ff       	jmp    8010640a <alltraps>

80106faf <vector178>:
.globl vector178
vector178:
  pushl $0
80106faf:	6a 00                	push   $0x0
  pushl $178
80106fb1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106fb6:	e9 4f f4 ff ff       	jmp    8010640a <alltraps>

80106fbb <vector179>:
.globl vector179
vector179:
  pushl $0
80106fbb:	6a 00                	push   $0x0
  pushl $179
80106fbd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106fc2:	e9 43 f4 ff ff       	jmp    8010640a <alltraps>

80106fc7 <vector180>:
.globl vector180
vector180:
  pushl $0
80106fc7:	6a 00                	push   $0x0
  pushl $180
80106fc9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106fce:	e9 37 f4 ff ff       	jmp    8010640a <alltraps>

80106fd3 <vector181>:
.globl vector181
vector181:
  pushl $0
80106fd3:	6a 00                	push   $0x0
  pushl $181
80106fd5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106fda:	e9 2b f4 ff ff       	jmp    8010640a <alltraps>

80106fdf <vector182>:
.globl vector182
vector182:
  pushl $0
80106fdf:	6a 00                	push   $0x0
  pushl $182
80106fe1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106fe6:	e9 1f f4 ff ff       	jmp    8010640a <alltraps>

80106feb <vector183>:
.globl vector183
vector183:
  pushl $0
80106feb:	6a 00                	push   $0x0
  pushl $183
80106fed:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106ff2:	e9 13 f4 ff ff       	jmp    8010640a <alltraps>

80106ff7 <vector184>:
.globl vector184
vector184:
  pushl $0
80106ff7:	6a 00                	push   $0x0
  pushl $184
80106ff9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106ffe:	e9 07 f4 ff ff       	jmp    8010640a <alltraps>

80107003 <vector185>:
.globl vector185
vector185:
  pushl $0
80107003:	6a 00                	push   $0x0
  pushl $185
80107005:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010700a:	e9 fb f3 ff ff       	jmp    8010640a <alltraps>

8010700f <vector186>:
.globl vector186
vector186:
  pushl $0
8010700f:	6a 00                	push   $0x0
  pushl $186
80107011:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107016:	e9 ef f3 ff ff       	jmp    8010640a <alltraps>

8010701b <vector187>:
.globl vector187
vector187:
  pushl $0
8010701b:	6a 00                	push   $0x0
  pushl $187
8010701d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107022:	e9 e3 f3 ff ff       	jmp    8010640a <alltraps>

80107027 <vector188>:
.globl vector188
vector188:
  pushl $0
80107027:	6a 00                	push   $0x0
  pushl $188
80107029:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010702e:	e9 d7 f3 ff ff       	jmp    8010640a <alltraps>

80107033 <vector189>:
.globl vector189
vector189:
  pushl $0
80107033:	6a 00                	push   $0x0
  pushl $189
80107035:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010703a:	e9 cb f3 ff ff       	jmp    8010640a <alltraps>

8010703f <vector190>:
.globl vector190
vector190:
  pushl $0
8010703f:	6a 00                	push   $0x0
  pushl $190
80107041:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107046:	e9 bf f3 ff ff       	jmp    8010640a <alltraps>

8010704b <vector191>:
.globl vector191
vector191:
  pushl $0
8010704b:	6a 00                	push   $0x0
  pushl $191
8010704d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107052:	e9 b3 f3 ff ff       	jmp    8010640a <alltraps>

80107057 <vector192>:
.globl vector192
vector192:
  pushl $0
80107057:	6a 00                	push   $0x0
  pushl $192
80107059:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010705e:	e9 a7 f3 ff ff       	jmp    8010640a <alltraps>

80107063 <vector193>:
.globl vector193
vector193:
  pushl $0
80107063:	6a 00                	push   $0x0
  pushl $193
80107065:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010706a:	e9 9b f3 ff ff       	jmp    8010640a <alltraps>

8010706f <vector194>:
.globl vector194
vector194:
  pushl $0
8010706f:	6a 00                	push   $0x0
  pushl $194
80107071:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107076:	e9 8f f3 ff ff       	jmp    8010640a <alltraps>

8010707b <vector195>:
.globl vector195
vector195:
  pushl $0
8010707b:	6a 00                	push   $0x0
  pushl $195
8010707d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107082:	e9 83 f3 ff ff       	jmp    8010640a <alltraps>

80107087 <vector196>:
.globl vector196
vector196:
  pushl $0
80107087:	6a 00                	push   $0x0
  pushl $196
80107089:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010708e:	e9 77 f3 ff ff       	jmp    8010640a <alltraps>

80107093 <vector197>:
.globl vector197
vector197:
  pushl $0
80107093:	6a 00                	push   $0x0
  pushl $197
80107095:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010709a:	e9 6b f3 ff ff       	jmp    8010640a <alltraps>

8010709f <vector198>:
.globl vector198
vector198:
  pushl $0
8010709f:	6a 00                	push   $0x0
  pushl $198
801070a1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801070a6:	e9 5f f3 ff ff       	jmp    8010640a <alltraps>

801070ab <vector199>:
.globl vector199
vector199:
  pushl $0
801070ab:	6a 00                	push   $0x0
  pushl $199
801070ad:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801070b2:	e9 53 f3 ff ff       	jmp    8010640a <alltraps>

801070b7 <vector200>:
.globl vector200
vector200:
  pushl $0
801070b7:	6a 00                	push   $0x0
  pushl $200
801070b9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801070be:	e9 47 f3 ff ff       	jmp    8010640a <alltraps>

801070c3 <vector201>:
.globl vector201
vector201:
  pushl $0
801070c3:	6a 00                	push   $0x0
  pushl $201
801070c5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801070ca:	e9 3b f3 ff ff       	jmp    8010640a <alltraps>

801070cf <vector202>:
.globl vector202
vector202:
  pushl $0
801070cf:	6a 00                	push   $0x0
  pushl $202
801070d1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801070d6:	e9 2f f3 ff ff       	jmp    8010640a <alltraps>

801070db <vector203>:
.globl vector203
vector203:
  pushl $0
801070db:	6a 00                	push   $0x0
  pushl $203
801070dd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801070e2:	e9 23 f3 ff ff       	jmp    8010640a <alltraps>

801070e7 <vector204>:
.globl vector204
vector204:
  pushl $0
801070e7:	6a 00                	push   $0x0
  pushl $204
801070e9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801070ee:	e9 17 f3 ff ff       	jmp    8010640a <alltraps>

801070f3 <vector205>:
.globl vector205
vector205:
  pushl $0
801070f3:	6a 00                	push   $0x0
  pushl $205
801070f5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801070fa:	e9 0b f3 ff ff       	jmp    8010640a <alltraps>

801070ff <vector206>:
.globl vector206
vector206:
  pushl $0
801070ff:	6a 00                	push   $0x0
  pushl $206
80107101:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107106:	e9 ff f2 ff ff       	jmp    8010640a <alltraps>

8010710b <vector207>:
.globl vector207
vector207:
  pushl $0
8010710b:	6a 00                	push   $0x0
  pushl $207
8010710d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107112:	e9 f3 f2 ff ff       	jmp    8010640a <alltraps>

80107117 <vector208>:
.globl vector208
vector208:
  pushl $0
80107117:	6a 00                	push   $0x0
  pushl $208
80107119:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010711e:	e9 e7 f2 ff ff       	jmp    8010640a <alltraps>

80107123 <vector209>:
.globl vector209
vector209:
  pushl $0
80107123:	6a 00                	push   $0x0
  pushl $209
80107125:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010712a:	e9 db f2 ff ff       	jmp    8010640a <alltraps>

8010712f <vector210>:
.globl vector210
vector210:
  pushl $0
8010712f:	6a 00                	push   $0x0
  pushl $210
80107131:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107136:	e9 cf f2 ff ff       	jmp    8010640a <alltraps>

8010713b <vector211>:
.globl vector211
vector211:
  pushl $0
8010713b:	6a 00                	push   $0x0
  pushl $211
8010713d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107142:	e9 c3 f2 ff ff       	jmp    8010640a <alltraps>

80107147 <vector212>:
.globl vector212
vector212:
  pushl $0
80107147:	6a 00                	push   $0x0
  pushl $212
80107149:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010714e:	e9 b7 f2 ff ff       	jmp    8010640a <alltraps>

80107153 <vector213>:
.globl vector213
vector213:
  pushl $0
80107153:	6a 00                	push   $0x0
  pushl $213
80107155:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010715a:	e9 ab f2 ff ff       	jmp    8010640a <alltraps>

8010715f <vector214>:
.globl vector214
vector214:
  pushl $0
8010715f:	6a 00                	push   $0x0
  pushl $214
80107161:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107166:	e9 9f f2 ff ff       	jmp    8010640a <alltraps>

8010716b <vector215>:
.globl vector215
vector215:
  pushl $0
8010716b:	6a 00                	push   $0x0
  pushl $215
8010716d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107172:	e9 93 f2 ff ff       	jmp    8010640a <alltraps>

80107177 <vector216>:
.globl vector216
vector216:
  pushl $0
80107177:	6a 00                	push   $0x0
  pushl $216
80107179:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010717e:	e9 87 f2 ff ff       	jmp    8010640a <alltraps>

80107183 <vector217>:
.globl vector217
vector217:
  pushl $0
80107183:	6a 00                	push   $0x0
  pushl $217
80107185:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010718a:	e9 7b f2 ff ff       	jmp    8010640a <alltraps>

8010718f <vector218>:
.globl vector218
vector218:
  pushl $0
8010718f:	6a 00                	push   $0x0
  pushl $218
80107191:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107196:	e9 6f f2 ff ff       	jmp    8010640a <alltraps>

8010719b <vector219>:
.globl vector219
vector219:
  pushl $0
8010719b:	6a 00                	push   $0x0
  pushl $219
8010719d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801071a2:	e9 63 f2 ff ff       	jmp    8010640a <alltraps>

801071a7 <vector220>:
.globl vector220
vector220:
  pushl $0
801071a7:	6a 00                	push   $0x0
  pushl $220
801071a9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801071ae:	e9 57 f2 ff ff       	jmp    8010640a <alltraps>

801071b3 <vector221>:
.globl vector221
vector221:
  pushl $0
801071b3:	6a 00                	push   $0x0
  pushl $221
801071b5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801071ba:	e9 4b f2 ff ff       	jmp    8010640a <alltraps>

801071bf <vector222>:
.globl vector222
vector222:
  pushl $0
801071bf:	6a 00                	push   $0x0
  pushl $222
801071c1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801071c6:	e9 3f f2 ff ff       	jmp    8010640a <alltraps>

801071cb <vector223>:
.globl vector223
vector223:
  pushl $0
801071cb:	6a 00                	push   $0x0
  pushl $223
801071cd:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801071d2:	e9 33 f2 ff ff       	jmp    8010640a <alltraps>

801071d7 <vector224>:
.globl vector224
vector224:
  pushl $0
801071d7:	6a 00                	push   $0x0
  pushl $224
801071d9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801071de:	e9 27 f2 ff ff       	jmp    8010640a <alltraps>

801071e3 <vector225>:
.globl vector225
vector225:
  pushl $0
801071e3:	6a 00                	push   $0x0
  pushl $225
801071e5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801071ea:	e9 1b f2 ff ff       	jmp    8010640a <alltraps>

801071ef <vector226>:
.globl vector226
vector226:
  pushl $0
801071ef:	6a 00                	push   $0x0
  pushl $226
801071f1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801071f6:	e9 0f f2 ff ff       	jmp    8010640a <alltraps>

801071fb <vector227>:
.globl vector227
vector227:
  pushl $0
801071fb:	6a 00                	push   $0x0
  pushl $227
801071fd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107202:	e9 03 f2 ff ff       	jmp    8010640a <alltraps>

80107207 <vector228>:
.globl vector228
vector228:
  pushl $0
80107207:	6a 00                	push   $0x0
  pushl $228
80107209:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010720e:	e9 f7 f1 ff ff       	jmp    8010640a <alltraps>

80107213 <vector229>:
.globl vector229
vector229:
  pushl $0
80107213:	6a 00                	push   $0x0
  pushl $229
80107215:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010721a:	e9 eb f1 ff ff       	jmp    8010640a <alltraps>

8010721f <vector230>:
.globl vector230
vector230:
  pushl $0
8010721f:	6a 00                	push   $0x0
  pushl $230
80107221:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107226:	e9 df f1 ff ff       	jmp    8010640a <alltraps>

8010722b <vector231>:
.globl vector231
vector231:
  pushl $0
8010722b:	6a 00                	push   $0x0
  pushl $231
8010722d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107232:	e9 d3 f1 ff ff       	jmp    8010640a <alltraps>

80107237 <vector232>:
.globl vector232
vector232:
  pushl $0
80107237:	6a 00                	push   $0x0
  pushl $232
80107239:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010723e:	e9 c7 f1 ff ff       	jmp    8010640a <alltraps>

80107243 <vector233>:
.globl vector233
vector233:
  pushl $0
80107243:	6a 00                	push   $0x0
  pushl $233
80107245:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010724a:	e9 bb f1 ff ff       	jmp    8010640a <alltraps>

8010724f <vector234>:
.globl vector234
vector234:
  pushl $0
8010724f:	6a 00                	push   $0x0
  pushl $234
80107251:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107256:	e9 af f1 ff ff       	jmp    8010640a <alltraps>

8010725b <vector235>:
.globl vector235
vector235:
  pushl $0
8010725b:	6a 00                	push   $0x0
  pushl $235
8010725d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107262:	e9 a3 f1 ff ff       	jmp    8010640a <alltraps>

80107267 <vector236>:
.globl vector236
vector236:
  pushl $0
80107267:	6a 00                	push   $0x0
  pushl $236
80107269:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010726e:	e9 97 f1 ff ff       	jmp    8010640a <alltraps>

80107273 <vector237>:
.globl vector237
vector237:
  pushl $0
80107273:	6a 00                	push   $0x0
  pushl $237
80107275:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010727a:	e9 8b f1 ff ff       	jmp    8010640a <alltraps>

8010727f <vector238>:
.globl vector238
vector238:
  pushl $0
8010727f:	6a 00                	push   $0x0
  pushl $238
80107281:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107286:	e9 7f f1 ff ff       	jmp    8010640a <alltraps>

8010728b <vector239>:
.globl vector239
vector239:
  pushl $0
8010728b:	6a 00                	push   $0x0
  pushl $239
8010728d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107292:	e9 73 f1 ff ff       	jmp    8010640a <alltraps>

80107297 <vector240>:
.globl vector240
vector240:
  pushl $0
80107297:	6a 00                	push   $0x0
  pushl $240
80107299:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010729e:	e9 67 f1 ff ff       	jmp    8010640a <alltraps>

801072a3 <vector241>:
.globl vector241
vector241:
  pushl $0
801072a3:	6a 00                	push   $0x0
  pushl $241
801072a5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801072aa:	e9 5b f1 ff ff       	jmp    8010640a <alltraps>

801072af <vector242>:
.globl vector242
vector242:
  pushl $0
801072af:	6a 00                	push   $0x0
  pushl $242
801072b1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801072b6:	e9 4f f1 ff ff       	jmp    8010640a <alltraps>

801072bb <vector243>:
.globl vector243
vector243:
  pushl $0
801072bb:	6a 00                	push   $0x0
  pushl $243
801072bd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801072c2:	e9 43 f1 ff ff       	jmp    8010640a <alltraps>

801072c7 <vector244>:
.globl vector244
vector244:
  pushl $0
801072c7:	6a 00                	push   $0x0
  pushl $244
801072c9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801072ce:	e9 37 f1 ff ff       	jmp    8010640a <alltraps>

801072d3 <vector245>:
.globl vector245
vector245:
  pushl $0
801072d3:	6a 00                	push   $0x0
  pushl $245
801072d5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801072da:	e9 2b f1 ff ff       	jmp    8010640a <alltraps>

801072df <vector246>:
.globl vector246
vector246:
  pushl $0
801072df:	6a 00                	push   $0x0
  pushl $246
801072e1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801072e6:	e9 1f f1 ff ff       	jmp    8010640a <alltraps>

801072eb <vector247>:
.globl vector247
vector247:
  pushl $0
801072eb:	6a 00                	push   $0x0
  pushl $247
801072ed:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801072f2:	e9 13 f1 ff ff       	jmp    8010640a <alltraps>

801072f7 <vector248>:
.globl vector248
vector248:
  pushl $0
801072f7:	6a 00                	push   $0x0
  pushl $248
801072f9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801072fe:	e9 07 f1 ff ff       	jmp    8010640a <alltraps>

80107303 <vector249>:
.globl vector249
vector249:
  pushl $0
80107303:	6a 00                	push   $0x0
  pushl $249
80107305:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010730a:	e9 fb f0 ff ff       	jmp    8010640a <alltraps>

8010730f <vector250>:
.globl vector250
vector250:
  pushl $0
8010730f:	6a 00                	push   $0x0
  pushl $250
80107311:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107316:	e9 ef f0 ff ff       	jmp    8010640a <alltraps>

8010731b <vector251>:
.globl vector251
vector251:
  pushl $0
8010731b:	6a 00                	push   $0x0
  pushl $251
8010731d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107322:	e9 e3 f0 ff ff       	jmp    8010640a <alltraps>

80107327 <vector252>:
.globl vector252
vector252:
  pushl $0
80107327:	6a 00                	push   $0x0
  pushl $252
80107329:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010732e:	e9 d7 f0 ff ff       	jmp    8010640a <alltraps>

80107333 <vector253>:
.globl vector253
vector253:
  pushl $0
80107333:	6a 00                	push   $0x0
  pushl $253
80107335:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010733a:	e9 cb f0 ff ff       	jmp    8010640a <alltraps>

8010733f <vector254>:
.globl vector254
vector254:
  pushl $0
8010733f:	6a 00                	push   $0x0
  pushl $254
80107341:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107346:	e9 bf f0 ff ff       	jmp    8010640a <alltraps>

8010734b <vector255>:
.globl vector255
vector255:
  pushl $0
8010734b:	6a 00                	push   $0x0
  pushl $255
8010734d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107352:	e9 b3 f0 ff ff       	jmp    8010640a <alltraps>
80107357:	66 90                	xchg   %ax,%ax
80107359:	66 90                	xchg   %ax,%ax
8010735b:	66 90                	xchg   %ax,%ax
8010735d:	66 90                	xchg   %ax,%ax
8010735f:	90                   	nop

80107360 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107360:	55                   	push   %ebp
80107361:	89 e5                	mov    %esp,%ebp
80107363:	57                   	push   %edi
80107364:	56                   	push   %esi
80107365:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107366:	89 d3                	mov    %edx,%ebx
{
80107368:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
8010736a:	c1 eb 16             	shr    $0x16,%ebx
8010736d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80107370:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80107373:	8b 06                	mov    (%esi),%eax
80107375:	a8 01                	test   $0x1,%al
80107377:	74 27                	je     801073a0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107379:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010737e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107384:	c1 ef 0a             	shr    $0xa,%edi
}
80107387:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
8010738a:	89 fa                	mov    %edi,%edx
8010738c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107392:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80107395:	5b                   	pop    %ebx
80107396:	5e                   	pop    %esi
80107397:	5f                   	pop    %edi
80107398:	5d                   	pop    %ebp
80107399:	c3                   	ret    
8010739a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801073a0:	85 c9                	test   %ecx,%ecx
801073a2:	74 2c                	je     801073d0 <walkpgdir+0x70>
801073a4:	e8 37 b1 ff ff       	call   801024e0 <kalloc>
801073a9:	85 c0                	test   %eax,%eax
801073ab:	89 c3                	mov    %eax,%ebx
801073ad:	74 21                	je     801073d0 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
801073af:	83 ec 04             	sub    $0x4,%esp
801073b2:	68 00 10 00 00       	push   $0x1000
801073b7:	6a 00                	push   $0x0
801073b9:	50                   	push   %eax
801073ba:	e8 f1 d3 ff ff       	call   801047b0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801073bf:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801073c5:	83 c4 10             	add    $0x10,%esp
801073c8:	83 c8 07             	or     $0x7,%eax
801073cb:	89 06                	mov    %eax,(%esi)
801073cd:	eb b5                	jmp    80107384 <walkpgdir+0x24>
801073cf:	90                   	nop
}
801073d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
801073d3:	31 c0                	xor    %eax,%eax
}
801073d5:	5b                   	pop    %ebx
801073d6:	5e                   	pop    %esi
801073d7:	5f                   	pop    %edi
801073d8:	5d                   	pop    %ebp
801073d9:	c3                   	ret    
801073da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801073e0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801073e0:	55                   	push   %ebp
801073e1:	89 e5                	mov    %esp,%ebp
801073e3:	57                   	push   %edi
801073e4:	56                   	push   %esi
801073e5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801073e6:	89 d3                	mov    %edx,%ebx
801073e8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
801073ee:	83 ec 1c             	sub    $0x1c,%esp
801073f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801073f4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801073f8:	8b 7d 08             	mov    0x8(%ebp),%edi
801073fb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107400:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80107403:	8b 45 0c             	mov    0xc(%ebp),%eax
80107406:	29 df                	sub    %ebx,%edi
80107408:	83 c8 01             	or     $0x1,%eax
8010740b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010740e:	eb 15                	jmp    80107425 <mappages+0x45>
    if(*pte & PTE_P)
80107410:	f6 00 01             	testb  $0x1,(%eax)
80107413:	75 45                	jne    8010745a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80107415:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80107418:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
8010741b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010741d:	74 31                	je     80107450 <mappages+0x70>
      break;
    a += PGSIZE;
8010741f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107425:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107428:	b9 01 00 00 00       	mov    $0x1,%ecx
8010742d:	89 da                	mov    %ebx,%edx
8010742f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80107432:	e8 29 ff ff ff       	call   80107360 <walkpgdir>
80107437:	85 c0                	test   %eax,%eax
80107439:	75 d5                	jne    80107410 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010743b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010743e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107443:	5b                   	pop    %ebx
80107444:	5e                   	pop    %esi
80107445:	5f                   	pop    %edi
80107446:	5d                   	pop    %ebp
80107447:	c3                   	ret    
80107448:	90                   	nop
80107449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107450:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107453:	31 c0                	xor    %eax,%eax
}
80107455:	5b                   	pop    %ebx
80107456:	5e                   	pop    %esi
80107457:	5f                   	pop    %edi
80107458:	5d                   	pop    %ebp
80107459:	c3                   	ret    
      panic("remap");
8010745a:	83 ec 0c             	sub    $0xc,%esp
8010745d:	68 fc 87 10 80       	push   $0x801087fc
80107462:	e8 29 8f ff ff       	call   80100390 <panic>
80107467:	89 f6                	mov    %esi,%esi
80107469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107470 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107470:	55                   	push   %ebp
80107471:	89 e5                	mov    %esp,%ebp
80107473:	57                   	push   %edi
80107474:	56                   	push   %esi
80107475:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107476:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010747c:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
8010747e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107484:	83 ec 1c             	sub    $0x1c,%esp
80107487:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010748a:	39 d3                	cmp    %edx,%ebx
8010748c:	73 66                	jae    801074f4 <deallocuvm.part.0+0x84>
8010748e:	89 d6                	mov    %edx,%esi
80107490:	eb 3d                	jmp    801074cf <deallocuvm.part.0+0x5f>
80107492:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80107498:	8b 10                	mov    (%eax),%edx
8010749a:	f6 c2 01             	test   $0x1,%dl
8010749d:	74 26                	je     801074c5 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010749f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801074a5:	74 58                	je     801074ff <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
801074a7:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
801074aa:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801074b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
801074b3:	52                   	push   %edx
801074b4:	e8 77 ae ff ff       	call   80102330 <kfree>
      *pte = 0;
801074b9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801074bc:	83 c4 10             	add    $0x10,%esp
801074bf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
801074c5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801074cb:	39 f3                	cmp    %esi,%ebx
801074cd:	73 25                	jae    801074f4 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
801074cf:	31 c9                	xor    %ecx,%ecx
801074d1:	89 da                	mov    %ebx,%edx
801074d3:	89 f8                	mov    %edi,%eax
801074d5:	e8 86 fe ff ff       	call   80107360 <walkpgdir>
    if(!pte)
801074da:	85 c0                	test   %eax,%eax
801074dc:	75 ba                	jne    80107498 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801074de:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
801074e4:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801074ea:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801074f0:	39 f3                	cmp    %esi,%ebx
801074f2:	72 db                	jb     801074cf <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
801074f4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801074f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074fa:	5b                   	pop    %ebx
801074fb:	5e                   	pop    %esi
801074fc:	5f                   	pop    %edi
801074fd:	5d                   	pop    %ebp
801074fe:	c3                   	ret    
        panic("kfree");
801074ff:	83 ec 0c             	sub    $0xc,%esp
80107502:	68 06 7f 10 80       	push   $0x80107f06
80107507:	e8 84 8e ff ff       	call   80100390 <panic>
8010750c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107510 <seginit>:
{
80107510:	55                   	push   %ebp
80107511:	89 e5                	mov    %esp,%ebp
80107513:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107516:	e8 c5 c2 ff ff       	call   801037e0 <cpuid>
8010751b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80107521:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107526:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010752a:	c7 80 b8 47 11 80 ff 	movl   $0xffff,-0x7feeb848(%eax)
80107531:	ff 00 00 
80107534:	c7 80 bc 47 11 80 00 	movl   $0xcf9a00,-0x7feeb844(%eax)
8010753b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010753e:	c7 80 c0 47 11 80 ff 	movl   $0xffff,-0x7feeb840(%eax)
80107545:	ff 00 00 
80107548:	c7 80 c4 47 11 80 00 	movl   $0xcf9200,-0x7feeb83c(%eax)
8010754f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107552:	c7 80 c8 47 11 80 ff 	movl   $0xffff,-0x7feeb838(%eax)
80107559:	ff 00 00 
8010755c:	c7 80 cc 47 11 80 00 	movl   $0xcffa00,-0x7feeb834(%eax)
80107563:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107566:	c7 80 d0 47 11 80 ff 	movl   $0xffff,-0x7feeb830(%eax)
8010756d:	ff 00 00 
80107570:	c7 80 d4 47 11 80 00 	movl   $0xcff200,-0x7feeb82c(%eax)
80107577:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010757a:	05 b0 47 11 80       	add    $0x801147b0,%eax
  pd[1] = (uint)p;
8010757f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107583:	c1 e8 10             	shr    $0x10,%eax
80107586:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010758a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010758d:	0f 01 10             	lgdtl  (%eax)
}
80107590:	c9                   	leave  
80107591:	c3                   	ret    
80107592:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801075a0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801075a0:	a1 64 c9 11 80       	mov    0x8011c964,%eax
{
801075a5:	55                   	push   %ebp
801075a6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801075a8:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801075ad:	0f 22 d8             	mov    %eax,%cr3
}
801075b0:	5d                   	pop    %ebp
801075b1:	c3                   	ret    
801075b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801075b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801075c0 <switchuvm>:
{
801075c0:	55                   	push   %ebp
801075c1:	89 e5                	mov    %esp,%ebp
801075c3:	57                   	push   %edi
801075c4:	56                   	push   %esi
801075c5:	53                   	push   %ebx
801075c6:	83 ec 1c             	sub    $0x1c,%esp
801075c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
801075cc:	85 db                	test   %ebx,%ebx
801075ce:	0f 84 cb 00 00 00    	je     8010769f <switchuvm+0xdf>
  if(p->kstack == 0)
801075d4:	8b 43 08             	mov    0x8(%ebx),%eax
801075d7:	85 c0                	test   %eax,%eax
801075d9:	0f 84 da 00 00 00    	je     801076b9 <switchuvm+0xf9>
  if(p->pgdir == 0)
801075df:	8b 43 04             	mov    0x4(%ebx),%eax
801075e2:	85 c0                	test   %eax,%eax
801075e4:	0f 84 c2 00 00 00    	je     801076ac <switchuvm+0xec>
  pushcli();
801075ea:	e8 e1 cf ff ff       	call   801045d0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801075ef:	e8 6c c1 ff ff       	call   80103760 <mycpu>
801075f4:	89 c6                	mov    %eax,%esi
801075f6:	e8 65 c1 ff ff       	call   80103760 <mycpu>
801075fb:	89 c7                	mov    %eax,%edi
801075fd:	e8 5e c1 ff ff       	call   80103760 <mycpu>
80107602:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107605:	83 c7 08             	add    $0x8,%edi
80107608:	e8 53 c1 ff ff       	call   80103760 <mycpu>
8010760d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107610:	83 c0 08             	add    $0x8,%eax
80107613:	ba 67 00 00 00       	mov    $0x67,%edx
80107618:	c1 e8 18             	shr    $0x18,%eax
8010761b:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80107622:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80107629:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010762f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107634:	83 c1 08             	add    $0x8,%ecx
80107637:	c1 e9 10             	shr    $0x10,%ecx
8010763a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80107640:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107645:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010764c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80107651:	e8 0a c1 ff ff       	call   80103760 <mycpu>
80107656:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010765d:	e8 fe c0 ff ff       	call   80103760 <mycpu>
80107662:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107666:	8b 73 08             	mov    0x8(%ebx),%esi
80107669:	e8 f2 c0 ff ff       	call   80103760 <mycpu>
8010766e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107674:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107677:	e8 e4 c0 ff ff       	call   80103760 <mycpu>
8010767c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107680:	b8 28 00 00 00       	mov    $0x28,%eax
80107685:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107688:	8b 43 04             	mov    0x4(%ebx),%eax
8010768b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107690:	0f 22 d8             	mov    %eax,%cr3
}
80107693:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107696:	5b                   	pop    %ebx
80107697:	5e                   	pop    %esi
80107698:	5f                   	pop    %edi
80107699:	5d                   	pop    %ebp
  popcli();
8010769a:	e9 71 cf ff ff       	jmp    80104610 <popcli>
    panic("switchuvm: no process");
8010769f:	83 ec 0c             	sub    $0xc,%esp
801076a2:	68 02 88 10 80       	push   $0x80108802
801076a7:	e8 e4 8c ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
801076ac:	83 ec 0c             	sub    $0xc,%esp
801076af:	68 2d 88 10 80       	push   $0x8010882d
801076b4:	e8 d7 8c ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
801076b9:	83 ec 0c             	sub    $0xc,%esp
801076bc:	68 18 88 10 80       	push   $0x80108818
801076c1:	e8 ca 8c ff ff       	call   80100390 <panic>
801076c6:	8d 76 00             	lea    0x0(%esi),%esi
801076c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801076d0 <inituvm>:
{
801076d0:	55                   	push   %ebp
801076d1:	89 e5                	mov    %esp,%ebp
801076d3:	57                   	push   %edi
801076d4:	56                   	push   %esi
801076d5:	53                   	push   %ebx
801076d6:	83 ec 1c             	sub    $0x1c,%esp
801076d9:	8b 75 10             	mov    0x10(%ebp),%esi
801076dc:	8b 45 08             	mov    0x8(%ebp),%eax
801076df:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
801076e2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
801076e8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
801076eb:	77 49                	ja     80107736 <inituvm+0x66>
  mem = kalloc();
801076ed:	e8 ee ad ff ff       	call   801024e0 <kalloc>
  memset(mem, 0, PGSIZE);
801076f2:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
801076f5:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801076f7:	68 00 10 00 00       	push   $0x1000
801076fc:	6a 00                	push   $0x0
801076fe:	50                   	push   %eax
801076ff:	e8 ac d0 ff ff       	call   801047b0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107704:	58                   	pop    %eax
80107705:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010770b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107710:	5a                   	pop    %edx
80107711:	6a 06                	push   $0x6
80107713:	50                   	push   %eax
80107714:	31 d2                	xor    %edx,%edx
80107716:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107719:	e8 c2 fc ff ff       	call   801073e0 <mappages>
  memmove(mem, init, sz);
8010771e:	89 75 10             	mov    %esi,0x10(%ebp)
80107721:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107724:	83 c4 10             	add    $0x10,%esp
80107727:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010772a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010772d:	5b                   	pop    %ebx
8010772e:	5e                   	pop    %esi
8010772f:	5f                   	pop    %edi
80107730:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107731:	e9 2a d1 ff ff       	jmp    80104860 <memmove>
    panic("inituvm: more than a page");
80107736:	83 ec 0c             	sub    $0xc,%esp
80107739:	68 41 88 10 80       	push   $0x80108841
8010773e:	e8 4d 8c ff ff       	call   80100390 <panic>
80107743:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107750 <loaduvm>:
{
80107750:	55                   	push   %ebp
80107751:	89 e5                	mov    %esp,%ebp
80107753:	57                   	push   %edi
80107754:	56                   	push   %esi
80107755:	53                   	push   %ebx
80107756:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80107759:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107760:	0f 85 91 00 00 00    	jne    801077f7 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80107766:	8b 75 18             	mov    0x18(%ebp),%esi
80107769:	31 db                	xor    %ebx,%ebx
8010776b:	85 f6                	test   %esi,%esi
8010776d:	75 1a                	jne    80107789 <loaduvm+0x39>
8010776f:	eb 6f                	jmp    801077e0 <loaduvm+0x90>
80107771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107778:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010777e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80107784:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80107787:	76 57                	jbe    801077e0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107789:	8b 55 0c             	mov    0xc(%ebp),%edx
8010778c:	8b 45 08             	mov    0x8(%ebp),%eax
8010778f:	31 c9                	xor    %ecx,%ecx
80107791:	01 da                	add    %ebx,%edx
80107793:	e8 c8 fb ff ff       	call   80107360 <walkpgdir>
80107798:	85 c0                	test   %eax,%eax
8010779a:	74 4e                	je     801077ea <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
8010779c:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010779e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
801077a1:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
801077a6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801077ab:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801077b1:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801077b4:	01 d9                	add    %ebx,%ecx
801077b6:	05 00 00 00 80       	add    $0x80000000,%eax
801077bb:	57                   	push   %edi
801077bc:	51                   	push   %ecx
801077bd:	50                   	push   %eax
801077be:	ff 75 10             	pushl  0x10(%ebp)
801077c1:	e8 aa a1 ff ff       	call   80101970 <readi>
801077c6:	83 c4 10             	add    $0x10,%esp
801077c9:	39 f8                	cmp    %edi,%eax
801077cb:	74 ab                	je     80107778 <loaduvm+0x28>
}
801077cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801077d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801077d5:	5b                   	pop    %ebx
801077d6:	5e                   	pop    %esi
801077d7:	5f                   	pop    %edi
801077d8:	5d                   	pop    %ebp
801077d9:	c3                   	ret    
801077da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801077e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801077e3:	31 c0                	xor    %eax,%eax
}
801077e5:	5b                   	pop    %ebx
801077e6:	5e                   	pop    %esi
801077e7:	5f                   	pop    %edi
801077e8:	5d                   	pop    %ebp
801077e9:	c3                   	ret    
      panic("loaduvm: address should exist");
801077ea:	83 ec 0c             	sub    $0xc,%esp
801077ed:	68 5b 88 10 80       	push   $0x8010885b
801077f2:	e8 99 8b ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
801077f7:	83 ec 0c             	sub    $0xc,%esp
801077fa:	68 fc 88 10 80       	push   $0x801088fc
801077ff:	e8 8c 8b ff ff       	call   80100390 <panic>
80107804:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010780a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107810 <allocuvm>:
{
80107810:	55                   	push   %ebp
80107811:	89 e5                	mov    %esp,%ebp
80107813:	57                   	push   %edi
80107814:	56                   	push   %esi
80107815:	53                   	push   %ebx
80107816:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80107819:	8b 7d 10             	mov    0x10(%ebp),%edi
8010781c:	85 ff                	test   %edi,%edi
8010781e:	0f 88 8e 00 00 00    	js     801078b2 <allocuvm+0xa2>
  if(newsz < oldsz)
80107824:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80107827:	0f 82 93 00 00 00    	jb     801078c0 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
8010782d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107830:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80107836:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010783c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010783f:	0f 86 7e 00 00 00    	jbe    801078c3 <allocuvm+0xb3>
80107845:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80107848:	8b 7d 08             	mov    0x8(%ebp),%edi
8010784b:	eb 42                	jmp    8010788f <allocuvm+0x7f>
8010784d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80107850:	83 ec 04             	sub    $0x4,%esp
80107853:	68 00 10 00 00       	push   $0x1000
80107858:	6a 00                	push   $0x0
8010785a:	50                   	push   %eax
8010785b:	e8 50 cf ff ff       	call   801047b0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107860:	58                   	pop    %eax
80107861:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107867:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010786c:	5a                   	pop    %edx
8010786d:	6a 06                	push   $0x6
8010786f:	50                   	push   %eax
80107870:	89 da                	mov    %ebx,%edx
80107872:	89 f8                	mov    %edi,%eax
80107874:	e8 67 fb ff ff       	call   801073e0 <mappages>
80107879:	83 c4 10             	add    $0x10,%esp
8010787c:	85 c0                	test   %eax,%eax
8010787e:	78 50                	js     801078d0 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
80107880:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107886:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80107889:	0f 86 81 00 00 00    	jbe    80107910 <allocuvm+0x100>
    mem = kalloc();
8010788f:	e8 4c ac ff ff       	call   801024e0 <kalloc>
    if(mem == 0){
80107894:	85 c0                	test   %eax,%eax
    mem = kalloc();
80107896:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80107898:	75 b6                	jne    80107850 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
8010789a:	83 ec 0c             	sub    $0xc,%esp
8010789d:	68 79 88 10 80       	push   $0x80108879
801078a2:	e8 b9 8d ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
801078a7:	83 c4 10             	add    $0x10,%esp
801078aa:	8b 45 0c             	mov    0xc(%ebp),%eax
801078ad:	39 45 10             	cmp    %eax,0x10(%ebp)
801078b0:	77 6e                	ja     80107920 <allocuvm+0x110>
}
801078b2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801078b5:	31 ff                	xor    %edi,%edi
}
801078b7:	89 f8                	mov    %edi,%eax
801078b9:	5b                   	pop    %ebx
801078ba:	5e                   	pop    %esi
801078bb:	5f                   	pop    %edi
801078bc:	5d                   	pop    %ebp
801078bd:	c3                   	ret    
801078be:	66 90                	xchg   %ax,%ax
    return oldsz;
801078c0:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
801078c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801078c6:	89 f8                	mov    %edi,%eax
801078c8:	5b                   	pop    %ebx
801078c9:	5e                   	pop    %esi
801078ca:	5f                   	pop    %edi
801078cb:	5d                   	pop    %ebp
801078cc:	c3                   	ret    
801078cd:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
801078d0:	83 ec 0c             	sub    $0xc,%esp
801078d3:	68 91 88 10 80       	push   $0x80108891
801078d8:	e8 83 8d ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
801078dd:	83 c4 10             	add    $0x10,%esp
801078e0:	8b 45 0c             	mov    0xc(%ebp),%eax
801078e3:	39 45 10             	cmp    %eax,0x10(%ebp)
801078e6:	76 0d                	jbe    801078f5 <allocuvm+0xe5>
801078e8:	89 c1                	mov    %eax,%ecx
801078ea:	8b 55 10             	mov    0x10(%ebp),%edx
801078ed:	8b 45 08             	mov    0x8(%ebp),%eax
801078f0:	e8 7b fb ff ff       	call   80107470 <deallocuvm.part.0>
      kfree(mem);
801078f5:	83 ec 0c             	sub    $0xc,%esp
      return 0;
801078f8:	31 ff                	xor    %edi,%edi
      kfree(mem);
801078fa:	56                   	push   %esi
801078fb:	e8 30 aa ff ff       	call   80102330 <kfree>
      return 0;
80107900:	83 c4 10             	add    $0x10,%esp
}
80107903:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107906:	89 f8                	mov    %edi,%eax
80107908:	5b                   	pop    %ebx
80107909:	5e                   	pop    %esi
8010790a:	5f                   	pop    %edi
8010790b:	5d                   	pop    %ebp
8010790c:	c3                   	ret    
8010790d:	8d 76 00             	lea    0x0(%esi),%esi
80107910:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80107913:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107916:	5b                   	pop    %ebx
80107917:	89 f8                	mov    %edi,%eax
80107919:	5e                   	pop    %esi
8010791a:	5f                   	pop    %edi
8010791b:	5d                   	pop    %ebp
8010791c:	c3                   	ret    
8010791d:	8d 76 00             	lea    0x0(%esi),%esi
80107920:	89 c1                	mov    %eax,%ecx
80107922:	8b 55 10             	mov    0x10(%ebp),%edx
80107925:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80107928:	31 ff                	xor    %edi,%edi
8010792a:	e8 41 fb ff ff       	call   80107470 <deallocuvm.part.0>
8010792f:	eb 92                	jmp    801078c3 <allocuvm+0xb3>
80107931:	eb 0d                	jmp    80107940 <deallocuvm>
80107933:	90                   	nop
80107934:	90                   	nop
80107935:	90                   	nop
80107936:	90                   	nop
80107937:	90                   	nop
80107938:	90                   	nop
80107939:	90                   	nop
8010793a:	90                   	nop
8010793b:	90                   	nop
8010793c:	90                   	nop
8010793d:	90                   	nop
8010793e:	90                   	nop
8010793f:	90                   	nop

80107940 <deallocuvm>:
{
80107940:	55                   	push   %ebp
80107941:	89 e5                	mov    %esp,%ebp
80107943:	8b 55 0c             	mov    0xc(%ebp),%edx
80107946:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107949:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010794c:	39 d1                	cmp    %edx,%ecx
8010794e:	73 10                	jae    80107960 <deallocuvm+0x20>
}
80107950:	5d                   	pop    %ebp
80107951:	e9 1a fb ff ff       	jmp    80107470 <deallocuvm.part.0>
80107956:	8d 76 00             	lea    0x0(%esi),%esi
80107959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107960:	89 d0                	mov    %edx,%eax
80107962:	5d                   	pop    %ebp
80107963:	c3                   	ret    
80107964:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010796a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107970 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107970:	55                   	push   %ebp
80107971:	89 e5                	mov    %esp,%ebp
80107973:	57                   	push   %edi
80107974:	56                   	push   %esi
80107975:	53                   	push   %ebx
80107976:	83 ec 0c             	sub    $0xc,%esp
80107979:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010797c:	85 f6                	test   %esi,%esi
8010797e:	74 59                	je     801079d9 <freevm+0x69>
80107980:	31 c9                	xor    %ecx,%ecx
80107982:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107987:	89 f0                	mov    %esi,%eax
80107989:	e8 e2 fa ff ff       	call   80107470 <deallocuvm.part.0>
8010798e:	89 f3                	mov    %esi,%ebx
80107990:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107996:	eb 0f                	jmp    801079a7 <freevm+0x37>
80107998:	90                   	nop
80107999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801079a0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801079a3:	39 fb                	cmp    %edi,%ebx
801079a5:	74 23                	je     801079ca <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801079a7:	8b 03                	mov    (%ebx),%eax
801079a9:	a8 01                	test   $0x1,%al
801079ab:	74 f3                	je     801079a0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801079ad:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
801079b2:	83 ec 0c             	sub    $0xc,%esp
801079b5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
801079b8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801079bd:	50                   	push   %eax
801079be:	e8 6d a9 ff ff       	call   80102330 <kfree>
801079c3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801079c6:	39 fb                	cmp    %edi,%ebx
801079c8:	75 dd                	jne    801079a7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
801079ca:	89 75 08             	mov    %esi,0x8(%ebp)
}
801079cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801079d0:	5b                   	pop    %ebx
801079d1:	5e                   	pop    %esi
801079d2:	5f                   	pop    %edi
801079d3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801079d4:	e9 57 a9 ff ff       	jmp    80102330 <kfree>
    panic("freevm: no pgdir");
801079d9:	83 ec 0c             	sub    $0xc,%esp
801079dc:	68 ad 88 10 80       	push   $0x801088ad
801079e1:	e8 aa 89 ff ff       	call   80100390 <panic>
801079e6:	8d 76 00             	lea    0x0(%esi),%esi
801079e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801079f0 <setupkvm>:
{
801079f0:	55                   	push   %ebp
801079f1:	89 e5                	mov    %esp,%ebp
801079f3:	56                   	push   %esi
801079f4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
801079f5:	e8 e6 aa ff ff       	call   801024e0 <kalloc>
801079fa:	85 c0                	test   %eax,%eax
801079fc:	89 c6                	mov    %eax,%esi
801079fe:	74 42                	je     80107a42 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80107a00:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107a03:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107a08:	68 00 10 00 00       	push   $0x1000
80107a0d:	6a 00                	push   $0x0
80107a0f:	50                   	push   %eax
80107a10:	e8 9b cd ff ff       	call   801047b0 <memset>
80107a15:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107a18:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107a1b:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107a1e:	83 ec 08             	sub    $0x8,%esp
80107a21:	8b 13                	mov    (%ebx),%edx
80107a23:	ff 73 0c             	pushl  0xc(%ebx)
80107a26:	50                   	push   %eax
80107a27:	29 c1                	sub    %eax,%ecx
80107a29:	89 f0                	mov    %esi,%eax
80107a2b:	e8 b0 f9 ff ff       	call   801073e0 <mappages>
80107a30:	83 c4 10             	add    $0x10,%esp
80107a33:	85 c0                	test   %eax,%eax
80107a35:	78 19                	js     80107a50 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107a37:	83 c3 10             	add    $0x10,%ebx
80107a3a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107a40:	75 d6                	jne    80107a18 <setupkvm+0x28>
}
80107a42:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107a45:	89 f0                	mov    %esi,%eax
80107a47:	5b                   	pop    %ebx
80107a48:	5e                   	pop    %esi
80107a49:	5d                   	pop    %ebp
80107a4a:	c3                   	ret    
80107a4b:	90                   	nop
80107a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107a50:	83 ec 0c             	sub    $0xc,%esp
80107a53:	56                   	push   %esi
      return 0;
80107a54:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107a56:	e8 15 ff ff ff       	call   80107970 <freevm>
      return 0;
80107a5b:	83 c4 10             	add    $0x10,%esp
}
80107a5e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107a61:	89 f0                	mov    %esi,%eax
80107a63:	5b                   	pop    %ebx
80107a64:	5e                   	pop    %esi
80107a65:	5d                   	pop    %ebp
80107a66:	c3                   	ret    
80107a67:	89 f6                	mov    %esi,%esi
80107a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107a70 <kvmalloc>:
{
80107a70:	55                   	push   %ebp
80107a71:	89 e5                	mov    %esp,%ebp
80107a73:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107a76:	e8 75 ff ff ff       	call   801079f0 <setupkvm>
80107a7b:	a3 64 c9 11 80       	mov    %eax,0x8011c964
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107a80:	05 00 00 00 80       	add    $0x80000000,%eax
80107a85:	0f 22 d8             	mov    %eax,%cr3
}
80107a88:	c9                   	leave  
80107a89:	c3                   	ret    
80107a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107a90 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107a90:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107a91:	31 c9                	xor    %ecx,%ecx
{
80107a93:	89 e5                	mov    %esp,%ebp
80107a95:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107a98:	8b 55 0c             	mov    0xc(%ebp),%edx
80107a9b:	8b 45 08             	mov    0x8(%ebp),%eax
80107a9e:	e8 bd f8 ff ff       	call   80107360 <walkpgdir>
  if(pte == 0)
80107aa3:	85 c0                	test   %eax,%eax
80107aa5:	74 05                	je     80107aac <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107aa7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107aaa:	c9                   	leave  
80107aab:	c3                   	ret    
    panic("clearpteu");
80107aac:	83 ec 0c             	sub    $0xc,%esp
80107aaf:	68 be 88 10 80       	push   $0x801088be
80107ab4:	e8 d7 88 ff ff       	call   80100390 <panic>
80107ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107ac0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107ac0:	55                   	push   %ebp
80107ac1:	89 e5                	mov    %esp,%ebp
80107ac3:	57                   	push   %edi
80107ac4:	56                   	push   %esi
80107ac5:	53                   	push   %ebx
80107ac6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107ac9:	e8 22 ff ff ff       	call   801079f0 <setupkvm>
80107ace:	85 c0                	test   %eax,%eax
80107ad0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107ad3:	0f 84 9f 00 00 00    	je     80107b78 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107ad9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107adc:	85 c9                	test   %ecx,%ecx
80107ade:	0f 84 94 00 00 00    	je     80107b78 <copyuvm+0xb8>
80107ae4:	31 ff                	xor    %edi,%edi
80107ae6:	eb 4a                	jmp    80107b32 <copyuvm+0x72>
80107ae8:	90                   	nop
80107ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107af0:	83 ec 04             	sub    $0x4,%esp
80107af3:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80107af9:	68 00 10 00 00       	push   $0x1000
80107afe:	53                   	push   %ebx
80107aff:	50                   	push   %eax
80107b00:	e8 5b cd ff ff       	call   80104860 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107b05:	58                   	pop    %eax
80107b06:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107b0c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107b11:	5a                   	pop    %edx
80107b12:	ff 75 e4             	pushl  -0x1c(%ebp)
80107b15:	50                   	push   %eax
80107b16:	89 fa                	mov    %edi,%edx
80107b18:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107b1b:	e8 c0 f8 ff ff       	call   801073e0 <mappages>
80107b20:	83 c4 10             	add    $0x10,%esp
80107b23:	85 c0                	test   %eax,%eax
80107b25:	78 61                	js     80107b88 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80107b27:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107b2d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80107b30:	76 46                	jbe    80107b78 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107b32:	8b 45 08             	mov    0x8(%ebp),%eax
80107b35:	31 c9                	xor    %ecx,%ecx
80107b37:	89 fa                	mov    %edi,%edx
80107b39:	e8 22 f8 ff ff       	call   80107360 <walkpgdir>
80107b3e:	85 c0                	test   %eax,%eax
80107b40:	74 61                	je     80107ba3 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80107b42:	8b 00                	mov    (%eax),%eax
80107b44:	a8 01                	test   $0x1,%al
80107b46:	74 4e                	je     80107b96 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80107b48:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
80107b4a:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
80107b4f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80107b55:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80107b58:	e8 83 a9 ff ff       	call   801024e0 <kalloc>
80107b5d:	85 c0                	test   %eax,%eax
80107b5f:	89 c6                	mov    %eax,%esi
80107b61:	75 8d                	jne    80107af0 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80107b63:	83 ec 0c             	sub    $0xc,%esp
80107b66:	ff 75 e0             	pushl  -0x20(%ebp)
80107b69:	e8 02 fe ff ff       	call   80107970 <freevm>
  return 0;
80107b6e:	83 c4 10             	add    $0x10,%esp
80107b71:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107b78:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107b7b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b7e:	5b                   	pop    %ebx
80107b7f:	5e                   	pop    %esi
80107b80:	5f                   	pop    %edi
80107b81:	5d                   	pop    %ebp
80107b82:	c3                   	ret    
80107b83:	90                   	nop
80107b84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107b88:	83 ec 0c             	sub    $0xc,%esp
80107b8b:	56                   	push   %esi
80107b8c:	e8 9f a7 ff ff       	call   80102330 <kfree>
      goto bad;
80107b91:	83 c4 10             	add    $0x10,%esp
80107b94:	eb cd                	jmp    80107b63 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80107b96:	83 ec 0c             	sub    $0xc,%esp
80107b99:	68 e2 88 10 80       	push   $0x801088e2
80107b9e:	e8 ed 87 ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80107ba3:	83 ec 0c             	sub    $0xc,%esp
80107ba6:	68 c8 88 10 80       	push   $0x801088c8
80107bab:	e8 e0 87 ff ff       	call   80100390 <panic>

80107bb0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107bb0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107bb1:	31 c9                	xor    %ecx,%ecx
{
80107bb3:	89 e5                	mov    %esp,%ebp
80107bb5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107bb8:	8b 55 0c             	mov    0xc(%ebp),%edx
80107bbb:	8b 45 08             	mov    0x8(%ebp),%eax
80107bbe:	e8 9d f7 ff ff       	call   80107360 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107bc3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107bc5:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107bc6:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107bc8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107bcd:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107bd0:	05 00 00 00 80       	add    $0x80000000,%eax
80107bd5:	83 fa 05             	cmp    $0x5,%edx
80107bd8:	ba 00 00 00 00       	mov    $0x0,%edx
80107bdd:	0f 45 c2             	cmovne %edx,%eax
}
80107be0:	c3                   	ret    
80107be1:	eb 0d                	jmp    80107bf0 <copyout>
80107be3:	90                   	nop
80107be4:	90                   	nop
80107be5:	90                   	nop
80107be6:	90                   	nop
80107be7:	90                   	nop
80107be8:	90                   	nop
80107be9:	90                   	nop
80107bea:	90                   	nop
80107beb:	90                   	nop
80107bec:	90                   	nop
80107bed:	90                   	nop
80107bee:	90                   	nop
80107bef:	90                   	nop

80107bf0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107bf0:	55                   	push   %ebp
80107bf1:	89 e5                	mov    %esp,%ebp
80107bf3:	57                   	push   %edi
80107bf4:	56                   	push   %esi
80107bf5:	53                   	push   %ebx
80107bf6:	83 ec 1c             	sub    $0x1c,%esp
80107bf9:	8b 5d 14             	mov    0x14(%ebp),%ebx
80107bfc:	8b 55 0c             	mov    0xc(%ebp),%edx
80107bff:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107c02:	85 db                	test   %ebx,%ebx
80107c04:	75 40                	jne    80107c46 <copyout+0x56>
80107c06:	eb 70                	jmp    80107c78 <copyout+0x88>
80107c08:	90                   	nop
80107c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107c10:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107c13:	89 f1                	mov    %esi,%ecx
80107c15:	29 d1                	sub    %edx,%ecx
80107c17:	81 c1 00 10 00 00    	add    $0x1000,%ecx
80107c1d:	39 d9                	cmp    %ebx,%ecx
80107c1f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107c22:	29 f2                	sub    %esi,%edx
80107c24:	83 ec 04             	sub    $0x4,%esp
80107c27:	01 d0                	add    %edx,%eax
80107c29:	51                   	push   %ecx
80107c2a:	57                   	push   %edi
80107c2b:	50                   	push   %eax
80107c2c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80107c2f:	e8 2c cc ff ff       	call   80104860 <memmove>
    len -= n;
    buf += n;
80107c34:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80107c37:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
80107c3a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80107c40:	01 cf                	add    %ecx,%edi
  while(len > 0){
80107c42:	29 cb                	sub    %ecx,%ebx
80107c44:	74 32                	je     80107c78 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107c46:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107c48:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
80107c4b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80107c4e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107c54:	56                   	push   %esi
80107c55:	ff 75 08             	pushl  0x8(%ebp)
80107c58:	e8 53 ff ff ff       	call   80107bb0 <uva2ka>
    if(pa0 == 0)
80107c5d:	83 c4 10             	add    $0x10,%esp
80107c60:	85 c0                	test   %eax,%eax
80107c62:	75 ac                	jne    80107c10 <copyout+0x20>
  }
  return 0;
}
80107c64:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107c67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107c6c:	5b                   	pop    %ebx
80107c6d:	5e                   	pop    %esi
80107c6e:	5f                   	pop    %edi
80107c6f:	5d                   	pop    %ebp
80107c70:	c3                   	ret    
80107c71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c78:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107c7b:	31 c0                	xor    %eax,%eax
}
80107c7d:	5b                   	pop    %ebx
80107c7e:	5e                   	pop    %esi
80107c7f:	5f                   	pop    %edi
80107c80:	5d                   	pop    %ebp
80107c81:	c3                   	ret    
