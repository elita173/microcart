<!--# include virtual="/_header?title=Einkaufswagen&page=cart" -->

<#setting locale="de_DE">

  <div class="container cart">
    <h1>Einkaufswagen <small></small></h1>        
    
    <#if cart.positions?size == 0 >
      <p class="bs-big-font">Es befinden sich keine Artikel in deinem Einkaufswagen</p> 
      <#else> 
	<div class="row cart-bottom-row">
	  <div class="cart-order">
	    <a class="btn btn-primary btn-lg" href="/shop/orderRegister">Jetzt bestellen &gt;&gt;</a>
	  </div>		        		        		        
	</div>
      </#if> 

      <#if cart.positions?size != 0 >
	<div class="row cart-bottom-row">
	  <#if (cart.shippingCostLimit-cart.totalPriceWithoutShipping) gt 0 && (cart.shippingCostLimit-cart.totalPriceWithoutShipping) lt 20>
	    <div class="cart-description">
	      <h3 class="onsale">Nur noch ${(cart.shippingCostLimit-cart.totalPriceWithoutShipping)?string.currency} und die Versandkosten entfallen!</h3>
	    </div>
	  </#if>
	</div>
	<#list cart.positions as position>
	  <div class="row cart-row">
	    <div class="cart-image">
	      <img src="${position.imageUrl}" alt="${position.title}" />
	    </div>
	    <div class="cart-description">
	      <div class="cart-label">${position.title}</div>
	    </div>
	    <div class="cart-price">
	      <span class="cart-label">${position.pricePerUnit?string.currency}/m</span>
	      
	      <div class="cart-quantity">
		<form class="cart-quantity-form" action="/shop/my-cart/article" method="POST">
		  <input type="hidden" name="articleId" value="${position.articleId}">
		  <#setting locale="us_US">
		    <input type="number" step="0.1" min="0.5" max="500" value="${position.quantity}" class="input-sm form-control" name="quantity" placeholder="m">
		    <#setting locale="de_DE">
		      <span>m</span>
		      <button type="submit" class="cart-quantity-form-field btn btn-default btn-sm">
			<span class="glyphicon glyphicon-refresh"></span> 		                  
		      </button>           
		      <button type="submit" name="action" value="removeArticle" class="cart-quantity-form-field btn btn-default btn-sm">
			<span class="glyphicon glyphicon-remove"></span> 		                  
		      </button>           
		</form>
	      </div>			            
	    </div>
	  </div>
	  </#list>
	  <#if cart.discountSaving gt 0>
	    <div class="row cart-row no-image">
	      <div class="cart-description">
		<span class="cart-label">Rabatt</span>
	      </div>
	      <div class="cart-other-price onsale">
		<span class="cart-label">- ${cart.discountSaving?string.currency}</span>
	      </div>
	    </div>
	  </#if>
	  <div class="row cart-row no-image">
	    <div class="cart-description">
	      <span class="cart-label">Verpackung &amp; Versand<br><small>Versandkostenfrei ab ${cart.shippingCostLimit?string.currency} Warenwert</small></span>
	    </div>
	    <div class="cart-other-price">
	      <span class="cart-label">${cart.calculatedShippingCosts?string.currency}</span>
	    </div>
	  </div>
	  <div class="row cart-bottom-row">
	    <div class="cart-price-total">
	      <h3>Summe: ${cart.totalPrice?string.currency}</h3>
	    </div>		        		        		        
	  </div>
	  
	  <div class="row cart-bottom-row">
	    <div class="cart-order">
	      <a class="btn btn-primary btn-lg" href="/shop/orderRegister">Jetzt bestellen &gt;&gt;</a>
	    </div>		        		        		        
	  </div>
          </#if> 
  </div> 
  
  <!--# include virtual="/_footer" -->
