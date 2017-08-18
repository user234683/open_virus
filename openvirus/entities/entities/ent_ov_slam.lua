-- This is an entity created by weapon_ov_slam

if ( SERVER ) then AddCSLuaFile() end

ENT.Type = "anim"

ENT.SpriteBool = true
ENT.SpriteToggle = 0


-- Initialize the entity
function ENT:Initialize()

	self:SetModel( "models/weapons/w_slam.mdl" )

	if ( SERVER ) then
	
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
		self:CollisionRulesChanged()
	
		self:PhysWake()
	
	end

end


-- Entity thinks
function ENT:Think()

	-- Is our owner an infected
	if ( SERVER ) then
	
		if ( self.SpriteBool && ( self.Entity:GetOwner() && self.Entity:GetOwner():IsValid() && self.Entity:GetOwner():IsPlayer() && ( self.Entity:GetOwner():Team() == TEAM_INFECTED ) ) ) then
		
			local explosiveeffect = EffectData()
			explosiveeffect:SetOrigin( self.Entity:GetPos() )
			util.Effect( "Explosion", explosiveeffect )
		
			self:Remove()
			return
		
		end
	
	end

	-- Is our owner a player
	if ( SERVER ) then
	
		if ( self.SpriteBool && ( self.Entity:GetOwner() && self.Entity:GetOwner():IsValid() && !self.Entity:GetOwner():IsPlayer() ) ) then
		
			local explosiveeffect = EffectData()
			explosiveeffect:SetOrigin( self.Entity:GetPos() )
			util.Effect( "Explosion", explosiveeffect )
		
			self:Remove()
			return
		
		end
	
	end

	-- Is our owner even valid
	if ( SERVER ) then
	
		if ( self.SpriteBool && ( self.Entity:GetOwner() && !self.Entity:GetOwner():IsValid() ) ) then
		
			local explosiveeffect = EffectData()
			explosiveeffect:SetOrigin( self.Entity:GetPos() )
			util.Effect( "Explosion", explosiveeffect )
		
			self:Remove()
			return
		
		end
	
	end

	-- Check if players are within radius
	if ( SERVER ) then
	
		if ( self.SpriteBool ) then
		
			for _, ent in pairs( ents.FindInSphere( self.Entity:GetPos(), 64 ) ) do
			
				if ( ent:IsValid() && ent:IsPlayer() && ent:Alive() && ( ent:Team() == TEAM_INFECTED ) ) then
				
					local explosiveeffect = EffectData()
					explosiveeffect:SetOrigin( self.Entity:GetPos() )
					util.Effect( "Explosion", explosiveeffect )
				
					for _, ent in pairs( ents.FindInSphere( self.Entity:GetPos(), 128 ) ) do
					
						if ( ent:IsValid() && ent:IsPlayer() && ent:Alive() && ( ent:Team() == TEAM_INFECTED ) ) then
						
							ent:TakeDamage( 250, self.Entity:GetOwner(), self.Entity )
						
						end
					
					end
				
					self:Remove()
					return
				
				end
			
			end
		
		end
	
	end

	-- Update the sprite flash
	if ( self.SpriteToggle < CurTime() ) then
	
		self.SpriteToggle = CurTime() + 0.15
		self.SpriteBool = !self.SpriteBool
	
	end

end


-- Draw
if ( CLIENT ) then

	function ENT:Draw()
	
		-- Draw the model
		self:DrawModel()
	
		-- Draw a sprite
		if ( self.SpriteBool ) then
		
			render.SetMaterial( OV_Material_SLAMSprite )
			render.DrawSprite( self.Entity:GetPos(), 16, 16, Color( 255, 255, 255, 255 ) )
		
		end
	
	end

end
