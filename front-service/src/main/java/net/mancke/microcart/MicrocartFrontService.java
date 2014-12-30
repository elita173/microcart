package net.mancke.microcart;

import java.util.EnumSet;

import javax.servlet.DispatcherType;

import io.dropwizard.Application;
import io.dropwizard.assets.AssetsBundle;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;
import io.dropwizard.views.ViewBundle;

/**
 * @author smancke
 */
public class MicrocartFrontService extends Application<FrontConfiguration> {

	@Override
	public String getName() {
	      return "Microcart Front Service";
	}
	
    /**
     * startup with the parameter java USer server config.yaml.
     * 
     * @param args the commandline args
     */
    public static void main(final String[] args) {
        try {
            new MicrocartFrontService().run(args);
        } catch (Exception e) {
            System.out.println("Error while startup"); // NOSONAR
            e.printStackTrace(); // NOSONAR
            System.exit(1);
        }
    }

    /**
     * Initialisation of the service.
     * 
     * @param bootstrap The Dropwizard Bootstrap Instance
     */
    @Override
    public void initialize(final Bootstrap<FrontConfiguration> bootstrap) {
    	 bootstrap.addBundle(new ViewBundle());
    }

    /**
     * The run method does the essential service configuration. Here we add all
     * Resources, Management Classes and HealthChecks.
     * 
     * @param configuration the configuration
     * @param environment the dropwizard environment
     */
    @Override
    public void run(final FrontConfiguration configuration,
            final Environment environment) throws Exception {

    	environment.servlets()
    		.addFilter("trackingIdFilter", new TrackingIdFilter())
    		.addMappingForUrlPatterns(EnumSet.of(DispatcherType.REQUEST), true, "/*");
        // Our Resources
    	environment.jersey().register(new CartResource(configuration));
    	
        // An example HealthCheck
        environment.healthChecks().register("demo health", new Health());       
    }
}
