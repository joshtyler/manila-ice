#include <stdint.h>
#include <stdbool.h>

#include "uip.h"
#include "uip_arp.h"

#include "timer.h"

#define BUF ((struct uip_eth_hdr *)&uip_buf[0])

#ifndef NULL
#define NULL (void *)0
#endif /* NULL */

#define reg_uart_data (*(volatile uint32_t*)0x02000008)
#define reg_leds (*(volatile uint32_t*)0x03000000)

void putchar(char c)
{
	if (c == '\n')
		putchar('\r');
	reg_uart_data = c;
}

void print(const char *p)
{
	while (*p)
		putchar(*(p++));
}

char getchar()
{
	int32_t c = reg_uart_data;
	return c;
}

// --------------------------------------------------------

void main()
{
	reg_leds = 0x55;

	int i;
    uip_ipaddr_t ipaddr;
    struct timer periodic_timer, arp_timer;

    timer_set(&periodic_timer, CLOCK_SECOND / 2);
    timer_set(&arp_timer, CLOCK_SECOND * 10);

    uip_init();

    uip_ipaddr(ipaddr, 192,168,0,2);
    uip_sethostaddr(ipaddr);
    uip_ipaddr(ipaddr, 192,168,0,1);
    uip_setdraddr(ipaddr);
    uip_ipaddr(ipaddr, 255,255,255,0);
    uip_setnetmask(ipaddr);

	#warning "This gives an undefined symbol error. It is missing an ifdef, or is something else happening here?"
    //httpd_init();

	print("Hello\n");
	while(1)
	{
		reg_leds++;
		//char c = getchar();
		//putchar(c);
		#warning "Receive here"
		uip_len =0;
		//uip_len = tapdev_read();
	    if(uip_len > 0) {
	      if(BUF->type == htons(UIP_ETHTYPE_IP)) {
		uip_arp_ipin();
		uip_input();
		/* If the above function invocation resulted in data that
		   should be sent out on the network, the global variable
		   uip_len is set to a value > 0. */
		if(uip_len > 0) {
		  uip_arp_out();
		  #warning "Send here"
		  //tapdev_send();
		}
	      } else if(BUF->type == htons(UIP_ETHTYPE_ARP)) {
		uip_arp_arpin();
		/* If the above function invocation resulted in data that
		   should be sent out on the network, the global variable
		   uip_len is set to a value > 0. */
		if(uip_len > 0) {
			#warning "Send here"
		  //tapdev_send();
		}
	      }

	    } else if(timer_expired(&periodic_timer)) {
	      timer_reset(&periodic_timer);
	      for(i = 0; i < UIP_CONNS; i++) {
		uip_periodic(i);
		/* If the above function invocation resulted in data that
		   should be sent out on the network, the global variable
		   uip_len is set to a value > 0. */
		if(uip_len > 0) {
		  uip_arp_out();
		  #warning "Send here"
		  //tapdev_send();
		}
	      }

	#if UIP_UDP
	      for(i = 0; i < UIP_UDP_CONNS; i++) {
		uip_udp_periodic(i);
		/* If the above function invocation resulted in data that
		   should be sent out on the network, the global variable
		   uip_len is set to a value > 0. */
		if(uip_len > 0) {
		  uip_arp_out();
		  #warning "Send here"
		  //tapdev_send();
		}
	      }
	#endif /* UIP_UDP */

	      /* Call the ARP timer function every 10 seconds. */
	      if(timer_expired(&arp_timer)) {
		timer_reset(&arp_timer);
		uip_arp_timer();
	      }
	    }
	}
}

void
uip_log(char *m)
{
  print("uIP log message:");
  print(m);
  putchar('\n');
}
void
resolv_found(char *name, u16_t *ipaddr)
{
  u16_t *ipaddr2;

  if(ipaddr == NULL) {
    print("Host not found.");
	print(name);
	putchar('\n');
  } else {
    print("Found name");
	print(name);
	putchar('\n');
  }
}

#ifdef __DHCPC_H__
void
dhcpc_configured(const struct dhcpc_state *s)
{
  uip_sethostaddr(s->ipaddr);
  uip_setnetmask(s->netmask);
  uip_setdraddr(s->default_router);
  resolv_conf(s->dnsaddr);
}
#endif /* __DHCPC_H__ */
void
smtp_done(unsigned char code)
{
  print("SMTP done\n");
}
void
webclient_closed(void)
{
  print("Webclient: connection closed\n");
}
void
webclient_aborted(void)
{
  print("Webclient: connection aborted\n");
}
void
webclient_timedout(void)
{
  print("Webclient: connection timed out\n");
}
void
webclient_connected(void)
{
  print("Webclient: connected, waiting for data...\n");
}
void
webclient_datahandler(char *data, u16_t len)
{
  print("Webclient: got data.\n");
}
/*---------------------------------------------------------------------------*/
